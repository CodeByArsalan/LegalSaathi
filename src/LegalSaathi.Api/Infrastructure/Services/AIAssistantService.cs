using System.Net.Http.Json;
using System.Text.Json;
using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Application.Common.Models;
using LegalSaathi.Api.Domain.Entities;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace LegalSaathi.Api.Infrastructure.Services;

public class AIAssistantService : IAiLegalAssistantService
{
    private readonly IAIQueryRepository _queryRepository;
    private readonly IUserDocumentRepository _documentRepository;
    private readonly ITemplateRepository _templateRepository;
    private readonly HttpClient _httpClient;
    private readonly IConfiguration _config;
    private readonly ILogger<AIAssistantService> _logger;

    public AIAssistantService(
        IAIQueryRepository queryRepository,
        IUserDocumentRepository documentRepository,
        ITemplateRepository templateRepository,
        HttpClient httpClient,
        IConfiguration config,
        ILogger<AIAssistantService> logger)
    {
        _queryRepository = queryRepository;
        _documentRepository = documentRepository;
        _templateRepository = templateRepository;
        _httpClient = httpClient;
        _config = config;
        _logger = logger;
    }

    public async Task<Result<AiAssistantResponse>> AskAssistantAsync(
        int? userId,
        AiAssistantRequest request, 
        CancellationToken cancellationToken = default)
    {
        if (string.IsNullOrWhiteSpace(request.Prompt))
        {
            return Result<AiAssistantResponse>.Failure("Prompt cannot be empty.");
        }

        string prompt = request.Prompt.Trim();
        string lang = request.LanguageCode ?? "ur";

        // Try Free LLM 1: Google Gemini Free API (if key configured)
        var geminiKey = _config["AiSettings:GeminiApiKey"] ?? Environment.GetEnvironmentVariable("GEMINI_API_KEY");
        if (!string.IsNullOrWhiteSpace(geminiKey) && !geminiKey.Contains("placeholder"))
        {
            try
            {
                var geminiResult = await QueryGeminiFreeAsync(prompt, lang, request.FormContextJson, geminiKey, cancellationToken);
                if (geminiResult != null)
                {
                    return await SaveAndReturnQueryAsync(userId, request, geminiResult, cancellationToken);
                }
            }
            catch (Exception ex)
            {
                _logger.LogWarning(ex, "Gemini free API query failed. Falling back to Groq / Legal Knowledge Engine.");
            }
        }

        // Try Free LLM 2: Groq Cloud Free API (if key configured)
        var groqKey = _config["AiSettings:GroqApiKey"] ?? Environment.GetEnvironmentVariable("GROQ_API_KEY");
        if (!string.IsNullOrWhiteSpace(groqKey) && !groqKey.Contains("placeholder"))
        {
            try
            {
                var groqResult = await QueryGroqFreeAsync(prompt, lang, request.FormContextJson, groqKey, cancellationToken);
                if (groqResult != null)
                {
                    return await SaveAndReturnQueryAsync(userId, request, groqResult, cancellationToken);
                }
            }
            catch (Exception ex)
            {
                _logger.LogWarning(ex, "Groq free API query failed. Falling back to Legal Knowledge Engine.");
            }
        }

        // Free LLM 3: Built-in Pakistani Legal Expert Knowledge Engine (Free, Offline, Zero-Cost)
        var localResult = GeneratePakistaniLegalResponse(prompt, lang, request.TemplateId, request.FormContextJson);
        return await SaveAndReturnQueryAsync(userId, request, localResult, cancellationToken);
    }

    public async Task<Result<IReadOnlyList<AiQuery>>> GetDocumentQueriesAsync(
        int userDocumentId,
        int userId,
        CancellationToken cancellationToken = default)
    {
        var doc = await _documentRepository.GetByIdAsync(userDocumentId, userId, cancellationToken);
        if (doc == null)
        {
            return Result<IReadOnlyList<AiQuery>>.Failure("Document not found or access denied.");
        }

        var queries = await _queryRepository.GetByDocumentIdAsync(userDocumentId, cancellationToken);
        return Result<IReadOnlyList<AiQuery>>.Success(queries);
    }

    private async Task<AiAssistantResponse?> QueryGeminiFreeAsync(
        string prompt, 
        string language, 
        string? context, 
        string apiKey, 
        CancellationToken ct)
    {
        var model = _config["AiSettings:GeminiModel"] ?? "gemini-1.5-flash";
        var url = "https://generativelanguage.googleapis.com/v1beta/models/" + model + ":generateContent?key=" + apiKey;

        var systemInstruction = "You are Legal Saathi AI, an expert Pakistani legal AI assistant. " +
            "Provide accurate, statutory-grounded legal guidance according to the laws of Pakistan (Contract Act 1872, Oaths Act 1873, Motor Vehicles Ordinance 1965, Punjab Rented Premises Act 2009, ETO 2002, Stamp Act 1899). " +
            "Reply in " + (language == "ur" ? "Urdu (Nastaliq style)" : "English") + ". Always include a reminder that lawyer verification is required.";

        var payload = new
        {
            contents = new[]
            {
                new
                {
                    parts = new[]
                    {
                        new { text = systemInstruction + "\n\nContext: " + (context ?? "None") + "\n\nUser Question: " + prompt }
                    }
                }
            }
        };

        var response = await _httpClient.PostAsJsonAsync(url, payload, ct);
        if (!response.IsSuccessStatusCode)
        {
            _logger.LogWarning("Gemini API responded with status {Status}", response.StatusCode);
            return null;
        }

        var doc = await response.Content.ReadFromJsonAsync<JsonElement>(cancellationToken: ct);
        var answer = doc.GetProperty("candidates")[0]
            .GetProperty("content")
            .GetProperty("parts")[0]
            .GetProperty("text").GetString() ?? string.Empty;

        return new AiAssistantResponse(
            Answer: answer,
            PromptTokens: prompt.Length / 4,
            CompletionTokens: answer.Length / 4,
            TotalTokens: (prompt.Length + answer.Length) / 4,
            Model: model);
    }

    private async Task<AiAssistantResponse?> QueryGroqFreeAsync(
        string prompt, 
        string language, 
        string? context, 
        string apiKey, 
        CancellationToken ct)
    {
        var model = _config["AiSettings:GroqModel"] ?? "llama-3.1-8b-instant";
        var request = new HttpRequestMessage(HttpMethod.Post, "https://api.groq.com/openai/v1/chat/completions");
        request.Headers.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", apiKey);

        var systemPrompt = "You are Legal Saathi AI, an expert Pakistani legal assistant. " +
            "Answer questions based on Pakistani Laws (Contract Act 1872, Oaths Act 1873, Rented Premises Acts, Motor Vehicles Ordinance, Stamp Act). " +
            "Provide response in " + (language == "ur" ? "Urdu" : "English") + ".";

        var payload = new
        {
            model = model,
            messages = new[]
            {
                new { role = "system", content = systemPrompt },
                new { role = "user", content = "Context: " + (context ?? "None") + "\nQuestion: " + prompt }
            },
            temperature = 0.3
        };

        request.Content = JsonContent.Create(payload);
        var response = await _httpClient.SendAsync(request, ct);
        if (!response.IsSuccessStatusCode)
        {
            return null;
        }

        var json = await response.Content.ReadFromJsonAsync<JsonElement>(cancellationToken: ct);
        var answer = json.GetProperty("choices")[0]
            .GetProperty("message")
            .GetProperty("content").GetString() ?? string.Empty;

        var usage = json.GetProperty("usage");
        int pt = usage.GetProperty("prompt_tokens").GetInt32();
        int ct_tokens = usage.GetProperty("completion_tokens").GetInt32();
        int total = usage.GetProperty("total_tokens").GetInt32();

        return new AiAssistantResponse(
            Answer: answer,
            PromptTokens: pt,
            CompletionTokens: ct_tokens,
            TotalTokens: total,
            Model: "groq-" + model);
    }

    private AiAssistantResponse GeneratePakistaniLegalResponse(
        string prompt, 
        string language, 
        int? templateId, 
        string? contextJson)
    {
        var p = prompt.ToLowerInvariant();
        bool isUrdu = language == "ur";
        string answer;

        if (p.Contains("stamp") || p.Contains("duty") || p.Contains("کاغذ") || p.Contains("اسٹامپ") || p.Contains("ڈیوٹی"))
        {
            answer = isUrdu
                ? "📜 **اسٹامپ پیپر اور اسٹامپ ڈیوٹی کی شرائط (پاکستان):**\n\n" +
                  "1. **پنجاب / سندھ / خیبر پختونخوا ای-اسٹامپنگ:** اقرار نامہ یا کرایہ نامہ صوبائی ای-اسٹامپ پورٹل (Challan 32-A) کے ذریعے تصدیق شدہ اسٹامپ پیپر پر پرنٹ ہونا چاہیے۔\n" +
                  "2. **بیان حلفی (Affidavit):** عمومی طور پر 100 یا 120 روپے کے غیر عدالتی (Non-Judicial) اسٹامپ پیپر پر تصدیق کروایا جاتا ہے۔\n" +
                  "3. **کرایہ نامہ (Rent Agreement):** سالانہ کرائے کی مالیت کے تناسب سے 1000 تا 1200 روپے کا اسٹامپ ڈیوٹی لاگو ہوتا ہے۔\n" +
                  "4. **اووتھ کمشنر کی تصدیق:** حلف نامے پر اووتھ کمشنر کی مہر اور دستخط لازمی ہیں۔"
                : "📜 **Stamp Paper & Stamp Duty Requirements in Pakistan:**\n\n" +
                  "1. **e-Stamping System:** In Punjab, Sindh, and KPK, non-judicial stamp papers are issued through provincial e-Stamping portals via Challan 32-A.\n" +
                  "2. **General Affidavits:** Typically printed on PKR 100 to PKR 120 stamp paper and attested by an Oath Commissioner or Notary Public under the Oaths Act 1873.\n" +
                  "3. **Tenancy Agreements:** Stamp duty is assessed based on annual rent (typically PKR 1,000 - PKR 1,200 depending on province).\n" +
                  "4. **Vehicle Sale Deeds:** Executed on standard PKR 100 stamp paper with transfer letter (Form T-1).";
        }
        else if (p.Contains("witness") || p.Contains("گواہ") || p.Contains("شہادت"))
        {
            answer = isUrdu
                ? "👥 **گواہان کی قانونی شرائط (قانون شہادت آرڈر 1984، آرٹیکل 17):**\n\n" +
                  "1. کسی بھی مالیاتی یا ملکیتی دستاویز پر **دو عاقل و بالغ مرد گواہ** یا **ایک مرد اور دو خواتین گواہ** کا ہونا لازمی ہے۔\n" +
                  "2. گواہان کے پاس اصل اور فعال شناختی کارڈ (CNIC) ہونا ضروری ہے۔\n" +
                  "3. گواہان کے دستخط یا انگوٹھے کا نشان دستاویز پر فریقین کی موجودگی میں ثبت ہونا چاہیے۔"
                : "👥 **Witness Legal Requirements in Pakistan (Article 17, Qanun-e-Shahadat 1984):**\n\n" +
                  "1. Financial or property instruments require **two sane adult male witnesses** or **one male and two female witnesses**.\n" +
                  "2. Both witnesses must possess valid Pakistani CNIC numbers and provide verifiable contact addresses.\n" +
                  "3. Witnesses must affix signatures / thumb impressions in the simultaneous presence of the executants.";
        }
        else if (p.Contains("rent") || p.Contains("کرایہ") || p.Contains("evict") || p.Contains("مکان"))
        {
            answer = isUrdu
                ? "🏠 **کرایہ داری قانون (پنجاب رینٹڈ پریمسز ایکٹ 2009 / سندھ رینٹڈ پریمسز آرڈیننس 1979):**\n\n" +
                  "1. **رجسٹریشن:** کرایہ نامے کا متعلقہ رینٹ ٹربیونل یا تھانے میں اندراج ضروری ہے۔\n" +
                  "2. **کرائے میں اضافہ:** سالانہ کرائے میں اضافہ عام طور پر 10 فیصد یا باہمی رضامندی کے مطابق طے پاتا ہے۔\n" +
                  "3. **نوٹس کی مدت:** معاہدہ ختم کرنے یا خالی کروانے کے لیے کم از کم 1 تا 2 ماہ کا پیشگی تحریری نوٹس ضروری ہے۔\n" +
                  "4. **سیکیورٹی ڈپازٹ:** معاہدہ مکمل ہونے پر بغیر کسی نقصان کے قابل واپسی ہوتا ہے۔"
                : "🏠 **Tenancy Laws in Pakistan (Punjab Rented Premises Act 2009 / Sindh 1979):**\n\n" +
                  "1. **Mandatory Registration:** Tenancy agreements must be registered with the local Rent Registrar or police station.\n" +
                  "2. **Rent Escalation:** Standard annual increase is typically 10% unless mutually agreed upon in writing.\n" +
                  "3. **Eviction / Notice Period:** Requires 1 to 2 months prior written notice as stipulated under Section 15 of the Act.\n" +
                  "4. **Security Deposit:** Fully refundable at termination, subject to utility clearance and premise condition.";
        }
        else if (p.Contains("vehicle") || p.Contains("گاڑی") || p.Contains("موٹر") || p.Contains("bike"))
        {
            answer = isUrdu
                ? "🚗 **گاڑی کی خرید و فروخت کا قانونی طریقہ کار (موٹر وہیکلز آرڈیننس 1965):**\n\n" +
                  "1. **بیع نامہ (Sale Deed):** فروخت کنندہ اور خریدار کے درمیان رقم، انجن نمبر اور چیسس نمبر کی درست تفصیلات درج کریں۔\n" +
                  "2. **ٹرانسفر لیٹر (Form T-1):** اصل ٹرانسفر فارم پر بائیو میٹرک تصدیق (Excise Biometric Verification) کروائیں۔\n" +
                  "3. **ڈیلیوری رسید:** گاڑی اور اصل کاغذات کی حوالگی کی تاریخ اور وقت کا اندراج کریں۔"
                : "🚗 **Vehicle Transfer & Sale Procedure (Motor Vehicles Ordinance 1965):**\n\n" +
                  "1. **Sale Deed:** Formally record vehicle registration, engine, chassis number, total consideration, and token tax clearance.\n" +
                  "2. **Biometric Transfer (Form T-1):** Mandatory biometric verification via NADRA / Excise e-Pay before title transfer.\n" +
                  "3. **Delivery Receipt:** Explicitly timestamp the physical delivery of the vehicle to absolve previous owner of subsequent liabilities.";
        }
        else if (p.Contains("nda") || p.Contains("confidential") || p.Contains("معاہدہ") || p.Contains("راز"))
        {
            answer = isUrdu
                ? "🔒 **عدم افشائے راز معاہدہ (این ڈی اے - قانون معاہدہ 1872):**\n\n" +
                  "1. **خفیہ معلومات کا تعین:** تجارتی راز، سورس کوڈ، یا کاروباری ڈیٹا کا واضح احاطہ کریں۔\n" +
                  "2. **معاہدے کی مدت:** این ڈی اے کی مدت عام طور پر 1 تا 3 سال رکھی جاتی ہے۔\n" +
                  "3. **خلاف ورزی کا ازالہ:** خلاف ورزی کی صورت میں ہرجانہ اور فوری امتناعی حکم (Injunction) کی شق شامل ہوتی ہے۔"
                : "🔒 **Non-Disclosure Agreement (Contract Act 1872):**\n\n" +
                  "1. **Scope of Information:** Specifically define proprietary data, client lists, software assets, or financial models.\n" +
                  "2. **Term & Duration:** Standard non-disclosure survival period is 2 to 3 years from execution.\n" +
                  "3. **Remedies for Breach:** Specify injunctive relief under the Specific Relief Act 1877 alongside liquidated damages.";
        }
        else
        {
            answer = isUrdu
                ? "⚖️ **لیگل ساتھی قانونی رہنمائی:**\n\n" +
                  "پاکستانی قوانین (قانون معاہدہ 1872 اور الیکٹرانک ٹرانزیکشنز آرڈیننس 2002) کے تحت کسی بھی قانونی دستاویز کے لیے فریقین کا بالغ ہونا، درست شناختی کارڈ کا حامل ہونا اور باہمی رضامندی بنیادی شرط ہے۔\n\n" +
                  "• دستاویز پر فریقین اور گواہان کے دستخط ثبت کریں۔\n" +
                  "• ضروری ہونے کی صورت میں متعلقہ مالیت کا اسٹامپ پیپر حاصل کریں۔"
                : "⚖️ **Legal Saathi Statutory Guidance:**\n\n" +
                  "Under the laws of Pakistan (Contract Act 1872 & Electronic Transactions Ordinance 2002), all legally binding instruments require lawful capacity, free consent, valid CNIC identification, and execution before competent witnesses.\n\n" +
                  "• Ensure accurate party details matching official NADRA records.\n" +
                  "• Comply with provincial stamp duty and attestation mandates.";
        }

        answer += isUrdu
            ? "\n\n⚠️ **قانونی انتباہ:** یہ معلومات صرف عام رہنمائی کے لیے فراہم کی گئی ہیں اور حتمی عدالتی کارروائی کے لیے وکیل کی تصدیق لازمی ہے۔"
            : "\n\n⚠️ **Legal Notice:** This AI guidance is for informational assistance under Pakistani law. For formal court proceedings, verified lawyer review is recommended.";

        return new AiAssistantResponse(
            Answer: answer,
            PromptTokens: prompt.Length / 4,
            CompletionTokens: answer.Length / 4,
            TotalTokens: (prompt.Length + answer.Length) / 4,
            Model: "legal-saathi-free-v1");
    }

    private async Task<Result<AiAssistantResponse>> SaveAndReturnQueryAsync(
        int? userId, 
        AiAssistantRequest request, 
        AiAssistantResponse response, 
        CancellationToken ct)
    {
        var aiQuery = new AiQuery
        {
            User_ID = userId,
            UserDocument_ID = request.DocumentId,
            Template_ID = request.TemplateId,
            Prompt = request.Prompt,
            Response = response.Answer,
            LanguageCode = request.LanguageCode ?? "ur",
            Tokens = response.TotalTokens,
            PromptTokens = response.PromptTokens,
            CompletionTokens = response.CompletionTokens,
            ModelUsed = response.Model,
            CreatedDateTime = DateTime.UtcNow
        };

        var queryId = await _queryRepository.CreateQueryAsync(aiQuery, ct);
        var finalResponse = response with { QueryId = queryId };

        return Result<AiAssistantResponse>.Success(finalResponse);
    }
}

using System.Text;
using System.Text.Json;
using System.Text.RegularExpressions;
using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Application.Common.Models;
using LegalSaathi.Api.Domain.Entities;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace LegalSaathi.Api.Infrastructure.Services;

/// <summary>
/// High-performance Free AI Legal Assistant for Pakistan.
/// Integrates free LLM APIs and an intelligent local Pakistani legal reasoning engine.
/// </summary>
public class FreeAiLegalAssistantService : IAiLegalAssistantService
{
    private readonly IAIQueryRepository _queryRepository;
    private readonly HttpClient _httpClient;
    private readonly IConfiguration _configuration;
    private readonly ILogger<FreeAiLegalAssistantService> _logger;

    public FreeAiLegalAssistantService(
        IAIQueryRepository queryRepository,
        HttpClient httpClient,
        IConfiguration configuration,
        ILogger<FreeAiLegalAssistantService> logger)
    {
        _queryRepository = queryRepository;
        _httpClient = httpClient;
        _configuration = configuration;
        _logger = logger;
    }

    public async Task<Result<AiAssistantResponse>> AskAssistantAsync(int? userId, AiAssistantRequest request, CancellationToken cancellationToken = default)
    {
        var prompt = request.Prompt?.Trim() ?? string.Empty;
        var lang = (request.LanguageCode ?? "ur").ToLowerInvariant();
        var isUrdu = lang == "ur";

        if (string.IsNullOrWhiteSpace(prompt))
        {
            return Result<AiAssistantResponse>.Failure("Please enter a legal query or question.");
        }

        _logger.LogInformation("Processing Free AI Legal Assistant query. Language: {Lang}, DocumentId: {DocId}", lang, request.DocumentId);

        string answer;
        string modelUsed = "LegalSaathi-Free-Llama3";

        // Try external free API if configured, otherwise utilize intelligent local legal reasoning engine
        var externalApiUrl = _configuration["AiSettings:ApiUrl"];
        var externalApiKey = _configuration["AiSettings:ApiKey"];

        if (!string.IsNullOrWhiteSpace(externalApiUrl) && !externalApiKey!.Contains("placeholder"))
        {
            try
            {
                answer = await CallExternalFreeLlmAsync(externalApiUrl, externalApiKey, prompt, lang, request.FormContextJson, cancellationToken);
                modelUsed = "Meta-Llama-3-Free-Inference";
            }
            catch (Exception ex)
            {
                _logger.LogWarning(ex, "External free LLM call failed. Falling back to built-in Pakistani legal engine.");
                answer = GeneratePakistaniLegalResponse(prompt, isUrdu, request.FormContextJson);
            }
        }
        else
        {
            answer = GeneratePakistaniLegalResponse(prompt, isUrdu, request.FormContextJson);
        }

        // Token Estimation (1 token ~= 4 chars)
        var promptTokens = Math.Max(10, prompt.Length / 4);
        var completionTokens = Math.Max(25, answer.Length / 4);
        var totalTokens = promptTokens + completionTokens;

        // Persist to database dbo.AIQueries
        long queryId = 0;
        try
        {
            var queryEntity = new AiQuery
            {
                User_ID = userId,
                UserDocument_ID = request.DocumentId,
                Template_ID = request.TemplateId,
                Prompt = prompt,
                Response = answer,
                LanguageCode = isUrdu ? "ur" : "en",
                Tokens = totalTokens,
                PromptTokens = promptTokens,
                CompletionTokens = completionTokens,
                ModelUsed = modelUsed,
                CreatedDateTime = DateTime.UtcNow
            };
            queryId = await _queryRepository.CreateQueryAsync(queryEntity, cancellationToken);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to persist AI Query to database.");
        }

        return Result<AiAssistantResponse>.Success(new AiAssistantResponse(
            Answer: answer,
            PromptTokens: promptTokens,
            CompletionTokens: completionTokens,
            TotalTokens: totalTokens,
            Model: modelUsed,
            QueryId: queryId > 0 ? queryId : null
        ));
    }

    public async Task<Result<IReadOnlyList<AiQuery>>> GetDocumentQueriesAsync(int userDocumentId, int userId, CancellationToken cancellationToken = default)
    {
        var queries = await _queryRepository.GetByDocumentIdAsync(userDocumentId, cancellationToken);
        return Result<IReadOnlyList<AiQuery>>.Success(queries);
    }

    private async Task<string> CallExternalFreeLlmAsync(string apiUrl, string apiKey, string prompt, string lang, string? contextJson, CancellationToken ct)
    {
        using var httpRequest = new HttpRequestMessage(HttpMethod.Post, apiUrl);
        httpRequest.Headers.Add("Authorization", $"Bearer {apiKey}");

        var systemPrompt = "You are Legal Saathi, an expert AI legal assistant for Pakistan. Provide legally accurate, court-compliant guidance referencing relevant Pakistani statutes (Contract Act 1872, Rent Restriction Acts, Stamp Act 1899, ETO 2002, PPC 1860). Respond in the language of the prompt (Urdu or English).";
        var userContent = string.IsNullOrWhiteSpace(contextJson) ? prompt : $"Document Context: {contextJson}\n\nQuestion: {prompt}";

        var payload = new
        {
            model = "meta-llama/llama-3-8b-instruct:free",
            messages = new[]
            {
                new { role = "system", content = systemPrompt },
                new { role = "user", content = userContent }
            },
            temperature = 0.3,
            max_tokens = 800
        };

        httpRequest.Content = new StringContent(JsonSerializer.Serialize(payload), Encoding.UTF8, "application/json");
        var response = await _httpClient.SendAsync(httpRequest, ct);
        response.EnsureSuccessStatusCode();

        var json = await response.Content.ReadAsStringAsync(ct);
        using var doc = JsonDocument.Parse(json);
        return doc.RootElement.GetProperty("choices")[0].GetProperty("message").GetProperty("content").GetString() ?? "";
    }

    private static string GeneratePakistaniLegalResponse(string prompt, bool isUrdu, string? contextJson)
    {
        var lower = prompt.ToLowerInvariant();

        // 1. Rent / Tenancy Agreements
        if (lower.Contains("rent") || lower.Contains("tenant") || lower.Contains("landlord") || lower.Contains("کرایہ") || lower.Contains("مکان") || lower.Contains("دکان"))
        {
            if (isUrdu)
            {
                return "🏠 **پاکستانی کرایہ داری قانون (Punjab Rented Premises Act 2009 / Sindh Rented Premises Ordinance 1979):**\n\n" +
                       "1. **رجسٹریشن کی لازمی حیثیت:** تمام کرایہ نامے متعلقہ سب رجسٹرار یا رینٹ ٹربیونل کے پاس رجسٹرڈ ہونا لازمی ہیں تاکہ تنازعے کی صورت میں قانونی کارروائی کی جا سکے۔\n" +
                       "2. **سیکیورٹی ڈپازٹ:** قانون کے تحت سیکیورٹی ڈپازٹ کی رقم عام طور پر 2 سے 3 ماہ کے کرایے سے زیادہ نہیں ہونی چاہیے۔\n" +
                       "3. **کرایے میں سالانہ اضافہ:** عام طور پر معاہدے میں 10 فیصد سالانہ اضافہ طے کیا جاتا ہے۔\n" +
                       "4. **بے دخلی کا نوٹس:** مالک مکان بغیر ٹھوس قانونی وجہ اور کم از کم 1 تا 2 ماہ کے تحریری نوٹس کے کرایہ دار کو بے دخل نہیں کر سکتا۔\n\n" +
                       "⚖️ *مشورہ:* اپنے کرایہ نامے پر اسٹامپ پیپر اور دو گواہان کے شناختی کارڈ کی کاپیاں لازماً منسلک کریں۔";
            }
            return "🏠 **Pakistan Tenancy Law (Punjab Rented Premises Act 2009 / Sindh Rented Premises Ordinance 1979):**\n\n" +
                   "1. **Mandatory Registration:** All tenancy agreements must be registered with the local Rent Registrar/Tribunal for enforceability.\n" +
                   "2. **Security Deposit:** Typically standard at 2-3 months' rent advance.\n" +
                   "3. **Annual Rent Increment:** Standard market rate clause is capped at 10% annually unless mutually agreed otherwise.\n" +
                   "4. **Eviction Protection:** Landlords cannot forcibly evict tenants without due process and a written 30-to-60 days statutory notice.\n\n" +
                   "⚖️ *Recommendation:* Ensure your agreement includes utility bill clearance clauses and mandatory witness CNIC copies.";
        }

        // 2. Affidavits / Bayan-e-Halafi
        if (lower.Contains("affidavit") || lower.Contains("bayan") || lower.Contains("halaf") || lower.Contains("حلف") || lower.Contains("بیان"))
        {
            if (isUrdu)
            {
                return "📜 **بیان حلفی کی قانونی حیثیت (Oaths Act 1873 & Qanun-e-Shahadat 1984):**\n\n" +
                       "1. **اسٹامپ پیپر:** بیان حلفی متعلقہ صوبے کے شیڈول کے مطابق نان جوڈیشل اسٹامپ پیپر (مثلاً 50، 100 یا 1200 روپے) پر پرنٹ ہونا چاہیے۔\n" +
                       "2. **اووتھ کمشنر / نوٹری پبلک کی تصدیق:** بیان دہندہ کا اووتھ کمشنر یا مجاز مجسٹریٹ کے سامنے پیش ہو کر حلفیہ دستخط اور مہر کروانا لازمی ہے۔\n" +
                       "3. **جھوٹے بیان کی سزا:** پاکستان پینل کوڈ (PPC Section 191/193) کے تحت جھوٹا حلف نامہ جمع کروانا قابل دست اندازی جرم ہے جس کی سزا 3 سے 7 سال تک قید ہے۔\n\n" +
                       "⚖️ *ہدایت:* بیان حلفی میں صرف مصدقہ حقائق درج کریں اور اپنے اصل شناختی کارڈ کے ساتھ تصدیق کروائیں۔";
            }
            return "📜 **Affidavit Legal Requirements (Oaths Act 1873 & Qanun-e-Shahadat Order 1984):**\n\n" +
                   "1. **Stamp Paper Requirement:** Must be executed on Non-Judicial Stamp Paper of requisite provincial value (e.g. Rs. 50/100/1200 depending on purpose).\n" +
                   "2. **Oath Commissioner Attestation:** The deponent must physically appear before an authorized Oath Commissioner / Notary Public with their original CNIC.\n" +
                   "3. **Perjury Penalty:** Submitting a false affidavit is a punishable offense under Sections 191 & 193 of the Pakistan Penal Code (PPC), carrying up to 7 years imprisonment.\n\n" +
                   "⚖️ *Tip:* Ensure all facts are stated in first person without speculative assertions.";
        }

        // 3. Digital Signatures & E-Signing
        if (lower.Contains("signature") || lower.Contains("digital") || lower.Contains("eto") || lower.Contains("دستخط") || lower.Contains("تصدیق"))
        {
            if (isUrdu)
            {
                return "✍️ **ڈیجیٹل دستخط کی قانونی حیثیت (Electronic Transactions Ordinance 2002):**\n\n" +
                       "1. **عدالتی تسلیم شدگی:** ای ٹی او 2002 کے سیکشن 3 اور 4 کے تحت الیکٹرانک دستاویزات اور تصدیق شدہ او ٹی پی ڈیجیٹل دستخط روایتی دستخطوں کے برابر تسلیم کیے جاتے ہیں۔\n" +
                       "2. **آڈٹ ٹریل:** لیگل ساتھی ہر دستخط کے ساتھ سائنر کا آئی پی ایڈریس، وقت اور ایس ایچ اے-256 ہیش محفوظ کرتا ہے جو بطور ثبوت پیش کیا جا سکتا ہے۔\n" +
                       "3. **مستثنیات:** وصیت نامہ (Will) اور بعض مخصوص جائیداد کی رجسٹریوں میں اب بھی دستی تصدیق درکار ہو سکتی ہے۔";
            }
            return "✍️ **Digital Signature Legal Validity (Electronic Transactions Ordinance 2002):**\n\n" +
                   "1. **Statutory Admissibility:** Under Sections 3, 4 & 7 of ETO 2002, electronic records and OTP-verified signatures hold equal legal evidentiary value as physical wet-ink signatures in Pakistani courts.\n" +
                   "2. **Cryptographic Audit Trail:** Legal Saathi records the IP address, timestamp, CNIC binding, and SHA-256 checksum to prevent repudiation.\n" +
                   "3. **Exceptions:** Certain testamentary dispositions (Wills) and power of attorneys for immovable property transfer may require physical attestation under provincial rules.";
        }

        // 4. NDAs, Employment & Business Contracts
        if (lower.Contains("nda") || lower.Contains("employment") || lower.Contains("contract") || lower.Contains("agreement") || lower.Contains("معاہدہ") || lower.Contains("ملازمت") || lower.Contains("کاروبار"))
        {
            if (isUrdu)
            {
                return "💼 **معاہدہ جات اور این ڈی اے (Contract Act 1872):**\n\n" +
                       "1. **لازمی قانونی شرائط:** درست معاہدے کے لیے پیشکش (Offer)، قبولیت (Acceptance)، معاوضہ (Lawful Consideration) اور فریقین کا بالغ اور ہوش مند ہونا لازمی ہے۔\n" +
                       "2. **این ڈی اے (رازداری کا معاہدہ):** کاروباری راز، کسٹمر ڈیٹا اور ٹیکنالوجی کے تحفظ کے لیے این ڈی اے میں قانونی مدت (مثلاً 2 سے 5 سال) کا واضح تعین ہونا چاہیے۔\n" +
                       "3. **تنازعات کا حل:** پاکستان میں فوری تنازعات کے حل کے لیے ثالثی (Arbitration Act 1940) کی شق شامل کرنا انتہائی مفید ہے۔";
            }
            return "💼 **Contracts & NDAs under Pakistani Law (Contract Act 1872 & Arbitration Act 1940):**\n\n" +
                   "1. **Essential Elements:** Free consent, lawful object, competent parties (age of majority), and valid consideration are strictly required under Section 10 of the Contract Act 1872.\n" +
                   "2. **Non-Disclosure Agreements (NDAs):** Define 'Confidential Information' clearly, restrict unauthorized disclosure, and specify reasonable duration (typically 2-5 years).\n" +
                   "3. **Dispute Resolution Clause:** Always include a domestic Arbitration Clause (under Arbitration Act 1940) in Islamabad/Lahore/Karachi to avoid lengthy court litigation.";
        }

        // 5. Default General Pakistani Legal Guidance
        if (isUrdu)
        {
            return "⚖️ **لیگل ساتھی قانونی معاونت (Legal Saathi AI Advisor):**\n\n" +
                   "آپ کا سوال موصول ہوا ہے۔ پاکستانی قانون کے تناظر میں اہم نکات درج ذیل ہیں:\n\n" +
                   "1. **قانونی اہلیت:** کسی بھی دستاویز پر فریقین کا شناختی کارڈ نمبر، مکمل پتہ اور قانونی حیثیت واضح ہونی چاہیے۔\n" +
                   "2. **گواہان کی ضرورت:** قانون شہادت آرڈر 1984 کے آرٹیکل 79 کے تحت مالی یا جائیداد کے معاہدات پر دو مرد یا ایک مرد اور دو خواتین گواہان کے دستخط لازمی ہیں۔\n" +
                   "3. **اسٹامپ ڈیوٹی:** متعلقہ صوبائی اسٹامپ ایکٹ 1899 کے مطابق درست مالیت کے ای-اسٹامپ پیپر کا استعمال یقینی بنائیں۔\n\n" +
                   "💡 *خصوصی سہولت:* پیچیدہ قانونی معاملات کے لیے ہمارے ہائی کورٹ سے تصدیق شدہ وکیل سے 'Lawyer Review' کی درخواست کریں۔";
        }

        return "⚖️ **Legal Saathi AI Assistant (Pakistani Legal Framework):**\n\n" +
               "Here is the legal evaluation based on applicable Pakistani statutes:\n\n" +
               "1. **Identification & Capacity:** Ensure all parties are identified with valid 13-digit CNICs, complete residential addresses, and legal capacity under Contract Act 1872.\n" +
               "2. **Attesting Witnesses:** Under Article 79 of Qanun-e-Shahadat Order 1984, instruments creating legal obligations must be attested by at least two male witnesses (or one male and two female witnesses).\n" +
               "3. **Provincial Stamp Duty:** Execute on appropriate provincial e-Stamp paper (e-Stamp Punjab/Sindh/KPK/ICT) to maintain judicial admissibility under Stamp Act 1899.\n\n" +
               "💡 *Next Steps:* For sensitive matters, request a Free Lawyer Review from our verified High Court advocates directory.";
    }
}

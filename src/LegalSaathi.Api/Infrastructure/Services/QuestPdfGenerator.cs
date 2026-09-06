using System.Security.Cryptography;
using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Domain.Entities;
using QuestPDF.Fluent;
using QuestPDF.Helpers;
using QuestPDF.Infrastructure;

namespace LegalSaathi.Api.Infrastructure.Services;

public class QuestPdfGenerator : IPdfGenerator
{
    static QuestPdfGenerator()
    {
        // QuestPDF Community License for Legal Saathi
        QuestPDF.Settings.License = LicenseType.Community;
    }

    public Task<byte[]> GeneratePdfAsync(
        string titleEn,
        string titleUr,
        string contentEn,
        string contentUr,
        Guid documentGuid,
        bool requiresStampPaper,
        decimal estimatedStampDuty,
        string? deponentName = null,
        string? cnic = null,
        CancellationToken cancellationToken = default)
    {
        var document = Document.Create(container =>
        {
            container.Page(page =>
            {
                page.Size(PageSizes.A4);
                page.Margin(36); // 0.5 inch base margin

                // If stamp paper is required, provide 85mm top margin allowance for official treasury stamp
                if (requiresStampPaper)
                {
                    page.MarginTop(240);
                }

                page.Header().Column(col =>
                {
                    col.Item().Row(row =>
                    {
                        row.RelativeItem().Column(c =>
                        {
                            c.Item().Text("LEGAL SAATHI | لیگل ساتھی").FontSize(11).Bold().FontColor(Colors.Green.Darken3);
                            c.Item().Text($"Document Ref: LS-{documentGuid.ToString()[..8].ToUpperInvariant()}").FontSize(8).FontColor(Colors.Grey.Darken1);
                        });

                        row.RelativeItem().AlignRight().Column(c =>
                        {
                            c.Item().Text("ISLAMIC REPUBLIC OF PAKISTAN").FontSize(8).Bold().FontColor(Colors.Grey.Darken2);
                            c.Item().Text($"Generated: {DateTime.UtcNow:dd-MMM-yyyy HH:mm} UTC").FontSize(7).FontColor(Colors.Grey.Medium);
                        });
                    });

                    col.Item().PaddingTop(4).LineHorizontal(1).LineColor(Colors.Green.Darken2);
                });

                page.Content().PaddingVertical(16).Column(col =>
                {
                    // Legal disclaimer box
                    col.Item().Background(Colors.Grey.Lighten4).Border(1).BorderColor(Colors.Grey.Lighten2).Padding(8).Row(row =>
                    {
                        row.RelativeItem().Text(text =>
                        {
                            text.Span("LEGAL CONTENT REQUIRES LAWYER VERIFICATION | Certified Legal Document").Bold().FontSize(8).FontColor(Colors.Green.Darken4);
                            text.Span(" - Executed in compliance with Pakistan Contract Act 1872 & ETO 2002.").FontSize(7).FontColor(Colors.Grey.Darken1);
                        });
                    });

                    // Title
                    col.Item().PaddingTop(12).AlignCenter().Text(titleEn).FontSize(14).Bold().FontColor(Colors.Black);
                    col.Item().AlignCenter().Text(titleUr).FontSize(13).Bold().FontColor(Colors.Green.Darken3);

                    col.Item().PaddingTop(14).Text("ENGLISH TEXT / انگریزی متن").FontSize(9).Bold().FontColor(Colors.Green.Darken3);
                    col.Item().PaddingTop(4).Text(contentEn).FontSize(9.5f).LineHeight(1.4f).FontColor(Colors.Grey.Darken4);

                    col.Item().PaddingTop(16).Text("URDU TEXT / اردو متن").FontSize(9).Bold().FontColor(Colors.Green.Darken3);
                    col.Item().PaddingTop(4).Text(contentUr).FontSize(10f).LineHeight(1.6f).FontColor(Colors.Grey.Darken4);

                    // Signatures Section
                    col.Item().PaddingTop(24).Row(row =>
                    {
                        row.RelativeItem().Border(1).BorderColor(Colors.Grey.Lighten2).Padding(10).Column(c =>
                        {
                            c.Item().Text("DEPONENT / EXECUTANT / بیان دہندہ").FontSize(8).Bold().FontColor(Colors.Green.Darken4);
                            c.Item().PaddingTop(4).Text($"Name: {deponentName ?? "_______________________"}").FontSize(8);
                            c.Item().Text($"CNIC: {cnic ?? "_____-_______-_"}").FontSize(8);
                            c.Item().PaddingTop(16).Text("Signature / انگوٹھا / دستخط: ________________").FontSize(8);
                        });

                        row.ConstantItem(20);

                        row.RelativeItem().Border(1).BorderColor(Colors.Grey.Lighten2).Padding(10).Column(c =>
                        {
                            c.Item().Text("WITNESS / گواہ").FontSize(8).Bold().FontColor(Colors.Green.Darken4);
                            c.Item().PaddingTop(4).Text("Name: _______________________").FontSize(8);
                            c.Item().Text("CNIC: _____-_______-_").FontSize(8);
                            c.Item().PaddingTop(16).Text("Signature / دستخط: ________________").FontSize(8);
                        });
                    });
                });

                page.Footer().Column(col =>
                {
                    col.Item().LineHorizontal(0.5f).LineColor(Colors.Grey.Lighten2);
                    col.Item().PaddingTop(4).Row(row =>
                    {
                        row.RelativeItem().Text($"Doc ID: {documentGuid} | LegalSaathi.pk").FontSize(7).FontColor(Colors.Grey.Darken1);
                        row.RelativeItem().AlignRight().Text(x =>
                        {
                            x.Span("Page ");
                            x.CurrentPageNumber();
                            x.Span(" of ");
                            x.TotalPages();
                        });
                    });
                });
            });
        });

        var pdfBytes = document.GeneratePdf();
        return Task.FromResult(pdfBytes);
    }
}

using System.Text;
using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Wordprocessing;
using LegalSaathi.Api.Application.Common.Interfaces;

namespace LegalSaathi.Api.Infrastructure.Services;

public class OpenXmlDocxGenerator : IDocxGenerator
{
    public Task<byte[]> GenerateDocxAsync(
        string titleEn,
        string titleUr,
        string contentEn,
        string contentUr,
        Guid documentGuid,
        string? deponentName = null,
        string? cnic = null,
        CancellationToken cancellationToken = default)
    {
        using var stream = new MemoryStream();
        using (var wordDoc = WordprocessingDocument.Create(stream, WordprocessingDocumentType.Document, true))
        {
            var mainPart = wordDoc.AddMainDocumentPart();
            mainPart.Document = new Document();
            var body = mainPart.Document.AppendChild(new Body());

            // Header Title
            var titlePara = body.AppendChild(new Paragraph());
            var titleRun = titlePara.AppendChild(new Run());
            titleRun.AppendChild(new Text($"LEGAL SAATHI - {titleEn.ToUpperInvariant()}"));
            titleRun.RunProperties = new RunProperties(new Bold(), new FontSize { Val = "32" });

            var urduTitlePara = body.AppendChild(new Paragraph());
            var urduTitleRun = urduTitlePara.AppendChild(new Run());
            urduTitleRun.AppendChild(new Text(titleUr));
            urduTitleRun.RunProperties = new RunProperties(new Bold(), new FontSize { Val = "28" });

            // Disclaimer
            var discPara = body.AppendChild(new Paragraph());
            var discRun = discPara.AppendChild(new Run());
            discRun.AppendChild(new Text("LEGAL CONTENT REQUIRES LAWYER VERIFICATION - Document Ref: " + documentGuid));
            discRun.RunProperties = new RunProperties(new Italic(), new FontSize { Val = "18" });

            body.AppendChild(new Paragraph(new Run(new Text("")))); // blank line

            // English content
            var enHeader = body.AppendChild(new Paragraph());
            var enHeaderRun = enHeader.AppendChild(new Run(new Text("ENGLISH TERMS & CONDITIONS")));
            enHeaderRun.RunProperties = new RunProperties(new Bold(), new FontSize { Val = "22" });

            var enPara = body.AppendChild(new Paragraph());
            enPara.AppendChild(new Run(new Text(contentEn)));

            body.AppendChild(new Paragraph(new Run(new Text("")))); // blank line

            // Urdu content
            var urHeader = body.AppendChild(new Paragraph());
            var urHeaderRun = urHeader.AppendChild(new Run(new Text("URDU TERMS & CONDITIONS / شرائط و ضوابط")));
            urHeaderRun.RunProperties = new RunProperties(new Bold(), new FontSize { Val = "22" });

            var urPara = body.AppendChild(new Paragraph());
            urPara.AppendChild(new Run(new Text(contentUr)));

            body.AppendChild(new Paragraph(new Run(new Text("")))); // blank line

            // Signature Block
            var sigPara = body.AppendChild(new Paragraph());
            var sigRun = sigPara.AppendChild(new Run(new Text($"EXECUTANT / DEPONENT: {deponentName ?? "________________"} | CNIC: {cnic ?? "_____-_______-_"}")));
            sigRun.RunProperties = new RunProperties(new Bold());

            wordDoc.Save();
        }

        return Task.FromResult(stream.ToArray());
    }
}

using System.Security.Cryptography;
using LegalSaathi.Api.Infrastructure.Services;
using Xunit;

namespace LegalSaathi.Api.Tests;

public class DocumentGenerationTests
{
    [Fact]
    public async Task QuestPdfGenerator_ShouldGenerateValidPdfBytes_WithSha256Checksum()
    {
        // Arrange
        var generator = new QuestPdfGenerator();
        var docGuid = Guid.NewGuid();

        // Act
        var pdfBytes = await generator.GeneratePdfAsync(
            titleEn: "General Affidavit",
            titleUr: "عمومی بیان حلفی",
            contentEn: "I, Muhammad Ali, CNIC 35201-1234567-1, solemnly affirm that the facts are true.",
            contentUr: "میں مسمی محمد علی، شناختی کارڈ 35201-1234567-1، بحلف اقرار و بیان کرتا ہوں۔",
            documentGuid: docGuid,
            requiresStampPaper: true,
            estimatedStampDuty: 100,
            deponentName: "Muhammad Ali",
            cnic: "35201-1234567-1"
        );

        var sha256 = SHA256.HashData(pdfBytes);
        var hashHex = Convert.ToHexString(sha256).ToLowerInvariant();

        // Assert
        Assert.NotNull(pdfBytes);
        Assert.True(pdfBytes.Length > 1000); // Standard PDF binary is > 1KB
        // PDF header magic bytes "%PDF"
        Assert.Equal(0x25, pdfBytes[0]);
        Assert.Equal(0x50, pdfBytes[1]);
        Assert.Equal(0x44, pdfBytes[2]);
        Assert.Equal(0x46, pdfBytes[3]);
        Assert.Equal(64, hashHex.Length); // 256 bits = 64 hex characters
    }

    [Fact]
    public async Task OpenXmlDocxGenerator_ShouldGenerateValidDocxBytes()
    {
        // Arrange
        var generator = new OpenXmlDocxGenerator();
        var docGuid = Guid.NewGuid();

        // Act
        var docxBytes = await generator.GenerateDocxAsync(
            titleEn: "Non-Disclosure Agreement",
            titleUr: "معاہدہ عدم افشائے راز",
            contentEn: "This agreement is made between Party A and Party B.",
            contentUr: "یہ معاہدہ بمابین فریق اول اور فریق دوم طے پایا۔",
            documentGuid: docGuid,
            deponentName: "Party A",
            cnic: "35201-1234567-1"
        );

        // Assert
        Assert.NotNull(docxBytes);
        Assert.True(docxBytes.Length > 500); // Valid zip archive for .docx
        // Zip magic bytes "PK"
        Assert.Equal(0x50, docxBytes[0]);
        Assert.Equal(0x4B, docxBytes[1]);
    }
}

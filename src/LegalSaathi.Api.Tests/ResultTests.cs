using LegalSaathi.Api.Application.Common.Models;
using Xunit;

namespace LegalSaathi.Api.Tests;

public class ResultTests
{
    [Fact]
    public void Success_ShouldCreateSuccessfulResult()
    {
        // Act
        var result = Result.Success("Done");

        // Assert
        Assert.True(result.Succeeded);
        Assert.Equal("Done", result.Message);
        Assert.Empty(result.Errors);
    }

    [Fact]
    public void Failure_ShouldCreateFailedResultWithErrors()
    {
        // Act
        var result = Result.Failure("Invalid input", "Validation failed");

        // Assert
        Assert.False(result.Succeeded);
        Assert.Equal("Validation failed", result.Message);
        Assert.Single(result.Errors);
        Assert.Equal("Invalid input", result.Errors[0]);
    }

    [Fact]
    public void GenericResult_Success_ShouldContainData()
    {
        // Arrange
        var testData = new { Id = 1, Name = "Rent Agreement" };

        // Act
        var result = Result<object>.Success(testData);

        // Assert
        Assert.True(result.Succeeded);
        Assert.NotNull(result.Data);
        Assert.Equal(testData, result.Data);
    }
}

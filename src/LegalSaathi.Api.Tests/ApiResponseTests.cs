using LegalSaathi.Api.Contracts.Common;
using Xunit;

namespace LegalSaathi.Api.Tests;

public class ApiResponseTests
{
    [Fact]
    public void Ok_ShouldCreateValid200Response()
    {
        // Arrange & Act
        var response = ApiResponse<string>.Ok("SuccessData", "Operation completed.");

        // Assert
        Assert.True(response.Success);
        Assert.Equal(200, response.StatusCode);
        Assert.Equal("SuccessData", response.Data);
        Assert.Equal("Operation completed.", response.Message);
        Assert.Empty(response.Errors);
    }

    [Fact]
    public void Fail_ShouldCreateErrorResponseWithCorrectStatusCode()
    {
        // Arrange & Act
        var response = ApiResponse<string>.Fail("Resource not found", 404, "Not found");

        // Assert
        Assert.False(response.Success);
        Assert.Equal(404, response.StatusCode);
        Assert.Null(response.Data);
        Assert.Single(response.Errors);
        Assert.Equal("Resource not found", response.Errors[0]);
    }
}

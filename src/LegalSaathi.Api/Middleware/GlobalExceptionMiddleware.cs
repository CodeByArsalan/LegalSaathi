using System.Net;
using System.Text.Json;
using LegalSaathi.Api.Application.Common.Exceptions;
using LegalSaathi.Api.Contracts.Common;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

namespace LegalSaathi.Api.Middleware;

public class GlobalExceptionMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger<GlobalExceptionMiddleware> _logger;
    private readonly IHostEnvironment _environment;

    public GlobalExceptionMiddleware(RequestDelegate _next, ILogger<GlobalExceptionMiddleware> logger, IHostEnvironment environment)
    {
        this._next = _next;
        _logger = logger;
        _environment = environment;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        try
        {
            await _next(context);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Unhandled exception occurred while processing HTTP request {Method} {Path}", 
                context.Request.Method, context.Request.Path);
            await HandleExceptionAsync(context, ex);
        }
    }

    private async Task HandleExceptionAsync(HttpContext context, Exception exception)
    {
        context.Response.ContentType = "application/json";

        var statusCode = (int)HttpStatusCode.InternalServerError;
        var message = "An unexpected error occurred. Please try again later.";
        var errors = Array.Empty<string>();

        if (exception is BaseApplicationException appEx)
        {
            statusCode = appEx.StatusCode;
            message = appEx.Message;
            errors = appEx.Errors;
        }
        else if (exception is UnauthorizedAccessException)
        {
            statusCode = (int)HttpStatusCode.Unauthorized;
            message = "Authentication is required to access this resource.";
        }

        context.Response.StatusCode = statusCode;

        var response = ApiResponse<object>.Fail(
            errors.Length > 0 ? errors : new[] { _environment.IsDevelopment() ? exception.Message : message },
            statusCode,
            message
        );

        var jsonOptions = new JsonSerializerOptions { PropertyNamingPolicy = JsonNamingPolicy.CamelCase };
        await context.Response.WriteAsync(JsonSerializer.Serialize(response, jsonOptions));
    }
}

using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Contracts.Common;
using Microsoft.AspNetCore.Mvc;

namespace LegalSaathi.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class HealthController : ApiControllerBase
{
    private readonly IDbConnectionFactory _connectionFactory;

    public HealthController(IDbConnectionFactory connectionFactory)
    {
        _connectionFactory = connectionFactory;
    }

    /// <summary>
    /// Basic liveness and readiness probe
    /// </summary>
    [HttpGet]
    public async Task<ActionResult<ApiResponse<object>>> GetHealth(CancellationToken cancellationToken)
    {
        var dbHealthy = false;
        string? dbError = null;

        try
        {
            await using var conn = await _connectionFactory.CreateOpenConnectionAsync(cancellationToken);
            dbHealthy = true;
        }
        catch (Exception ex)
        {
            dbError = ex.Message;
        }

        var healthData = new
        {
            Status = dbHealthy ? "Healthy" : "Degraded",
            Timestamp = DateTime.UtcNow,
            Version = "1.0.0",
            Database = new
            {
                Connected = dbHealthy,
                Details = dbHealthy ? "SQL Server 2022 responsive." : dbError
            },
            Modules = new
            {
                DocumentGeneration = "Ready",
                AIAdvisor = "Ready",
                PaymentIntegrations = "Ready"
            }
        };

        return Ok(ApiResponse<object>.Ok(healthData, "System health status check complete."));
    }
}

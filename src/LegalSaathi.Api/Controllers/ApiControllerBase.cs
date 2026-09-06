using LegalSaathi.Api.Application.Common.Models;
using LegalSaathi.Api.Contracts.Common;
using Microsoft.AspNetCore.Mvc;

namespace LegalSaathi.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
[Produces("application/json")]
public abstract class ApiControllerBase : ControllerBase
{
    protected ActionResult<ApiResponse<T>> HandleResult<T>(Result<T> result)
    {
        if (result.Succeeded)
        {
            return Ok(ApiResponse<T>.Ok(result.Data!, result.Message));
        }

        return BadRequest(ApiResponse<T>.Fail(result.Errors, 400, result.Message));
    }

    protected ActionResult<ApiResponse> HandleResult(Result result)
    {
        if (result.Succeeded)
        {
            return Ok(ApiResponse.Ok(result.Message));
        }

        return BadRequest(ApiResponse<object>.Fail(result.Errors, 400, result.Message));
    }
}

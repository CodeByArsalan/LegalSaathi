using System.Security.Claims;
using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Contracts.Auth;
using LegalSaathi.Api.Contracts.Common;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace LegalSaathi.Api.Controllers;

[ApiController]
[Route("api/auth")]
[Produces("application/json")]
public class AuthController : ApiControllerBase
{
    private readonly IAuthService _authService;
    private readonly ICurrentUserService _currentUserService;

    public AuthController(IAuthService authService, ICurrentUserService currentUserService)
    {
        _authService = authService;
        _currentUserService = currentUserService;
    }

    /// <summary>
    /// Register a new user account (Citizen, Corporate Admin, or Verified Lawyer)
    /// </summary>
    [HttpPost("register")]
    [AllowAnonymous]
    [ProducesResponseType(typeof(ApiResponse<AuthResponse>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<AuthResponse>), StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<ApiResponse<AuthResponse>>> Register([FromBody] RegisterRequest request, CancellationToken ct)
    {
        var ip = HttpContext.Connection.RemoteIpAddress?.ToString();
        var userAgent = Request.Headers.UserAgent.ToString();
        var result = await _authService.RegisterAsync(request, ip, userAgent, ct);
        return HandleResult(result);
    }

    /// <summary>
    /// Authenticate using Email/Phone and Password
    /// </summary>
    [HttpPost("login")]
    [AllowAnonymous]
    [ProducesResponseType(typeof(ApiResponse<AuthResponse>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<AuthResponse>), StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<ApiResponse<AuthResponse>>> Login([FromBody] LoginRequest request, CancellationToken ct)
    {
        var ip = HttpContext.Connection.RemoteIpAddress?.ToString();
        var userAgent = Request.Headers.UserAgent.ToString();
        var result = await _authService.LoginAsync(request, ip, userAgent, ct);
        return HandleResult(result);
    }

    /// <summary>
    /// Exchange an expired access token and valid refresh token for a fresh token pair
    /// </summary>
    [HttpPost("refresh-token")]
    [AllowAnonymous]
    [ProducesResponseType(typeof(ApiResponse<AuthResponse>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<AuthResponse>), StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<ApiResponse<AuthResponse>>> RefreshToken([FromBody] RefreshTokenRequest request, CancellationToken ct)
    {
        var ip = HttpContext.Connection.RemoteIpAddress?.ToString();
        var userAgent = Request.Headers.UserAgent.ToString();
        var result = await _authService.RefreshTokenAsync(request, ip, userAgent, ct);
        return HandleResult(result);
    }

    /// <summary>
    /// Revoke the active refresh token and sign out
    /// </summary>
    [HttpPost("revoke-token")]
    [Authorize]
    [ProducesResponseType(typeof(ApiResponse), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse), StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<ApiResponse>> RevokeToken(CancellationToken ct)
    {
        var userId = _currentUserService.UserId;
        if (!userId.HasValue)
        {
            return Unauthorized(ApiResponse<object>.Fail("User is not authenticated.", 401));
        }

        var ip = HttpContext.Connection.RemoteIpAddress?.ToString();
        var userAgent = Request.Headers.UserAgent.ToString();
        var result = await _authService.RevokeTokenAsync(userId.Value, ip, userAgent, ct);
        return HandleResult(result);
    }

    /// <summary>
    /// Get the profile of the currently authenticated user
    /// </summary>
    [HttpGet("me")]
    [Authorize]
    [ProducesResponseType(typeof(ApiResponse<UserProfileResponse>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<UserProfileResponse>), StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<ApiResponse<UserProfileResponse>>> GetProfile(CancellationToken ct)
    {
        var userId = _currentUserService.UserId;
        if (!userId.HasValue)
        {
            return Unauthorized(ApiResponse<UserProfileResponse>.Fail("User is not authenticated.", 401));
        }

        var result = await _authService.GetProfileAsync(userId.Value, ct);
        return HandleResult(result);
    }

    /// <summary>
    /// Update personal profile information (Full Name, Mobile Number, CNIC)
    /// </summary>
    [HttpPut("profile")]
    [Authorize]
    [ProducesResponseType(typeof(ApiResponse<UserProfileResponse>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<UserProfileResponse>), StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<ApiResponse<UserProfileResponse>>> UpdateProfile([FromBody] UpdateProfileRequest request, CancellationToken ct)
    {
        var userId = _currentUserService.UserId;
        if (!userId.HasValue)
        {
            return Unauthorized(ApiResponse<UserProfileResponse>.Fail("User is not authenticated.", 401));
        }

        var ip = HttpContext.Connection.RemoteIpAddress?.ToString();
        var userAgent = Request.Headers.UserAgent.ToString();
        var result = await _authService.UpdateProfileAsync(userId.Value, request, ip, userAgent, ct);
        return HandleResult(result);
    }

    /// <summary>
    /// Request an SMS/Email OTP for registration, password reset, or e-signature verification
    /// </summary>
    [HttpPost("send-otp")]
    [AllowAnonymous]
    [ProducesResponseType(typeof(ApiResponse<SendOtpResponse>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<SendOtpResponse>), StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<ApiResponse<SendOtpResponse>>> SendOtp([FromBody] SendOtpRequest request, CancellationToken ct)
    {
        var result = await _authService.SendOtpAsync(request, ct);
        return HandleResult(result);
    }

    /// <summary>
    /// Verify a 6-digit OTP code against the requested destination and purpose
    /// </summary>
    [HttpPost("verify-otp")]
    [AllowAnonymous]
    [ProducesResponseType(typeof(ApiResponse<VerifyOtpResponse>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<VerifyOtpResponse>), StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<ApiResponse<VerifyOtpResponse>>> VerifyOtp([FromBody] VerifyOtpRequest request, CancellationToken ct)
    {
        var result = await _authService.VerifyOtpAsync(request, ct);
        return HandleResult(result);
    }
}

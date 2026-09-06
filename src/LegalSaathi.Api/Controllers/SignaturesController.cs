using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Contracts.Common;
using LegalSaathi.Api.Contracts.Signatures;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace LegalSaathi.Api.Controllers;

[Authorize]
[ApiController]
[Route("api/documents/{documentId:int}/signatures")]
public class SignaturesController : ApiControllerBase
{
    private readonly ISignatureService _signatureService;
    private readonly ICurrentUserService _currentUserService;

    public SignaturesController(ISignatureService signatureService, ICurrentUserService currentUserService)
    {
        _signatureService = signatureService;
        _currentUserService = currentUserService;
    }

    /// <summary>
    /// Request SMS/Email OTP code for signing authorization
    /// </summary>
    [HttpPost("request-otp")]
    public async Task<ActionResult<ApiResponse<RequestSigningOtpResponseDto>>> RequestOtp(
        [FromRoute] int documentId, 
        [FromBody] RequestSigningOtpDto dto, 
        CancellationToken cancellationToken)
    {
        var userId = _currentUserService.UserId;
        if (!userId.HasValue) return Unauthorized();

        var req = new RequestOtpForSigningRequest(
            UserDocumentId: documentId,
            SignerName: dto.SignerName,
            SignerCnic: dto.SignerCnic,
            DestinationPhoneOrEmail: dto.DestinationPhoneOrEmail);

        var result = await _signatureService.RequestSigningOtpAsync(userId.Value, req, cancellationToken);
        if (!result.Succeeded)
        {
            return BadRequest(ApiResponse<RequestSigningOtpResponseDto>.Fail(result.Errors, 400, result.Message));
        }

        var res = result.Data!;
        return Ok(ApiResponse<RequestSigningOtpResponseDto>.Ok(new RequestSigningOtpResponseDto(
            Success: res.Success,
            Message: res.Message,
            DestinationMasked: res.DestinationMasked,
            ExpiresAt: res.ExpiresAt
        ), "OTP code sent."));
    }

    /// <summary>
    /// Submit digital e-signature with OTP verification and canvas capture
    /// </summary>
    [HttpPost]
    public async Task<ActionResult<ApiResponse<SignatureDetailDto>>> SignDocument(
        [FromRoute] int documentId, 
        [FromBody] SubmitSignatureDto dto, 
        CancellationToken cancellationToken)
    {
        var userId = _currentUserService.UserId;
        if (!userId.HasValue) return Unauthorized();

        var req = new SignDocumentRequest(
            UserDocumentId: documentId,
            SignerName: dto.SignerName,
            SignerCnic: dto.SignerCnic,
            SignerRole: dto.SignerRole,
            SignerPhone: dto.SignerPhone,
            SignerEmail: dto.SignerEmail,
            SignatureBase64Image: dto.SignatureBase64Image,
            OtpCode: dto.OtpCode,
            IpAddress: HttpContext.Connection.RemoteIpAddress?.ToString(),
            UserAgent: Request.Headers["User-Agent"].ToString());

        var result = await _signatureService.SignDocumentAsync(userId.Value, req, cancellationToken);
        if (!result.Succeeded)
        {
            return BadRequest(ApiResponse<SignatureDetailDto>.Fail(result.Errors, 400, result.Message));
        }

        var sig = result.Data!;
        return Ok(ApiResponse<SignatureDetailDto>.Ok(new SignatureDetailDto(
            SignatureId: sig.SignatureID,
            UserDocumentId: sig.UserDocument_ID,
            SignerName: sig.SignerName,
            SignerCnic: sig.SignerCnic,
            SignerRole: sig.SignerRole,
            SignerEmail: sig.SignerEmail,
            SignerPhone: sig.SignerPhone,
            SignatureUri: sig.SignatureUri,
            IsOtpVerified: sig.OtpVerified,
            IpAddress: sig.IpAddress,
            SignedAt: sig.SignedDateTime
        ), "Document digitally signed successfully under Pakistan ETO 2002."));
    }

    /// <summary>
    /// List all digital signatures recorded for this document
    /// </summary>
    [HttpGet]
    public async Task<ActionResult<ApiResponse<List<SignatureDetailDto>>>> GetSignatures(
        [FromRoute] int documentId, 
        CancellationToken cancellationToken)
    {
        var userId = _currentUserService.UserId;
        if (!userId.HasValue) return Unauthorized();

        var result = await _signatureService.GetDocumentSignaturesAsync(documentId, userId.Value, cancellationToken);
        if (!result.Succeeded)
        {
            return BadRequest(ApiResponse<List<SignatureDetailDto>>.Fail(result.Errors, 400, result.Message));
        }

        var dtos = result.Data!.Select(sig => new SignatureDetailDto(
            SignatureId: sig.SignatureID,
            UserDocumentId: sig.UserDocument_ID,
            SignerName: sig.SignerName,
            SignerCnic: sig.SignerCnic,
            SignerRole: sig.SignerRole,
            SignerEmail: sig.SignerEmail,
            SignerPhone: sig.SignerPhone,
            SignatureUri: sig.SignatureUri,
            IsOtpVerified: sig.OtpVerified,
            IpAddress: sig.IpAddress,
            SignedAt: sig.SignedDateTime
        )).ToList();

        return Ok(ApiResponse<List<SignatureDetailDto>>.Ok(dtos, "Signatures retrieved successfully."));
    }
}

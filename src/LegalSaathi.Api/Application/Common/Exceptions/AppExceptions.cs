namespace LegalSaathi.Api.Application.Common.Exceptions;

public abstract class BaseApplicationException : Exception
{
    public int StatusCode { get; }
    public string[] Errors { get; }

    protected BaseApplicationException(string message, int statusCode = 500, string[]? errors = null)
        : base(message)
    {
        StatusCode = statusCode;
        Errors = errors ?? Array.Empty<string>();
    }
}

public class ValidationException : BaseApplicationException
{
    public ValidationException(string[] errors) 
        : base("One or more validation failures have occurred.", 400, errors)
    {
    }

    public ValidationException(string error) 
        : base(error, 400, new[] { error })
    {
    }
}

public class NotFoundException : BaseApplicationException
{
    public NotFoundException(string entityName, object key) 
        : base($"Entity \"{entityName}\" ({key}) was not found.", 404)
    {
    }
}

public class UnauthorizedException : BaseApplicationException
{
    public UnauthorizedException(string message = "You are not authorized to perform this operation.") 
        : base(message, 401)
    {
    }
}

public class ForbiddenException : BaseApplicationException
{
    public ForbiddenException(string message = "Access to this resource is forbidden.") 
        : base(message, 403)
    {
    }
}

public class ConflictException : BaseApplicationException
{
    public ConflictException(string message) 
        : base(message, 409)
    {
    }
}

public class ExternalProviderException : BaseApplicationException
{
    public ExternalProviderException(string providerName, string message, Exception? innerException = null) 
        : base($"Error communicating with external provider '{providerName}': {message}", 502)
    {
    }
}

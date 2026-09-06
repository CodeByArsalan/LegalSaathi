namespace LegalSaathi.Api.Application.Common.Models;

public class Result
{
    public bool Succeeded { get; protected set; }
    public string Message { get; protected set; } = string.Empty;
    public string[] Errors { get; protected set; } = Array.Empty<string>();

    protected Result(bool succeeded, string message, IEnumerable<string>? errors = null)
    {
        Succeeded = succeeded;
        Message = message;
        Errors = errors?.ToArray() ?? Array.Empty<string>();
    }

    public static Result Success(string message = "Operation completed successfully.") 
        => new(true, message);

    public static Result Failure(string error, string message = "Operation failed.") 
        => new(false, message, new[] { error });

    public static Result Failure(IEnumerable<string> errors, string message = "Operation failed.") 
        => new(false, message, errors);
}

public class Result<T> : Result
{
    public T? Data { get; private set; }

    private Result(bool succeeded, T? data, string message, IEnumerable<string>? errors = null)
        : base(succeeded, message, errors)
    {
        Data = data;
    }

    public static Result<T> Success(T data, string message = "Operation completed successfully.") 
        => new(true, data, message);

    public new static Result<T> Failure(string error, string message = "Operation failed.") 
        => new(false, default, message, new[] { error });

    public new static Result<T> Failure(IEnumerable<string> errors, string message = "Operation failed.") 
        => new(false, default, message, errors);
}

namespace LegalSaathi.Api.Contracts.Common;

public class ApiResponse<T>
{
    public bool Success { get; set; }
    public int StatusCode { get; set; }
    public string Message { get; set; } = string.Empty;
    public T? Data { get; set; }
    public string[] Errors { get; set; } = Array.Empty<string>();
    public DateTime Timestamp { get; set; } = DateTime.UtcNow;

    public static ApiResponse<T> Ok(T data, string message = "Operation completed successfully.")
    {
        return new ApiResponse<T>
        {
            Success = true,
            StatusCode = 200,
            Message = message,
            Data = data,
            Errors = Array.Empty<string>()
        };
    }

    public static ApiResponse<T> Created(T data, string message = "Resource created successfully.")
    {
        return new ApiResponse<T>
        {
            Success = true,
            StatusCode = 201,
            Message = message,
            Data = data,
            Errors = Array.Empty<string>()
        };
    }

    public static ApiResponse<T> Fail(string error, int statusCode = 400, string message = "Operation failed.")
    {
        return new ApiResponse<T>
        {
            Success = false,
            StatusCode = statusCode,
            Message = message,
            Data = default,
            Errors = new[] { error }
        };
    }

    public static ApiResponse<T> Fail(IEnumerable<string> errors, int statusCode = 400, string message = "Operation failed.")
    {
        return new ApiResponse<T>
        {
            Success = false,
            StatusCode = statusCode,
            Message = message,
            Data = default,
            Errors = errors.ToArray()
        };
    }
}

public class ApiResponse : ApiResponse<object>
{
    public static ApiResponse Ok(string message = "Operation completed successfully.")
    {
        return new ApiResponse
        {
            Success = true,
            StatusCode = 200,
            Message = message,
            Data = null,
            Errors = Array.Empty<string>()
        };
    }
}

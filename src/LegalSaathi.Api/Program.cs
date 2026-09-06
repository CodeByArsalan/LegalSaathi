using System.Text;
using LegalSaathi.Api.Infrastructure;
using LegalSaathi.Api.Middleware;
using LegalSaathi.Api.Security;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

// 1. Configuration & JWT Options
var jwtSettings = new JwtSettings();
builder.Configuration.GetSection(JwtSettings.SectionName).Bind(jwtSettings);
builder.Services.Configure<JwtSettings>(builder.Configuration.GetSection(JwtSettings.SectionName));

// 2. Add Infrastructure Services (ADO.NET, Gateways, Document Generators, AI)
builder.Services.AddInfrastructureServices(builder.Configuration);

// 3. Authentication & Authorization
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options =>
{
    options.RequireHttpsMetadata = false; // Set to true in production
    options.SaveToken = true;
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(
            string.IsNullOrEmpty(jwtSettings.SecretKey) 
                ? "LegalSaathi_Default_Fallback_Key_For_Development_Only_Must_Be_Long_2026!" 
                : jwtSettings.SecretKey)),
        ValidateIssuer = true,
        ValidIssuer = jwtSettings.Issuer,
        ValidateAudience = true,
        ValidAudience = jwtSettings.Audience,
        ValidateLifetime = true,
        ClockSkew = TimeSpan.Zero
    };
    options.Events = new JwtBearerEvents
    {
        OnMessageReceived = context =>
        {
            // If token was not provided in Authorization header, check HttpOnly cookie
            if (string.IsNullOrEmpty(context.Token) &&
                context.Request.Cookies.TryGetValue("legal_saathi_access_token", out var cookieToken) &&
                !string.IsNullOrWhiteSpace(cookieToken))
            {
                context.Token = cookieToken;
            }
            return Task.CompletedTask;
        }
    };
});

builder.Services.AddAuthorization(options =>
{
    options.AddPolicy(AuthorizationPolicies.RequireEndUser, policy => policy.RequireRole(UserRoleNames.EndUser, UserRoleNames.SuperAdmin));
    options.AddPolicy(AuthorizationPolicies.RequireLawyer, policy => policy.RequireRole(UserRoleNames.Lawyer, UserRoleNames.SuperAdmin));
    options.AddPolicy(AuthorizationPolicies.RequireCorporateAdmin, policy => policy.RequireRole(UserRoleNames.CorporateAdmin, UserRoleNames.SuperAdmin));
    options.AddPolicy(AuthorizationPolicies.RequireSuperAdmin, policy => policy.RequireRole(UserRoleNames.SuperAdmin));
});

// 4. CORS Policy for Next.js Web Client
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowNextJsClient", policy =>
    {
        policy.WithOrigins(
                builder.Configuration.GetSection("AllowedCorsOrigins").Get<string[]>() 
                ?? new[] { "http://localhost:3000", "https://legalsaathi.pk" })
              .AllowAnyHeader()
              .AllowAnyMethod()
              .AllowCredentials();
    });
});

// 5. Controllers & JSON Options
builder.Services.AddControllers()
    .AddJsonOptions(options =>
    {
        options.JsonSerializerOptions.PropertyNamingPolicy = System.Text.Json.JsonNamingPolicy.CamelCase;
        options.JsonSerializerOptions.Converters.Add(new System.Text.Json.Serialization.JsonStringEnumConverter());
    });

builder.Services.AddEndpointsApiExplorer();

// 6. Swagger / OpenAPI Documentation
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "Legal Saathi API",
        Version = "v1",
        Description = "ASP.NET Core 8 RESTful Web API for Legal Saathi (Urdu + English LegalTech Platform for Pakistan)",
        Contact = new OpenApiContact
        {
            Name = "Legal Saathi Engineering",
            Email = "engineering@legalsaathi.pk",
            Url = new Uri("https://legalsaathi.pk")
        }
    });

    c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Description = "JWT Authorization header using the Bearer scheme. Example: \"Authorization: Bearer {token}\"",
        Name = "Authorization",
        In = ParameterLocation.Header,
        Type = SecuritySchemeType.ApiKey,
        Scheme = "Bearer"
    });

    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            Array.Empty<string>()
        }
    });
});

var app = builder.Build();

// 7. HTTP Request Pipeline Configuration
app.UseMiddleware<GlobalExceptionMiddleware>();
app.UseMiddleware<RequestLoggingMiddleware>();
app.UseMiddleware<SecurityHeadersMiddleware>();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "Legal Saathi API v1");
        c.RoutePrefix = "swagger";
    });
}

app.UseCors("AllowNextJsClient");

if (!app.Environment.IsDevelopment())
{
    app.UseHttpsRedirection();
}

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();

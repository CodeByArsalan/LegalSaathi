# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy project files and restore dependencies
COPY ["src/LegalSaathi.Api/LegalSaathi.Api.csproj", "src/LegalSaathi.Api/"]
RUN dotnet restore "src/LegalSaathi.Api/LegalSaathi.Api.csproj"

# Copy source code and build
COPY . .
WORKDIR "/src/src/LegalSaathi.Api"
RUN dotnet publish "LegalSaathi.Api.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "LegalSaathi.Api.dll"]

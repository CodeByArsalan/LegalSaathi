namespace LegalSaathi.Api.Domain.Enums;

/// <summary>
/// Core system roles for authorization matching dbo.Roles (1: SuperAdmin, 2: EndUser, 3: CorporateAdmin, 4: Lawyer)
/// </summary>
public enum UserRole
{
    SuperAdmin = 1,
    EndUser = 2,
    CorporateAdmin = 3,
    Lawyer = 4
}


namespace LegalSaathi.Api.Security;

public static class AuthorizationPolicies
{
    public const string RequireEndUser = "RequireEndUser";
    public const string RequireLawyer = "RequireLawyer";
    public const string RequireCorporateAdmin = "RequireCorporateAdmin";
    public const string RequireSuperAdmin = "RequireSuperAdmin";
    public const string RequireStaffOrSuperAdmin = "RequireStaffOrSuperAdmin";
}

public static class UserRoleNames
{
    public const string EndUser = "EndUser";
    public const string Lawyer = "Lawyer";
    public const string CorporateAdmin = "CorporateAdmin";
    public const string SuperAdmin = "SuperAdmin";
}

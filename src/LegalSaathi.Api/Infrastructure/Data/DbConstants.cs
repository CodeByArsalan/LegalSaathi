namespace LegalSaathi.Api.Infrastructure.Data;

public static class DbConstants
{
    public const string ConnectionStringName = "DefaultConnection";

    public static class Procedures
    {
        // Users
        public const string SpUserCreate = "dbo.CreateUser";
        public const string SpUserGetById = "dbo.GetUserById";
        public const string SpUserGetByEmail = "dbo.GetUserByEmail";
        public const string SpUserGetByEmailOrPhone = "dbo.GetUserByEmailOrPhone";
        public const string SpUserUpdate = "dbo.UpdateUser";
        public const string SpUserUpdateRefreshToken = "dbo.UpdateUserRefreshToken";
        public const string SpUserVerifyEmail = "dbo.VerifyUserEmail";

        // Categories & Templates
        public const string SpCategoryGetAll = "dbo.GetAllCategories";
        public const string SpTemplateGetAll = "dbo.GetAllTemplates";
        public const string SpTemplateGetById = "dbo.GetTemplateById";
        public const string SpTemplateGetByCategory = "dbo.GetTemplateByCategory";
        public const string SpTemplateGetBySlug = "dbo.GetTemplateBySlug";
        public const string SpFormFieldGetByTemplate = "dbo.GetFormFieldByTemplate";

        // User Documents & Signatures
        public const string SpUserDocumentCreate = "dbo.CreateUserDocument";
        public const string SpUserDocumentGetById = "dbo.GetUserDocumentById";
        public const string SpUserDocumentGetByUser = "dbo.GetUserDocumentsByUser";
        public const string SpUserDocumentUpdateAnswers = "dbo.UpdateUserDocumentAnswers";
        public const string SpUserDocumentUpdateStatus = "dbo.UpdateUserDocumentStatus";
        public const string SpSignatureCreate = "dbo.CreateSignature";
        public const string SpSignatureGetByDocumentId = "dbo.GetSignatureByDocumentId";

        // Payments
        public const string SpPaymentCreate = "dbo.CreatePayment";
        public const string SpPaymentUpdateStatus = "dbo.UpdatePaymentStatus";
        public const string SpPaymentGetByTxnRef = "dbo.GetPaymentByTransactionReference";
        public const string SpPaymentGetByUser = "dbo.GetPaymentByUser";

        // Lawyers & Reviews
        public const string SpLawyerGetVerified = "dbo.Lawyer_GetVerifiedLawyers";
        public const string SpLawyerGetById = "dbo.GetLawyerById";
        public const string SpLawyerReviewCreate = "dbo.CreateLawyerReview";
        public const string SpLawyerReviewAssign = "dbo.AssignLawyerReview";
        public const string SpLawyerReviewUpdateStatus = "dbo.UpdateLawyerReviewStatus";
        public const string SpLawyerReviewGetByLawyer = "dbo.GetLawyerReviewByLawyer";

        // AI & Audit
        public const string SpAiQueryCreate = "dbo.CreateAIQuery";
        public const string SpAiQueryGetByDocument = "dbo.GetAIQueryByDocument";
        public const string SpAuditLogCreate = "dbo.CreateAuditLog";
    }
}


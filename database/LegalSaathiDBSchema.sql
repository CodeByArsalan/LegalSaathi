USE [LegalSaathiDB]
GO
/****** Object:  Table [dbo].[AIQueries]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AIQueries](
	[QueryID] [bigint] IDENTITY(1,1) NOT NULL,
	[User_ID] [int] NULL,
	[UserDocument_ID] [int] NULL,
	[Template_ID] [int] NULL,
	[Prompt] [nvarchar](max) NOT NULL,
	[Response] [nvarchar](max) NOT NULL,
	[LanguageCode] [nvarchar](10) NOT NULL,
	[Tokens] [int] NOT NULL,
	[PromptTokens] [int] NOT NULL,
	[CompletionTokens] [int] NOT NULL,
	[ModelUsed] [nvarchar](50) NOT NULL,
	[CreatedDateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_AIQueries] PRIMARY KEY CLUSTERED 
(
	[QueryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuditLogs]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditLogs](
	[AuditLogID] [bigint] IDENTITY(1,1) NOT NULL,
	[User_ID] [int] NULL,
	[Action] [nvarchar](100) NOT NULL,
	[EntityName] [nvarchar](100) NOT NULL,
	[EntityID] [nvarchar](100) NULL,
	[IpAddress] [nvarchar](50) NULL,
	[UserAgent] [nvarchar](500) NULL,
	[OldValuesJson] [nvarchar](max) NULL,
	[NewValuesJson] [nvarchar](max) NULL,
	[IntegrityChecksum] [nvarchar](128) NULL,
	[CreatedDateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_AuditLogs] PRIMARY KEY CLUSTERED 
(
	[AuditLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DocumentStatuses]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentStatuses](
	[DocumentStatusID] [int] IDENTITY(1,1) NOT NULL,
	[DocumentStatus] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[DocumentStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FormFields]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FormFields](
	[FormFieldID] [int] IDENTITY(1,1) NOT NULL,
	[Template_ID] [int] NOT NULL,
	[FieldKey] [nvarchar](100) NOT NULL,
	[FieldType] [nvarchar](50) NOT NULL,
	[LabelEng] [nvarchar](250) NOT NULL,
	[LabelUrdu] [nvarchar](250) NOT NULL,
	[PlaceholderEng] [nvarchar](250) NULL,
	[PlaceholderUrdu] [nvarchar](250) NULL,
	[HelpTextEng] [nvarchar](500) NULL,
	[HelpTextUrdu] [nvarchar](500) NULL,
	[IsRequired] [bit] NOT NULL,
	[ValidationRegex] [nvarchar](500) NULL,
	[OptionsJson] [nvarchar](max) NULL,
	[ConditionalLogicJson] [nvarchar](max) NULL,
	[StepNumber] [int] NOT NULL,
	[SortOrder] [int] NOT NULL,
	[CreatedDateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_FormFields] PRIMARY KEY CLUSTERED 
(
	[FormFieldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LawyerReviews]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LawyerReviews](
	[LawyerReviewID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserDocument_ID] [int] NOT NULL,
	[Lawyer_ID] [int] NULL,
	[Notes] [nvarchar](max) NULL,
	[AnnotatedPdfPath] [nvarchar](500) NULL,
	[ReviewFee] [decimal](18, 2) NOT NULL,
	[LawyerShareAmount] [decimal](18, 2) NOT NULL,
	[PlatformShareAmount] [decimal](18, 2) NOT NULL,
	[LawyerReviewStatus_ID] [int] NULL,
	[RequesteDateTime] [datetime2](7) NOT NULL,
	[AssignedDateTime] [datetime2](7) NULL,
	[CompletedDateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_LawyerReviews] PRIMARY KEY CLUSTERED 
(
	[LawyerReviewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LawyerReviewStatuses]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LawyerReviewStatuses](
	[LawyerReviewStatuseID] [int] IDENTITY(1,1) NOT NULL,
	[LawyerReviewStatuse] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[LawyerReviewStatuseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lawyers]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lawyers](
	[LawyerID] [int] IDENTITY(1,1) NOT NULL,
	[User_ID] [int] NOT NULL,
	[BarCouncilNumber] [nvarchar](100) NOT NULL,
	[BarCouncilProvince] [nvarchar](50) NOT NULL,
	[Specialization] [nvarchar](200) NOT NULL,
	[YearsOfExperience] [int] NOT NULL,
	[OfficeAddress] [nvarchar](300) NULL,
	[LicenseDocumentUri] [nvarchar](500) NULL,
	[VerifiedStatus] [bit] NOT NULL,
	[VerifiedDateTime] [datetime2](7) NULL,
	[VerifiedByUserID] [int] NULL,
	[Rating] [decimal](3, 2) NOT NULL,
	[TotalReviewsCompleted] [int] NOT NULL,
	[CreatedDateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Lawyers] PRIMARY KEY CLUSTERED 
(
	[LawyerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentGateways]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentGateways](
	[PaymentGatewayID] [int] IDENTITY(1,1) NOT NULL,
	[PaymentGateway] [varchar](25) NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentGatewayID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[PaymentID] [bigint] IDENTITY(1,1) NOT NULL,
	[PaymentGuid] [uniqueidentifier] NOT NULL,
	[User_ID] [int] NOT NULL,
	[UserDocument_ID] [int] NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[Currency] [nvarchar](10) NOT NULL,
	[PaymentGateway_ID] [int] NOT NULL,
	[PaymentStatus_ID] [int] NOT NULL,
	[TxnRef] [nvarchar](150) NULL,
	[GatewayTxnId] [nvarchar](150) NULL,
	[GatewayPayload] [nvarchar](max) NULL,
	[CreatedDateTime] [datetime2](7) NOT NULL,
	[CompletedDateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_Payments] PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentStatuses]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentStatuses](
	[PaymentStatusID] [int] IDENTITY(1,1) NOT NULL,
	[PaymentStatus] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[ROLENAME] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Signatures]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Signatures](
	[SignatureID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserDocument_ID] [int] NOT NULL,
	[SignerName] [nvarchar](150) NOT NULL,
	[SignerCnic] [nvarchar](20) NOT NULL,
	[SignerRole] [nvarchar](100) NOT NULL,
	[SignerEmail] [nvarchar](256) NULL,
	[SignerPhone] [nvarchar](20) NULL,
	[SignatureUri] [nvarchar](500) NOT NULL,
	[OtpVerified] [bit] NOT NULL,
	[OtpCodeHash] [nvarchar](256) NULL,
	[IpAddress] [nvarchar](50) NULL,
	[UserAgent] [nvarchar](500) NULL,
	[SignedDateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Signatures] PRIMARY KEY CLUSTERED 
(
	[SignatureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TemplateCategories]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TemplateCategories](
	[TemplateCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[NameEng] [nvarchar](150) NOT NULL,
	[NameUrdu] [nvarchar](150) NOT NULL,
	[DescriptionEng] [nvarchar](500) NULL,
	[DescriptionUrdu] [nvarchar](500) NULL,
	[Icon] [nvarchar](50) NULL,
	[SortOrder] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedDateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_TemplateCategories] PRIMARY KEY CLUSTERED 
(
	[TemplateCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Templates]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Templates](
	[TemplateID] [int] IDENTITY(1,1) NOT NULL,
	[Category_ID] [int] NOT NULL,
	[Slug] [nvarchar](150) NOT NULL,
	[TitleEng] [nvarchar](200) NOT NULL,
	[TitleUrdu] [nvarchar](200) NOT NULL,
	[DescriptionEng] [nvarchar](1000) NULL,
	[DescriptionUrdu] [nvarchar](1000) NULL,
	[BasePrice] [decimal](18, 2) NOT NULL,
	[Tier] [nvarchar](50) NOT NULL,
	[ContentTemplateEng] [nvarchar](max) NOT NULL,
	[ContentTemplateUrdu] [nvarchar](max) NOT NULL,
	[ApplicableLaws] [nvarchar](500) NULL,
	[RequiresStampPaper] [bit] NOT NULL,
	[EstimatedStampDuty] [decimal](18, 2) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedDateTime] [datetime2](7) NOT NULL,
	[UpdatedDateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_Templates] PRIMARY KEY CLUSTERED 
(
	[TemplateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserDocuments]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserDocuments](
	[UserDocumentID] [int] IDENTITY(1,1) NOT NULL,
	[DocumentGuid] [uniqueidentifier] NOT NULL,
	[User_ID] [int] NOT NULL,
	[Template_ID] [int] NOT NULL,
	[Title] [nvarchar](250) NOT NULL,
	[FormAnswers] [nvarchar](max) NOT NULL,
	[StoragePath] [nvarchar](500) NULL,
	[DocxStoragePath] [nvarchar](500) NULL,
	[DocumentHash] [nvarchar](128) NULL,
	[DocumentStatus_ID] [int] NULL,
	[IsPaid] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[CompletedAt] [datetime2](7) NULL,
 CONSTRAINT [PK_UserDocuments] PRIMARY KEY CLUSTERED 
(
	[UserDocumentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[Email] [nvarchar](256) NOT NULL,
	[Phone] [nvarchar](20) NOT NULL,
	[PasswordHash] [nvarchar](500) NOT NULL,
	[Role_ID] [int] NULL,
	[Cnic] [nvarchar](20) NULL,
	[IsEmailVerified] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[RefreshToken] [nvarchar](500) NULL,
	[RefreshTokenExpiryDateTime] [datetime2](7) NULL,
	[CreatedDateTime] [datetime2](7) NOT NULL,
	[UpdatedDateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[DocumentStatuses] ON 

INSERT [dbo].[DocumentStatuses] ([DocumentStatusID], [DocumentStatus]) VALUES (1, N'Draft')
INSERT [dbo].[DocumentStatuses] ([DocumentStatusID], [DocumentStatus]) VALUES (2, N'Completed')
INSERT [dbo].[DocumentStatuses] ([DocumentStatusID], [DocumentStatus]) VALUES (3, N'PendingSignature')
INSERT [dbo].[DocumentStatuses] ([DocumentStatusID], [DocumentStatus]) VALUES (4, N'Signed')
INSERT [dbo].[DocumentStatuses] ([DocumentStatusID], [DocumentStatus]) VALUES (5, N'UnderLawyerReview')
INSERT [dbo].[DocumentStatuses] ([DocumentStatusID], [DocumentStatus]) VALUES (6, N'LawyerApproved')
INSERT [dbo].[DocumentStatuses] ([DocumentStatusID], [DocumentStatus]) VALUES (7, N'Archived')
SET IDENTITY_INSERT [dbo].[DocumentStatuses] OFF
GO
SET IDENTITY_INSERT [dbo].[FormFields] ON 

INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (1, 1, N'DeponentName', N'Text', N'Deponent Full Name', N'بیان دہندہ کا پورا نام', N'e.g. Muhammad Ali', N'مثال: محمد علی', N'Enter legal name as per CNIC', N'شناختی کارڈ کے مطابق نام درج کریں', 1, NULL, NULL, NULL, 1, 1, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (2, 1, N'FatherName', N'Text', N'Father / Husband Name', N'والد / شوہر کا نام', N'e.g. Ahmad Khan', N'مثال: احمد خان', NULL, NULL, 1, NULL, NULL, NULL, 1, 2, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (3, 1, N'Cnic', N'Cnic', N'CNIC Number', N'قومی شناختی کارڈ نمبر', N'35201-1234567-1', N'35201-1234567-1', N'13-digit Pakistani CNIC', N'13 ہندسوں کا شناختی کارڈ نمبر', 1, N'^[0-9]{5}-[0-9]{7}-[0-9]$', NULL, NULL, 1, 3, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (4, 1, N'Address', N'Address', N'Residential Address', N'رہائشی پتہ', N'House #, Street, City', N'مکان نمبر، گلی، شہر', NULL, NULL, 1, NULL, NULL, NULL, 1, 4, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (5, 1, N'AffidavitStatement', N'TextArea', N'Sworn Statement / Facts', N'بیان حلفی کی تفصیل / حقائق', N'State the facts clearly...', N'اپنے بیانات اور حقائق واضح طور پر تحریر کریں...', N'Write clearly without assumptions', N'صرف مصدقہ حقائق بیان کریں', 1, NULL, NULL, NULL, 2, 1, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))

-- Template 2: Residential Rent Agreement
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (6, 2, N'AgreementDate', N'Date', N'Agreement Date', N'معاہدے کی تاریخ', N'YYYY-MM-DD', N'YYYY-MM-DD', N'Date of tenancy execution', N'معاہدے کی تاریخ', 1, NULL, NULL, NULL, 1, 1, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (7, 2, N'LandlordName', N'Text', N'Landlord Full Name', N'مالک مکان کا پورا نام', N'e.g. Tariq Mehmood', N'مثال: طارق محمود', N'As per CNIC', N'شناختی کارڈ کے مطابق نام', 1, NULL, NULL, NULL, 1, 2, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (8, 2, N'LandlordCnic', N'Cnic', N'Landlord CNIC', N'مالک مکان کا شناختی کارڈ نمبر', N'35201-1111111-1', N'35201-1111111-1', N'13-digit Pakistani CNIC', N'13 ہندسوں کا شناختی کارڈ نمبر', 1, N'^[0-9]{5}-[0-9]{7}-[0-9]$', NULL, NULL, 1, 3, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (9, 2, N'TenantName', N'Text', N'Tenant Full Name', N'کرایہ دار کا پورا نام', N'e.g. Usman Ali', N'مثال: عثمان علی', N'As per CNIC', N'شناختی کارڈ کے مطابق نام', 1, NULL, NULL, NULL, 1, 4, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (10, 2, N'TenantCnic', N'Cnic', N'Tenant CNIC', N'کرایہ دار کا شناختی کارڈ نمبر', N'35201-2222222-2', N'35201-2222222-2', N'13-digit Pakistani CNIC', N'13 ہندسوں کا شناختی کارڈ نمبر', 1, N'^[0-9]{5}-[0-9]{7}-[0-9]$', NULL, NULL, 1, 5, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (11, 2, N'PropertyAddress', N'Address', N'Rental Property Address', N'کرایہ کی جائیداد کا پتہ', N'House #, Street, Phase, City', N'مکان نمبر، گلی، فیز، شہر', N'Complete physical address of premises', N'جائیداد کا مکمل پتہ', 1, NULL, NULL, NULL, 2, 1, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (12, 2, N'MonthlyRent', N'Text', N'Monthly Rent (PKR)', N'ماہانہ کرایہ (روپے)', N'e.g. 45000', N'مثال: 45000', N'Agreed monthly rent in PKR', N'طے شدہ ماہانہ کرایہ', 1, NULL, NULL, NULL, 2, 2, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (13, 2, N'SecurityDeposit', N'Text', N'Security Deposit (PKR)', N'سیکیورٹی ڈپازٹ (روپے)', N'e.g. 90000', N'مثال: 90000', N'Refundable security advance amount', N'قابل واپسی ایڈوانس سیکیورٹی رقم', 1, NULL, NULL, NULL, 2, 3, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (14, 2, N'DurationMonths', N'Text', N'Tenancy Duration (Months)', N'مدت کرایہ داری (ماہ)', N'e.g. 11', N'مثال: 11', N'Tenancy period in months', N'کرایہ داری کی مدت', 1, NULL, NULL, NULL, 2, 4, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))

-- Template 3: Vehicle Sale Deed
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (15, 3, N'SellerName', N'Text', N'Seller Full Name', N'فروخت کنندہ کا پورا نام', N'e.g. Kamran Ashraf', N'مثال: کامران اشرف', N'As per vehicle registration & CNIC', N'شناختی کارڈ و رجسٹریشن کے مطابق نام', 1, NULL, NULL, NULL, 1, 1, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (16, 3, N'SellerCnic', N'Cnic', N'Seller CNIC', N'فروخت کنندہ کا شناختی کارڈ نمبر', N'35201-3333333-3', N'35201-3333333-3', N'13-digit Pakistani CNIC', N'13 ہندسوں کا شناختی کارڈ نمبر', 1, N'^[0-9]{5}-[0-9]{7}-[0-9]$', NULL, NULL, 1, 2, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (17, 3, N'BuyerName', N'Text', N'Buyer Full Name', N'خریدار کا پورا نام', N'e.g. Bilal Ahmed', N'مثال: بلال احمد', N'Purchaser name as per CNIC', N'خریدار کا شناختی کارڈ کے مطابق نام', 1, NULL, NULL, NULL, 1, 3, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (18, 3, N'BuyerCnic', N'Cnic', N'Buyer CNIC', N'خریدار کا شناختی کارڈ نمبر', N'35201-4444444-4', N'35201-4444444-4', N'13-digit Pakistani CNIC', N'13 ہندسوں کا شناختی کارڈ نمبر', 1, N'^[0-9]{5}-[0-9]{7}-[0-9]$', NULL, NULL, 1, 4, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (19, 3, N'RegNumber', N'Text', N'Registration Number', N'رجسٹریشن نمبر', N'e.g. LEB-21-4567', N'مثال: LEB-21-4567', N'Vehicle registration number', N'گاڑی کا ایکسائز نمبر', 1, NULL, NULL, NULL, 2, 1, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (20, 3, N'MakeModel', N'Text', N'Make / Model / Year', N'گاڑی کی قسم / ماڈل / سال', N'e.g. Toyota Corolla 2021', N'مثال: ٹویوٹا کرولا 2021', N'Vehicle make, model and manufacturing year', N'گاڑی کی کمپنی، ماڈل اور سال', 1, NULL, NULL, NULL, 2, 2, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (21, 3, N'EngineNumber', N'Text', N'Engine Number', N'انجن نمبر', N'e.g. 1NZ-5893214', N'مثال: 1NZ-5893214', N'As printed in vehicle registration book', N'رجسٹریشن بک کے مطابق انجن نمبر', 1, NULL, NULL, NULL, 2, 3, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (22, 3, N'ChassisNumber', N'Text', N'Chassis / Frame Number', N'چیسس نمبر', N'e.g. NZE140-9012345', N'مثال: NZE140-9012345', N'Frame chassis number', N'گاڑی کا چیسس نمبر', 1, NULL, NULL, NULL, 2, 4, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (23, 3, N'SaleAmount', N'Text', N'Total Sale Price (PKR)', N'کل قیمت فروخت (روپے)', N'e.g. 3500000', N'مثال: 3500000', N'Total agreed sale consideration', N'طے شدہ کل رقم برائے فروخت', 1, NULL, NULL, NULL, 2, 5, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))

-- Template 4: Non-Disclosure Agreement (NDA)
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (24, 4, N'DisclosingParty', N'Text', N'Disclosing Party Name', N'معلومات ظاہر کرنے والے فریق کا نام', N'Company / Individual Name', N'کمپنی یا فرد کا نام', N'Party disclosing confidential information', N'فریق اول کا قانونی نام', 1, NULL, NULL, NULL, 1, 1, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (25, 4, N'ReceivingParty', N'Text', N'Receiving Party Name', N'معلومات وصول کرنے والے فریق کا نام', N'Company / Individual Name', N'کمپنی یا فرد کا نام', N'Party receiving proprietary information', N'فریق دوم کا قانونی نام', 1, NULL, NULL, NULL, 1, 2, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (26, 4, N'ProjectScope', N'TextArea', N'Confidential Purpose / Project Scope', N'خفیہ معلومات کا دائرہ کار / منصوبہ', N'Describe the project or confidential domain...', N'منصوبے یا کاروباری راز کی وضاحت کریں...', N'Scope of protected information', N'خفیہ معلومات کا دائرہ کار', 1, NULL, NULL, NULL, 2, 1, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (27, 4, N'DurationYears', N'Text', N'Confidentiality Term (Years)', N'رازداری کی مدت (سال)', N'e.g. 3', N'مثال: 3', N'Non-disclosure duration in years', N'معاہدے کی مدت سالوں میں', 1, NULL, NULL, NULL, 2, 2, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))

-- Template 5: Employment Contract
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (28, 5, N'EmployerName', N'Text', N'Employer / Company Name', N'مالک / ادارے کا نام', N'e.g. Saathi Technologies Pvt Ltd', N'مثال: ساتھی ٹیکنالوجیز پرائیویٹ لمیٹڈ', N'Official registered employer entity', N'ادارے کا رجسٹرڈ نام', 1, NULL, NULL, NULL, 1, 1, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (29, 5, N'EmployeeName', N'Text', N'Employee Full Name', N'ملازم کا پورا نام', N'e.g. Zaid Khan', N'مثال: زید خان', N'As per CNIC', N'شناختی کارڈ کے مطابق ملازم کا نام', 1, NULL, NULL, NULL, 1, 2, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (30, 5, N'JobTitle', N'Text', N'Job Designation / Title', N'عہدہ / جاب ٹائٹل', N'e.g. Senior Software Engineer', N'مثال: سینئر سافٹ ویئر انجینئر', N'Position title', N'ملازمت کا عہدہ', 1, NULL, NULL, NULL, 2, 1, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (31, 5, N'MonthlySalary', N'Text', N'Monthly Salary (PKR)', N'ماہانہ تنخواہ (روپے)', N'e.g. 150000', N'مثال: 150000', N'Monthly remuneration', N'ماہانہ مشاہرہ', 1, NULL, NULL, NULL, 2, 2, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (32, 5, N'JoiningDate', N'Date', N'Joining Date', N'شمولیت کی تاریخ', N'YYYY-MM-DD', N'YYYY-MM-DD', N'First day of employment', N'ملازمت کے آغاز کی تاریخ', 1, NULL, NULL, NULL, 2, 3, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))

-- Template 6: Memorandum of Understanding (MOU)
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (33, 6, N'PartyA', N'Text', N'First Party / Entity', N'فریق اول / ادارہ', N'e.g. Alpha Solutions Pvt Ltd', N'مثال: الفا سلوشنز پرائیویٹ لمیٹڈ', N'First collaborating organization', N'پہلا فریق', 1, NULL, NULL, NULL, 1, 1, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (34, 6, N'PartyB', N'Text', N'Second Party / Entity', N'فریق دوم / ادارہ', N'e.g. Beta Services Ltd', N'مثال: بیٹا سروسز لمیٹڈ', N'Second collaborating organization', N'دوسرا فریق', 1, NULL, NULL, NULL, 1, 2, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (35, 6, N'CollaborationPurpose', N'TextArea', N'Collaboration Purpose', N'باہمی تعاون کا مقصد', N'Describe strategic cooperation areas...', N'باہمی تعاون اور اشتراک کے مقاصد تحریر کریں...', N'Strategic goals of agreement', N'مشترکہ مقاصد', 1, NULL, NULL, NULL, 2, 1, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))

-- Template 7: Partnership Deed (Sharakat Nama)
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (36, 7, N'FirmName', N'Text', N'Partnership Firm Name', N'شراکت داری فرم کا نام', N'e.g. Prime Agro Enterprises', N'مثال: پرائم ایگرو انٹرپرائزز', N'Business trade name', N'کاروباری فرم کا نام', 1, NULL, NULL, NULL, 1, 1, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (37, 7, N'DeedDate', N'Date', N'Deed Execution Date', N'معاہدے کی تاریخ', N'YYYY-MM-DD', N'YYYY-MM-DD', N'Date of partnership signing', N'شراکت نامہ کی تاریخ', 1, NULL, NULL, NULL, 1, 2, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
INSERT [dbo].[FormFields] ([FormFieldID], [Template_ID], [FieldKey], [FieldType], [LabelEng], [LabelUrdu], [PlaceholderEng], [PlaceholderUrdu], [HelpTextEng], [HelpTextUrdu], [IsRequired], [ValidationRegex], [OptionsJson], [ConditionalLogicJson], [StepNumber], [SortOrder], [CreatedDateTime]) VALUES (38, 7, N'ProfitRatio', N'Text', N'Profit / Loss Ratio', N'نفع و نقصان کا تناسب', N'e.g. 50:50 or 60:40', N'مثال: 50:50 یا 60:40', N'Agreed distribution ratio', N'نفع و نقصان کا تناسب', 1, NULL, NULL, NULL, 2, 1, CAST(N'2026-09-05T21:43:20.5121987' AS DateTime2))
SET IDENTITY_INSERT [dbo].[FormFields] OFF
GO
SET IDENTITY_INSERT [dbo].[LawyerReviewStatuses] ON 

INSERT [dbo].[LawyerReviewStatuses] ([LawyerReviewStatuseID], [LawyerReviewStatuse]) VALUES (1, N'Requested')
INSERT [dbo].[LawyerReviewStatuses] ([LawyerReviewStatuseID], [LawyerReviewStatuse]) VALUES (2, N'Assigned')
INSERT [dbo].[LawyerReviewStatuses] ([LawyerReviewStatuseID], [LawyerReviewStatuse]) VALUES (3, N'InProgress')
INSERT [dbo].[LawyerReviewStatuses] ([LawyerReviewStatuseID], [LawyerReviewStatuse]) VALUES (4, N'ChangesSuggested')
INSERT [dbo].[LawyerReviewStatuses] ([LawyerReviewStatuseID], [LawyerReviewStatuse]) VALUES (5, N'ApprovedAndStamped')
INSERT [dbo].[LawyerReviewStatuses] ([LawyerReviewStatuseID], [LawyerReviewStatuse]) VALUES (6, N'Rejected')
SET IDENTITY_INSERT [dbo].[LawyerReviewStatuses] OFF
GO
SET IDENTITY_INSERT [dbo].[PaymentGateways] ON 

INSERT [dbo].[PaymentGateways] ([PaymentGatewayID], [PaymentGateway]) VALUES (1, N'Free')
INSERT [dbo].[PaymentGateways] ([PaymentGatewayID], [PaymentGateway]) VALUES (2, N'EasyPaisa')
INSERT [dbo].[PaymentGateways] ([PaymentGatewayID], [PaymentGateway]) VALUES (3, N'JazzCash')
SET IDENTITY_INSERT [dbo].[PaymentGateways] OFF
GO
SET IDENTITY_INSERT [dbo].[PaymentStatuses] ON 

INSERT [dbo].[PaymentStatuses] ([PaymentStatusID], [PaymentStatus]) VALUES (1, N'Pending')
INSERT [dbo].[PaymentStatuses] ([PaymentStatusID], [PaymentStatus]) VALUES (2, N'Success')
INSERT [dbo].[PaymentStatuses] ([PaymentStatusID], [PaymentStatus]) VALUES (3, N'Failed')
INSERT [dbo].[PaymentStatuses] ([PaymentStatusID], [PaymentStatus]) VALUES (4, N'Signed')
INSERT [dbo].[PaymentStatuses] ([PaymentStatusID], [PaymentStatus]) VALUES (5, N'Refunded')
INSERT [dbo].[PaymentStatuses] ([PaymentStatusID], [PaymentStatus]) VALUES (6, N'Cancelled')
SET IDENTITY_INSERT [dbo].[PaymentStatuses] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleID], [ROLENAME]) VALUES (1, N'SuperAdmin')
INSERT [dbo].[Roles] ([RoleID], [ROLENAME]) VALUES (2, N'EndUser')
INSERT [dbo].[Roles] ([RoleID], [ROLENAME]) VALUES (3, N'CorporateAdmin')
INSERT [dbo].[Roles] ([RoleID], [ROLENAME]) VALUES (4, N'Lawyer')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[TemplateCategories] ON 

INSERT [dbo].[TemplateCategories] ([TemplateCategoryID], [NameEng], [NameUrdu], [DescriptionEng], [DescriptionUrdu], [Icon], [SortOrder], [IsActive], [CreatedDateTime]) VALUES (1, N'Personal & Family', N'ذاتی اور خاندانی', N'Affidavits, Power of Attorney, Declarations.', N'حلف نامے، مختار نامہ، اور ذاتی بیانات۔', N'Users', 1, 1, CAST(N'2026-09-05T21:42:32.4117098' AS DateTime2))
INSERT [dbo].[TemplateCategories] ([TemplateCategoryID], [NameEng], [NameUrdu], [DescriptionEng], [DescriptionUrdu], [Icon], [SortOrder], [IsActive], [CreatedDateTime]) VALUES (2, N'Real Estate & Tenancy', N'جائیداد اور کرایہ داری', N'Residential & Commercial Leases, Sale Bayana, Eviction Notices.', N'رہائشی و کمرشل کرایہ نامے، بیعانہ اور نوٹسز۔', N'Home', 2, 1, CAST(N'2026-09-05T21:42:32.4127102' AS DateTime2))
INSERT [dbo].[TemplateCategories] ([TemplateCategoryID], [NameEng], [NameUrdu], [DescriptionEng], [DescriptionUrdu], [Icon], [SortOrder], [IsActive], [CreatedDateTime]) VALUES (3, N'Business / Freelance / SME', N'کاروبار اور فری لانسنگ', N'NDAs, Employment, Freelance Agreements, MOUs, Partnership Deeds.', N'معاہدات ملازمت، این ڈی اے، مفاہمتی یادداشت اور شراکت نامے۔', N'Briefcase', 3, 1, CAST(N'2026-09-05T21:42:32.4127102' AS DateTime2))
INSERT [dbo].[TemplateCategories] ([TemplateCategoryID], [NameEng], [NameUrdu], [DescriptionEng], [DescriptionUrdu], [Icon], [SortOrder], [IsActive], [CreatedDateTime]) VALUES (4, N'Vehicles & Assets', N'گاڑیاں اور اثاثہ جات', N'Vehicle Sale Deeds, Delivery Receipts, Promissory Notes.', N'گاڑیوں کا بیع نامہ، وصولی رسید، اور اقرار نامے۔', N'Car', 4, 1, CAST(N'2026-09-05T21:42:32.4127102' AS DateTime2))
SET IDENTITY_INSERT [dbo].[TemplateCategories] OFF
GO
SET IDENTITY_INSERT [dbo].[Templates] ON 

INSERT [dbo].[Templates] ([TemplateID], [Category_ID], [Slug], [TitleEng], [TitleUrdu], [DescriptionEng], [DescriptionUrdu], [BasePrice], [Tier], [ContentTemplateEng], [ContentTemplateUrdu], [ApplicableLaws], [RequiresStampPaper], [EstimatedStampDuty], [IsActive], [CreatedDateTime], [UpdatedDateTime]) VALUES (1, 1, N'general-affidavit', N'General Affidavit (Bayan-e-Halfi)', N'عمومی بیان حلفی', N'Court-compliant general sworn statement of truth for official, academic, or administrative use.', N'سرکاری، تعلیمی اور انتظامی مقاصد کے لیے تصدیق شدہ عدالتی بیان حلفی۔', CAST(0.00 AS Decimal(18, 2)), N'Free', N'LEGAL CONTENT REQUIRES LAWYER VERIFICATION: I, {{DeponentName}}, son/daughter of {{FatherName}}, holding CNIC No. {{Cnic}}, resident of {{Address}}, do hereby solemnly affirm and declare on oath as under: {{AffidavitStatement}}', N'LEGAL CONTENT REQUIRES LAWYER VERIFICATION: میں، {{DeponentName}}، ولد/دختر {{FatherName}}، شناختی کارڈ نمبر {{Cnic}}، ساکن {{Address}}، بحلف اقرار و بیان کرتا/کرتی ہوں کہ: {{AffidavitStatement}}', N'Oaths Act 1873, High Court Rules & Orders', 1, CAST(100.00 AS Decimal(18, 2)), 1, CAST(N'2026-09-05T21:42:42.6469866' AS DateTime2), NULL)
INSERT [dbo].[Templates] ([TemplateID], [Category_ID], [Slug], [TitleEng], [TitleUrdu], [DescriptionEng], [DescriptionUrdu], [BasePrice], [Tier], [ContentTemplateEng], [ContentTemplateUrdu], [ApplicableLaws], [RequiresStampPaper], [EstimatedStampDuty], [IsActive], [CreatedDateTime], [UpdatedDateTime]) VALUES (2, 2, N'residential-rent-agreement', N'Residential Rent Agreement', N'رہائشی کرایہ نامہ', N'Standard tenancy contract between Landlord and Tenant with rent, deposit, and maintenance terms.', N'مالک مکان اور کرایہ دار کے مابین قانونی معاہدہ مع کرایہ، سیکیورٹی ڈپازٹ اور شرائط۔', CAST(199.00 AS Decimal(18, 2)), N'Standard', N'LEGAL CONTENT REQUIRES LAWYER VERIFICATION: This Tenancy Agreement is entered into on {{AgreementDate}} between {{LandlordName}} (Landlord) and {{TenantName}} (Tenant) for the property situated at {{PropertyAddress}} for monthly rent PKR {{MonthlyRent}}.', N'LEGAL CONTENT REQUIRES LAWYER VERIFICATION: یہ کرایہ نامہ بتاریخ {{AgreementDate}} بمقام بمابین {{LandlordName}} (مالک مکان) اور {{TenantName}} (کرایہ دار) برائے جائیداد واقع {{PropertyAddress}} بماہانہ کرایہ {{MonthlyRent}} روپے طے پایا۔', N'Punjab/Sindh/KPK Rented Premises Acts, Contract Act 1872', 1, CAST(1200.00 AS Decimal(18, 2)), 1, CAST(N'2026-09-05T21:42:50.4830132' AS DateTime2), NULL)
INSERT [dbo].[Templates] ([TemplateID], [Category_ID], [Slug], [TitleEng], [TitleUrdu], [DescriptionEng], [DescriptionUrdu], [BasePrice], [Tier], [ContentTemplateEng], [ContentTemplateUrdu], [ApplicableLaws], [RequiresStampPaper], [EstimatedStampDuty], [IsActive], [CreatedDateTime], [UpdatedDateTime]) VALUES (3, 4, N'vehicle-sale-deed', N'Vehicle / Motorcycle Sale Deed', N'گاڑی / موٹر سائیکل کا بیع نامہ', N'Legally binding transfer and sale deed for cars, motorcycles, or commercial vehicles.', N'گاڑی یا موٹر سائیکل کی ملکیت کی منتقلی اور فروخت کا مصدقہ قانونی اقرار نامہ۔', CAST(199.00 AS Decimal(18, 2)), N'Standard', N'LEGAL CONTENT REQUIRES LAWYER VERIFICATION: I, {{SellerName}} (Seller), have sold vehicle Registration No. {{RegNumber}}, Engine No. {{EngineNumber}}, Chassis No. {{ChassisNumber}} to {{BuyerName}} (Buyer) against total amount PKR {{SaleAmount}}.', N'LEGAL CONTENT REQUIRES LAWYER VERIFICATION: میں کہ {{SellerName}} (فروخت کنندہ) نے اپنی گاڑی نمبری {{RegNumber}}، انجن نمبر {{EngineNumber}}، چیسس نمبر {{ChassisNumber}} بعوض مبلغ {{SaleAmount}} روپے بحق {{BuyerName}} (خریدار) فروخت کر دی ہے۔', N'Motor Vehicles Ordinance 1965, Sale of Goods Act 1930', 1, CAST(100.00 AS Decimal(18, 2)), 1, CAST(N'2026-09-05T21:42:55.1130305' AS DateTime2), NULL)
INSERT [dbo].[Templates] ([TemplateID], [Category_ID], [Slug], [TitleEng], [TitleUrdu], [DescriptionEng], [DescriptionUrdu], [BasePrice], [Tier], [ContentTemplateEng], [ContentTemplateUrdu], [ApplicableLaws], [RequiresStampPaper], [EstimatedStampDuty], [IsActive], [CreatedDateTime], [UpdatedDateTime]) VALUES (4, 3, N'non-disclosure-agreement-nda', N'Non-Disclosure Agreement (NDA)', N'عدم افشائے راز معاہدہ (این ڈی اے)', N'Protects proprietary information, trade secrets, and client IP between business parties.', N'کاروباری رازوں اور نجی معلومات کے تحفظ کے لیے یکطرفہ یا دوطرفہ قانونی معاہدہ۔', CAST(199.00 AS Decimal(18, 2)), N'Standard', N'LEGAL CONTENT REQUIRES LAWYER VERIFICATION: This Mutual Non-Disclosure Agreement is executed between {{DisclosingParty}} and {{ReceivingParty}} regarding confidential discussions regarding {{ProjectScope}}.', N'LEGAL CONTENT REQUIRES LAWYER VERIFICATION: یہ عدم افشائے راز معاہدہ بمابین فریق اول {{DisclosingParty}} اور فریق دوم {{ReceivingParty}} برائے تحفظ معلومات بابت {{ProjectScope}} طے پایا۔', N'Contract Act 1872, Copyright Ordinance 1962', 0, CAST(0.00 AS Decimal(18, 2)), 1, CAST(N'2026-09-05T21:43:00.2276234' AS DateTime2), NULL)
INSERT [dbo].[Templates] ([TemplateID], [Category_ID], [Slug], [TitleEng], [TitleUrdu], [DescriptionEng], [DescriptionUrdu], [BasePrice], [Tier], [ContentTemplateEng], [ContentTemplateUrdu], [ApplicableLaws], [RequiresStampPaper], [EstimatedStampDuty], [IsActive], [CreatedDateTime], [UpdatedDateTime]) VALUES (5, 3, N'employment-contract', N'Full-Time Employment Contract', N'ملازمت کا معاہدہ', N'Statutory compliant Pakistani employment agreement covering salary, probation, notice, and leaves.', N'پاکستانی لیبر قوانین کے مطابق تنخواہ، آزمائشی مدت، اور دیگر شرائط پر مبنی ملازمت کا معاہدہ۔', CAST(499.00 AS Decimal(18, 2)), N'Premium', N'LEGAL CONTENT REQUIRES LAWYER VERIFICATION: {{EmployerName}} (Employer) appoints {{EmployeeName}} (Employee) as {{JobTitle}} with a monthly salary of PKR {{MonthlySalary}} effective {{JoiningDate}}.', N'LEGAL CONTENT REQUIRES LAWYER VERIFICATION: ادارہ {{EmployerName}} (مالک/ادارہ) مسمی {{EmployeeName}} (ملازم) کو بحیثیت {{JobTitle}} بماہانہ مشاہرہ {{MonthlySalary}} روپے تعینات کرتا ہے۔', N'Industrial and Commercial Employment (Standing Orders) Ordinance 1968', 0, CAST(0.00 AS Decimal(18, 2)), 1, CAST(N'2026-09-05T21:43:05.4051184' AS DateTime2), NULL)
INSERT [dbo].[Templates] ([TemplateID], [Category_ID], [Slug], [TitleEng], [TitleUrdu], [DescriptionEng], [DescriptionUrdu], [BasePrice], [Tier], [ContentTemplateEng], [ContentTemplateUrdu], [ApplicableLaws], [RequiresStampPaper], [EstimatedStampDuty], [IsActive], [CreatedDateTime], [UpdatedDateTime]) VALUES (6, 3, N'memorandum-of-understanding-mou', N'Memorandum of Understanding (MOU)', N'مفاہمتی یادداشت (ایم او یو)', N'Formal framework agreement establishing strategic cooperation between two organizations.', N'دو اداروں یا کمپنیوں کے درمیان باہمی تعاون اور شراکت داری کا ابتدائی خاکہ۔', CAST(499.00 AS Decimal(18, 2)), N'Premium', N'LEGAL CONTENT REQUIRES LAWYER VERIFICATION: This Memorandum of Understanding outlines the mutual intent between {{PartyA}} and {{PartyB}} to collaborate on {{CollaborationPurpose}}.', N'LEGAL CONTENT REQUIRES LAWYER VERIFICATION: یہ مفاہمتی یادداشت بمابین {{PartyA}} اور {{PartyB}} برائے باہمی تعاون {{CollaborationPurpose}} تحریر کی جاتی ہے۔', N'Contract Act 1872', 0, CAST(0.00 AS Decimal(18, 2)), 1, CAST(N'2026-09-05T21:43:10.3384612' AS DateTime2), NULL)
INSERT [dbo].[Templates] ([TemplateID], [Category_ID], [Slug], [TitleEng], [TitleUrdu], [DescriptionEng], [DescriptionUrdu], [BasePrice], [Tier], [ContentTemplateEng], [ContentTemplateUrdu], [ApplicableLaws], [RequiresStampPaper], [EstimatedStampDuty], [IsActive], [CreatedDateTime], [UpdatedDateTime]) VALUES (7, 3, N'partnership-deed-sharakat-nama', N'Partnership Deed (Sharakat Nama)', N'شراکت داری کا معاہدہ (شراکت نامہ)', N'Comprehensive partnership deed detailing capital contribution, profit/loss ratio, and dispute resolution.', N'شراکت داروں کے درمیان سرمائے کی فراہمی، نفع و نقصان کی تقسیم اور شرائط پر مبنی شراکت نامہ۔', CAST(499.00 AS Decimal(18, 2)), N'Premium', N'LEGAL CONTENT REQUIRES LAWYER VERIFICATION: This Deed of Partnership is executed on {{DeedDate}} among the partners for operating the business under the name {{FirmName}} with profit sharing ratio {{ProfitRatio}}.', N'LEGAL CONTENT REQUIRES LAWYER VERIFICATION: یہ شراکت نامہ بتاریخ {{DeedDate}} برائے کاروبار زیر عنوان {{FirmName}} مع تناسب نفع و نقصان {{ProfitRatio}} تحریر کیا جاتا ہے۔', N'Partnership Act 1932, Contract Act 1872', 1, CAST(2000.00 AS Decimal(18, 2)), 1, CAST(N'2026-09-05T21:43:13.9554236' AS DateTime2), NULL)
SET IDENTITY_INSERT [dbo].[Templates] OFF
GO
/****** Object:  Index [UQ_Lawyers_UserId]    Script Date: 9/6/2026 2:46:10 AM ******/
ALTER TABLE [dbo].[Lawyers] ADD  CONSTRAINT [UQ_Lawyers_UserId] UNIQUE NONCLUSTERED 
(
	[User_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Payments_Guid]    Script Date: 9/6/2026 2:46:10 AM ******/
ALTER TABLE [dbo].[Payments] ADD  CONSTRAINT [UQ_Payments_Guid] UNIQUE NONCLUSTERED 
(
	[PaymentGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Payments_TxnRef]    Script Date: 9/6/2026 2:46:10 AM ******/
ALTER TABLE [dbo].[Payments] ADD  CONSTRAINT [UQ_Payments_TxnRef] UNIQUE NONCLUSTERED 
(
	[TxnRef] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Templates_Slug]    Script Date: 9/6/2026 2:46:10 AM ******/
ALTER TABLE [dbo].[Templates] ADD  CONSTRAINT [UQ_Templates_Slug] UNIQUE NONCLUSTERED 
(
	[Slug] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_UserDocuments_Guid]    Script Date: 9/6/2026 2:46:10 AM ******/
ALTER TABLE [dbo].[UserDocuments] ADD  CONSTRAINT [UQ_UserDocuments_Guid] UNIQUE NONCLUSTERED 
(
	[DocumentGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Users_Email]    Script Date: 9/6/2026 2:46:10 AM ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [UQ_Users_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Users_Phone]    Script Date: 9/6/2026 2:46:10 AM ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [UQ_Users_Phone] UNIQUE NONCLUSTERED 
(
	[Phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AIQueries] ADD  CONSTRAINT [DF_AIQueries_LanguageCode]  DEFAULT (N'ur') FOR [LanguageCode]
GO
ALTER TABLE [dbo].[AIQueries] ADD  CONSTRAINT [DF_AIQueries_Tokens]  DEFAULT ((0)) FOR [Tokens]
GO
ALTER TABLE [dbo].[AIQueries] ADD  CONSTRAINT [DF_AIQueries_PromptTokens]  DEFAULT ((0)) FOR [PromptTokens]
GO
ALTER TABLE [dbo].[AIQueries] ADD  CONSTRAINT [DF_AIQueries_CompletionTokens]  DEFAULT ((0)) FOR [CompletionTokens]
GO
ALTER TABLE [dbo].[AIQueries] ADD  CONSTRAINT [DF_AIQueries_ModelUsed]  DEFAULT (N'gpt-4o') FOR [ModelUsed]
GO
ALTER TABLE [dbo].[AIQueries] ADD  DEFAULT (getdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [dbo].[AuditLogs] ADD  DEFAULT (getdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [dbo].[FormFields] ADD  CONSTRAINT [DF_FormFields_IsRequired]  DEFAULT ((1)) FOR [IsRequired]
GO
ALTER TABLE [dbo].[FormFields] ADD  CONSTRAINT [DF_FormFields_StepNumber]  DEFAULT ((1)) FOR [StepNumber]
GO
ALTER TABLE [dbo].[FormFields] ADD  CONSTRAINT [DF_FormFields_SortOrder]  DEFAULT ((0)) FOR [SortOrder]
GO
ALTER TABLE [dbo].[FormFields] ADD  DEFAULT (getdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [dbo].[LawyerReviews] ADD  CONSTRAINT [DF_LawyerReviews_ReviewFee]  DEFAULT ((1499.00)) FOR [ReviewFee]
GO
ALTER TABLE [dbo].[LawyerReviews] ADD  CONSTRAINT [DF_LawyerReviews_LawyerShare]  DEFAULT ((1049.30)) FOR [LawyerShareAmount]
GO
ALTER TABLE [dbo].[LawyerReviews] ADD  CONSTRAINT [DF_LawyerReviews_PlatformShare]  DEFAULT ((449.70)) FOR [PlatformShareAmount]
GO
ALTER TABLE [dbo].[LawyerReviews] ADD  DEFAULT (getdate()) FOR [RequesteDateTime]
GO
ALTER TABLE [dbo].[Lawyers] ADD  CONSTRAINT [DF_Lawyers_YearsOfExperience]  DEFAULT ((0)) FOR [YearsOfExperience]
GO
ALTER TABLE [dbo].[Lawyers] ADD  CONSTRAINT [DF_Lawyers_VerifiedStatus]  DEFAULT ((0)) FOR [VerifiedStatus]
GO
ALTER TABLE [dbo].[Lawyers] ADD  CONSTRAINT [DF_Lawyers_Rating]  DEFAULT ((5.00)) FOR [Rating]
GO
ALTER TABLE [dbo].[Lawyers] ADD  CONSTRAINT [DF_Lawyers_TotalReviewsCompleted]  DEFAULT ((0)) FOR [TotalReviewsCompleted]
GO
ALTER TABLE [dbo].[Lawyers] ADD  DEFAULT (getdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [dbo].[Payments] ADD  CONSTRAINT [DF_Payments_Guid]  DEFAULT (newid()) FOR [PaymentGuid]
GO
ALTER TABLE [dbo].[Payments] ADD  CONSTRAINT [DF_Payments_Currency]  DEFAULT (N'PKR') FOR [Currency]
GO
ALTER TABLE [dbo].[Payments] ADD  DEFAULT (getdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [dbo].[Signatures] ADD  CONSTRAINT [DF_Signatures_OtpVerified]  DEFAULT ((0)) FOR [OtpVerified]
GO
ALTER TABLE [dbo].[Signatures] ADD  DEFAULT (getdate()) FOR [SignedDateTime]
GO
ALTER TABLE [dbo].[TemplateCategories] ADD  CONSTRAINT [DF_TemplateCategories_SortOrder]  DEFAULT ((0)) FOR [SortOrder]
GO
ALTER TABLE [dbo].[TemplateCategories] ADD  CONSTRAINT [DF_TemplateCategories_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[TemplateCategories] ADD  DEFAULT (getdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [dbo].[Templates] ADD  CONSTRAINT [DF_Templates_BasePrice]  DEFAULT ((0.00)) FOR [BasePrice]
GO
ALTER TABLE [dbo].[Templates] ADD  CONSTRAINT [DF_Templates_Tier]  DEFAULT (N'Free') FOR [Tier]
GO
ALTER TABLE [dbo].[Templates] ADD  CONSTRAINT [DF_Templates_RequiresStampPaper]  DEFAULT ((0)) FOR [RequiresStampPaper]
GO
ALTER TABLE [dbo].[Templates] ADD  CONSTRAINT [DF_Templates_EstimatedStampDuty]  DEFAULT ((0.00)) FOR [EstimatedStampDuty]
GO
ALTER TABLE [dbo].[Templates] ADD  CONSTRAINT [DF_Templates_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Templates] ADD  DEFAULT (getdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [dbo].[UserDocuments] ADD  CONSTRAINT [DF_UserDocuments_Guid]  DEFAULT (newid()) FOR [DocumentGuid]
GO
ALTER TABLE [dbo].[UserDocuments] ADD  CONSTRAINT [DF_UserDocuments_FormAnswers]  DEFAULT (N'{}') FOR [FormAnswers]
GO
ALTER TABLE [dbo].[UserDocuments] ADD  CONSTRAINT [DF_UserDocuments_IsPaid]  DEFAULT ((0)) FOR [IsPaid]
GO
ALTER TABLE [dbo].[UserDocuments] ADD  CONSTRAINT [DF_UserDocuments_CreatedAt]  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsEmailVerified]  DEFAULT ((0)) FOR [IsEmailVerified]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [dbo].[AuditLogs]  WITH CHECK ADD  CONSTRAINT [CK_AuditLogs_NewValuesJson] CHECK  (([NewValuesJson] IS NULL OR isjson([NewValuesJson])=(1)))
GO
ALTER TABLE [dbo].[AuditLogs] CHECK CONSTRAINT [CK_AuditLogs_NewValuesJson]
GO
ALTER TABLE [dbo].[AuditLogs]  WITH CHECK ADD  CONSTRAINT [CK_AuditLogs_OldValuesJson] CHECK  (([OldValuesJson] IS NULL OR isjson([OldValuesJson])=(1)))
GO
ALTER TABLE [dbo].[AuditLogs] CHECK CONSTRAINT [CK_AuditLogs_OldValuesJson]
GO
ALTER TABLE [dbo].[FormFields]  WITH CHECK ADD  CONSTRAINT [CK_FormFields_ConditionalLogicJson] CHECK  (([ConditionalLogicJson] IS NULL OR isjson([ConditionalLogicJson])=(1)))
GO
ALTER TABLE [dbo].[FormFields] CHECK CONSTRAINT [CK_FormFields_ConditionalLogicJson]
GO
ALTER TABLE [dbo].[FormFields]  WITH CHECK ADD  CONSTRAINT [CK_FormFields_FieldType] CHECK  (([FieldType]=N'Address' OR [FieldType]=N'CurrencyPkr' OR [FieldType]=N'Checkbox' OR [FieldType]=N'Radio' OR [FieldType]=N'Select' OR [FieldType]=N'TextArea' OR [FieldType]=N'Email' OR [FieldType]=N'Phone' OR [FieldType]=N'Cnic' OR [FieldType]=N'Date' OR [FieldType]=N'Number' OR [FieldType]=N'Text'))
GO
ALTER TABLE [dbo].[FormFields] CHECK CONSTRAINT [CK_FormFields_FieldType]
GO
ALTER TABLE [dbo].[FormFields]  WITH CHECK ADD  CONSTRAINT [CK_FormFields_OptionsJson] CHECK  (([OptionsJson] IS NULL OR isjson([OptionsJson])=(1)))
GO
ALTER TABLE [dbo].[FormFields] CHECK CONSTRAINT [CK_FormFields_OptionsJson]
GO
ALTER TABLE [dbo].[LawyerReviews]  WITH CHECK ADD  CONSTRAINT [CK_LawyerReviews_LawyerShare] CHECK  (([LawyerShareAmount]>=(0.00)))
GO
ALTER TABLE [dbo].[LawyerReviews] CHECK CONSTRAINT [CK_LawyerReviews_LawyerShare]
GO
ALTER TABLE [dbo].[LawyerReviews]  WITH CHECK ADD  CONSTRAINT [CK_LawyerReviews_PlatformShare] CHECK  (([PlatformShareAmount]>=(0.00)))
GO
ALTER TABLE [dbo].[LawyerReviews] CHECK CONSTRAINT [CK_LawyerReviews_PlatformShare]
GO
ALTER TABLE [dbo].[LawyerReviews]  WITH CHECK ADD  CONSTRAINT [CK_LawyerReviews_ReviewFee] CHECK  (([ReviewFee]>=(0.00)))
GO
ALTER TABLE [dbo].[LawyerReviews] CHECK CONSTRAINT [CK_LawyerReviews_ReviewFee]
GO
ALTER TABLE [dbo].[Lawyers]  WITH CHECK ADD  CONSTRAINT [CK_Lawyers_Rating] CHECK  (([Rating]>=(0.00) AND [Rating]<=(5.00)))
GO
ALTER TABLE [dbo].[Lawyers] CHECK CONSTRAINT [CK_Lawyers_Rating]
GO
ALTER TABLE [dbo].[Lawyers]  WITH CHECK ADD  CONSTRAINT [CK_Lawyers_TotalReviews] CHECK  (([TotalReviewsCompleted]>=(0)))
GO
ALTER TABLE [dbo].[Lawyers] CHECK CONSTRAINT [CK_Lawyers_TotalReviews]
GO
ALTER TABLE [dbo].[Lawyers]  WITH CHECK ADD  CONSTRAINT [CK_Lawyers_YearsOfExperience] CHECK  (([YearsOfExperience]>=(0)))
GO
ALTER TABLE [dbo].[Lawyers] CHECK CONSTRAINT [CK_Lawyers_YearsOfExperience]
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [CK_Payments_Amount] CHECK  (([Amount]>=(0.00)))
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [CK_Payments_Amount]
GO
ALTER TABLE [dbo].[Templates]  WITH CHECK ADD  CONSTRAINT [CK_Templates_BasePrice] CHECK  (([BasePrice]>=(0.00)))
GO
ALTER TABLE [dbo].[Templates] CHECK CONSTRAINT [CK_Templates_BasePrice]
GO
ALTER TABLE [dbo].[Templates]  WITH CHECK ADD  CONSTRAINT [CK_Templates_EstimatedStampDuty] CHECK  (([EstimatedStampDuty]>=(0.00)))
GO
ALTER TABLE [dbo].[Templates] CHECK CONSTRAINT [CK_Templates_EstimatedStampDuty]
GO
ALTER TABLE [dbo].[Templates]  WITH CHECK ADD  CONSTRAINT [CK_Templates_Tier] CHECK  (([Tier]=N'Corporate' OR [Tier]=N'Premium' OR [Tier]=N'Standard' OR [Tier]=N'Free'))
GO
ALTER TABLE [dbo].[Templates] CHECK CONSTRAINT [CK_Templates_Tier]
GO
ALTER TABLE [dbo].[UserDocuments]  WITH CHECK ADD  CONSTRAINT [CK_UserDocuments_FormAnswers] CHECK  ((isjson([FormAnswers])=(1)))
GO
ALTER TABLE [dbo].[UserDocuments] CHECK CONSTRAINT [CK_UserDocuments_FormAnswers]
GO
/****** Object:  StoredProcedure [dbo].[AssignLawyerReview]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[AssignLawyerReview]
    @ReviewID  BIGINT,
    @Lawyer_ID INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.LawyerReviews
    SET [Lawyer_ID] = @Lawyer_ID,
        [LawyerReviewStatus_ID] = 2, -- 2: Assigned
        [AssignedDateTime] = GETDATE()
    WHERE [LawyerReviewID] = @ReviewID;
END
GO
/****** Object:  StoredProcedure [dbo].[CreateAIQuery]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[CreateAIQuery]
    @User_ID          INT = NULL,
    @UserDocument_ID  INT = NULL,
    @Template_ID      INT = NULL,
    @Prompt           NVARCHAR(MAX),
    @Response         NVARCHAR(MAX),
    @LanguageCode     NVARCHAR(10) = N'ur',
    @Tokens           INT = 0,
    @PromptTokens     INT = 0,
    @CompletionTokens INT = 0,
    @ModelUsed        NVARCHAR(50) = N'gpt-4o',
    @QueryID          BIGINT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.AIQueries (
        [User_ID], [UserDocument_ID], [Template_ID], [Prompt], [Response],
        [LanguageCode], [Tokens], [PromptTokens], [CompletionTokens], [ModelUsed], [CreatedDateTime]
    )
    VALUES (
        @User_ID, @UserDocument_ID, @Template_ID, @Prompt, @Response,
        @LanguageCode, @Tokens, @PromptTokens, @CompletionTokens, @ModelUsed, GETDATE()
    );

    SET @QueryID = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[CreateAuditLog]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[CreateAuditLog]
    @User_ID           INT = NULL,
    @Action            NVARCHAR(100),
    @EntityName        NVARCHAR(100),
    @EntityID          NVARCHAR(100) = NULL,
    @IpAddress         NVARCHAR(50) = NULL,
    @UserAgent         NVARCHAR(500) = NULL,
    @OldValuesJson     NVARCHAR(MAX) = NULL,
    @NewValuesJson     NVARCHAR(MAX) = NULL,
    @IntegrityChecksum NVARCHAR(128) = NULL,
    @AuditLogID        BIGINT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.AuditLogs (
        [User_ID], [Action], [EntityName], [EntityID],
        [IpAddress], [UserAgent], [OldValuesJson], [NewValuesJson],
        [IntegrityChecksum], [CreatedDateTime]
    )
    VALUES (
        @User_ID, @Action, @EntityName, @EntityID,
        @IpAddress, @UserAgent, @OldValuesJson, @NewValuesJson,
        @IntegrityChecksum, GETDATE()
    );

    SET @AuditLogID = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[CreateLawyerReview]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[CreateLawyerReview]
    @UserDocument_ID INT,
    @ReviewFee       DECIMAL(18,2) = 1499.00,
    @ReviewID        BIGINT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.LawyerReviews (
        [UserDocument_ID], [ReviewFee], [LawyerShareAmount], [PlatformShareAmount],
        [LawyerReviewStatus_ID], [RequesteDateTime]
    )
    VALUES (
        @UserDocument_ID, @ReviewFee, @ReviewFee * 0.70, @ReviewFee * 0.30,
        1, -- 1: Requested
        GETDATE()
    );

    SET @ReviewID = SCOPE_IDENTITY();

    -- Update Document status to UnderLawyerReview (ID 5)
    UPDATE dbo.UserDocuments
    SET [DocumentStatus_ID] = 5,
        [UpdatedAt] = GETDATE()
    WHERE [UserDocumentID] = @UserDocument_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[CreatePayment]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[CreatePayment]
    @User_ID           INT,
    @UserDocument_ID   INT = NULL,
    @Amount            DECIMAL(18,2),
    @Currency          NVARCHAR(10) = N'PKR',
    @PaymentGateway_ID INT,
    @TxnRef            NVARCHAR(150),
    @PaymentID         BIGINT OUTPUT,
    @PaymentGuid       UNIQUEIDENTIFIER OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SET @PaymentGuid = NEWID();

    INSERT INTO dbo.Payments (
        [PaymentGuid], [User_ID], [UserDocument_ID], [Amount], [Currency],
        [PaymentGateway_ID], [PaymentStatus_ID], [TxnRef], [CreatedDateTime]
    )
    VALUES (
        @PaymentGuid, @User_ID, @UserDocument_ID, @Amount, @Currency,
        @PaymentGateway_ID, 1, -- 1: Pending
        @TxnRef, GETDATE()
    );

    SET @PaymentID = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[CreateSignature]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[CreateSignature]
    @UserDocument_ID INT,
    @SignerName      NVARCHAR(150),
    @SignerCnic      NVARCHAR(20),
    @SignerRole      NVARCHAR(100),
    @SignerEmail     NVARCHAR(256) = NULL,
    @SignerPhone     NVARCHAR(20) = NULL,
    @SignatureUri    NVARCHAR(500),
    @OtpVerified     BIT = 0,
    @OtpCodeHash     NVARCHAR(256) = NULL,
    @IpAddress       NVARCHAR(50) = NULL,
    @UserAgent       NVARCHAR(500) = NULL,
    @SignatureID     BIGINT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Signatures (
        [UserDocument_ID], [SignerName], [SignerCnic], [SignerRole],
        [SignerEmail], [SignerPhone], [SignatureUri],
        [OtpVerified], [OtpCodeHash], [IpAddress], [UserAgent], [SignedDateTime]
    )
    VALUES (
        @UserDocument_ID, @SignerName, @SignerCnic, @SignerRole,
        @SignerEmail, @SignerPhone, @SignatureUri,
        @OtpVerified, @OtpCodeHash, @IpAddress, @UserAgent, GETDATE()
    );

    SET @SignatureID = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[CreateUser]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[CreateUser]
    @Name         NVARCHAR(150),
    @Email        NVARCHAR(256),
    @Phone        NVARCHAR(20),
    @PasswordHash NVARCHAR(500),
    @Role_ID      INT ,
    @Cnic         NVARCHAR(20) = NULL,
    @UserID       INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Users (
        [Name], [Email], [Phone], [PasswordHash], [Role_ID], [Cnic],
        [IsEmailVerified], [IsActive], [CreatedDateTime]
    )
    VALUES (
        @Name, @Email, @Phone, @PasswordHash, @Role_ID, @Cnic,
        0, 1, SYSUTCDATETIME()
    );

    SET @UserID = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[CreateUserDocument]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[CreateUserDocument]
    @User_ID        INT,
    @Template_ID    INT,
    @Title          NVARCHAR(250),
    @FormAnswers    NVARCHAR(MAX) = N'{}',
    @UserDocumentID INT OUTPUT,
    @DocumentGuid   UNIQUEIDENTIFIER OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SET @DocumentGuid = NEWID();

    INSERT INTO dbo.UserDocuments (
        [DocumentGuid], [User_ID], [Template_ID], [Title], [FormAnswers],
        [DocumentStatus_ID], [IsPaid], [CreatedAt]
    )
    VALUES (
        @DocumentGuid, @User_ID, @Template_ID, @Title, @FormAnswers,
        1, -- 1: Draft
        0, GETDATE()
    );

    SET @UserDocumentID = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[GetAIQueryByDocument]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[GetAIQueryByDocument]
    @UserDocument_ID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        [QueryID],
        [User_ID],
        [UserDocument_ID],
        [Prompt],
        [Response],
        [LanguageCode],
        [Tokens],
        [ModelUsed],
        [CreatedDateTime]
    FROM dbo.AIQueries
    WHERE [UserDocument_ID] = @UserDocument_ID
    ORDER BY [CreatedDateTime] ASC;
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllCategories]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[GetAllCategories]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        c.[TemplateCategoryID] AS [CategoryID],
        c.[NameEng] AS [NameEn],
        c.[NameUrdu] AS [NameUr],
        c.[DescriptionEng] AS [DescriptionEn],
        c.[DescriptionUrdu] AS [DescriptionUr],
        c.[Icon],
        COUNT(t.[TemplateID]) AS [TemplateCount]
    FROM dbo.TemplateCategories c
    LEFT JOIN dbo.Templates t ON c.[TemplateCategoryID] = t.[Category_ID] AND t.[IsActive] = 1
    WHERE c.[IsActive] = 1
    GROUP BY c.[TemplateCategoryID], c.[NameEng], c.[NameUrdu], c.[DescriptionEng], c.[DescriptionUrdu], c.[Icon], c.[SortOrder]
    ORDER BY c.[SortOrder] ASC;
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllTemplates]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[GetAllTemplates]
    @SearchTerm NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        t.[TemplateID],
        t.[Category_ID] AS [CategoryID],
        c.[NameEng] AS [CategoryNameEn],
        c.[NameUrdu] AS [CategoryNameUr],
        t.[Slug],
        t.[TitleEng] AS [TitleEn],
        t.[TitleUrdu] AS [TitleUr],
        t.[DescriptionEng] AS [DescriptionEn],
        t.[DescriptionUrdu] AS [DescriptionUr],
        t.[BasePrice],
        t.[Tier],
        t.[RequiresStampPaper],
        t.[EstimatedStampDuty]
    FROM dbo.Templates t
    INNER JOIN dbo.TemplateCategories c ON t.[Category_ID] = c.[TemplateCategoryID]
    WHERE t.[IsActive] = 1
      AND (@SearchTerm IS NULL OR t.[TitleEng] LIKE N'%' + @SearchTerm + N'%' OR t.[TitleUrdu] LIKE N'%' + @SearchTerm + N'%')
    ORDER BY t.[TemplateID] ASC;
END
GO
/****** Object:  StoredProcedure [dbo].[GetFormFieldByTemplate]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[GetFormFieldByTemplate]
    @TemplateID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        [FormFieldID] AS [FieldId],
        [Template_ID] AS [TemplateId],
        [FieldKey],
        [FieldType],
        [LabelEng] AS [LabelEn],
        [LabelUrdu] AS [LabelUr],
        [PlaceholderEng] AS [PlaceholderEn],
        [PlaceholderUrdu] AS [PlaceholderUr],
        [HelpTextEng] AS [HelpTextEn],
        [HelpTextUrdu] AS [HelpTextUr],
        [IsRequired],
        [ValidationRegex],
        [OptionsJson],
        [ConditionalLogicJson],
        [StepNumber],
        [SortOrder]
    FROM dbo.FormFields
    WHERE [Template_ID] = @TemplateID
    ORDER BY [StepNumber] ASC, [SortOrder] ASC;
END
GO
/****** Object:  StoredProcedure [dbo].[GetLawyerById]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[GetLawyerById]
    @LawyerID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        l.[LawyerID],
        l.[User_ID],
        u.[Name] AS [LawyerName],
        u.[Email],
        u.[Phone],
        l.[BarCouncilNumber],
        l.[BarCouncilProvince],
        l.[Specialization],
        l.[YearsOfExperience],
        l.[OfficeAddress],
        l.[VerifiedStatus],
        l.[Rating],
        l.[TotalReviewsCompleted],
        l.[CreatedDateTime]
    FROM dbo.Lawyers l
    INNER JOIN dbo.Users u ON l.[User_ID] = u.[UserID]
    WHERE l.[LawyerID] = @LawyerID;
END
GO
/****** Object:  StoredProcedure [dbo].[GetLawyerReviewByLawyer]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[GetLawyerReviewByLawyer]
    @Lawyer_ID             INT,
    @LawyerReviewStatus_ID INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        lr.[LawyerReviewID] AS [ReviewID],
        lr.[UserDocument_ID],
        d.[Title] AS [DocumentTitle],
        d.[DocumentGuid],
        lr.[LawyerReviewStatus_ID],
        lrs.[LawyerReviewStatuse] AS [StatusName],
        lr.[ReviewFee],
        lr.[LawyerShareAmount],
        lr.[RequesteDateTime] AS [RequestedAt],
        lr.[AssignedDateTime] AS [AssignedAt],
        lr.[CompletedDateTime] AS [CompletedAt]
    FROM dbo.LawyerReviews lr
    INNER JOIN dbo.UserDocuments d ON lr.[UserDocument_ID] = d.[UserDocumentID]
    LEFT JOIN dbo.LawyerReviewStatuses lrs ON lr.[LawyerReviewStatus_ID] = lrs.[LawyerReviewStatuseID]
    WHERE lr.[Lawyer_ID] = @Lawyer_ID
      AND (@LawyerReviewStatus_ID IS NULL OR lr.[LawyerReviewStatus_ID] = @LawyerReviewStatus_ID)
    ORDER BY lr.[RequesteDateTime] DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[GetPaymentByTransactionReference]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[GetPaymentByTransactionReference]
    @TxnRef NVARCHAR(150)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.[PaymentID],
        p.[PaymentGuid],
        p.[User_ID],
        p.[UserDocument_ID],
        p.[Amount],
        p.[Currency],
        p.[PaymentGateway_ID],
        pg.[PaymentGateway] AS [GatewayName],
        p.[PaymentStatus_ID],
        ps.[PaymentStatus] AS [StatusName],
        p.[TxnRef],
        p.[GatewayTxnId],
        p.[CreatedDateTime],
        p.[CompletedDateTime]
    FROM dbo.Payments p
    LEFT JOIN dbo.PaymentGateways pg ON p.[PaymentGateway_ID] = pg.[PaymentGatewayID]
    LEFT JOIN dbo.PaymentStatuses ps ON p.[PaymentStatus_ID] = ps.[PaymentStatusID]
    WHERE p.[TxnRef] = @TxnRef;
END
GO
/****** Object:  StoredProcedure [dbo].[GetPaymentByUser]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[GetPaymentByUser]
    @User_ID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.[PaymentID],
        p.[PaymentGuid],
        p.[UserDocument_ID],
        p.[Amount],
        p.[Currency],
        p.[PaymentGateway_ID],
        pg.[PaymentGateway] AS [GatewayName],
        p.[PaymentStatus_ID],
        ps.[PaymentStatus] AS [StatusName],
        p.[TxnRef],
        p.[CreatedDateTime],
        p.[CompletedDateTime]
    FROM dbo.Payments p
    LEFT JOIN dbo.PaymentGateways pg ON p.[PaymentGateway_ID] = pg.[PaymentGatewayID]
    LEFT JOIN dbo.PaymentStatuses ps ON p.[PaymentStatus_ID] = ps.[PaymentStatusID]
    WHERE p.[User_ID] = @User_ID
    ORDER BY p.[CreatedDateTime] DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[GetSignatureByDocumentId]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[GetSignatureByDocumentId]
    @UserDocument_ID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        [SignatureID],
        [UserDocument_ID],
        [SignerName],
        [SignerCnic],
        [SignerRole],
        [SignerEmail],
        [SignerPhone],
        [SignatureUri],
        [OtpVerified],
        [IpAddress],
        [SignedDateTime] AS [SignedAt]
    FROM dbo.Signatures
    WHERE [UserDocument_ID] = @UserDocument_ID
    ORDER BY [SignedDateTime] ASC;
END
GO
/****** Object:  StoredProcedure [dbo].[GetTemplateByCategory]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[GetTemplateByCategory]
    @CategoryID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        t.[TemplateID],
        t.[Category_ID] AS [CategoryID],
        c.[NameEng] AS [CategoryNameEn],
        c.[NameUrdu] AS [CategoryNameUr],
        t.[Slug],
        t.[TitleEng] AS [TitleEn],
        t.[TitleUrdu] AS [TitleUr],
        t.[DescriptionEng] AS [DescriptionEn],
        t.[DescriptionUrdu] AS [DescriptionUr],
        t.[BasePrice],
        t.[Tier],
        t.[RequiresStampPaper],
        t.[EstimatedStampDuty]
    FROM dbo.Templates t
    INNER JOIN dbo.TemplateCategories c ON t.[Category_ID] = c.[TemplateCategoryID]
    WHERE t.[Category_ID] = @CategoryID AND t.[IsActive] = 1
    ORDER BY t.[TemplateID] ASC;
END
GO
/****** Object:  StoredProcedure [dbo].[GetTemplateById]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[GetTemplateById]
    @TemplateID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        t.[TemplateID],
        t.[Category_ID] AS [CategoryID],
        t.[Slug],
        t.[TitleEng] AS [TitleEn],
        t.[TitleUrdu] AS [TitleUr],
        t.[DescriptionEng] AS [DescriptionEn],
        t.[DescriptionUrdu] AS [DescriptionUr],
        t.[BasePrice],
        t.[Tier],
        t.[ContentTemplateEng] AS [ContentTemplateEn],
        t.[ContentTemplateUrdu] AS [ContentTemplateUr],
        t.[ApplicableLaws],
        t.[RequiresStampPaper],
        t.[EstimatedStampDuty]
    FROM dbo.Templates t
    WHERE t.[TemplateID] = @TemplateID AND t.[IsActive] = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[GetTemplateBySlug]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[GetTemplateBySlug]
    @Slug NVARCHAR(150)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        t.[TemplateID],
        t.[Category_ID] AS [CategoryID],
        t.[Slug],
        t.[TitleEng] AS [TitleEn],
        t.[TitleUrdu] AS [TitleUr],
        t.[DescriptionEng] AS [DescriptionEn],
        t.[DescriptionUrdu] AS [DescriptionUr],
        t.[BasePrice],
        t.[Tier],
        t.[ContentTemplateEng] AS [ContentTemplateEn],
        t.[ContentTemplateUrdu] AS [ContentTemplateUr],
        t.[ApplicableLaws],
        t.[RequiresStampPaper],
        t.[EstimatedStampDuty]
    FROM dbo.Templates t
    WHERE t.[Slug] = @Slug AND t.[IsActive] = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[GetUserByEmail]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[GetUserByEmail]
    @Email NVARCHAR(256)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        u.[UserID],
        u.[Name],
        u.[Email],
        u.[Phone],
        u.[Role_ID],
        r.[ROLENAME] AS [RoleName],
        u.[Cnic],
        u.[IsEmailVerified],
        u.[IsActive],
        u.[CreatedDateTime],
        u.[UpdatedDateTime]
    FROM dbo.Users u
    LEFT JOIN dbo.Roles r ON u.[Role_ID] = r.[RoleID]
    WHERE u.[Email] = @Email AND u.[IsActive] = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[GetUserByEmailOrPhone]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[GetUserByEmailOrPhone]
    @Identifier NVARCHAR(256)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        u.[UserID],
        u.[Name],
        u.[Email],
        u.[Phone],
        u.[PasswordHash],
        u.[Role_ID],
        r.[ROLENAME] AS [RoleName],
        u.[Cnic],
        u.[IsEmailVerified],
        u.[IsActive],
        u.[RefreshToken],
        u.[RefreshTokenExpiryDateTime],
        u.[CreatedDateTime]
    FROM dbo.Users u
    LEFT JOIN dbo.Roles r ON u.[Role_ID] = r.[RoleID]
    WHERE (u.[Email] = @Identifier OR u.[Phone] = @Identifier) AND u.[IsActive] = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[GetUserById]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[GetUserById]
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        u.[UserID],
        u.[Name],
        u.[Email],
        u.[Phone],
        u.[Role_ID],
        r.[ROLENAME] AS [RoleName],
        u.[Cnic],
        u.[IsEmailVerified],
        u.[IsActive],
        u.[CreatedDateTime],
        u.[UpdatedDateTime]
    FROM dbo.Users u
    LEFT JOIN dbo.Roles r ON u.[Role_ID] = r.[RoleID]
    WHERE u.[UserID] = @UserID AND u.[IsActive] = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[GetUserDocumentById]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[GetUserDocumentById]
    @UserDocumentID INT,
    @User_ID        INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        d.[UserDocumentID],
        d.[DocumentGuid],
        d.[User_ID],
        d.[Template_ID],
        t.[TitleEng] AS [TemplateTitleEn],
        t.[TitleUrdu] AS [TemplateTitleUr],
        d.[Title],
        d.[FormAnswers],
        d.[DocumentStatus_ID],
        ds.[DocumentStatus] AS [Status],
        d.[StoragePath],
        d.[DocxStoragePath],
        d.[DocumentHash],
        d.[IsPaid],
        d.[CreatedAt],
        d.[UpdatedAt],
        d.[CompletedAt]
    FROM dbo.UserDocuments d
    INNER JOIN dbo.Templates t ON d.[Template_ID] = t.[TemplateID]
    LEFT JOIN dbo.DocumentStatuses ds ON d.[DocumentStatus_ID] = ds.[DocumentStatusID]
    WHERE d.[UserDocumentID] = @UserDocumentID
      AND (@User_ID IS NULL OR d.[User_ID] = @User_ID);
END
GO
/****** Object:  StoredProcedure [dbo].[GetUserDocumentsByUser]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[GetUserDocumentsByUser]
    @User_ID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        d.[UserDocumentID],
        d.[DocumentGuid],
        d.[Template_ID],
        t.[TitleEng] AS [TemplateTitleEn],
        t.[TitleUrdu] AS [TemplateTitleUr],
        d.[Title],
        d.[DocumentStatus_ID],
        ds.[DocumentStatus] AS [Status],
        d.[IsPaid],
        d.[CreatedAt],
        d.[CompletedAt]
    FROM dbo.UserDocuments d
    INNER JOIN dbo.Templates t ON d.[Template_ID] = t.[TemplateID]
    LEFT JOIN dbo.DocumentStatuses ds ON d.[DocumentStatus_ID] = ds.[DocumentStatusID]
    WHERE d.[User_ID] = @User_ID
    ORDER BY d.[CreatedAt] DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[Lawyer_GetVerifiedLawyers]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[Lawyer_GetVerifiedLawyers]
    @Specialization NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        l.[LawyerID],
        l.[User_ID],
        u.[Name] AS [LawyerName],
        u.[Email],
        l.[BarCouncilNumber],
        l.[BarCouncilProvince],
        l.[Specialization],
        l.[YearsOfExperience],
        l.[Rating],
        l.[TotalReviewsCompleted]
    FROM dbo.Lawyers l
    INNER JOIN dbo.Users u ON l.[User_ID] = u.[UserID]
    WHERE l.[VerifiedStatus] = 1 AND u.[IsActive] = 1
      AND (@Specialization IS NULL OR l.[Specialization] LIKE N'%' + @Specialization + N'%')
    ORDER BY l.[Rating] DESC, l.[TotalReviewsCompleted] DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateLawyerReviewStatus]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[UpdateLawyerReviewStatus]
    @ReviewID              BIGINT,
    @LawyerReviewStatus_ID INT,
    @Notes                 NVARCHAR(MAX) = NULL,
    @AnnotatedPdfPath      NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.LawyerReviews
    SET [LawyerReviewStatus_ID] = @LawyerReviewStatus_ID,
        [Notes] = COALESCE(@Notes, [Notes]),
        [AnnotatedPdfPath] = COALESCE(@AnnotatedPdfPath, [AnnotatedPdfPath]),
        [CompletedDateTime] = CASE WHEN @LawyerReviewStatus_ID IN (5, 6) THEN GETDATE() ELSE [CompletedDateTime] END
    WHERE [LawyerReviewID] = @ReviewID;

    -- If approved & stamped (ID 5), update document status to LawyerApproved (ID 6)
    IF @LawyerReviewStatus_ID = 5
    BEGIN
        UPDATE d
        SET d.[DocumentStatus_ID] = 6,
            d.[UpdatedAt] = GETDATE()
        FROM dbo.UserDocuments d
        INNER JOIN dbo.LawyerReviews lr ON d.[UserDocumentID] = lr.[UserDocument_ID]
        WHERE lr.[LawyerReviewID] = @ReviewID;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[UpdatePaymentStatus]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[UpdatePaymentStatus]
    @TxnRef           NVARCHAR(150),
    @PaymentStatus_ID INT,
    @GatewayTxnId     NVARCHAR(150) = NULL,
    @GatewayPayload   NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Payments
    SET [PaymentStatus_ID] = @PaymentStatus_ID,
        [GatewayTxnId] = COALESCE(@GatewayTxnId, [GatewayTxnId]),
        [GatewayPayload] = COALESCE(@GatewayPayload, [GatewayPayload]),
        [CompletedDateTime] = CASE WHEN @PaymentStatus_ID IN (2, 3, 5, 6) THEN SYSUTCDATETIME() ELSE [CompletedDateTime] END
    WHERE [TxnRef] = @TxnRef;

    -- If payment is successful (ID 2), mark document as paid
    IF @PaymentStatus_ID = 2
    BEGIN
        UPDATE d
        SET d.[IsPaid] = 1,
            d.[UpdatedAt] = SYSUTCDATETIME()
        FROM dbo.UserDocuments d
        INNER JOIN dbo.Payments p ON d.[UserDocumentID] = p.[UserDocument_ID]
        WHERE p.[TxnRef] = @TxnRef AND p.[UserDocument_ID] IS NOT NULL;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateUser]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[UpdateUser]
    @UserID INT,
    @Name   NVARCHAR(150),
    @Phone  NVARCHAR(20),
    @Cnic   NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Users
    SET [Name] = @Name,
        [Phone] = @Phone,
        [Cnic] = @Cnic,
        [UpdatedDateTime] = SYSUTCDATETIME()
    WHERE [UserID] = @UserID;
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateUserDocumentAnswers]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[UpdateUserDocumentAnswers]
    @UserDocumentID INT,
    @User_ID        INT,
    @FormAnswers    NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.UserDocuments
    SET [FormAnswers] = @FormAnswers,
        [UpdatedAt] = SYSUTCDATETIME()
    WHERE [UserDocumentID] = @UserDocumentID AND [User_ID] = @User_ID;
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateUserDocumentStatus]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[UpdateUserDocumentStatus]
    @UserDocumentID    INT,
    @DocumentStatus_ID INT,
    @StoragePath       NVARCHAR(500) = NULL,
    @DocxStoragePath   NVARCHAR(500) = NULL,
    @DocumentHash      NVARCHAR(128) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.UserDocuments
    SET [DocumentStatus_ID] = @DocumentStatus_ID,
        [StoragePath] = COALESCE(@StoragePath, [StoragePath]),
        [DocxStoragePath] = COALESCE(@DocxStoragePath, [DocxStoragePath]),
        [DocumentHash] = COALESCE(@DocumentHash, [DocumentHash]),
        [UpdatedAt] = SYSUTCDATETIME(),
        [CompletedAt] = CASE WHEN @DocumentStatus_ID IN (2, 4, 6) THEN SYSUTCDATETIME() ELSE [CompletedAt] END
    WHERE [UserDocumentID] = @UserDocumentID;
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateUserRefreshToken]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[UpdateUserRefreshToken]
    @UserID                     INT,
    @RefreshToken               NVARCHAR(500),
    @RefreshTokenExpiryDateTime DATETIME2
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Users
    SET [RefreshToken] = @RefreshToken,
        [RefreshTokenExpiryDateTime] = @RefreshTokenExpiryDateTime,
        [UpdatedDateTime] = SYSUTCDATETIME()
    WHERE [UserID] = @UserID;
END
GO
/****** Object:  StoredProcedure [dbo].[VerifyUserEmail]    Script Date: 9/6/2026 2:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[VerifyUserEmail]
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Users
    SET [IsEmailVerified] = 1,
        [UpdatedDateTime] = SYSUTCDATETIME()
    WHERE [UserID] = @UserID;
END
GO

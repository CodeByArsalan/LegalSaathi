# Legal Saathi - API Specification & Standards

## Base URL
- Local API: `http://localhost:5000/api` or `https://localhost:5001/api`

## Standard Envelope Format
All API responses follow a uniform JSON structure:

```json
{
  "success": true,
  "statusCode": 200,
  "message": "Operation completed successfully.",
  "data": { ... },
  "errors": [],
  "timestamp": "2026-09-05T23:30:00Z"
}
```

## Error Envelope Format
```json
{
  "success": false,
  "statusCode": 400,
  "message": "Validation failed.",
  "data": null,
  "errors": [
    "CNIC number must follow the 13-digit format (e.g. 35201-1234567-1)."
  ],
  "timestamp": "2026-09-05T23:30:00Z"
}
```

## Planned API Endpoints Outline

### 1. System & Diagnostics
- `GET /api/health` - Basic liveness and database connectivity health probe.

### 2. Authentication & User Management
- `POST /api/auth/register` - Create user account (EndUser / Lawyer / CorporateAdmin).
- `POST /api/auth/login` - Authenticate with email/phone & password.
- `POST /api/auth/send-otp` - Send OTP via SMS/Email.
- `POST /api/auth/verify-otp` - Verify OTP token.
- `POST /api/auth/refresh-token` - Exchange valid refresh token for a new JWT access token.

### 3. Legal Templates & Questionnaire
- `GET /api/templates/categories` - List categories with template counts.
- `GET /api/templates` - Search & filter legal templates.
- `GET /api/templates/{id}` - Retrieve template definition and dynamic form fields.

### 4. User Documents
- `POST /api/documents` - Initialize a document draft from a template.
- `PUT /api/documents/{id}/answers` - Save or update questionnaire answers JSON.
- `POST /api/documents/{id}/generate-pdf` - Compile court-ready PDF via QuestPDF.
- `POST /api/documents/{id}/generate-docx` - Compile editable DOCX via OpenXML.
- `GET /api/documents/{id}/download` - Stream generated document file.

### 5. E-Signatures & Verification
- `POST /api/documents/{id}/sign` - Attach digital signature with IP and OTP audit trail.
- `GET /api/documents/{id}/verification-certificate` - Evidentiary certificate of authenticity.

### 6. Payments
- `POST /api/payments/initiate` - Initiate checkout session (JazzCash, EasyPaisa, PayFast).
- `POST /api/payments/webhook/{gateway}` - Webhook callback handler.

### 7. AI Legal Assistant
- `POST /api/ai/ask` - Contextual query to OpenAI GPT-4o with Pakistani legal prompt constraints.

### 8. Lawyer Marketplace & Reviews
- `POST /api/reviews/request` - Submit document draft for verified advocate review.
- `GET /api/reviews/lawyer-queue` - Review queue for authorized lawyers.
- `PUT /api/reviews/{id}/complete` - Submit advocate review annotations and stamp.

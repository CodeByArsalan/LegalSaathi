# ⚖️ Legal Saathi (LegalSaathi.pk)
> **AI-Powered Bilingual DIY Legal Document Generation Platform for Pakistan**

Legal Saathi is a full-stack LegalTech platform engineered to democratize access to court-compliant, lawyer-verified legal documentation across Pakistan in both **Urdu (Nastaliq script)** and **English**.

---

## 🏛 Solution Architecture

The solution is divided into modular, decoupled tiers:

```
Legal Saathi/
├── src/
│   ├── LegalSaathi.Api/          # ASP.NET Core 8 RESTful Web API (Clean Modular Architecture)
│   ├── LegalSaathi.Api.Tests/    # xUnit Unit & Integration Test Suite
│   └── LegalSaathi.Web/          # Next.js 14 App Router, React 18, TypeScript, Tailwind CSS
├── database/                     # SQL Server 2022 Schemas, Procedures & Seed Scripts
│   ├── schema/                   # DDL scripts for tables and relational constraints
│   ├── procedures/               # Pure ADO.NET Stored Procedures (zero EF Core dependency)
│   └── seeds/                    # Initial Legal Categories & Standard Templates
├── docs/                         # Technical specifications and architectural references
│   ├── ARCHITECTURE.md
│   └── API_SPEC.md
├── infrastructure/               # Docker Compose and deployment manifests
│   └── docker-compose.yml
└── templates/                    # Raw bilingual template schemas and markup
    └── definitions/
```

---

## 🚀 Technology Stack

| Layer | Technology | Key Highlights |
|---|---|---|
| **Web Frontend** | Next.js 14, React 18, TypeScript, Tailwind CSS | App Router, Urdu Nastaliq & English typography, dynamic forms, mobile-responsive |
| **Backend API** | ASP.NET Core 8 Web API (C#) | Thin controllers, CQRS/feature organization, centralized exception handling |
| **Data Access** | ADO.NET (`Microsoft.Data.SqlClient`) | 100% Stored Procedures, parameterized queries, async cancellation tokens |
| **Database** | Microsoft SQL Server 2022 | Relational integrity, audit logs, encrypted columns |
| **PDF Generation** | QuestPDF | Native RTL and Urdu Nastaliq font embedding |
| **DOCX Generation** | OpenXML SDK | Native Microsoft Word document compilation |
| **AI Engine** | OpenAI GPT-4o Abstraction | Provider-isolated Pakistani legal advisor |
| **Payments** | JazzCash, EasyPaisa, PayFast | Abstraction layer for Pakistani local gateways |
| **Security & Auth** | ASP.NET Core Identity & JWT | Role-based policies (`EndUser`, `Lawyer`, `CorporateAdmin`, `SuperAdmin`), SMS/Email OTP |

---

## ⚙️ Quick Start

### 1. Prerequisites
- **.NET 8.0 SDK** (or later)
- **Node.js 18+ / 20+** and **npm**
- **Docker** (or local Microsoft SQL Server 2022)

### 2. Database Initialization
Start the local SQL Server instance using Docker:
```bash
cd infrastructure
docker-compose up -d
```
Then execute the scripts in `database/schema/` and `database/procedures/` in your SQL Server instance.

### 3. Backend API
```bash
cd src/LegalSaathi.Api
dotnet restore
dotnet build
dotnet run
```
Access Swagger UI at: `http://localhost:5000/swagger` or `https://localhost:5001/swagger`.
Health check endpoint: `GET /api/health`

### 4. Running Backend Tests
```bash
cd src/LegalSaathi.Api.Tests
dotnet test
```

### 5. Web Frontend
```bash
cd src/LegalSaathi.Web
npm install
npm run dev
```
Open `http://localhost:3000` in your browser.

---

## 🔐 Security & Compliance
- **Electronic Transactions Ordinance (ETO) 2002**: Court evidentiary compliance for digital agreements and timestamps.
- **Parametric SQL**: Strict parameterized stored procedures prevent SQL injection.
- **Secret Zero**: All secrets and keys are isolated in environment variables.

---

## 📄 License & Attribution
Proprietary & Confidential - Engineered by **Nexvora Technologies** for **Legal Saathi (LegalSaathi.pk)**.

export interface DocumentSummary {
  userDocumentId: number;
  documentGuid: string;
  templateId: number;
  templateTitleEn: string;
  templateTitleUr: string;
  title: string;
  status: string;
  statusId: number;
  isPaid: boolean;
  createdAt: string;
  completedAt?: string;
}

export interface DocumentDetail {
  userDocumentId: number;
  documentGuid: string;
  userId: number;
  templateId: number;
  templateTitleEn: string;
  templateTitleUr: string;
  title: string;
  formAnswersJson: string;
  status: string;
  statusId: number;
  storagePath?: string;
  docxStoragePath?: string;
  documentHash?: string;
  isPaid: boolean;
  createdAt: string;
  updatedAt?: string;
  completedAt?: string;
}

export interface GenerateDocumentResponse {
  userDocumentId: number;
  documentGuid: string;
  status: string;
  storagePath: string;
  docxStoragePath: string;
  documentHash: string;
  pdfDownloadUrl: string;
  docxDownloadUrl: string;
}

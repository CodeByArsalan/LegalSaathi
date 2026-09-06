export interface TemplateCategory {
  categoryId: number;
  nameEn: string;
  nameUr: string;
  descriptionEn?: string;
  descriptionUr?: string;
  icon?: string;
  templateCount: number;
}

export interface TemplateSummary {
  templateId: number;
  categoryId: number;
  categoryNameEn: string;
  categoryNameUr: string;
  slug: string;
  titleEn: string;
  titleUr: string;
  descriptionEn?: string;
  descriptionUr?: string;
  basePrice: number;
  tier: string;
  requiresStampPaper: boolean;
  estimatedStampDuty: number;
}

export interface FormField {
  fieldId: number;
  templateId: number;
  fieldKey: string;
  fieldType: "Text" | "Number" | "Date" | "Cnic" | "Phone" | "Email" | "TextArea" | "Select" | "Radio" | "Checkbox" | "CurrencyPkr" | "Address";
  labelEn: string;
  labelUr: string;
  placeholderEn?: string;
  placeholderUr?: string;
  helpTextEn?: string;
  helpTextUr?: string;
  isRequired: boolean;
  validationRegex?: string;
  optionsJson?: string;
  conditionalLogicJson?: string;
  stepNumber: number;
  sortOrder: number;
}

export interface TemplateDetail {
  templateId: number;
  categoryId: number;
  slug: string;
  titleEn: string;
  titleUr: string;
  descriptionEn?: string;
  descriptionUr?: string;
  basePrice: number;
  tier: string;
  contentTemplateEn: string;
  contentTemplateUr: string;
  applicableLaws?: string;
  requiresStampPaper: boolean;
  estimatedStampDuty: number;
  formFields: FormField[];
}

export interface TemplatePreviewResponse {
  interpolatedContentEn: string;
  interpolatedContentUr: string;
  missingRequiredFields: string[];
  isValid: boolean;
  validationErrors: string[];
}

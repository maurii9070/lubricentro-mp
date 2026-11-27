export type Shift = 'MORNING' | 'AFTERNOON';

export type OperationType = 'QUICK_SALE' | 'SERVICE';

export type PaymentMethod = 'CASH' | 'TRANSFER' | 'DEBIT' | 'CREDIT' | 'QR';

export interface ApiErrorResponse {
  timestamp: string;
  status: number;
  error: string;
  message: string;
  path: string;
  fieldErrors: Record<string, string>;
}

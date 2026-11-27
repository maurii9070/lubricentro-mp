import type { Shift, OperationType, PaymentMethod } from '@/types/common';

export interface PaymentMethodTotalResponse {
  paymentMethod: PaymentMethod;
  total: number;
}

export interface DailyClosingOperationResponse {
  saleId: number;
  operationDate: string;
  shift: Shift;
  operationType: OperationType;
  description: string;
  licensePlate: string | null;
  mileage: number | null;
  totalCharged: number;
  payments: PaymentMethodTotalResponse[];
}

export interface DrumConsumptionResponse {
  productId: number;
  productName: string;
  consumedLiters: number;
}

export interface DailyClosingReportResponse {
  date: string;
  shift: Shift | null;
  shiftLabel: string | null;
  completedSalesCount: number;
  completedServicesCount: number;
  totalAmount: number;
  paymentsByMethod: PaymentMethodTotalResponse[];
  operations: DailyClosingOperationResponse[];
  drumConsumption: DrumConsumptionResponse[];
}
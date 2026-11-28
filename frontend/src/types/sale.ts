import type { OperationType, PaymentMethod, Shift } from '@/types/common';
import type { StockMovementResponse } from '@/types/stockMovement';

export interface SaleDetailRequest {
  productId?: number | null;
  customDescription?: string | null;
  quantity: number;
  customUnitPrice?: number | null;
}

export interface SalePaymentRequest {
  paymentMethod: PaymentMethod;
  amount: number;
}

export interface VehicleServiceRequest {
  vehicleId: number;
  mileage?: number | null;
  technicalNotes?: string | null;
}

export interface SaleRequest {
  operationDate?: string | null;
  shift: Shift;
  operationType: OperationType;
  totalCharged: number;
  notes?: string | null;
  vehicleService?: VehicleServiceRequest | null;
  items: SaleDetailRequest[];
  payments: SalePaymentRequest[];
}

export interface SaleDetailResponse {
  id: number;
  productId: number | null;
  description: string;
  quantity: number;
  unitPrice: number;
  subtotal: number;
}

export interface SalePaymentResponse {
  id: number;
  paymentMethod: PaymentMethod;
  amount: number;
}

export interface VehicleServiceResponse {
  saleId: number;
  vehicleId: number;
  licensePlate: string;
  brandModel: string;
  mileage: number | null;
  technicalNotes: string | null;
}

export interface SaleResponse {
  id: number;
  operationDate: string;
  shift: Shift;
  operationType: OperationType;
  status: 'COMPLETED' | 'CANCELLED';
  calculatedSubtotal: number;
  totalCharged: number;
  notes: string | null;
  vehicleService: VehicleServiceResponse | null;
  items: SaleDetailResponse[];
  payments: SalePaymentResponse[];
}

export interface SaleCancellationRequest {
  reason?: string | null;
}

export interface SaleCancellationResponse {
  saleId: number;
  status: 'COMPLETED' | 'CANCELLED';
  operationDate: string;
  totalCharged: number;
  reason: string | null;
  movements: StockMovementResponse[];
}
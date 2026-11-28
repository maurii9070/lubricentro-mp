import type { SaleResponse } from '@/types/sale';

export interface VehicleResponse {
  id: number;
  licensePlate: string;
  brandModel: string;
  ownerName: string | null;
  phone: string | null;
  createdAt: string;
}

export interface VehicleRequest {
  licensePlate: string;
  brandModel: string;
  ownerName?: string | null;
  phone?: string | null;
}

export type VehicleServiceHistoryResponse = SaleResponse[];
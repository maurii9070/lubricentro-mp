export type DrumStatus = 'OPEN' | 'EMPTY';

export interface OilDrumResponse {
  id: number;
  productId: number;
  productName: string;
  capacityLiters: number;
  remainingLiters: number;
  remainingPercentage: number;
  status: DrumStatus;
  openedAt: string;
  notes: string | null;
}

export interface OpenOilDrumRequest {
  productId: number;
  capacityLiters: number;
  notes?: string | null;
}

export interface CloseOilDrumRequest {
  notes?: string | null;
}
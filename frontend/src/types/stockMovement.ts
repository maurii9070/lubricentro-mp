export type MovementType =
  | 'PURCHASE_ENTRY'
  | 'LOCAL_TRANSFER'
  | 'DRUM_OPENING'
  | 'SALE_EXIT'
  | 'MANUAL_ADJUSTMENT'
  | 'SALE_CANCELLATION';

export type StockLocation = 'LOCAL' | 'WAREHOUSE' | 'OPEN_DRUM';

export interface StockMovementResponse {
  id: number;
  productId: number;
  productName: string;
  saleId: number | null;
  movementType: MovementType;
  location: StockLocation;
  quantity: number;
  movementDate: string;
  reason: string | null;
}

export interface PurchaseEntryRequest {
  productId: number;
  location: StockLocation;
  quantity: number;
  reason: string | null;
}

export interface ManualAdjustmentRequest {
  productId: number;
  location: StockLocation;
  quantityDelta: number;
  reason: string;
}

import apiClient from '@/api/axiosClient';

import type {
  ManualAdjustmentRequest,
  PurchaseEntryRequest,
  StockMovementResponse,
} from '@/types/stockMovement';

export async function registerPurchaseEntry(
  request: PurchaseEntryRequest
): Promise<StockMovementResponse> {
  const { data } = await apiClient.post<StockMovementResponse>(
    '/stock-movements/entries',
    request
  );
  return data;
}

export async function registerManualAdjustment(
  request: ManualAdjustmentRequest
): Promise<StockMovementResponse> {
  const { data } = await apiClient.post<StockMovementResponse>(
    '/stock-movements/adjustments',
    request
  );
  return data;
}

export async function getMovementsByProduct(
  productId: number
): Promise<StockMovementResponse[]> {
  const { data } = await apiClient.get<StockMovementResponse[]>(
    `/stock-movements/product/${productId}`
  );
  return data;
}

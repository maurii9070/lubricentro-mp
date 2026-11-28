import apiClient from '@/api/axiosClient';

import type { SaleCancellationResponse, SaleRequest, SaleResponse } from '@/types/sale';

export async function createSale(request: SaleRequest): Promise<SaleResponse> {
  const { data } = await apiClient.post<SaleResponse>('/sales', request);
  return data;
}

export async function getSaleById(id: number): Promise<SaleResponse> {
  const { data } = await apiClient.get<SaleResponse>(`/sales/${id}`);
  return data;
}

export async function cancelSale(
  id: number,
  reason?: string | null
): Promise<SaleCancellationResponse> {
  const { data } = await apiClient.post<SaleCancellationResponse>(`/sales/${id}/cancel`, {
    reason: reason ?? null,
  });
  return data;
}
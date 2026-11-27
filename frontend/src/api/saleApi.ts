import apiClient from '@/api/axiosClient';

import type { SaleRequest, SaleResponse } from '@/types/sale';

export async function createSale(request: SaleRequest): Promise<SaleResponse> {
  const { data } = await apiClient.post<SaleResponse>('/sales', request);
  return data;
}

export async function getSaleById(id: number): Promise<SaleResponse> {
  const { data } = await apiClient.get<SaleResponse>(`/sales/${id}`);
  return data;
}
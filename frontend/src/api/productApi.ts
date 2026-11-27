import apiClient from '@/api/axiosClient';

import type { ProductResponse } from '@/types/product';

export async function listProducts(): Promise<ProductResponse[]> {
  const { data } = await apiClient.get<ProductResponse[]>('/products');
  return data;
}

export async function listLowStockProducts(): Promise<ProductResponse[]> {
  const { data } = await apiClient.get<ProductResponse[]>('/products/low-stock');
  return data;
}

export async function searchProducts(term: string): Promise<ProductResponse[]> {
  const { data } = await apiClient.get<ProductResponse[]>('/products/search', {
    params: { term },
  });
  return data;
}
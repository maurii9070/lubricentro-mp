import apiClient from '@/api/axiosClient';

import type { ProductRequest, ProductResponse, TransferStockRequest } from '@/types/product';

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

export async function getProductById(id: number): Promise<ProductResponse> {
  const { data } = await apiClient.get<ProductResponse>(`/products/${id}`);
  return data;
}

export async function createProduct(request: ProductRequest): Promise<ProductResponse> {
  const { data } = await apiClient.post<ProductResponse>('/products', request);
  return data;
}

export async function updateProduct(
  id: number,
  request: ProductRequest
): Promise<ProductResponse> {
  const { data } = await apiClient.put<ProductResponse>(`/products/${id}`, request);
  return data;
}

export async function deactivateProduct(id: number): Promise<void> {
  await apiClient.delete(`/products/${id}`);
}

export async function activateProduct(id: number): Promise<ProductResponse> {
  const { data } = await apiClient.patch<ProductResponse>(`/products/${id}/activate`);
  return data;
}

export async function transferStock(
  id: number,
  request: TransferStockRequest
): Promise<ProductResponse> {
  const { data } = await apiClient.patch<ProductResponse>(
    `/products/${id}/stock-transfer`,
    request
  );
  return data;
}

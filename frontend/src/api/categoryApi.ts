import apiClient from '@/api/axiosClient';

import type { CategoryResponse } from '@/types/product';

export async function listCategories(): Promise<CategoryResponse[]> {
  const { data } = await apiClient.get<CategoryResponse[]>('/categories');
  return data;
}

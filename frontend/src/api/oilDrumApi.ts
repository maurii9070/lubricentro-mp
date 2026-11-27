import apiClient from '@/api/axiosClient';

import type { OilDrumResponse, OpenOilDrumRequest, CloseOilDrumRequest } from '@/types/oilDrum';

export async function listOpenOilDrums(): Promise<OilDrumResponse[]> {
  const { data } = await apiClient.get<OilDrumResponse[]>('/oil-drums/open');
  return data;
}

export async function openOilDrum(request: OpenOilDrumRequest): Promise<OilDrumResponse> {
  const { data } = await apiClient.post<OilDrumResponse>('/oil-drums', request);
  return data;
}

export async function closeOilDrum(
  id: number,
  request?: CloseOilDrumRequest
): Promise<OilDrumResponse> {
  const { data } = await apiClient.patch<OilDrumResponse>(`/oil-drums/${id}/close`, request ?? {});
  return data;
}
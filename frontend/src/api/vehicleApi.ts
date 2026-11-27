import apiClient from '@/api/axiosClient';

import type { VehicleRequest, VehicleResponse } from '@/types/vehicle';

export async function searchVehicles(term: string): Promise<VehicleResponse[]> {
  const { data } = await apiClient.get<VehicleResponse[]>('/vehicles', {
    params: { search: term },
  });
  return data;
}

export async function getVehicleByLicensePlate(
  licensePlate: string
): Promise<VehicleResponse> {
  const { data } = await apiClient.get<VehicleResponse>(
    `/vehicles/plate/${encodeURIComponent(licensePlate)}`
  );
  return data;
}

export async function createVehicle(
  request: VehicleRequest
): Promise<VehicleResponse> {
  const { data } = await apiClient.post<VehicleResponse>('/vehicles', request);
  return data;
}
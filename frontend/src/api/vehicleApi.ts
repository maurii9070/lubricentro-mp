import apiClient from '@/api/axiosClient';

import type { VehicleRequest, VehicleResponse } from '@/types/vehicle';
import type { SaleResponse } from '@/types/sale';

export async function searchVehicles(term: string): Promise<VehicleResponse[]> {
  const { data } = await apiClient.get<VehicleResponse[]>('/vehicles', {
    params: { search: term },
  });
  return data;
}

export async function getVehicleById(id: number): Promise<VehicleResponse> {
  const { data } = await apiClient.get<VehicleResponse>(`/vehicles/${id}`);
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

export async function updateVehicle(
  id: number,
  request: VehicleRequest
): Promise<VehicleResponse> {
  const { data } = await apiClient.put<VehicleResponse>(`/vehicles/${id}`, request);
  return data;
}

export async function getVehicleServiceHistory(
  vehicleId: number
): Promise<SaleResponse[]> {
  const { data } = await apiClient.get<SaleResponse[]>(
    `/sales/vehicles/${vehicleId}/history`
  );
  return data;
}
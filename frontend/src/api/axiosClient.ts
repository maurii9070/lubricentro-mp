import axios, { type AxiosError } from 'axios';

import type { ApiErrorResponse } from '@/types/common';

const apiClient = axios.create({
  baseURL: import.meta.env.VITE_API_URL ?? 'http://localhost:8080/api/v1',
  headers: {
    'Content-Type': 'application/json',
  },
});

apiClient.interceptors.response.use(
  (response) => response,
  (error: AxiosError<ApiErrorResponse>) => {
    if (error.response?.data) {
      const data = error.response.data;
      const fieldMessage = data.fieldErrors
        ? Object.values(data.fieldErrors).join(' ')
        : '';
      const message = data.message || data.error || fieldMessage || 'Ocurrió un error inesperado.';
      return Promise.reject(new Error(message));
    }

    if (error.request) {
      return Promise.reject(
        new Error('No se pudo conectar con el servidor. Verificá tu conexión e intentá nuevamente.')
      );
    }

    return Promise.reject(new Error('Ocurrió un error inesperado. Intentá nuevamente.'));
  }
);

export default apiClient;

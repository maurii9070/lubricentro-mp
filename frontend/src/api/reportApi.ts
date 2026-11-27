import apiClient from '@/api/axiosClient';

import type { DailyClosingReportResponse } from '@/types/report';
import type { Shift } from '@/types/common';

export async function getDailyClosingReport(
  date: string,
  shift?: Shift
): Promise<DailyClosingReportResponse> {
  const { data } = await apiClient.get<DailyClosingReportResponse>('/reports/daily-closing', {
    params: { date, shift },
  });
  return data;
}
package com.lubricentromp.api.dto;

import com.lubricentromp.api.enums.Shift;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

public record DailyClosingReportResponse(
        LocalDate date,
        Shift shift,
        String shiftLabel,
        long completedSalesCount,
        long completedServicesCount,
        BigDecimal totalAmount,
        List<PaymentMethodTotalResponse> paymentsByMethod,
        List<DailyClosingOperationResponse> operations,
        List<DrumConsumptionResponse> drumConsumption
) {
}

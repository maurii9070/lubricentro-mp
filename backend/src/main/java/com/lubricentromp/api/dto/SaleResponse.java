package com.lubricentromp.api.dto;

import com.lubricentromp.api.enums.OperationType;
import com.lubricentromp.api.enums.Shift;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public record SaleResponse(
        Long id,
        LocalDateTime operationDate,
        Shift shift,
        OperationType operationType,
        BigDecimal calculatedSubtotal,
        BigDecimal totalCharged,
        String notes,
        VehicleServiceResponse vehicleService,
        List<SaleDetailResponse> items,
        List<SalePaymentResponse> payments
) {
}

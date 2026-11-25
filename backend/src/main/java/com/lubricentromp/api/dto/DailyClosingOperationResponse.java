package com.lubricentromp.api.dto;

import com.lubricentromp.api.enums.OperationType;
import com.lubricentromp.api.enums.Shift;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public record DailyClosingOperationResponse(
        Long saleId,
        LocalDateTime operationDate,
        Shift shift,
        OperationType operationType,
        String description,
        String licensePlate,
        Integer mileage,
        BigDecimal totalCharged,
        List<PaymentMethodTotalResponse> payments
) {
}

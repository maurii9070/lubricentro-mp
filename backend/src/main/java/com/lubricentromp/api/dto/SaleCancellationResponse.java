package com.lubricentromp.api.dto;

import com.lubricentromp.api.enums.SaleStatus;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public record SaleCancellationResponse(
        Long saleId,
        SaleStatus status,
        LocalDateTime operationDate,
        BigDecimal totalCharged,
        String reason,
        List<StockMovementResponse> movements
) {
}

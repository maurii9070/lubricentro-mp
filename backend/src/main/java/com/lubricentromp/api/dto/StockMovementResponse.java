package com.lubricentromp.api.dto;

import com.lubricentromp.api.enums.MovementType;
import com.lubricentromp.api.enums.StockLocation;
import java.math.BigDecimal;
import java.time.LocalDateTime;

public record StockMovementResponse(
        Long id,
        Long productId,
        String productName,
        Long saleId,
        MovementType movementType,
        StockLocation location,
        BigDecimal quantity,
        LocalDateTime movementDate,
        String reason
) {
}

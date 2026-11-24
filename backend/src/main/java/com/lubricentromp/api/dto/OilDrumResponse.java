package com.lubricentromp.api.dto;

import com.lubricentromp.api.enums.DrumStatus;
import java.math.BigDecimal;
import java.time.LocalDateTime;

public record OilDrumResponse(
        Long id,
        Long productId,
        String productName,
        BigDecimal capacityLiters,
        BigDecimal remainingLiters,
        BigDecimal remainingPercentage,
        DrumStatus status,
        LocalDateTime openedAt,
        String notes
) {
}

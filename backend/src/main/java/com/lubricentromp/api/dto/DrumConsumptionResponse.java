package com.lubricentromp.api.dto;

import java.math.BigDecimal;

public record DrumConsumptionResponse(
        Long productId,
        String productName,
        BigDecimal consumedLiters
) {
}

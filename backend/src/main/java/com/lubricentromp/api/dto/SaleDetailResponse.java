package com.lubricentromp.api.dto;

import java.math.BigDecimal;

public record SaleDetailResponse(
        Long id,
        Long productId,
        String description,
        BigDecimal quantity,
        BigDecimal unitPrice,
        BigDecimal subtotal
) {
}

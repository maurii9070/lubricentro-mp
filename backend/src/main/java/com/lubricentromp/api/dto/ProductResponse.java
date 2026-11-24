package com.lubricentromp.api.dto;

import java.math.BigDecimal;

public record ProductResponse(
        Long id,
        Long categoryId,
        String categoryName,
        String code,
        String name,
        String brand,
        boolean tracksStock,
        int localStock,
        int warehouseStock,
        int minStock,
        BigDecimal listPrice,
        boolean active
) {
}

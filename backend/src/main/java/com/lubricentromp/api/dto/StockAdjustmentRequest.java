package com.lubricentromp.api.dto;

import com.lubricentromp.api.enums.StockLocation;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.math.BigDecimal;

public record StockAdjustmentRequest(
        @NotNull(message = "El producto es obligatorio.")
        Long productId,

        @NotNull(message = "La ubicación es obligatoria.")
        StockLocation location,

        @NotNull(message = "El ajuste es obligatorio.")
        @Digits(integer = 6, fraction = 2, message = "El ajuste debe tener como máximo 6 enteros y 2 decimales.")
        BigDecimal quantityDelta,

        @NotBlank(message = "El motivo del ajuste es obligatorio.")
        @Size(max = 255, message = "El motivo no puede superar los 255 caracteres.")
        String reason
) {
}

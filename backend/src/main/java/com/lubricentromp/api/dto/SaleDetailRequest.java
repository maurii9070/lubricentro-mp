package com.lubricentromp.api.dto;

import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.PositiveOrZero;
import jakarta.validation.constraints.Size;
import java.math.BigDecimal;

public record SaleDetailRequest(
        Long productId,

        @Size(max = 255, message = "La descripción no puede superar los 255 caracteres.")
        String customDescription,

        @NotNull(message = "La cantidad es obligatoria.")
        @Positive(message = "La cantidad debe ser mayor a cero.")
        @Digits(integer = 6, fraction = 2, message = "La cantidad debe tener como máximo 6 enteros y 2 decimales.")
        BigDecimal quantity,

        @PositiveOrZero(message = "El precio unitario no puede ser negativo.")
        @Digits(integer = 8, fraction = 2, message = "El precio unitario debe tener como máximo 8 enteros y 2 decimales.")
        BigDecimal customUnitPrice
) {
}

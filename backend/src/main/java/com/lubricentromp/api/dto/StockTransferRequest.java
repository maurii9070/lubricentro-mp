package com.lubricentromp.api.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

public record StockTransferRequest(
        @NotNull(message = "La cantidad a trasladar es obligatoria.")
        @Positive(message = "La cantidad a trasladar debe ser mayor a cero.")
        Integer quantity
) {
}

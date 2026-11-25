package com.lubricentromp.api.dto;

import com.lubricentromp.api.enums.StockLocation;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.Size;

public record StockEntryRequest(
        @NotNull(message = "El producto es obligatorio.")
        Long productId,

        @NotNull(message = "La ubicación es obligatoria.")
        StockLocation location,

        @NotNull(message = "La cantidad del ingreso es obligatoria.")
        @Positive(message = "La cantidad del ingreso debe ser mayor a cero.")
        Integer quantity,

        @Size(max = 255, message = "El motivo no puede superar los 255 caracteres.")
        String reason
) {
}

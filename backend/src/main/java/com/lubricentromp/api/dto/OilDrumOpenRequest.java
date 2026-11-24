package com.lubricentromp.api.dto;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.math.BigDecimal;

public record OilDrumOpenRequest(
        @NotNull(message = "El producto es obligatorio.")
        Long productId,

        @NotNull(message = "La capacidad del tambor es obligatoria.")
        @DecimalMin(value = "0.01", message = "La capacidad del tambor debe ser mayor a cero.")
        @Digits(integer = 6, fraction = 2, message = "La capacidad del tambor debe tener como máximo 6 enteros y 2 decimales.")
        BigDecimal capacityLiters,

        @Size(max = 255, message = "Las notas no pueden superar los 255 caracteres.")
        String notes
) {
}

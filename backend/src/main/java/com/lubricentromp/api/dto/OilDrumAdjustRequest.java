package com.lubricentromp.api.dto;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.math.BigDecimal;

public record OilDrumAdjustRequest(
        @NotNull(message = "Los litros restantes son obligatorios.")
        @DecimalMin(value = "0.00", message = "Los litros restantes no pueden ser negativos.")
        @Digits(integer = 6, fraction = 2, message = "Los litros restantes deben tener como máximo 6 enteros y 2 decimales.")
        BigDecimal remainingLiters,

        @Size(max = 255, message = "Las notas no pueden superar los 255 caracteres.")
        String notes
) {
}

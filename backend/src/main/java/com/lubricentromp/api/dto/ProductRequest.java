package com.lubricentromp.api.dto;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;
import jakarta.validation.constraints.Size;
import java.math.BigDecimal;

public record ProductRequest(
        @NotNull(message = "La categoría es obligatoria.")
        Long categoryId,

        @Size(max = 50, message = "El código no puede superar los 50 caracteres.")
        String code,

        @NotBlank(message = "El nombre del producto es obligatorio.")
        @Size(max = 200, message = "El nombre del producto no puede superar los 200 caracteres.")
        String name,

        @Size(max = 100, message = "La marca no puede superar los 100 caracteres.")
        String brand,

        @NotNull(message = "El indicador de control de stock es obligatorio.")
        Boolean tracksStock,

        @NotNull(message = "El stock local es obligatorio.")
        @PositiveOrZero(message = "El stock local no puede ser negativo.")
        Integer localStock,

        @NotNull(message = "El stock de depósito es obligatorio.")
        @PositiveOrZero(message = "El stock de depósito no puede ser negativo.")
        Integer warehouseStock,

        @NotNull(message = "El stock mínimo es obligatorio.")
        @PositiveOrZero(message = "El stock mínimo no puede ser negativo.")
        Integer minStock,

        @NotNull(message = "El precio de lista es obligatorio.")
        @DecimalMin(value = "0.00", message = "El precio de lista no puede ser negativo.")
        @Digits(integer = 8, fraction = 2, message = "El precio de lista debe tener como máximo 8 enteros y 2 decimales.")
        BigDecimal listPrice
) {
}

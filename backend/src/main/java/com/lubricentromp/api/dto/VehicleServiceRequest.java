package com.lubricentromp.api.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;
import jakarta.validation.constraints.Size;

public record VehicleServiceRequest(
        @NotNull(message = "El vehículo es obligatorio para una operación de tipo SERVICE.")
        Long vehicleId,

        @PositiveOrZero(message = "El kilometraje no puede ser negativo.")
        Integer mileage,

        @Size(max = 2000, message = "Las notas técnicas no pueden superar los 2000 caracteres.")
        String technicalNotes
) {
}

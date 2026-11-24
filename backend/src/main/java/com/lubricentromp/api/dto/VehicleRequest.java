package com.lubricentromp.api.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record VehicleRequest(
        @NotBlank(message = "La patente es obligatoria.")
        @Size(max = 20, message = "La patente no puede superar los 20 caracteres.")
        String licensePlate,

        @NotBlank(message = "La marca y modelo son obligatorios.")
        @Size(max = 150, message = "La marca y modelo no pueden superar los 150 caracteres.")
        String brandModel,

        @Size(max = 150, message = "El nombre del propietario no puede superar los 150 caracteres.")
        String ownerName,

        @Size(max = 50, message = "El teléfono no puede superar los 50 caracteres.")
        String phone
) {
}

package com.lubricentromp.api.dto;

import jakarta.validation.constraints.Size;

public record SaleCancellationRequest(
        @Size(max = 255, message = "El motivo de la anulación no puede superar los 255 caracteres.")
        String reason
) {
}

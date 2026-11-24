package com.lubricentromp.api.dto;

import jakarta.validation.constraints.Size;

public record OilDrumCloseRequest(
        @Size(max = 255, message = "Las notas no pueden superar los 255 caracteres.")
        String notes
) {
}

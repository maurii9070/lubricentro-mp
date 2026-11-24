package com.lubricentromp.api.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record CategoryRequest(
        @NotBlank(message = "El nombre de la categoría es obligatorio.")
        @Size(max = 100, message = "El nombre de la categoría no puede superar los 100 caracteres.")
        String name
) {
}

package com.lubricentromp.api.dto;

public record CategoryResponse(
        Long id,
        String name,
        boolean active
) {
}

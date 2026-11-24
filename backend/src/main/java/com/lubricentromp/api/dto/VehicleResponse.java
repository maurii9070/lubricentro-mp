package com.lubricentromp.api.dto;

import java.time.LocalDateTime;

public record VehicleResponse(
        Long id,
        String licensePlate,
        String brandModel,
        String ownerName,
        String phone,
        LocalDateTime createdAt
) {
}

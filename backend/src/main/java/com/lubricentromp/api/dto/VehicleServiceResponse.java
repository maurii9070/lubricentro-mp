package com.lubricentromp.api.dto;

public record VehicleServiceResponse(
        Long saleId,
        Long vehicleId,
        String licensePlate,
        String brandModel,
        Integer mileage,
        String technicalNotes
) {
}

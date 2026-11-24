package com.lubricentromp.api.mapper;

import com.lubricentromp.api.dto.VehicleRequest;
import com.lubricentromp.api.dto.VehicleResponse;
import com.lubricentromp.api.entity.Vehicle;
import java.time.LocalDateTime;
import java.util.Locale;
import org.springframework.stereotype.Component;

@Component
public class VehicleMapper {

    public Vehicle toEntity(VehicleRequest request) {
        Vehicle vehicle = new Vehicle();
        applyRequest(vehicle, request);
        vehicle.setCreatedAt(LocalDateTime.now());
        return vehicle;
    }

    public void updateEntity(Vehicle vehicle, VehicleRequest request) {
        applyRequest(vehicle, request);
    }

    public VehicleResponse toResponse(Vehicle vehicle) {
        return new VehicleResponse(
                vehicle.getId(),
                vehicle.getLicensePlate(),
                vehicle.getBrandModel(),
                vehicle.getOwnerName(),
                vehicle.getPhone(),
                vehicle.getCreatedAt()
        );
    }

    public static String normalizeLicensePlate(String licensePlate) {
        if (licensePlate == null) {
            return null;
        }
        return licensePlate
                .replaceAll("\\s+", "")
                .replace("-", "")
                .toUpperCase(Locale.ROOT);
    }

    private void applyRequest(Vehicle vehicle, VehicleRequest request) {
        vehicle.setLicensePlate(normalizeLicensePlate(request.licensePlate()));
        vehicle.setBrandModel(request.brandModel().trim());
        vehicle.setOwnerName(normalizeNullable(request.ownerName()));
        vehicle.setPhone(normalizeNullable(request.phone()));
    }

    private static String normalizeNullable(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }
}

package com.lubricentromp.api.service;

import com.lubricentromp.api.dto.VehicleRequest;
import com.lubricentromp.api.dto.VehicleResponse;
import com.lubricentromp.api.entity.Vehicle;
import com.lubricentromp.api.exception.BusinessRuleException;
import com.lubricentromp.api.exception.ResourceNotFoundException;
import com.lubricentromp.api.mapper.VehicleMapper;
import com.lubricentromp.api.repository.VehicleRepository;
import java.util.List;
import java.util.Locale;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class VehicleService {

    private final VehicleRepository vehicleRepository;
    private final VehicleMapper vehicleMapper;

    public VehicleService(VehicleRepository vehicleRepository, VehicleMapper vehicleMapper) {
        this.vehicleRepository = vehicleRepository;
        this.vehicleMapper = vehicleMapper;
    }

    @Transactional
    public VehicleResponse createVehicle(VehicleRequest request) {
        String licensePlate = VehicleMapper.normalizeLicensePlate(request.licensePlate());
        if (vehicleRepository.existsByLicensePlate(licensePlate)) {
            throw new BusinessRuleException(
                    "Ya existe un vehículo registrado con la patente '" + licensePlate + "'."
            );
        }
        Vehicle vehicle = vehicleMapper.toEntity(request);
        return vehicleMapper.toResponse(vehicleRepository.save(vehicle));
    }

    @Transactional
    public VehicleResponse updateVehicle(Long id, VehicleRequest request) {
        Vehicle vehicle = findVehicle(id);
        String licensePlate = VehicleMapper.normalizeLicensePlate(request.licensePlate());
        validateLicensePlateAvailable(licensePlate, id);
        vehicleMapper.updateEntity(vehicle, request);
        return vehicleMapper.toResponse(vehicleRepository.save(vehicle));
    }

    public VehicleResponse getVehicleById(Long id) {
        return vehicleMapper.toResponse(findVehicle(id));
    }

    public VehicleResponse getVehicleByLicensePlate(String licensePlate) {
        String normalizedLicensePlate = VehicleMapper.normalizeLicensePlate(licensePlate);
        Vehicle vehicle = vehicleRepository.findByLicensePlate(normalizedLicensePlate)
                .orElseThrow(() -> new ResourceNotFoundException(
                        "No existe el vehículo con patente '" + normalizedLicensePlate + "'."
                ));
        return vehicleMapper.toResponse(vehicle);
    }

    public List<VehicleResponse> searchVehicles(String term) {
        String normalizedTerm = normalizeSearchTerm(term);
        List<Vehicle> vehicles = normalizedTerm.isEmpty()
                ? vehicleRepository.findAllByOrderByCreatedAtDescIdDesc()
                : vehicleRepository.searchByTerm(normalizedTerm);
        return vehicles.stream().map(vehicleMapper::toResponse).toList();
    }

    private Vehicle findVehicle(Long id) {
        return vehicleRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("No existe el vehículo con id " + id + "."));
    }

    private void validateLicensePlateAvailable(String licensePlate, Long vehicleId) {
        if (vehicleRepository.existsByLicensePlateAndIdNot(licensePlate, vehicleId)) {
            throw new BusinessRuleException(
                    "Ya existe un vehículo registrado con la patente '" + licensePlate + "'."
            );
        }
    }

    private String normalizeSearchTerm(String term) {
        if (term == null) {
            return "";
        }
        return term
                .replaceAll("\\s+", "")
                .replace("-", "")
                .toLowerCase(Locale.ROOT);
    }
}

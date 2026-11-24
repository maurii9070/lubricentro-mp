package com.lubricentromp.api.controller;

import com.lubricentromp.api.dto.VehicleRequest;
import com.lubricentromp.api.dto.VehicleResponse;
import com.lubricentromp.api.service.VehicleService;
import jakarta.validation.Valid;
import java.net.URI;
import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/vehicles")
public class VehicleController {

    private final VehicleService vehicleService;

    public VehicleController(VehicleService vehicleService) {
        this.vehicleService = vehicleService;
    }

    @GetMapping
    public List<VehicleResponse> search(
            @RequestParam(name = "search", required = false, defaultValue = "") String search
    ) {
        return vehicleService.searchVehicles(search);
    }

    @GetMapping("/{id}")
    public VehicleResponse findById(@PathVariable("id") Long id) {
        return vehicleService.getVehicleById(id);
    }

    @GetMapping("/plate/{licensePlate}")
    public VehicleResponse findByLicensePlate(@PathVariable("licensePlate") String licensePlate) {
        return vehicleService.getVehicleByLicensePlate(licensePlate);
    }

    @PostMapping
    public ResponseEntity<VehicleResponse> create(@Valid @RequestBody VehicleRequest request) {
        VehicleResponse response = vehicleService.createVehicle(request);
        return ResponseEntity.created(URI.create("/api/v1/vehicles/" + response.id())).body(response);
    }

    @PutMapping("/{id}")
    public VehicleResponse update(
            @PathVariable("id") Long id,
            @Valid @RequestBody VehicleRequest request
    ) {
        return vehicleService.updateVehicle(id, request);
    }
}

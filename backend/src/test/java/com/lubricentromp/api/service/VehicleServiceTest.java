package com.lubricentromp.api.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import com.lubricentromp.api.dto.VehicleRequest;
import com.lubricentromp.api.dto.VehicleResponse;
import com.lubricentromp.api.entity.Vehicle;
import com.lubricentromp.api.exception.BusinessRuleException;
import com.lubricentromp.api.exception.ResourceNotFoundException;
import com.lubricentromp.api.mapper.VehicleMapper;
import com.lubricentromp.api.repository.VehicleRepository;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class VehicleServiceTest {

    private static final LocalDateTime CREATED_AT = LocalDateTime.of(2026, 1, 15, 10, 30);

    @Mock
    private VehicleRepository vehicleRepository;

    private VehicleService vehicleService;

    @BeforeEach
    void setUp() {
        vehicleService = new VehicleService(vehicleRepository, new VehicleMapper());
    }

    @Test
    void createVehicleShouldNormalizeLicensePlate() {
        VehicleRequest request = request("ab 123 cd", "Toyota Corolla", "Ana Pérez", "351-555-1234");
        when(vehicleRepository.existsByLicensePlate("AB123CD")).thenReturn(false);
        when(vehicleRepository.save(any(Vehicle.class))).thenAnswer(invocation -> {
            Vehicle vehicle = invocation.getArgument(0);
            vehicle.setId(10L);
            return vehicle;
        });

        VehicleResponse response = vehicleService.createVehicle(request);

        assertEquals(10L, response.id());
        assertEquals("AB123CD", response.licensePlate());
        assertEquals("Toyota Corolla", response.brandModel());
        assertEquals("Ana Pérez", response.ownerName());
        assertEquals("351-555-1234", response.phone());
        assertNotNull(response.createdAt());
        verify(vehicleRepository).existsByLicensePlate("AB123CD");
        verify(vehicleRepository).save(any(Vehicle.class));
    }

    @Test
    void createVehicleShouldStoreBlankOptionalFieldsAsNull() {
        VehicleRequest request = request("ab123cd", "Toyota Corolla", "   ", "");
        when(vehicleRepository.existsByLicensePlate("AB123CD")).thenReturn(false);
        when(vehicleRepository.save(any(Vehicle.class))).thenAnswer(invocation -> {
            Vehicle vehicle = invocation.getArgument(0);
            vehicle.setId(10L);
            return vehicle;
        });

        VehicleResponse response = vehicleService.createVehicle(request);

        assertNull(response.ownerName());
        assertNull(response.phone());
    }

    @Test
    void createVehicleShouldRejectDuplicateLicensePlate() {
        VehicleRequest request = request("ab 123 cd", "Toyota Corolla", null, null);
        when(vehicleRepository.existsByLicensePlate("AB123CD")).thenReturn(true);

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> vehicleService.createVehicle(request)
        );

        assertTrue(exception.getMessage().contains("Ya existe un vehículo registrado"));
        assertTrue(exception.getMessage().contains("AB123CD"));
        verify(vehicleRepository, never()).save(any(Vehicle.class));
    }

    @Test
    void updateVehicleShouldNormalizeLicensePlateAndKeepCreatedAt() {
        Vehicle vehicle = vehicle(10L, "AB123CD", "Toyota Corolla");
        when(vehicleRepository.findById(10L)).thenReturn(Optional.of(vehicle));
        when(vehicleRepository.existsByLicensePlateAndIdNot("XY987ZZ", 10L)).thenReturn(false);
        when(vehicleRepository.save(vehicle)).thenReturn(vehicle);

        VehicleResponse response = vehicleService.updateVehicle(
                10L,
                request("xy-987 zz", "Ford Ranger", "Juan Gómez", "3515550000")
        );

        assertEquals(10L, response.id());
        assertEquals("XY987ZZ", response.licensePlate());
        assertEquals("Ford Ranger", response.brandModel());
        assertEquals("Juan Gómez", response.ownerName());
        assertEquals(CREATED_AT, response.createdAt());
        verify(vehicleRepository).existsByLicensePlateAndIdNot("XY987ZZ", 10L);
        verify(vehicleRepository).save(vehicle);
    }

    @Test
    void updateVehicleShouldRejectLicensePlateUsedByAnotherVehicle() {
        Vehicle vehicle = vehicle(10L, "AB123CD", "Toyota Corolla");
        when(vehicleRepository.findById(10L)).thenReturn(Optional.of(vehicle));
        when(vehicleRepository.existsByLicensePlateAndIdNot("XY987ZZ", 10L)).thenReturn(true);

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> vehicleService.updateVehicle(10L, request("xy 987 zz", "Ford Ranger", null, null))
        );

        assertTrue(exception.getMessage().contains("Ya existe un vehículo registrado"));
        assertTrue(exception.getMessage().contains("XY987ZZ"));
        verify(vehicleRepository, never()).save(any(Vehicle.class));
    }

    @Test
    void updateVehicleShouldRejectMissingVehicle() {
        when(vehicleRepository.findById(99L)).thenReturn(Optional.empty());

        assertThrows(
                ResourceNotFoundException.class,
                () -> vehicleService.updateVehicle(99L, request("ab123cd", "Toyota Corolla", null, null))
        );

        verify(vehicleRepository, never()).save(any(Vehicle.class));
    }

    @Test
    void getVehicleByLicensePlateShouldNormalizeInput() {
        when(vehicleRepository.findByLicensePlate("AB123CD"))
                .thenReturn(Optional.of(vehicle(10L, "AB123CD", "Toyota Corolla")));

        VehicleResponse response = vehicleService.getVehicleByLicensePlate(" ab-123 cd ");

        assertEquals(10L, response.id());
        assertEquals("AB123CD", response.licensePlate());
        verify(vehicleRepository).findByLicensePlate("AB123CD");
    }

    @Test
    void getVehicleByLicensePlateShouldRejectMissingVehicle() {
        when(vehicleRepository.findByLicensePlate("ZZ999ZZ")).thenReturn(Optional.empty());

        ResourceNotFoundException exception = assertThrows(
                ResourceNotFoundException.class,
                () -> vehicleService.getVehicleByLicensePlate("zz 999-zz")
        );

        assertTrue(exception.getMessage().contains("ZZ999ZZ"));
    }

    @Test
    void getVehicleByIdShouldReturnVehicle() {
        when(vehicleRepository.findById(10L))
                .thenReturn(Optional.of(vehicle(10L, "AB123CD", "Toyota Corolla")));

        VehicleResponse response = vehicleService.getVehicleById(10L);

        assertEquals(10L, response.id());
        assertEquals("AB123CD", response.licensePlate());
    }

    @Test
    void getVehicleByIdShouldRejectMissingVehicle() {
        when(vehicleRepository.findById(99L)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> vehicleService.getVehicleById(99L));
    }

    @Test
    void searchVehiclesShouldReturnAllWhenTermIsBlank() {
        when(vehicleRepository.findAllByOrderByCreatedAtDescIdDesc()).thenReturn(List.of(
                vehicle(2L, "BB222BB", "Ford Ranger"),
                vehicle(1L, "AA111AA", "Toyota Corolla")
        ));

        List<VehicleResponse> blankTerm = vehicleService.searchVehicles("   ");
        List<VehicleResponse> nullTerm = vehicleService.searchVehicles(null);

        assertEquals(2, blankTerm.size());
        assertEquals("BB222BB", blankTerm.get(0).licensePlate());
        assertEquals(2, nullTerm.size());
        verify(vehicleRepository, never()).searchByTerm(any());
    }

    @Test
    void searchVehiclesShouldUseFlexibleSearchWhenTermHasText() {
        when(vehicleRepository.searchByTerm("toyota"))
                .thenReturn(List.of(vehicle(1L, "AA111AA", "Toyota Corolla")));

        List<VehicleResponse> responses = vehicleService.searchVehicles(" Toyota ");

        assertEquals(1, responses.size());
        assertEquals("Toyota Corolla", responses.get(0).brandModel());
        verify(vehicleRepository).searchByTerm("toyota");
        verify(vehicleRepository, never()).findAllByOrderByCreatedAtDescIdDesc();
    }

    @Test
    void searchVehiclesShouldNormalizeLicensePlateTerm() {
        when(vehicleRepository.searchByTerm("ab123cd"))
                .thenReturn(List.of(vehicle(1L, "AB123CD", "Toyota Corolla")));

        List<VehicleResponse> responses = vehicleService.searchVehicles("ab 123-cd");

        assertEquals(1, responses.size());
        assertEquals("AB123CD", responses.get(0).licensePlate());
        verify(vehicleRepository).searchByTerm("ab123cd");
    }

    private VehicleRequest request(String licensePlate, String brandModel, String ownerName, String phone) {
        return new VehicleRequest(licensePlate, brandModel, ownerName, phone);
    }

    private Vehicle vehicle(Long id, String licensePlate, String brandModel) {
        Vehicle vehicle = new Vehicle();
        vehicle.setId(id);
        vehicle.setLicensePlate(licensePlate);
        vehicle.setBrandModel(brandModel);
        vehicle.setCreatedAt(CREATED_AT);
        return vehicle;
    }
}

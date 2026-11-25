package com.lubricentromp.api.repository;

import com.lubricentromp.api.entity.VehicleService;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface VehicleServiceRepository extends JpaRepository<VehicleService, Long> {

    @Query("""
            SELECT vs FROM VehicleService vs
            JOIN FETCH vs.sale s
            JOIN FETCH vs.vehicle v
            WHERE v.id = :vehicleId
            ORDER BY s.operationDate DESC, s.id DESC
            """)
    List<VehicleService> findHistoryByVehicleId(@Param("vehicleId") Long vehicleId);

    @Query("""
            SELECT vs FROM VehicleService vs
            JOIN FETCH vs.vehicle
            WHERE vs.sale.id = :saleId
            """)
    Optional<VehicleService> findBySaleIdWithVehicle(@Param("saleId") Long saleId);
}

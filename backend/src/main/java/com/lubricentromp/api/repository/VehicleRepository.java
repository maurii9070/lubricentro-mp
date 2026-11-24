package com.lubricentromp.api.repository;

import com.lubricentromp.api.entity.Vehicle;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface VehicleRepository extends JpaRepository<Vehicle, Long> {

    Optional<Vehicle> findByLicensePlate(String licensePlate);

    boolean existsByLicensePlate(String licensePlate);

    boolean existsByLicensePlateAndIdNot(String licensePlate, Long id);

    List<Vehicle> findAllByOrderByCreatedAtDescIdDesc();

    @Query("""
            SELECT v FROM Vehicle v
            WHERE LOWER(REPLACE(REPLACE(v.licensePlate, '-', ''), ' ', '')) LIKE CONCAT('%', :term, '%')
               OR LOWER(REPLACE(REPLACE(COALESCE(v.brandModel, ''), '-', ''), ' ', '')) LIKE CONCAT('%', :term, '%')
            ORDER BY v.createdAt DESC, v.id DESC
            """)
    List<Vehicle> searchByTerm(@Param("term") String term);
}

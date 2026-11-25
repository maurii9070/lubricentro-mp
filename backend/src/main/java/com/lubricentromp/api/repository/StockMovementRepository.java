package com.lubricentromp.api.repository;

import com.lubricentromp.api.dto.DrumConsumptionResponse;
import com.lubricentromp.api.entity.StockMovement;
import com.lubricentromp.api.enums.MovementType;
import com.lubricentromp.api.enums.StockLocation;
import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface StockMovementRepository extends JpaRepository<StockMovement, Long> {

    List<StockMovement> findBySaleIdOrderByMovementDateAscIdAsc(Long saleId);

    @Query("""
            SELECT m FROM StockMovement m
            JOIN FETCH m.product
            WHERE m.product.id = :productId
            ORDER BY m.movementDate DESC, m.id DESC
            """)
    List<StockMovement> findHistoryByProductId(@Param("productId") Long productId);

    @Query("""
            SELECT new com.lubricentromp.api.dto.DrumConsumptionResponse(
                m.product.id,
                m.product.name,
                SUM(m.quantity) * -1
            )
            FROM StockMovement m
            WHERE m.location = :location
              AND m.movementType IN :movementTypes
              AND m.movementDate >= :from
              AND m.movementDate < :to
            GROUP BY m.product.id, m.product.name
            ORDER BY m.product.name ASC
            """)
    List<DrumConsumptionResponse> sumConsumedLitersBetween(
            @Param("location") StockLocation location,
            @Param("movementTypes") Collection<MovementType> movementTypes,
            @Param("from") LocalDateTime from,
            @Param("to") LocalDateTime to
    );
}

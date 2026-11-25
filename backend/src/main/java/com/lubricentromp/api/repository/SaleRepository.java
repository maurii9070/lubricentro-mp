package com.lubricentromp.api.repository;

import com.lubricentromp.api.entity.Sale;
import com.lubricentromp.api.enums.SaleStatus;
import com.lubricentromp.api.enums.Shift;
import jakarta.persistence.LockModeType;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface SaleRepository extends JpaRepository<Sale, Long> {

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("SELECT s FROM Sale s WHERE s.id = :id")
    Optional<Sale> findByIdForUpdate(@Param("id") Long id);

    @Query("""
            SELECT s FROM Sale s
            WHERE s.status = :status
              AND s.operationDate >= :from
              AND s.operationDate < :to
            ORDER BY s.operationDate ASC, s.id ASC
            """)
    List<Sale> findCompletedBetween(
            @Param("status") SaleStatus status,
            @Param("from") LocalDateTime from,
            @Param("to") LocalDateTime to
    );

    @Query("""
            SELECT s FROM Sale s
            WHERE s.status = :status
              AND s.shift = :shift
              AND s.operationDate >= :from
              AND s.operationDate < :to
            ORDER BY s.operationDate ASC, s.id ASC
            """)
    List<Sale> findCompletedBetweenAndShift(
            @Param("status") SaleStatus status,
            @Param("shift") Shift shift,
            @Param("from") LocalDateTime from,
            @Param("to") LocalDateTime to
    );
}

package com.lubricentromp.api.repository;

import com.lubricentromp.api.entity.OilDrum;
import com.lubricentromp.api.enums.DrumStatus;
import jakarta.persistence.LockModeType;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface OilDrumRepository extends JpaRepository<OilDrum, Long> {

    List<OilDrum> findByStatusOrderByOpenedAtAsc(DrumStatus status);

    boolean existsByProductIdAndStatus(Long productId, DrumStatus status);

    boolean existsByProductId(Long productId);

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("SELECT d FROM OilDrum d WHERE d.id = :id")
    Optional<OilDrum> findByIdForUpdate(@Param("id") Long id);

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("""
            SELECT d FROM OilDrum d
            WHERE d.product.id = :productId
              AND d.status = :status
            ORDER BY d.openedAt ASC
            """)
    List<OilDrum> findByProductIdAndStatusForUpdate(
            @Param("productId") Long productId,
            @Param("status") DrumStatus status
    );
}

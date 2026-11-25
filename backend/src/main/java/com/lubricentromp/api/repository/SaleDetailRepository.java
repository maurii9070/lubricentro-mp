package com.lubricentromp.api.repository;

import com.lubricentromp.api.entity.SaleDetail;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface SaleDetailRepository extends JpaRepository<SaleDetail, Long> {

    @Query("""
            SELECT d FROM SaleDetail d
            LEFT JOIN FETCH d.product
            WHERE d.sale.id = :saleId
            ORDER BY d.id ASC
            """)
    List<SaleDetail> findBySaleIdOrderByIdAsc(@Param("saleId") Long saleId);
}

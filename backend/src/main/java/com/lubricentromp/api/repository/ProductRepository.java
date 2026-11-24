package com.lubricentromp.api.repository;

import com.lubricentromp.api.entity.Product;
import jakarta.persistence.LockModeType;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ProductRepository extends JpaRepository<Product, Long> {

    List<Product> findByActiveTrueOrderByNameAsc();

    boolean existsByCodeIgnoreCase(String code);

    boolean existsByCodeIgnoreCaseAndIdNot(String code, Long id);

    @Query("""
            SELECT p FROM Product p
            WHERE p.active = true
              AND (
                LOWER(REPLACE(REPLACE(p.name, '-', ''), ' ', '')) LIKE LOWER(CONCAT('%', :term, '%'))
                OR LOWER(REPLACE(REPLACE(COALESCE(p.code, ''), '-', ''), ' ', '')) LIKE LOWER(CONCAT('%', :term, '%'))
              )
            ORDER BY p.name ASC
            """)
    List<Product> searchActiveByTerm(@Param("term") String term);

    @Query("""
            SELECT p FROM Product p
            WHERE p.active = true
              AND (p.localStock + p.warehouseStock) <= p.minStock
            ORDER BY p.name ASC
            """)
    List<Product> findLowStockProducts();

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("SELECT p FROM Product p WHERE p.id = :id")
    Optional<Product> findByIdForUpdate(@Param("id") Long id);
}

package com.lubricentromp.api.repository;

import com.lubricentromp.api.entity.Sale;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SaleRepository extends JpaRepository<Sale, Long> {
}

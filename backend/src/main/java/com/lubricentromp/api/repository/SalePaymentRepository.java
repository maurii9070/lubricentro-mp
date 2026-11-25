package com.lubricentromp.api.repository;

import com.lubricentromp.api.entity.SalePayment;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SalePaymentRepository extends JpaRepository<SalePayment, Long> {

    List<SalePayment> findBySaleIdOrderByIdAsc(Long saleId);
}

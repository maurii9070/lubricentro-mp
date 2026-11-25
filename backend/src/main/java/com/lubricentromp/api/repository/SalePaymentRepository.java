package com.lubricentromp.api.repository;

import com.lubricentromp.api.dto.PaymentMethodTotalResponse;
import com.lubricentromp.api.entity.SalePayment;
import com.lubricentromp.api.enums.SaleStatus;
import com.lubricentromp.api.enums.Shift;
import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface SalePaymentRepository extends JpaRepository<SalePayment, Long> {

    List<SalePayment> findBySaleIdOrderByIdAsc(Long saleId);

    List<SalePayment> findBySaleIdInOrderBySaleIdAsc(Collection<Long> saleIds);

    @Query("""
            SELECT new com.lubricentromp.api.dto.PaymentMethodTotalResponse(
                p.paymentMethod,
                SUM(p.amount)
            )
            FROM SalePayment p
            WHERE p.sale.status = :status
              AND p.sale.operationDate >= :from
              AND p.sale.operationDate < :to
            GROUP BY p.paymentMethod
            ORDER BY p.paymentMethod ASC
            """)
    List<PaymentMethodTotalResponse> sumAmountsByPaymentMethod(
            @Param("status") SaleStatus status,
            @Param("from") LocalDateTime from,
            @Param("to") LocalDateTime to
    );

    @Query("""
            SELECT new com.lubricentromp.api.dto.PaymentMethodTotalResponse(
                p.paymentMethod,
                SUM(p.amount)
            )
            FROM SalePayment p
            WHERE p.sale.status = :status
              AND p.sale.shift = :shift
              AND p.sale.operationDate >= :from
              AND p.sale.operationDate < :to
            GROUP BY p.paymentMethod
            ORDER BY p.paymentMethod ASC
            """)
    List<PaymentMethodTotalResponse> sumAmountsByPaymentMethodAndShift(
            @Param("status") SaleStatus status,
            @Param("shift") Shift shift,
            @Param("from") LocalDateTime from,
            @Param("to") LocalDateTime to
    );
}

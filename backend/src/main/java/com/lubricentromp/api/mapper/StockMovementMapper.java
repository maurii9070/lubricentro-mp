package com.lubricentromp.api.mapper;

import com.lubricentromp.api.dto.StockMovementResponse;
import com.lubricentromp.api.entity.Product;
import com.lubricentromp.api.entity.Sale;
import com.lubricentromp.api.entity.StockMovement;
import com.lubricentromp.api.enums.MovementType;
import com.lubricentromp.api.enums.StockLocation;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import org.springframework.stereotype.Component;

@Component
public class StockMovementMapper {

    private static final int QUANTITY_SCALE = 2;
    private static final int REASON_MAX_LENGTH = 255;

    public StockMovement toEntity(
            Product product,
            Sale sale,
            MovementType movementType,
            StockLocation location,
            BigDecimal quantity,
            String reason
    ) {
        StockMovement movement = new StockMovement();
        movement.setProduct(product);
        movement.setSale(sale);
        movement.setMovementType(movementType);
        movement.setLocation(location);
        movement.setQuantity(normalizeQuantity(quantity));
        movement.setMovementDate(LocalDateTime.now());
        movement.setReason(normalizeReason(reason));
        return movement;
    }

    public StockMovementResponse toResponse(StockMovement movement) {
        return new StockMovementResponse(
                movement.getId(),
                movement.getProduct().getId(),
                movement.getProduct().getName(),
                movement.getSale() == null ? null : movement.getSale().getId(),
                movement.getMovementType(),
                movement.getLocation(),
                normalizeQuantity(movement.getQuantity()),
                movement.getMovementDate(),
                movement.getReason()
        );
    }

    public static BigDecimal normalizeQuantity(BigDecimal value) {
        return value == null ? null : value.setScale(QUANTITY_SCALE, RoundingMode.HALF_UP);
    }

    public static String normalizeReason(String reason) {
        if (reason == null) {
            return null;
        }
        String trimmed = reason.trim();
        if (trimmed.isEmpty()) {
            return null;
        }
        return trimmed.length() <= REASON_MAX_LENGTH ? trimmed : trimmed.substring(0, REASON_MAX_LENGTH);
    }
}

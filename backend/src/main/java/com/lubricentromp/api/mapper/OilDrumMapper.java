package com.lubricentromp.api.mapper;

import com.lubricentromp.api.dto.OilDrumResponse;
import com.lubricentromp.api.entity.OilDrum;
import com.lubricentromp.api.entity.Product;
import com.lubricentromp.api.enums.DrumStatus;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import org.springframework.stereotype.Component;

@Component
public class OilDrumMapper {

    public OilDrum toEntity(Product product, BigDecimal capacityLiters, String notes) {
        OilDrum drum = new OilDrum();
        drum.setProduct(product);
        BigDecimal capacity = normalizeLiters(capacityLiters);
        drum.setCapacityLiters(capacity);
        drum.setRemainingLiters(capacity);
        drum.setStatus(DrumStatus.OPEN);
        drum.setOpenedAt(LocalDateTime.now());
        drum.setNotes(normalizeNotes(notes));
        return drum;
    }

    public OilDrumResponse toResponse(OilDrum drum) {
        BigDecimal capacity = drum.getCapacityLiters() == null ? BigDecimal.ZERO : drum.getCapacityLiters();
        BigDecimal remaining = drum.getRemainingLiters() == null ? BigDecimal.ZERO : drum.getRemainingLiters();
        BigDecimal percentage = BigDecimal.ZERO.setScale(2, RoundingMode.HALF_UP);
        if (capacity.compareTo(BigDecimal.ZERO) > 0) {
            percentage = remaining.multiply(BigDecimal.valueOf(100))
                    .divide(capacity, 2, RoundingMode.HALF_UP);
        }
        return new OilDrumResponse(
                drum.getId(),
                drum.getProduct().getId(),
                drum.getProduct().getName(),
                capacity,
                remaining,
                percentage,
                drum.getStatus(),
                drum.getOpenedAt(),
                drum.getNotes()
        );
    }

    public static BigDecimal normalizeLiters(BigDecimal liters) {
        return liters == null ? null : liters.setScale(2, RoundingMode.HALF_UP);
    }

    public static String normalizeNotes(String notes) {
        if (notes == null) {
            return null;
        }
        String trimmed = notes.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }
}

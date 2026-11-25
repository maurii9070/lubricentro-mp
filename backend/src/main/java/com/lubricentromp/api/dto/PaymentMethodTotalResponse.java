package com.lubricentromp.api.dto;

import com.lubricentromp.api.enums.PaymentMethod;
import java.math.BigDecimal;

public record PaymentMethodTotalResponse(
        PaymentMethod paymentMethod,
        BigDecimal total
) {
}

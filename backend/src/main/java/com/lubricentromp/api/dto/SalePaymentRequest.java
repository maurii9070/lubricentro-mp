package com.lubricentromp.api.dto;

import com.lubricentromp.api.enums.PaymentMethod;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import java.math.BigDecimal;

public record SalePaymentRequest(
        @NotNull(message = "El método de pago es obligatorio.")
        PaymentMethod paymentMethod,

        @NotNull(message = "El monto del pago es obligatorio.")
        @Positive(message = "El monto del pago debe ser mayor a cero.")
        @Digits(integer = 8, fraction = 2, message = "El monto del pago debe tener como máximo 8 enteros y 2 decimales.")
        BigDecimal amount
) {
}

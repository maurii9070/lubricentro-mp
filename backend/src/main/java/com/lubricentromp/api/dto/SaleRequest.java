package com.lubricentromp.api.dto;

import com.lubricentromp.api.enums.OperationType;
import com.lubricentromp.api.enums.Shift;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;
import jakarta.validation.constraints.Size;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public record SaleRequest(
        LocalDateTime operationDate,

        @NotNull(message = "El turno es obligatorio.")
        Shift shift,

        @NotNull(message = "El tipo de operación es obligatorio.")
        OperationType operationType,

        @NotNull(message = "El total cobrado es obligatorio.")
        @PositiveOrZero(message = "El total cobrado no puede ser negativo.")
        @Digits(integer = 8, fraction = 2, message = "El total cobrado debe tener como máximo 8 enteros y 2 decimales.")
        BigDecimal totalCharged,

        @Size(max = 2000, message = "Las notas no pueden superar los 2000 caracteres.")
        String notes,

        @Valid
        VehicleServiceRequest vehicleService,

        @NotEmpty(message = "La venta debe incluir al menos un ítem.")
        List<@Valid SaleDetailRequest> items,

        @NotEmpty(message = "La venta debe incluir al menos un pago.")
        List<@Valid SalePaymentRequest> payments
) {
}

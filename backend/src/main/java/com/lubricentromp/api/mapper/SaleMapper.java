package com.lubricentromp.api.mapper;

import com.lubricentromp.api.dto.SaleDetailResponse;
import com.lubricentromp.api.dto.SalePaymentRequest;
import com.lubricentromp.api.dto.SalePaymentResponse;
import com.lubricentromp.api.dto.SaleRequest;
import com.lubricentromp.api.dto.SaleResponse;
import com.lubricentromp.api.dto.VehicleServiceRequest;
import com.lubricentromp.api.dto.VehicleServiceResponse;
import com.lubricentromp.api.entity.Product;
import com.lubricentromp.api.entity.Sale;
import com.lubricentromp.api.entity.SaleDetail;
import com.lubricentromp.api.entity.SalePayment;
import com.lubricentromp.api.entity.Vehicle;
import com.lubricentromp.api.entity.VehicleService;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.List;
import org.springframework.stereotype.Component;

@Component
public class SaleMapper {

    private static final int MONEY_SCALE = 2;
    private static final int QUANTITY_SCALE = 2;

    public Sale toEntity(SaleRequest request) {
        Sale sale = new Sale();
        sale.setOperationDate(request.operationDate() != null ? request.operationDate() : LocalDateTime.now());
        sale.setShift(request.shift());
        sale.setOperationType(request.operationType());
        sale.setTotalCharged(normalizeMoney(request.totalCharged()));
        sale.setNotes(normalizeNullable(request.notes()));
        return sale;
    }

    public SaleDetail toDetailEntity(
            Sale sale,
            Product product,
            String description,
            BigDecimal quantity,
            BigDecimal unitPrice
    ) {
        SaleDetail detail = new SaleDetail();
        detail.setSale(sale);
        detail.setProduct(product);
        detail.setDescriptionSnapshot(description.trim());
        detail.setQuantity(normalizeQuantity(quantity));
        detail.setUnitPriceSnapshot(normalizeMoney(unitPrice));
        return detail;
    }

    public SalePayment toPaymentEntity(Sale sale, SalePaymentRequest request) {
        SalePayment payment = new SalePayment();
        payment.setSale(sale);
        payment.setPaymentMethod(request.paymentMethod());
        payment.setAmount(normalizeMoney(request.amount()));
        return payment;
    }

    public VehicleService toVehicleServiceEntity(
            Sale sale,
            Vehicle vehicle,
            VehicleServiceRequest request
    ) {
        VehicleService vehicleService = new VehicleService();
        vehicleService.setSale(sale);
        vehicleService.setVehicle(vehicle);
        vehicleService.setMileage(request.mileage());
        vehicleService.setTechnicalNotes(normalizeNullable(request.technicalNotes()));
        return vehicleService;
    }

    public SaleResponse toResponse(
            Sale sale,
            VehicleService vehicleService,
            List<SaleDetail> details,
            List<SalePayment> payments
    ) {
        VehicleServiceResponse vehicleServiceResponse = vehicleService == null
                ? null
                : toVehicleServiceResponse(sale, vehicleService);
        return new SaleResponse(
                sale.getId(),
                sale.getOperationDate(),
                sale.getShift(),
                sale.getOperationType(),
                normalizeMoney(sale.getCalculatedSubtotal()),
                normalizeMoney(sale.getTotalCharged()),
                sale.getNotes(),
                vehicleServiceResponse,
                details.stream().map(this::toDetailResponse).toList(),
                payments.stream().map(this::toPaymentResponse).toList()
        );
    }

    private VehicleServiceResponse toVehicleServiceResponse(Sale sale, VehicleService vehicleService) {
        Vehicle vehicle = vehicleService.getVehicle();
        return new VehicleServiceResponse(
                sale.getId(),
                vehicle.getId(),
                vehicle.getLicensePlate(),
                vehicle.getBrandModel(),
                vehicleService.getMileage(),
                vehicleService.getTechnicalNotes()
        );
    }

    private SaleDetailResponse toDetailResponse(SaleDetail detail) {
        return new SaleDetailResponse(
                detail.getId(),
                detail.getProduct() == null ? null : detail.getProduct().getId(),
                detail.getDescriptionSnapshot(),
                normalizeQuantity(detail.getQuantity()),
                normalizeMoney(detail.getUnitPriceSnapshot()),
                normalizeMoney(detail.getQuantity().multiply(detail.getUnitPriceSnapshot()))
        );
    }

    private SalePaymentResponse toPaymentResponse(SalePayment payment) {
        return new SalePaymentResponse(
                payment.getId(),
                payment.getPaymentMethod(),
                normalizeMoney(payment.getAmount())
        );
    }

    public static BigDecimal normalizeMoney(BigDecimal value) {
        return value == null ? null : value.setScale(MONEY_SCALE, RoundingMode.HALF_UP);
    }

    public static BigDecimal normalizeQuantity(BigDecimal value) {
        return value == null ? null : value.setScale(QUANTITY_SCALE, RoundingMode.HALF_UP);
    }

    public static String normalizeNullable(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }
}

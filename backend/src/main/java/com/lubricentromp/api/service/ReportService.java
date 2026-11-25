package com.lubricentromp.api.service;

import com.lubricentromp.api.dto.DailyClosingOperationResponse;
import com.lubricentromp.api.dto.DailyClosingReportResponse;
import com.lubricentromp.api.dto.DrumConsumptionResponse;
import com.lubricentromp.api.dto.PaymentMethodTotalResponse;
import com.lubricentromp.api.entity.Sale;
import com.lubricentromp.api.entity.SalePayment;
import com.lubricentromp.api.entity.VehicleService;
import com.lubricentromp.api.enums.MovementType;
import com.lubricentromp.api.enums.OperationType;
import com.lubricentromp.api.enums.PaymentMethod;
import com.lubricentromp.api.enums.SaleStatus;
import com.lubricentromp.api.enums.Shift;
import com.lubricentromp.api.enums.StockLocation;
import com.lubricentromp.api.exception.BusinessRuleException;
import com.lubricentromp.api.mapper.SaleMapper;
import com.lubricentromp.api.repository.SalePaymentRepository;
import com.lubricentromp.api.repository.SaleRepository;
import com.lubricentromp.api.repository.StockMovementRepository;
import com.lubricentromp.api.repository.VehicleServiceRepository;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.EnumMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class ReportService {

    private static final String ALL_SHIFTS_LABEL = "TODOS";
    private static final Map<Shift, String> SHIFT_LABELS = Map.of(
            Shift.MORNING, "MAÑANA",
            Shift.AFTERNOON, "TARDE"
    );
    private static final List<MovementType> DRUM_CONSUMPTION_TYPES = List.of(
            MovementType.SALE_EXIT,
            MovementType.SALE_CANCELLATION
    );

    private final SaleRepository saleRepository;
    private final SalePaymentRepository salePaymentRepository;
    private final StockMovementRepository stockMovementRepository;
    private final VehicleServiceRepository vehicleServiceRepository;

    public ReportService(
            SaleRepository saleRepository,
            SalePaymentRepository salePaymentRepository,
            StockMovementRepository stockMovementRepository,
            VehicleServiceRepository vehicleServiceRepository
    ) {
        this.saleRepository = saleRepository;
        this.salePaymentRepository = salePaymentRepository;
        this.stockMovementRepository = stockMovementRepository;
        this.vehicleServiceRepository = vehicleServiceRepository;
    }

    public DailyClosingReportResponse getDailyClosingReport(LocalDate date, Shift shift) {
        if (date == null) {
            throw new BusinessRuleException("La fecha del cierre es obligatoria.");
        }
        if (date.isAfter(LocalDate.now())) {
            throw new BusinessRuleException("No se puede generar el cierre de una fecha futura.");
        }
        LocalDateTime from = date.atStartOfDay();
        LocalDateTime to = from.plusDays(1);

        List<Sale> sales = shift == null
                ? saleRepository.findCompletedBetween(SaleStatus.COMPLETED, from, to)
                : saleRepository.findCompletedBetweenAndShift(SaleStatus.COMPLETED, shift, from, to);

        List<PaymentMethodTotalResponse> totalsByMethod = shift == null
                ? salePaymentRepository.sumAmountsByPaymentMethod(SaleStatus.COMPLETED, from, to)
                : salePaymentRepository.sumAmountsByPaymentMethodAndShift(SaleStatus.COMPLETED, shift, from, to);

        long completedSalesCount = sales.stream()
                .filter(sale -> sale.getOperationType() == OperationType.QUICK_SALE)
                .count();
        long completedServicesCount = sales.stream()
                .filter(sale -> sale.getOperationType() == OperationType.SERVICE)
                .count();
        BigDecimal totalAmount = sales.stream()
                .map(Sale::getTotalCharged)
                .map(SaleMapper::normalizeMoney)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        totalAmount = SaleMapper.normalizeMoney(totalAmount);

        List<DrumConsumptionResponse> drumConsumption = new ArrayList<>();
        for (DrumConsumptionResponse consumption : stockMovementRepository.sumConsumedLitersBetween(
                StockLocation.OPEN_DRUM,
                DRUM_CONSUMPTION_TYPES,
                from,
                to
        )) {
            drumConsumption.add(new DrumConsumptionResponse(
                    consumption.productId(),
                    consumption.productName(),
                    SaleMapper.normalizeMoney(consumption.consumedLiters())
            ));
        }

        return new DailyClosingReportResponse(
                date,
                shift,
                shift == null ? ALL_SHIFTS_LABEL : SHIFT_LABELS.getOrDefault(shift, shift.name()),
                completedSalesCount,
                completedServicesCount,
                totalAmount,
                completePaymentMethods(totalsByMethod),
                buildOperations(sales),
                drumConsumption
        );
    }

    private List<DailyClosingOperationResponse> buildOperations(List<Sale> sales) {
        if (sales.isEmpty()) {
            return List.of();
        }
        List<Long> saleIds = sales.stream().map(Sale::getId).toList();
        Map<Long, List<SalePayment>> paymentsBySale = salePaymentRepository
                .findBySaleIdInOrderBySaleIdAsc(saleIds)
                .stream()
                .collect(Collectors.groupingBy(payment -> payment.getSale().getId()));
        Map<Long, VehicleService> servicesBySale = vehicleServiceRepository
                .findBySaleIdInWithVehicle(saleIds)
                .stream()
                .collect(Collectors.toMap(
                        vehicleService -> vehicleService.getSale().getId(),
                        Function.identity(),
                        (first, second) -> first
                ));

        List<DailyClosingOperationResponse> operations = new ArrayList<>();
        for (Sale sale : sales) {
            VehicleService vehicleService = servicesBySale.get(sale.getId());
            List<PaymentMethodTotalResponse> payments = paymentsBySale
                    .getOrDefault(sale.getId(), List.of())
                    .stream()
                    .map(payment -> new PaymentMethodTotalResponse(
                            payment.getPaymentMethod(),
                            SaleMapper.normalizeMoney(payment.getAmount())
                    ))
                    .toList();
            operations.add(new DailyClosingOperationResponse(
                    sale.getId(),
                    sale.getOperationDate(),
                    sale.getShift(),
                    sale.getOperationType(),
                    describeOperation(sale, vehicleService),
                    vehicleService == null ? null : vehicleService.getVehicle().getLicensePlate(),
                    vehicleService == null ? null : vehicleService.getMileage(),
                    SaleMapper.normalizeMoney(sale.getTotalCharged()),
                    payments
            ));
        }
        return operations;
    }

    private String describeOperation(Sale sale, VehicleService vehicleService) {
        if (sale.getOperationType() != OperationType.SERVICE) {
            return "Venta rápida";
        }
        if (vehicleService == null) {
            return "Service de vehículo";
        }
        return "Service - "
                + vehicleService.getVehicle().getBrandModel()
                + " ("
                + vehicleService.getVehicle().getLicensePlate()
                + ")";
    }

    private List<PaymentMethodTotalResponse> completePaymentMethods(List<PaymentMethodTotalResponse> totals) {
        Map<PaymentMethod, BigDecimal> totalsByMethod = new EnumMap<>(PaymentMethod.class);
        for (PaymentMethodTotalResponse total : totals) {
            totalsByMethod.put(total.paymentMethod(), SaleMapper.normalizeMoney(total.total()));
        }
        List<PaymentMethodTotalResponse> completed = new ArrayList<>();
        for (PaymentMethod paymentMethod : PaymentMethod.values()) {
            completed.add(new PaymentMethodTotalResponse(
                    paymentMethod,
                    totalsByMethod.getOrDefault(paymentMethod, BigDecimal.ZERO.setScale(2))
            ));
        }
        return completed;
    }
}

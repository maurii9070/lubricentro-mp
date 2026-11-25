package com.lubricentromp.api.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.anyList;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;

import com.lubricentromp.api.dto.DailyClosingOperationResponse;
import com.lubricentromp.api.dto.DailyClosingReportResponse;
import com.lubricentromp.api.dto.DrumConsumptionResponse;
import com.lubricentromp.api.dto.PaymentMethodTotalResponse;
import com.lubricentromp.api.entity.Sale;
import com.lubricentromp.api.entity.SalePayment;
import com.lubricentromp.api.entity.Vehicle;
import com.lubricentromp.api.entity.VehicleService;
import com.lubricentromp.api.enums.OperationType;
import com.lubricentromp.api.enums.PaymentMethod;
import com.lubricentromp.api.enums.SaleStatus;
import com.lubricentromp.api.enums.Shift;
import com.lubricentromp.api.enums.StockLocation;
import com.lubricentromp.api.exception.BusinessRuleException;
import com.lubricentromp.api.repository.SalePaymentRepository;
import com.lubricentromp.api.repository.SaleRepository;
import com.lubricentromp.api.repository.StockMovementRepository;
import com.lubricentromp.api.repository.VehicleServiceRepository;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class ReportServiceTest {

    private static final LocalDate REPORT_DATE = LocalDate.of(2026, 11, 24);
    private static final LocalDateTime FROM = REPORT_DATE.atStartOfDay();
    private static final LocalDateTime TO = FROM.plusDays(1);

    @Mock
    private SaleRepository saleRepository;

    @Mock
    private SalePaymentRepository salePaymentRepository;

    @Mock
    private StockMovementRepository stockMovementRepository;

    @Mock
    private VehicleServiceRepository vehicleServiceRepository;

    private ReportService reportService;

    @BeforeEach
    void setUp() {
        reportService = new ReportService(
                saleRepository,
                salePaymentRepository,
                stockMovementRepository,
                vehicleServiceRepository
        );
    }

    @Test
    void dailyClosingShouldAggregateShiftOperations() {
        Sale quickSale = sale(1L, OperationType.QUICK_SALE, Shift.MORNING, "3000.00");
        Sale serviceSale = sale(2L, OperationType.SERVICE, Shift.MORNING, "29500.00");
        Vehicle vehicle = vehicle(5L, "AB123CD", "Peugeot 408");
        VehicleService vehicleService = vehicleService(serviceSale, vehicle, 50000);

        when(saleRepository.findCompletedBetweenAndShift(SaleStatus.COMPLETED, Shift.MORNING, FROM, TO))
                .thenReturn(List.of(quickSale, serviceSale));
        when(salePaymentRepository.sumAmountsByPaymentMethodAndShift(
                SaleStatus.COMPLETED,
                Shift.MORNING,
                FROM,
                TO
        )).thenReturn(List.of(
                new PaymentMethodTotalResponse(PaymentMethod.CASH, new BigDecimal("20000.00")),
                new PaymentMethodTotalResponse(PaymentMethod.TRANSFER, new BigDecimal("12500.00"))
        ));
        when(salePaymentRepository.findBySaleIdInOrderBySaleIdAsc(List.of(1L, 2L)))
                .thenReturn(List.of(
                        payment(quickSale, PaymentMethod.CASH, "3000.00"),
                        payment(serviceSale, PaymentMethod.CASH, "17000.00"),
                        payment(serviceSale, PaymentMethod.TRANSFER, "12500.00")
                ));
        when(vehicleServiceRepository.findBySaleIdInWithVehicle(List.of(1L, 2L)))
                .thenReturn(List.of(vehicleService));
        when(stockMovementRepository.sumConsumedLitersBetween(
                eq(StockLocation.OPEN_DRUM),
                anyList(),
                eq(FROM),
                eq(TO)
        )).thenReturn(List.of(new DrumConsumptionResponse(10L, "Aceite 15W40", new BigDecimal("4.50"))));

        DailyClosingReportResponse report = reportService.getDailyClosingReport(
                REPORT_DATE,
                Shift.MORNING
        );

        assertEquals(REPORT_DATE, report.date());
        assertEquals(Shift.MORNING, report.shift());
        assertEquals("MAÑANA", report.shiftLabel());
        assertEquals(1, report.completedSalesCount());
        assertEquals(1, report.completedServicesCount());
        assertEquals(0, new BigDecimal("32500.00").compareTo(report.totalAmount()));
        assertEquals(5, report.paymentsByMethod().size());
        assertEquals(0, new BigDecimal("20000.00").compareTo(totalOf(report, PaymentMethod.CASH)));
        assertEquals(0, new BigDecimal("12500.00").compareTo(totalOf(report, PaymentMethod.TRANSFER)));
        assertEquals(0, BigDecimal.ZERO.compareTo(totalOf(report, PaymentMethod.CREDIT)));

        assertEquals(2, report.operations().size());
        DailyClosingOperationResponse quickOperation = report.operations().get(0);
        assertEquals(1L, quickOperation.saleId());
        assertEquals("Venta rápida", quickOperation.description());
        assertNull(quickOperation.licensePlate());
        assertEquals(1, quickOperation.payments().size());

        DailyClosingOperationResponse serviceOperation = report.operations().get(1);
        assertEquals(2L, serviceOperation.saleId());
        assertEquals("AB123CD", serviceOperation.licensePlate());
        assertEquals(50000, serviceOperation.mileage());
        assertEquals("Service - Peugeot 408 (AB123CD)", serviceOperation.description());
        assertEquals(2, serviceOperation.payments().size());

        assertEquals(1, report.drumConsumption().size());
        assertEquals("Aceite 15W40", report.drumConsumption().get(0).productName());
        assertEquals(0, new BigDecimal("4.50").compareTo(report.drumConsumption().get(0).consumedLiters()));
    }

    @Test
    void dailyClosingWithoutShiftShouldReportAllShifts() {
        Sale sale = sale(3L, OperationType.QUICK_SALE, Shift.AFTERNOON, "1000.00");
        when(saleRepository.findCompletedBetween(SaleStatus.COMPLETED, FROM, TO))
                .thenReturn(List.of(sale));
        when(salePaymentRepository.sumAmountsByPaymentMethod(SaleStatus.COMPLETED, FROM, TO))
                .thenReturn(List.of(new PaymentMethodTotalResponse(PaymentMethod.QR, new BigDecimal("1000.00"))));
        when(salePaymentRepository.findBySaleIdInOrderBySaleIdAsc(List.of(3L)))
                .thenReturn(List.of(payment(sale, PaymentMethod.QR, "1000.00")));
        when(vehicleServiceRepository.findBySaleIdInWithVehicle(List.of(3L)))
                .thenReturn(List.of());
        when(stockMovementRepository.sumConsumedLitersBetween(
                eq(StockLocation.OPEN_DRUM),
                anyList(),
                eq(FROM),
                eq(TO)
        )).thenReturn(List.of());

        DailyClosingReportResponse report = reportService.getDailyClosingReport(REPORT_DATE, null);

        assertNull(report.shift());
        assertEquals("TODOS", report.shiftLabel());
        assertEquals(1, report.completedSalesCount());
        assertEquals(0, report.completedServicesCount());
        assertEquals(0, new BigDecimal("1000.00").compareTo(totalOf(report, PaymentMethod.QR)));
        assertEquals(1, report.operations().size());
        assertTrue(report.drumConsumption().isEmpty());
    }

    @Test
    void dailyClosingShouldReturnZeroesWhenThereAreNoOperations() {
        when(saleRepository.findCompletedBetween(SaleStatus.COMPLETED, FROM, TO))
                .thenReturn(List.of());
        when(salePaymentRepository.sumAmountsByPaymentMethod(SaleStatus.COMPLETED, FROM, TO))
                .thenReturn(List.of());
        when(stockMovementRepository.sumConsumedLitersBetween(
                eq(StockLocation.OPEN_DRUM),
                anyList(),
                eq(FROM),
                eq(TO)
        )).thenReturn(List.of());

        DailyClosingReportResponse report = reportService.getDailyClosingReport(REPORT_DATE, null);

        assertEquals(0, report.completedSalesCount());
        assertEquals(0, report.completedServicesCount());
        assertEquals(0, BigDecimal.ZERO.compareTo(report.totalAmount()));
        assertEquals(5, report.paymentsByMethod().size());
        assertTrue(report.operations().isEmpty());
        report.paymentsByMethod().forEach(total ->
                assertEquals(0, BigDecimal.ZERO.compareTo(total.total()))
        );
    }

    @Test
    void dailyClosingShouldRejectFutureDate() {
        assertThrows(
                BusinessRuleException.class,
                () -> reportService.getDailyClosingReport(LocalDate.now().plusDays(1), null)
        );
        verifyNoInteractions(saleRepository, salePaymentRepository, stockMovementRepository);
    }

    @Test
    void dailyClosingShouldRejectMissingDate() {
        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> reportService.getDailyClosingReport(null, null)
        );

        assertTrue(exception.getMessage().contains("fecha"));
        verifyNoInteractions(saleRepository, salePaymentRepository, stockMovementRepository);
    }

    private BigDecimal totalOf(DailyClosingReportResponse report, PaymentMethod paymentMethod) {
        return report.paymentsByMethod()
                .stream()
                .filter(total -> total.paymentMethod() == paymentMethod)
                .findFirst()
                .orElseThrow()
                .total();
    }

    private Sale sale(Long id, OperationType operationType, Shift shift, String totalCharged) {
        Sale sale = new Sale();
        sale.setId(id);
        sale.setOperationDate(FROM.plusHours(9));
        sale.setShift(shift);
        sale.setOperationType(operationType);
        sale.setStatus(SaleStatus.COMPLETED);
        sale.setCalculatedSubtotal(new BigDecimal(totalCharged));
        sale.setTotalCharged(new BigDecimal(totalCharged));
        return sale;
    }

    private SalePayment payment(Sale sale, PaymentMethod paymentMethod, String amount) {
        SalePayment payment = new SalePayment();
        payment.setSale(sale);
        payment.setPaymentMethod(paymentMethod);
        payment.setAmount(new BigDecimal(amount));
        return payment;
    }

    private Vehicle vehicle(Long id, String licensePlate, String brandModel) {
        Vehicle vehicle = new Vehicle();
        vehicle.setId(id);
        vehicle.setLicensePlate(licensePlate);
        vehicle.setBrandModel(brandModel);
        return vehicle;
    }

    private VehicleService vehicleService(Sale sale, Vehicle vehicle, Integer mileage) {
        VehicleService vehicleService = new VehicleService();
        vehicleService.setSale(sale);
        vehicleService.setSaleId(sale.getId());
        vehicleService.setVehicle(vehicle);
        vehicleService.setMileage(mileage);
        return vehicleService;
    }
}

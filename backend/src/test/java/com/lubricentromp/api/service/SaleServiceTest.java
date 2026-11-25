package com.lubricentromp.api.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;

import com.lubricentromp.api.dto.SaleDetailRequest;
import com.lubricentromp.api.dto.SalePaymentRequest;
import com.lubricentromp.api.dto.SaleRequest;
import com.lubricentromp.api.dto.SaleResponse;
import com.lubricentromp.api.dto.VehicleServiceRequest;
import com.lubricentromp.api.entity.Category;
import com.lubricentromp.api.entity.OilDrum;
import com.lubricentromp.api.entity.Product;
import com.lubricentromp.api.entity.Sale;
import com.lubricentromp.api.entity.SaleDetail;
import com.lubricentromp.api.entity.SalePayment;
import com.lubricentromp.api.entity.Vehicle;
import com.lubricentromp.api.entity.VehicleService;
import com.lubricentromp.api.enums.DrumStatus;
import com.lubricentromp.api.enums.OperationType;
import com.lubricentromp.api.enums.PaymentMethod;
import com.lubricentromp.api.enums.Shift;
import com.lubricentromp.api.exception.BusinessRuleException;
import com.lubricentromp.api.exception.ResourceNotFoundException;
import com.lubricentromp.api.mapper.SaleMapper;
import com.lubricentromp.api.repository.OilDrumRepository;
import com.lubricentromp.api.repository.ProductRepository;
import com.lubricentromp.api.repository.SaleDetailRepository;
import com.lubricentromp.api.repository.SalePaymentRepository;
import com.lubricentromp.api.repository.SaleRepository;
import com.lubricentromp.api.repository.VehicleRepository;
import com.lubricentromp.api.repository.VehicleServiceRepository;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class SaleServiceTest {

    private static final LocalDateTime OPERATION_DATE = LocalDateTime.of(2026, 11, 24, 9, 30);

    @Mock
    private SaleRepository saleRepository;

    @Mock
    private VehicleServiceRepository vehicleServiceRepository;

    @Mock
    private SaleDetailRepository saleDetailRepository;

    @Mock
    private SalePaymentRepository salePaymentRepository;

    @Mock
    private ProductRepository productRepository;

    @Mock
    private OilDrumRepository oilDrumRepository;

    @Mock
    private VehicleRepository vehicleRepository;

    private SaleService saleService;

    @BeforeEach
    void setUp() {
        saleService = new SaleService(
                saleRepository,
                vehicleServiceRepository,
                saleDetailRepository,
                salePaymentRepository,
                productRepository,
                oilDrumRepository,
                vehicleRepository,
                new SaleMapper()
        );
    }

    @Test
    void createQuickSaleShouldDiscountLocalStockAndRegisterSinglePayment() {
        Product filter = product(1L, "FAP-9013", "Filtro de aceite", "Filtro de Aceite", "1500.00", 10, true, true);
        when(productRepository.findByIdForUpdate(1L)).thenReturn(Optional.of(filter));
        when(oilDrumRepository.existsByProductId(1L)).thenReturn(false);
        stubSaleSave(100L);
        stubDetailSave();
        stubPaymentSave();

        SaleResponse response = saleService.createSale(new SaleRequest(
                OPERATION_DATE,
                Shift.MORNING,
                OperationType.QUICK_SALE,
                new BigDecimal("3000.00"),
                "Venta de mostrador",
                null,
                List.of(new SaleDetailRequest(1L, null, new BigDecimal("2"), null)),
                List.of(new SalePaymentRequest(PaymentMethod.CASH, new BigDecimal("3000.00")))
        ));

        assertEquals(100L, response.id());
        assertEquals(OPERATION_DATE, response.operationDate());
        assertEquals(0, new BigDecimal("3000.00").compareTo(response.calculatedSubtotal()));
        assertEquals(0, new BigDecimal("3000.00").compareTo(response.totalCharged()));
        assertNull(response.vehicleService());
        assertEquals(1, response.items().size());
        assertEquals("FAP-9013 - Filtro de aceite", response.items().get(0).description());
        assertEquals(0, new BigDecimal("2.00").compareTo(response.items().get(0).quantity()));
        assertEquals(0, new BigDecimal("1500.00").compareTo(response.items().get(0).unitPrice()));
        assertEquals(0, new BigDecimal("3000.00").compareTo(response.items().get(0).subtotal()));
        assertEquals(PaymentMethod.CASH, response.payments().get(0).paymentMethod());
        assertEquals(8, filter.getLocalStock());
        verify(productRepository).save(filter);
        verify(saleRepository).save(any(Sale.class));
        verify(vehicleServiceRepository, never()).save(any(VehicleService.class));
    }

    @Test
    void createServiceShouldDiscountFiltersAndDrumLitersAndRegisterMixedPayments() {
        Product airFilter = product(1L, "FA-1", "Filtro de aire", "Filtro de Aire", "1000.00", 10, true, true);
        Product oilFilter = product(2L, "FO-1", "Filtro de aceite", "Filtro de Aceite", "1500.00", 10, true, true);
        Product fuelFilter = product(3L, "FC-1", "Filtro de combustible", "Filtro de Combustible", "2000.00", 10, true, true);
        Product cabinFilter = product(4L, "FH-1", "Filtro de habitáculo", "Filtro de Habitáculo", "2500.00", 10, true, true);
        Product oil = product(10L, "AT-15W40", "Aceite 15W40", "Aceite Tambor", "5000.00", 3, true, true);
        Vehicle vehicle = vehicle(5L, "AB123CD", "Peugeot 408");
        OilDrum drum = drum(50L, oil, "20.00");

        when(vehicleRepository.findById(5L)).thenReturn(Optional.of(vehicle));
        when(productRepository.findByIdForUpdate(1L)).thenReturn(Optional.of(airFilter));
        when(productRepository.findByIdForUpdate(2L)).thenReturn(Optional.of(oilFilter));
        when(productRepository.findByIdForUpdate(3L)).thenReturn(Optional.of(fuelFilter));
        when(productRepository.findByIdForUpdate(4L)).thenReturn(Optional.of(cabinFilter));
        when(productRepository.findByIdForUpdate(10L)).thenReturn(Optional.of(oil));
        when(oilDrumRepository.existsByProductId(1L)).thenReturn(false);
        when(oilDrumRepository.existsByProductId(2L)).thenReturn(false);
        when(oilDrumRepository.existsByProductId(3L)).thenReturn(false);
        when(oilDrumRepository.existsByProductId(4L)).thenReturn(false);
        when(oilDrumRepository.findByProductIdAndStatusForUpdate(10L, DrumStatus.OPEN))
                .thenReturn(List.of(drum));
        stubSaleSave(100L);
        stubDetailSave();
        stubPaymentSave();
        when(vehicleServiceRepository.save(any(VehicleService.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        SaleResponse response = saleService.createSale(new SaleRequest(
                OPERATION_DATE,
                Shift.AFTERNOON,
                OperationType.SERVICE,
                new BigDecimal("29500.00"),
                "Service completo Peugeot 408",
                new VehicleServiceRequest(5L, 50000, "Cambio de aceite y filtros"),
                List.of(
                        new SaleDetailRequest(1L, null, new BigDecimal("1"), null),
                        new SaleDetailRequest(2L, null, new BigDecimal("1"), null),
                        new SaleDetailRequest(3L, null, new BigDecimal("1"), null),
                        new SaleDetailRequest(4L, null, new BigDecimal("1"), null),
                        new SaleDetailRequest(10L, null, new BigDecimal("4.5"), null)
                ),
                List.of(
                        new SalePaymentRequest(PaymentMethod.CASH, new BigDecimal("20000.00")),
                        new SalePaymentRequest(PaymentMethod.TRANSFER, new BigDecimal("9500.00"))
                )
        ));

        assertEquals(100L, response.id());
        assertEquals(OperationType.SERVICE, response.operationType());
        assertEquals(0, new BigDecimal("29500.00").compareTo(response.calculatedSubtotal()));
        assertEquals(0, new BigDecimal("29500.00").compareTo(response.totalCharged()));
        assertEquals(5, response.items().size());
        assertEquals(2, response.payments().size());
        assertNotNull(response.vehicleService());
        assertEquals(5L, response.vehicleService().vehicleId());
        assertEquals("AB123CD", response.vehicleService().licensePlate());
        assertEquals("Peugeot 408", response.vehicleService().brandModel());
        assertEquals(50000, response.vehicleService().mileage());
        assertEquals("Cambio de aceite y filtros", response.vehicleService().technicalNotes());

        assertEquals(9, airFilter.getLocalStock());
        assertEquals(9, oilFilter.getLocalStock());
        assertEquals(9, fuelFilter.getLocalStock());
        assertEquals(9, cabinFilter.getLocalStock());
        assertEquals(3, oil.getLocalStock());
        assertEquals(0, new BigDecimal("15.50").compareTo(drum.getRemainingLiters()));
        verify(productRepository, times(4)).save(any(Product.class));
        verify(oilDrumRepository).save(drum);

        ArgumentCaptor<VehicleService> captor = ArgumentCaptor.forClass(VehicleService.class);
        verify(vehicleServiceRepository).save(captor.capture());
        assertEquals(100L, captor.getValue().getSale().getId());
        assertEquals(5L, captor.getValue().getVehicle().getId());
        assertEquals(50000, captor.getValue().getMileage());
    }

    @Test
    void createSaleShouldRejectPaymentsThatDoNotMatchTotalCharged() {
        SaleRequest request = new SaleRequest(
                OPERATION_DATE,
                Shift.MORNING,
                OperationType.QUICK_SALE,
                new BigDecimal("1000.00"),
                null,
                null,
                List.of(new SaleDetailRequest(1L, null, new BigDecimal("1"), null)),
                List.of(
                        new SalePaymentRequest(PaymentMethod.CASH, new BigDecimal("600.00")),
                        new SalePaymentRequest(PaymentMethod.TRANSFER, new BigDecimal("300.00"))
                )
        );

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> saleService.createSale(request)
        );

        assertTrue(exception.getMessage().contains("no coincide"));
        assertTrue(exception.getMessage().contains("900.00"));
        assertTrue(exception.getMessage().contains("1000.00"));
        verifyNoInteractions(saleRepository, productRepository, oilDrumRepository);
    }

    @Test
    void createServiceShouldRejectMissingVehicleData() {
        SaleRequest request = new SaleRequest(
                OPERATION_DATE,
                Shift.MORNING,
                OperationType.SERVICE,
                new BigDecimal("1000.00"),
                null,
                null,
                List.of(new SaleDetailRequest(1L, null, new BigDecimal("1"), null)),
                List.of(new SalePaymentRequest(PaymentMethod.CASH, new BigDecimal("1000.00")))
        );

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> saleService.createSale(request)
        );

        assertTrue(exception.getMessage().contains("SERVICE"));
        assertTrue(exception.getMessage().contains("vehículo"));
        verifyNoInteractions(saleRepository, productRepository, oilDrumRepository);
    }

    @Test
    void createQuickSaleShouldRejectVehicleData() {
        SaleRequest request = new SaleRequest(
                OPERATION_DATE,
                Shift.MORNING,
                OperationType.QUICK_SALE,
                new BigDecimal("1000.00"),
                null,
                new VehicleServiceRequest(5L, null, null),
                List.of(new SaleDetailRequest(1L, null, new BigDecimal("1"), null)),
                List.of(new SalePaymentRequest(PaymentMethod.CASH, new BigDecimal("1000.00")))
        );

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> saleService.createSale(request)
        );

        assertTrue(exception.getMessage().contains("ventas rápidas"));
        verifyNoInteractions(saleRepository, productRepository, oilDrumRepository);
    }

    @Test
    void createServiceShouldRejectWhenThereIsNoOpenDrum() {
        Product oil = product(10L, "AT-15W40", "Aceite 15W40", "Aceite Tambor", "5000.00", 3, true, true);
        Vehicle vehicle = vehicle(5L, "AB123CD", "Peugeot 408");

        when(vehicleRepository.findById(5L)).thenReturn(Optional.of(vehicle));
        when(productRepository.findByIdForUpdate(10L)).thenReturn(Optional.of(oil));
        when(oilDrumRepository.findByProductIdAndStatusForUpdate(10L, DrumStatus.OPEN))
                .thenReturn(List.of());

        SaleRequest request = new SaleRequest(
                OPERATION_DATE,
                Shift.AFTERNOON,
                OperationType.SERVICE,
                new BigDecimal("22500.00"),
                null,
                new VehicleServiceRequest(5L, 50000, null),
                List.of(new SaleDetailRequest(10L, null, new BigDecimal("4.5"), null)),
                List.of(new SalePaymentRequest(PaymentMethod.CASH, new BigDecimal("22500.00")))
        );

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> saleService.createSale(request)
        );

        assertTrue(exception.getMessage().contains("tambor abierto"));
        verify(oilDrumRepository, never()).save(any(OilDrum.class));
        verify(saleRepository, never()).save(any(Sale.class));
    }

    @Test
    void createSaleShouldRejectInsufficientLocalStock() {
        Product filter = product(1L, "FAP-9013", "Filtro de aceite", "Filtro de Aceite", "1500.00", 1, true, true);
        when(productRepository.findByIdForUpdate(1L)).thenReturn(Optional.of(filter));
        when(oilDrumRepository.existsByProductId(1L)).thenReturn(false);

        SaleRequest request = new SaleRequest(
                OPERATION_DATE,
                Shift.MORNING,
                OperationType.QUICK_SALE,
                new BigDecimal("3000.00"),
                null,
                null,
                List.of(new SaleDetailRequest(1L, null, new BigDecimal("2"), null)),
                List.of(new SalePaymentRequest(PaymentMethod.CASH, new BigDecimal("3000.00")))
        );

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> saleService.createSale(request)
        );

        assertTrue(exception.getMessage().contains("stock local"));
        assertTrue(exception.getMessage().contains("Disponible: 1"));
        verify(productRepository, never()).save(any(Product.class));
        verify(saleRepository, never()).save(any(Sale.class));
    }

    @Test
    void createSaleShouldRejectInsufficientDrumLiters() {
        Product oil = product(10L, "AT-15W40", "Aceite 15W40", "Aceite Tambor", "5000.00", 3, true, true);
        Vehicle vehicle = vehicle(5L, "AB123CD", "Peugeot 408");
        OilDrum drum = drum(50L, oil, "2.00");

        when(vehicleRepository.findById(5L)).thenReturn(Optional.of(vehicle));
        when(productRepository.findByIdForUpdate(10L)).thenReturn(Optional.of(oil));
        when(oilDrumRepository.findByProductIdAndStatusForUpdate(10L, DrumStatus.OPEN))
                .thenReturn(List.of(drum));

        SaleRequest request = new SaleRequest(
                OPERATION_DATE,
                Shift.AFTERNOON,
                OperationType.SERVICE,
                new BigDecimal("22500.00"),
                null,
                new VehicleServiceRequest(5L, 50000, null),
                List.of(new SaleDetailRequest(10L, null, new BigDecimal("4.5"), null)),
                List.of(new SalePaymentRequest(PaymentMethod.CASH, new BigDecimal("22500.00")))
        );

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> saleService.createSale(request)
        );

        assertTrue(exception.getMessage().contains("litros suficientes"));
        assertTrue(exception.getMessage().contains("Disponible: 2.00 L"));
        assertTrue(exception.getMessage().contains("solicitado: 4.50 L"));
        verify(oilDrumRepository, never()).save(any(OilDrum.class));
        verify(saleRepository, never()).save(any(Sale.class));
    }

    @Test
    void createSaleShouldRejectNonIntegerQuantityForStockProduct() {
        Product filter = product(1L, "FAP-9013", "Filtro de aceite", "Filtro de Aceite", "1500.00", 10, true, true);
        when(productRepository.findByIdForUpdate(1L)).thenReturn(Optional.of(filter));
        when(oilDrumRepository.existsByProductId(1L)).thenReturn(false);

        SaleRequest request = new SaleRequest(
                OPERATION_DATE,
                Shift.MORNING,
                OperationType.QUICK_SALE,
                new BigDecimal("6750.00"),
                null,
                null,
                List.of(new SaleDetailRequest(1L, null, new BigDecimal("4.5"), null)),
                List.of(new SalePaymentRequest(PaymentMethod.CASH, new BigDecimal("6750.00")))
        );

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> saleService.createSale(request)
        );

        assertTrue(exception.getMessage().contains("número entero"));
        verify(productRepository, never()).save(any(Product.class));
    }

    @Test
    void createSaleShouldRejectFreeItemWithoutDescription() {
        SaleRequest request = new SaleRequest(
                OPERATION_DATE,
                Shift.MORNING,
                OperationType.QUICK_SALE,
                new BigDecimal("1000.00"),
                null,
                null,
                List.of(new SaleDetailRequest(null, "   ", new BigDecimal("1"), new BigDecimal("1000.00"))),
                List.of(new SalePaymentRequest(PaymentMethod.CASH, new BigDecimal("1000.00")))
        );

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> saleService.createSale(request)
        );

        assertTrue(exception.getMessage().contains("descripción"));
    }

    @Test
    void createSaleShouldRejectFreeItemWithoutUnitPrice() {
        SaleRequest request = new SaleRequest(
                OPERATION_DATE,
                Shift.MORNING,
                OperationType.QUICK_SALE,
                new BigDecimal("1000.00"),
                null,
                null,
                List.of(new SaleDetailRequest(null, "Lavado completo", new BigDecimal("1"), null)),
                List.of(new SalePaymentRequest(PaymentMethod.CASH, new BigDecimal("1000.00")))
        );

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> saleService.createSale(request)
        );

        assertTrue(exception.getMessage().contains("precio unitario"));
    }

    @Test
    void createSaleShouldRejectInactiveProduct() {
        Product filter = product(1L, "FAP-9013", "Filtro de aceite", "Filtro de Aceite", "1500.00", 10, true, false);
        when(productRepository.findByIdForUpdate(1L)).thenReturn(Optional.of(filter));

        SaleRequest request = new SaleRequest(
                OPERATION_DATE,
                Shift.MORNING,
                OperationType.QUICK_SALE,
                new BigDecimal("1500.00"),
                null,
                null,
                List.of(new SaleDetailRequest(1L, null, new BigDecimal("1"), null)),
                List.of(new SalePaymentRequest(PaymentMethod.CASH, new BigDecimal("1500.00")))
        );

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> saleService.createSale(request)
        );

        assertTrue(exception.getMessage().contains("inactivo"));
        verify(productRepository, never()).save(any(Product.class));
    }

    @Test
    void getSaleByIdShouldReturnFullSale() {
        Sale sale = sale(1L, OperationType.SERVICE);
        Product product = product(1L, "FAP-9013", "Filtro de aceite", "Filtro de Aceite", "1500.00", 10, true, true);
        SaleDetail detail = detail(sale, product, "FAP-9013 - Filtro de aceite", "1", "1500.00");
        SalePayment payment = payment(sale, PaymentMethod.CASH, "1500.00");
        Vehicle vehicle = vehicle(5L, "AB123CD", "Peugeot 408");
        VehicleService vehicleService = vehicleService(sale, vehicle, 50000, "Service completo");

        when(saleRepository.findById(1L)).thenReturn(Optional.of(sale));
        when(saleDetailRepository.findBySaleIdOrderByIdAsc(1L)).thenReturn(List.of(detail));
        when(salePaymentRepository.findBySaleIdOrderByIdAsc(1L)).thenReturn(List.of(payment));
        when(vehicleServiceRepository.findBySaleIdWithVehicle(1L)).thenReturn(Optional.of(vehicleService));

        SaleResponse response = saleService.getSaleById(1L);

        assertEquals(1L, response.id());
        assertEquals(OperationType.SERVICE, response.operationType());
        assertEquals(1, response.items().size());
        assertEquals(1, response.payments().size());
        assertEquals("AB123CD", response.vehicleService().licensePlate());
        assertEquals(50000, response.vehicleService().mileage());
    }

    @Test
    void getSaleByIdShouldRejectMissingSale() {
        when(saleRepository.findById(99L)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> saleService.getSaleById(99L));
    }

    @Test
    void getServiceHistoryByVehicleIdShouldReturnServicesOrdered() {
        Vehicle vehicle = vehicle(5L, "AB123CD", "Peugeot 408");
        Sale firstSale = sale(100L, OperationType.SERVICE);
        firstSale.setOperationDate(OPERATION_DATE);
        Sale secondSale = sale(99L, OperationType.SERVICE);
        secondSale.setOperationDate(OPERATION_DATE.minusDays(1));
        VehicleService firstService = vehicleService(firstSale, vehicle, 50000, "Primer service");
        VehicleService secondService = vehicleService(secondSale, vehicle, 40000, "Segundo service");

        when(vehicleRepository.existsById(5L)).thenReturn(true);
        when(vehicleServiceRepository.findHistoryByVehicleId(5L))
                .thenReturn(List.of(firstService, secondService));
        when(saleDetailRepository.findBySaleIdOrderByIdAsc(100L)).thenReturn(List.of());
        when(salePaymentRepository.findBySaleIdOrderByIdAsc(100L)).thenReturn(List.of());
        when(saleDetailRepository.findBySaleIdOrderByIdAsc(99L)).thenReturn(List.of());
        when(salePaymentRepository.findBySaleIdOrderByIdAsc(99L)).thenReturn(List.of());

        List<SaleResponse> history = saleService.getServiceHistoryByVehicleId(5L);

        assertEquals(2, history.size());
        assertEquals(100L, history.get(0).id());
        assertEquals(99L, history.get(1).id());
        assertEquals("AB123CD", history.get(0).vehicleService().licensePlate());
        assertEquals(50000, history.get(0).vehicleService().mileage());
        assertEquals(40000, history.get(1).vehicleService().mileage());
        verify(vehicleServiceRepository).findHistoryByVehicleId(5L);
    }

    @Test
    void getServiceHistoryByVehicleIdShouldRejectMissingVehicle() {
        when(vehicleRepository.existsById(99L)).thenReturn(false);

        assertThrows(
                ResourceNotFoundException.class,
                () -> saleService.getServiceHistoryByVehicleId(99L)
        );

        verifyNoInteractions(vehicleServiceRepository);
    }

    private void stubSaleSave(Long id) {
        when(saleRepository.save(any(Sale.class))).thenAnswer(invocation -> {
            Sale sale = invocation.getArgument(0);
            sale.setId(id);
            return sale;
        });
    }

    private void stubDetailSave() {
        when(saleDetailRepository.save(any(SaleDetail.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));
    }

    private void stubPaymentSave() {
        when(salePaymentRepository.save(any(SalePayment.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));
    }

    private Product product(
            Long id,
            String code,
            String name,
            String categoryName,
            String listPrice,
            int localStock,
            boolean tracksStock,
            boolean active
    ) {
        Category category = new Category();
        category.setId((long) categoryName.hashCode());
        category.setName(categoryName);
        category.setActive(true);

        Product product = new Product();
        product.setId(id);
        product.setCode(code);
        product.setName(name);
        product.setCategory(category);
        product.setBrand("Marca");
        product.setTracksStock(tracksStock);
        product.setLocalStock(localStock);
        product.setWarehouseStock(10);
        product.setMinStock(2);
        product.setListPrice(new BigDecimal(listPrice));
        product.setActive(active);
        return product;
    }

    private Vehicle vehicle(Long id, String licensePlate, String brandModel) {
        Vehicle vehicle = new Vehicle();
        vehicle.setId(id);
        vehicle.setLicensePlate(licensePlate);
        vehicle.setBrandModel(brandModel);
        vehicle.setOwnerName("Juan Pérez");
        vehicle.setPhone("3515551234");
        vehicle.setCreatedAt(OPERATION_DATE.minusDays(30));
        return vehicle;
    }

    private OilDrum drum(Long id, Product product, String remainingLiters) {
        OilDrum drum = new OilDrum();
        drum.setId(id);
        drum.setProduct(product);
        drum.setCapacityLiters(new BigDecimal("20.00"));
        drum.setRemainingLiters(new BigDecimal(remainingLiters));
        drum.setStatus(DrumStatus.OPEN);
        drum.setOpenedAt(OPERATION_DATE.minusDays(10));
        return drum;
    }

    private Sale sale(Long id, OperationType operationType) {
        Sale sale = new Sale();
        sale.setId(id);
        sale.setOperationDate(OPERATION_DATE);
        sale.setShift(Shift.MORNING);
        sale.setOperationType(operationType);
        sale.setCalculatedSubtotal(new BigDecimal("1500.00"));
        sale.setTotalCharged(new BigDecimal("1500.00"));
        sale.setNotes("Venta de prueba");
        return sale;
    }

    private SaleDetail detail(Sale sale, Product product, String description, String quantity, String unitPrice) {
        SaleDetail detail = new SaleDetail();
        detail.setId(200L);
        detail.setSale(sale);
        detail.setProduct(product);
        detail.setDescriptionSnapshot(description);
        detail.setQuantity(new BigDecimal(quantity));
        detail.setUnitPriceSnapshot(new BigDecimal(unitPrice));
        return detail;
    }

    private SalePayment payment(Sale sale, PaymentMethod paymentMethod, String amount) {
        SalePayment payment = new SalePayment();
        payment.setId(300L);
        payment.setSale(sale);
        payment.setPaymentMethod(paymentMethod);
        payment.setAmount(new BigDecimal(amount));
        return payment;
    }

    private VehicleService vehicleService(
            Sale sale,
            Vehicle vehicle,
            Integer mileage,
            String technicalNotes
    ) {
        VehicleService vehicleService = new VehicleService();
        vehicleService.setSale(sale);
        vehicleService.setSaleId(sale.getId());
        vehicleService.setVehicle(vehicle);
        vehicleService.setMileage(mileage);
        vehicleService.setTechnicalNotes(technicalNotes);
        return vehicleService;
    }
}

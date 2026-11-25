package com.lubricentromp.api.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;

import com.lubricentromp.api.dto.StockMovementResponse;
import com.lubricentromp.api.entity.Category;
import com.lubricentromp.api.entity.OilDrum;
import com.lubricentromp.api.entity.Product;
import com.lubricentromp.api.entity.StockMovement;
import com.lubricentromp.api.enums.DrumStatus;
import com.lubricentromp.api.enums.MovementType;
import com.lubricentromp.api.enums.StockLocation;
import com.lubricentromp.api.exception.BusinessRuleException;
import com.lubricentromp.api.exception.ResourceNotFoundException;
import com.lubricentromp.api.mapper.StockMovementMapper;
import com.lubricentromp.api.repository.OilDrumRepository;
import com.lubricentromp.api.repository.ProductRepository;
import com.lubricentromp.api.repository.StockMovementRepository;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class StockMovementServiceTest {

    private static final LocalDateTime MOVEMENT_DATE = LocalDateTime.of(2026, 11, 24, 10, 0);

    @Mock
    private StockMovementRepository stockMovementRepository;

    @Mock
    private ProductRepository productRepository;

    @Mock
    private OilDrumRepository oilDrumRepository;

    private StockMovementService stockMovementService;

    @BeforeEach
    void setUp() {
        stockMovementService = new StockMovementService(
                stockMovementRepository,
                productRepository,
                oilDrumRepository,
                new StockMovementMapper()
        );
    }

    @Test
    void registerPurchaseEntryShouldIncreaseLocalStock() {
        Product product = product(1L, "Filtro de aceite", "Filtro de Aceite", 5, 10);
        when(productRepository.findByIdForUpdate(1L)).thenReturn(Optional.of(product));
        stubMovementSave(900L);

        StockMovementResponse response = stockMovementService.registerPurchaseEntry(
                1L,
                StockLocation.LOCAL,
                4,
                "Compra a proveedor"
        );

        assertEquals(9, product.getLocalStock());
        assertEquals(10, product.getWarehouseStock());
        assertEquals(900L, response.id());
        assertEquals(MovementType.PURCHASE_ENTRY, response.movementType());
        assertEquals(StockLocation.LOCAL, response.location());
        assertEquals(0, new BigDecimal("4.00").compareTo(response.quantity()));
        assertEquals("Compra a proveedor", response.reason());
        assertNull(response.saleId());
        verify(productRepository).save(product);
    }

    @Test
    void registerPurchaseEntryShouldIncreaseWarehouseStock() {
        Product product = product(1L, "Filtro de aceite", "Filtro de Aceite", 5, 10);
        when(productRepository.findByIdForUpdate(1L)).thenReturn(Optional.of(product));
        stubMovementSave(900L);

        StockMovementResponse response = stockMovementService.registerPurchaseEntry(
                1L,
                StockLocation.WAREHOUSE,
                7,
                null
        );

        assertEquals(5, product.getLocalStock());
        assertEquals(17, product.getWarehouseStock());
        assertEquals("Ingreso por compra de 7 unidad(es).", response.reason());
    }

    @Test
    void registerPurchaseEntryShouldRejectOpenDrumLocation() {
        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> stockMovementService.registerPurchaseEntry(1L, StockLocation.OPEN_DRUM, 3, null)
        );

        assertTrue(exception.getMessage().contains("local o depósito"));
        verifyNoInteractions(productRepository, stockMovementRepository);
    }

    @Test
    void registerPurchaseEntryShouldRejectInvalidQuantity() {
        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> stockMovementService.registerPurchaseEntry(1L, StockLocation.LOCAL, 0, null)
        );

        assertTrue(exception.getMessage().contains("mayor a cero"));
        verifyNoInteractions(productRepository, stockMovementRepository);
    }

    @Test
    void registerPurchaseEntryShouldRejectInactiveProduct() {
        Product product = product(1L, "Filtro de aceite", "Filtro de Aceite", 5, 10);
        product.setActive(false);
        when(productRepository.findByIdForUpdate(1L)).thenReturn(Optional.of(product));

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> stockMovementService.registerPurchaseEntry(1L, StockLocation.LOCAL, 1, null)
        );

        assertTrue(exception.getMessage().contains("inactivo"));
        verify(productRepository, never()).save(any(Product.class));
        verifyNoInteractions(stockMovementRepository);
    }

    @Test
    void registerManualAdjustmentShouldApplyNegativeDeltaOnLocalStock() {
        Product product = product(1L, "Filtro de aceite", "Filtro de Aceite", 10, 5);
        when(productRepository.findByIdForUpdate(1L)).thenReturn(Optional.of(product));
        stubMovementSave(901L);

        StockMovementResponse response = stockMovementService.registerManualAdjustment(
                1L,
                StockLocation.LOCAL,
                new BigDecimal("-6"),
                "Rotura de stock"
        );

        assertEquals(4, product.getLocalStock());
        assertEquals(MovementType.MANUAL_ADJUSTMENT, response.movementType());
        assertEquals(0, new BigDecimal("-6.00").compareTo(response.quantity()));
        assertEquals("Rotura de stock", response.reason());
    }

    @Test
    void registerManualAdjustmentShouldRequireReason() {
        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> stockMovementService.registerManualAdjustment(
                        1L,
                        StockLocation.LOCAL,
                        new BigDecimal("-1"),
                        "   "
                )
        );

        assertTrue(exception.getMessage().contains("motivo"));
        verifyNoInteractions(productRepository, stockMovementRepository);
    }

    @Test
    void registerManualAdjustmentShouldRejectNegativeResultingStock() {
        Product product = product(1L, "Filtro de aceite", "Filtro de Aceite", 2, 5);
        when(productRepository.findByIdForUpdate(1L)).thenReturn(Optional.of(product));

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> stockMovementService.registerManualAdjustment(
                        1L,
                        StockLocation.LOCAL,
                        new BigDecimal("-5"),
                        "Merma"
                )
        );

        assertTrue(exception.getMessage().contains("negativo"));
        assertEquals(2, product.getLocalStock());
        verify(productRepository, never()).save(any(Product.class));
        verifyNoInteractions(stockMovementRepository);
    }

    @Test
    void registerManualAdjustmentShouldRejectNonIntegerDeltaForStockProducts() {
        Product product = product(1L, "Filtro de aceite", "Filtro de Aceite", 5, 5);
        when(productRepository.findByIdForUpdate(1L)).thenReturn(Optional.of(product));

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> stockMovementService.registerManualAdjustment(
                        1L,
                        StockLocation.LOCAL,
                        new BigDecimal("-1.50"),
                        "Ajuste"
                )
        );

        assertTrue(exception.getMessage().contains("número entero"));
        verifyNoInteractions(stockMovementRepository);
    }

    @Test
    void registerManualAdjustmentShouldUpdateOpenDrumLiters() {
        Product oil = product(10L, "Aceite 15W40", "Aceite Tambor", 3, 0);
        OilDrum drum = drum(50L, oil, "10.00");
        when(productRepository.findByIdForUpdate(10L)).thenReturn(Optional.of(oil));
        when(oilDrumRepository.findByProductIdAndStatusForUpdate(10L, DrumStatus.OPEN))
                .thenReturn(List.of(drum));
        stubMovementSave(902L);

        StockMovementResponse response = stockMovementService.registerManualAdjustment(
                10L,
                StockLocation.OPEN_DRUM,
                new BigDecimal("5.50"),
                "Carga adicional de aceite"
        );

        assertEquals(0, new BigDecimal("15.50").compareTo(drum.getRemainingLiters()));
        assertEquals(StockLocation.OPEN_DRUM, response.location());
        assertEquals(0, new BigDecimal("5.50").compareTo(response.quantity()));
        verify(oilDrumRepository).save(drum);
    }

    @Test
    void registerManualAdjustmentShouldRejectDrumAdjustmentAboveCapacity() {
        Product oil = product(10L, "Aceite 15W40", "Aceite Tambor", 3, 0);
        OilDrum drum = drum(50L, oil, "19.00");
        when(productRepository.findByIdForUpdate(10L)).thenReturn(Optional.of(oil));
        when(oilDrumRepository.findByProductIdAndStatusForUpdate(10L, DrumStatus.OPEN))
                .thenReturn(List.of(drum));

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> stockMovementService.registerManualAdjustment(
                        10L,
                        StockLocation.OPEN_DRUM,
                        new BigDecimal("5"),
                        "Carga adicional"
                )
        );

        assertTrue(exception.getMessage().contains("supera la capacidad"));
        verify(oilDrumRepository, never()).save(any(OilDrum.class));
        verifyNoInteractions(stockMovementRepository);
    }

    @Test
    void registerManualAdjustmentShouldRejectDrumAdjustmentWithoutOpenDrum() {
        Product oil = product(10L, "Aceite 15W40", "Aceite Tambor", 3, 0);
        when(productRepository.findByIdForUpdate(10L)).thenReturn(Optional.of(oil));
        when(oilDrumRepository.findByProductIdAndStatusForUpdate(10L, DrumStatus.OPEN))
                .thenReturn(List.of());

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> stockMovementService.registerManualAdjustment(
                        10L,
                        StockLocation.OPEN_DRUM,
                        new BigDecimal("5"),
                        "Carga adicional"
                )
        );

        assertTrue(exception.getMessage().contains("No hay un tambor abierto"));
        verifyNoInteractions(stockMovementRepository);
    }

    @Test
    void getMovementsByProductShouldReturnHistoryDescending() {
        Product product = product(1L, "Filtro de aceite", "Filtro de Aceite", 5, 10);
        StockMovement movement = movement(product, "2.00");
        when(productRepository.existsById(1L)).thenReturn(true);
        when(stockMovementRepository.findHistoryByProductId(1L)).thenReturn(List.of(movement));

        List<StockMovementResponse> movements = stockMovementService.getMovementsByProduct(1L);

        assertEquals(1, movements.size());
        assertEquals(1L, movements.get(0).productId());
        assertEquals("Filtro de aceite", movements.get(0).productName());
        assertEquals(MovementType.PURCHASE_ENTRY, movements.get(0).movementType());
    }

    @Test
    void getMovementsByProductShouldRejectMissingProduct() {
        when(productRepository.existsById(99L)).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> stockMovementService.getMovementsByProduct(99L));
        verifyNoInteractions(stockMovementRepository);
    }

    private void stubMovementSave(Long id) {
        when(stockMovementRepository.save(any(StockMovement.class))).thenAnswer(invocation -> {
            StockMovement movement = invocation.getArgument(0);
            movement.setId(id);
            return movement;
        });
    }

    private Product product(Long id, String name, String categoryName, int localStock, int warehouseStock) {
        Category category = new Category();
        category.setId((long) categoryName.hashCode());
        category.setName(categoryName);
        category.setActive(true);

        Product product = new Product();
        product.setId(id);
        product.setCode("COD-" + id);
        product.setName(name);
        product.setCategory(category);
        product.setTracksStock(true);
        product.setLocalStock(localStock);
        product.setWarehouseStock(warehouseStock);
        product.setMinStock(1);
        product.setListPrice(new BigDecimal("1000.00"));
        product.setActive(true);
        return product;
    }

    private OilDrum drum(Long id, Product product, String remainingLiters) {
        OilDrum drum = new OilDrum();
        drum.setId(id);
        drum.setProduct(product);
        drum.setCapacityLiters(new BigDecimal("20.00"));
        drum.setRemainingLiters(new BigDecimal(remainingLiters));
        drum.setStatus(DrumStatus.OPEN);
        drum.setOpenedAt(MOVEMENT_DATE.minusDays(1));
        return drum;
    }

    private StockMovement movement(Product product, String quantity) {
        StockMovement movement = new StockMovement();
        movement.setId(900L);
        movement.setProduct(product);
        movement.setMovementType(MovementType.PURCHASE_ENTRY);
        movement.setLocation(StockLocation.LOCAL);
        movement.setQuantity(new BigDecimal(quantity));
        movement.setMovementDate(MOVEMENT_DATE);
        movement.setReason("Ingreso por compra");
        return movement;
    }
}

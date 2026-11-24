package com.lubricentromp.api.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;

import com.lubricentromp.api.dto.OilDrumResponse;
import com.lubricentromp.api.entity.Category;
import com.lubricentromp.api.entity.OilDrum;
import com.lubricentromp.api.entity.Product;
import com.lubricentromp.api.enums.DrumStatus;
import com.lubricentromp.api.exception.BusinessRuleException;
import com.lubricentromp.api.exception.ResourceNotFoundException;
import com.lubricentromp.api.mapper.OilDrumMapper;
import com.lubricentromp.api.repository.OilDrumRepository;
import com.lubricentromp.api.repository.ProductRepository;
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
class OilDrumServiceTest {

    @Mock
    private OilDrumRepository oilDrumRepository;

    @Mock
    private ProductRepository productRepository;

    private OilDrumService oilDrumService;

    @BeforeEach
    void setUp() {
        oilDrumService = new OilDrumService(oilDrumRepository, productRepository, new OilDrumMapper());
    }

    @Test
    void openNewDrumShouldCreateOpenDrumAndDecreaseLocalStock() {
        Product product = product(10L, "Aceite 15W40", 5, true);
        when(productRepository.findByIdForUpdate(10L)).thenReturn(Optional.of(product));
        when(oilDrumRepository.existsByProductIdAndStatus(10L, DrumStatus.OPEN)).thenReturn(false);
        when(productRepository.save(product)).thenReturn(product);
        when(oilDrumRepository.save(any(OilDrum.class))).thenAnswer(invocation -> {
            OilDrum drum = invocation.getArgument(0);
            drum.setId(50L);
            return drum;
        });

        OilDrumResponse response = oilDrumService.openNewDrum(
                10L,
                new BigDecimal("20.00"),
                "Tambor nuevo"
        );

        assertEquals(4, product.getLocalStock());
        assertEquals(50L, response.id());
        assertEquals(10L, response.productId());
        assertEquals("Aceite 15W40", response.productName());
        assertEquals(0, new BigDecimal("20.00").compareTo(response.capacityLiters()));
        assertEquals(0, new BigDecimal("20.00").compareTo(response.remainingLiters()));
        assertEquals(0, new BigDecimal("100.00").compareTo(response.remainingPercentage()));
        assertEquals(DrumStatus.OPEN, response.status());
        assertNotNull(response.openedAt());
        assertEquals("Tambor nuevo", response.notes());
        verify(productRepository).save(product);
        verify(oilDrumRepository).save(any(OilDrum.class));
    }

    @Test
    void openNewDrumShouldRejectMissingProduct() {
        when(productRepository.findByIdForUpdate(99L)).thenReturn(Optional.empty());

        assertThrows(
                ResourceNotFoundException.class,
                () -> oilDrumService.openNewDrum(99L, new BigDecimal("20.00"), null)
        );

        verifyNoInteractions(oilDrumRepository);
    }

    @Test
    void openNewDrumShouldRejectInactiveProduct() {
        Product product = product(10L, "Aceite 15W40", 5, false);
        when(productRepository.findByIdForUpdate(10L)).thenReturn(Optional.of(product));

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> oilDrumService.openNewDrum(10L, new BigDecimal("20.00"), null)
        );

        assertTrue(exception.getMessage().contains("inactivo"));
        verifyNoInteractions(oilDrumRepository);
    }

    @Test
    void openNewDrumShouldRejectWhenAnOpenDrumAlreadyExists() {
        Product product = product(10L, "Aceite 15W40", 5, true);
        when(productRepository.findByIdForUpdate(10L)).thenReturn(Optional.of(product));
        when(oilDrumRepository.existsByProductIdAndStatus(10L, DrumStatus.OPEN)).thenReturn(true);

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> oilDrumService.openNewDrum(10L, new BigDecimal("20.00"), null)
        );

        assertTrue(exception.getMessage().contains("Ya existe un tambor abierto"));
        verify(productRepository, never()).save(any(Product.class));
        verify(oilDrumRepository, never()).save(any(OilDrum.class));
    }

    @Test
    void openNewDrumShouldRejectWhenThereIsNoLocalStock() {
        Product product = product(10L, "Aceite 15W40", 0, true);
        when(productRepository.findByIdForUpdate(10L)).thenReturn(Optional.of(product));
        when(oilDrumRepository.existsByProductIdAndStatus(10L, DrumStatus.OPEN)).thenReturn(false);

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> oilDrumService.openNewDrum(10L, new BigDecimal("20.00"), null)
        );

        assertTrue(exception.getMessage().contains("stock local"));
        verify(productRepository, never()).save(any(Product.class));
        verify(oilDrumRepository, never()).save(any(OilDrum.class));
    }

    @Test
    void openNewDrumShouldRejectInvalidCapacity() {
        assertThrows(
                BusinessRuleException.class,
                () -> oilDrumService.openNewDrum(10L, BigDecimal.ZERO, null)
        );
        assertThrows(
                BusinessRuleException.class,
                () -> oilDrumService.openNewDrum(10L, null, null)
        );

        verifyNoInteractions(productRepository, oilDrumRepository);
    }

    @Test
    void closeDrumShouldRegisterShrinkageAndEmptyDrum() {
        Product product = product(10L, "Aceite 15W40", 5, true);
        OilDrum drum = drum(50L, product, "20.00", "3.50", DrumStatus.OPEN, "Uso intenso");
        when(oilDrumRepository.findByIdForUpdate(50L)).thenReturn(Optional.of(drum));
        when(oilDrumRepository.save(drum)).thenReturn(drum);

        OilDrumResponse response = oilDrumService.closeDrumWithShrinkage(50L, "Se descartó el fondo");

        assertEquals(DrumStatus.EMPTY, response.status());
        assertEquals(0, BigDecimal.ZERO.compareTo(response.remainingLiters()));
        assertEquals(0, BigDecimal.ZERO.compareTo(response.remainingPercentage()));
        assertTrue(response.notes().contains("Cierre con merma de 3.50 L."));
        assertTrue(response.notes().contains("Uso intenso"));
        assertTrue(response.notes().contains("Se descartó el fondo"));
        assertTrue(response.notes().length() <= 255);
        verify(oilDrumRepository).save(drum);
    }

    @Test
    void closeDrumShouldRejectAlreadyClosedDrum() {
        Product product = product(10L, "Aceite 15W40", 5, true);
        OilDrum drum = drum(50L, product, "20.00", "0.00", DrumStatus.EMPTY, null);
        when(oilDrumRepository.findByIdForUpdate(50L)).thenReturn(Optional.of(drum));

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> oilDrumService.closeDrumWithShrinkage(50L, null)
        );

        assertTrue(exception.getMessage().contains("ya está cerrado"));
        verify(oilDrumRepository, never()).save(any(OilDrum.class));
    }

    @Test
    void closeDrumShouldRejectMissingDrum() {
        when(oilDrumRepository.findByIdForUpdate(99L)).thenReturn(Optional.empty());

        assertThrows(
                ResourceNotFoundException.class,
                () -> oilDrumService.closeDrumWithShrinkage(99L, null)
        );

        verify(oilDrumRepository, never()).save(any(OilDrum.class));
    }

    @Test
    void adjustLitersShouldUpdateRemainingLiters() {
        Product product = product(10L, "Aceite 15W40", 5, true);
        OilDrum drum = drum(50L, product, "20.00", "10.00", DrumStatus.OPEN, null);
        when(oilDrumRepository.findByIdForUpdate(50L)).thenReturn(Optional.of(drum));
        when(oilDrumRepository.save(drum)).thenReturn(drum);

        OilDrumResponse response = oilDrumService.adjustLiters(50L, new BigDecimal("12.5"), "Ajuste manual");

        assertEquals(0, new BigDecimal("12.50").compareTo(response.remainingLiters()));
        assertEquals(0, new BigDecimal("62.50").compareTo(response.remainingPercentage()));
        assertEquals("Ajuste manual", response.notes());
    }

    @Test
    void adjustLitersShouldRejectValuesGreaterThanCapacity() {
        Product product = product(10L, "Aceite 15W40", 5, true);
        OilDrum drum = drum(50L, product, "20.00", "10.00", DrumStatus.OPEN, null);
        when(oilDrumRepository.findByIdForUpdate(50L)).thenReturn(Optional.of(drum));

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> oilDrumService.adjustLiters(50L, new BigDecimal("20.01"), null)
        );

        assertTrue(exception.getMessage().contains("capacidad"));
        verify(oilDrumRepository, never()).save(any(OilDrum.class));
    }

    @Test
    void adjustLitersShouldRejectNegativeValues() {
        assertThrows(
                BusinessRuleException.class,
                () -> oilDrumService.adjustLiters(50L, new BigDecimal("-0.01"), null)
        );

        verifyNoInteractions(oilDrumRepository);
    }

    @Test
    void adjustLitersShouldRejectClosedDrum() {
        Product product = product(10L, "Aceite 15W40", 5, true);
        OilDrum drum = drum(50L, product, "20.00", "0.00", DrumStatus.EMPTY, null);
        when(oilDrumRepository.findByIdForUpdate(50L)).thenReturn(Optional.of(drum));

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> oilDrumService.adjustLiters(50L, new BigDecimal("5.00"), null)
        );

        assertTrue(exception.getMessage().contains("no está abierto"));
        verify(oilDrumRepository, never()).save(any(OilDrum.class));
    }

    @Test
    void listOpenDrumsShouldCalculateRemainingPercentage() {
        Product product = product(10L, "Aceite 15W40", 5, true);
        OilDrum first = drum(1L, product, "20.00", "10.00", DrumStatus.OPEN, null);
        OilDrum second = drum(2L, product, "20.00", "0.00", DrumStatus.OPEN, null);
        when(oilDrumRepository.findByStatusOrderByOpenedAtAsc(DrumStatus.OPEN))
                .thenReturn(List.of(first, second));

        List<OilDrumResponse> responses = oilDrumService.listOpenDrums();

        assertEquals(2, responses.size());
        assertEquals(0, new BigDecimal("50.00").compareTo(responses.get(0).remainingPercentage()));
        assertEquals(0, BigDecimal.ZERO.compareTo(responses.get(1).remainingPercentage()));
    }

    @Test
    void listOpenDrumsShouldReturnEmptyList() {
        when(oilDrumRepository.findByStatusOrderByOpenedAtAsc(DrumStatus.OPEN)).thenReturn(List.of());

        assertTrue(oilDrumService.listOpenDrums().isEmpty());
    }

    @Test
    void getByIdShouldReturnDrum() {
        Product product = product(10L, "Aceite 15W40", 5, true);
        OilDrum drum = drum(50L, product, "20.00", "10.00", DrumStatus.OPEN, null);
        when(oilDrumRepository.findById(50L)).thenReturn(Optional.of(drum));

        OilDrumResponse response = oilDrumService.getById(50L);

        assertEquals(50L, response.id());
        assertEquals(DrumStatus.OPEN, response.status());
    }

    @Test
    void getByIdShouldRejectMissingDrum() {
        when(oilDrumRepository.findById(99L)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> oilDrumService.getById(99L));
    }

    private Product product(Long id, String name, int localStock, boolean active) {
        Category category = new Category();
        category.setId(1L);
        category.setName("Aceite Tambor");
        category.setActive(true);

        Product product = new Product();
        product.setId(id);
        product.setName(name);
        product.setCode("ACE-15W40");
        product.setCategory(category);
        product.setBrand("Marca");
        product.setTracksStock(true);
        product.setLocalStock(localStock);
        product.setWarehouseStock(10);
        product.setMinStock(2);
        product.setListPrice(new BigDecimal("10000.00"));
        product.setActive(active);
        return product;
    }

    private OilDrum drum(
            Long id,
            Product product,
            String capacityLiters,
            String remainingLiters,
            DrumStatus status,
            String notes
    ) {
        OilDrum drum = new OilDrum();
        drum.setId(id);
        drum.setProduct(product);
        drum.setCapacityLiters(new BigDecimal(capacityLiters));
        drum.setRemainingLiters(new BigDecimal(remainingLiters));
        drum.setStatus(status);
        drum.setOpenedAt(LocalDateTime.now());
        drum.setNotes(notes);
        return drum;
    }
}

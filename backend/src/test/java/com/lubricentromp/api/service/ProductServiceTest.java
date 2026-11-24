package com.lubricentromp.api.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;

import com.lubricentromp.api.dto.ProductRequest;
import com.lubricentromp.api.dto.ProductResponse;
import com.lubricentromp.api.entity.Category;
import com.lubricentromp.api.entity.Product;
import com.lubricentromp.api.exception.BusinessRuleException;
import com.lubricentromp.api.exception.ResourceNotFoundException;
import com.lubricentromp.api.mapper.ProductMapper;
import com.lubricentromp.api.repository.CategoryRepository;
import com.lubricentromp.api.repository.ProductRepository;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class ProductServiceTest {

    @Mock
    private ProductRepository productRepository;

    @Mock
    private CategoryRepository categoryRepository;

    private ProductService productService;

    @BeforeEach
    void setUp() {
        productService = new ProductService(productRepository, categoryRepository, new ProductMapper());
    }

    @Test
    void createShouldSaveProductWhenDataIsValid() {
        Category category = category(1L, "Filtros", true);
        ProductRequest request = request(1L, " FAP-9013 ", "Filtro de aceite", "FAP", true, 2, 10, 3, "1500.00");
        when(categoryRepository.findById(1L)).thenReturn(Optional.of(category));
        when(productRepository.existsByCodeIgnoreCase("FAP-9013")).thenReturn(false);
        when(productRepository.save(any(Product.class))).thenAnswer(invocation -> {
            Product product = invocation.getArgument(0);
            product.setId(100L);
            return product;
        });

        ProductResponse response = productService.create(request);

        assertEquals(100L, response.id());
        assertEquals("FAP-9013", response.code());
        assertEquals("Filtro de aceite", response.name());
        assertEquals("Filtros", response.categoryName());
        assertEquals(2, response.localStock());
        assertEquals(10, response.warehouseStock());
        assertEquals(0, new BigDecimal("1500.00").compareTo(response.listPrice()));
        assertTrue(response.active());
        verify(productRepository).save(any(Product.class));
    }

    @Test
    void createShouldRejectMissingCategory() {
        ProductRequest request = request(99L, "FAP-9013", "Filtro de aceite", null, true, 0, 0, 0, "100.00");
        when(categoryRepository.findById(99L)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> productService.create(request));

        verify(productRepository, never()).save(any(Product.class));
    }

    @Test
    void createShouldRejectInactiveCategory() {
        Category category = category(1L, "Filtros", false);
        ProductRequest request = request(1L, "FAP-9013", "Filtro de aceite", null, true, 0, 0, 0, "100.00");
        when(categoryRepository.findById(1L)).thenReturn(Optional.of(category));

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> productService.create(request)
        );

        assertTrue(exception.getMessage().contains("inactiva"));
        verify(productRepository, never()).save(any(Product.class));
    }

    @Test
    void createShouldRejectDuplicatedCode() {
        Category category = category(1L, "Filtros", true);
        ProductRequest request = request(1L, "FAP-9013", "Filtro de aceite", null, true, 0, 0, 0, "100.00");
        when(categoryRepository.findById(1L)).thenReturn(Optional.of(category));
        when(productRepository.existsByCodeIgnoreCase("FAP-9013")).thenReturn(true);

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> productService.create(request)
        );

        assertTrue(exception.getMessage().contains("FAP-9013"));
        verify(productRepository, never()).save(any(Product.class));
    }

    @Test
    void createShouldAllowBlankCodeAsNull() {
        Category category = category(1L, "Servicios", true);
        ProductRequest request = request(1L, "   ", "Lavado completo", null, false, 0, 0, 0, "500.00");
        when(categoryRepository.findById(1L)).thenReturn(Optional.of(category));
        when(productRepository.save(any(Product.class))).thenAnswer(invocation -> invocation.getArgument(0));

        ProductResponse response = productService.create(request);

        assertNull(response.code());
        verify(productRepository, never()).existsByCodeIgnoreCase(anyString());
    }

    @Test
    void updateShouldModifyProductWhenDataIsValid() {
        Category oldCategory = category(1L, "Filtros", true);
        Category newCategory = category(2L, "Aceites", true);
        Product product = product(10L, "Filtro viejo", "OLD-1", oldCategory, 1, 2, 1, true);
        ProductRequest request = request(2L, "NEW-1", "Filtro nuevo", "Nueva marca", true, 4, 8, 2, "2500.00");
        when(productRepository.findById(10L)).thenReturn(Optional.of(product));
        when(categoryRepository.findById(2L)).thenReturn(Optional.of(newCategory));
        when(productRepository.existsByCodeIgnoreCaseAndIdNot("NEW-1", 10L)).thenReturn(false);
        when(productRepository.save(product)).thenReturn(product);

        ProductResponse response = productService.update(10L, request);

        assertEquals("NEW-1", response.code());
        assertEquals("Filtro nuevo", response.name());
        assertEquals("Aceites", response.categoryName());
        assertEquals(4, response.localStock());
        assertEquals(8, response.warehouseStock());
        assertEquals(0, new BigDecimal("2500.00").compareTo(response.listPrice()));
    }

    @Test
    void updateShouldRejectMissingProduct() {
        ProductRequest request = request(1L, "NEW-1", "Filtro nuevo", null, true, 0, 0, 0, "100.00");
        when(productRepository.findById(99L)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> productService.update(99L, request));

        verify(productRepository, never()).save(any(Product.class));
    }

    @Test
    void updateShouldRejectDuplicatedCode() {
        Category category = category(1L, "Filtros", true);
        Product product = product(10L, "Filtro viejo", "OLD-1", category, 1, 2, 1, true);
        ProductRequest request = request(1L, "DUP-1", "Filtro nuevo", null, true, 1, 2, 1, "100.00");
        when(productRepository.findById(10L)).thenReturn(Optional.of(product));
        when(categoryRepository.findById(1L)).thenReturn(Optional.of(category));
        when(productRepository.existsByCodeIgnoreCaseAndIdNot("DUP-1", 10L)).thenReturn(true);

        assertThrows(BusinessRuleException.class, () -> productService.update(10L, request));

        verify(productRepository, never()).save(any(Product.class));
    }

    @Test
    void getByIdShouldReturnInactiveProduct() {
        Category category = category(1L, "Filtros", true);
        Product product = product(10L, "Filtro viejo", "OLD-1", category, 1, 2, 1, false);
        when(productRepository.findById(10L)).thenReturn(Optional.of(product));

        ProductResponse response = productService.getById(10L);

        assertFalse(response.active());
        assertEquals(10L, response.id());
    }

    @Test
    void getByIdShouldRejectMissingProduct() {
        when(productRepository.findById(99L)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> productService.getById(99L));
    }

    @Test
    void deactivateShouldSetActiveFalse() {
        Category category = category(1L, "Filtros", true);
        Product product = product(10L, "Filtro", "F-1", category, 1, 2, 1, true);
        when(productRepository.findById(10L)).thenReturn(Optional.of(product));
        when(productRepository.save(product)).thenReturn(product);

        productService.deactivate(10L);

        assertFalse(product.isActive());
        verify(productRepository).save(product);
    }

    @Test
    void activateShouldSetActiveTrue() {
        Category category = category(1L, "Filtros", true);
        Product product = product(10L, "Filtro", "F-1", category, 1, 2, 1, false);
        when(productRepository.findById(10L)).thenReturn(Optional.of(product));
        when(productRepository.save(product)).thenReturn(product);

        ProductResponse response = productService.activate(10L);

        assertTrue(response.active());
        assertTrue(product.isActive());
    }

    @Test
    void searchShouldReturnActiveProductsWhenTermIsBlank() {
        Category category = category(1L, "Filtros", true);
        Product product = product(10L, "Filtro", "F-1", category, 1, 2, 1, true);
        when(productRepository.findByActiveTrueOrderByNameAsc()).thenReturn(List.of(product));

        List<ProductResponse> responses = productService.search("   ");

        assertEquals(1, responses.size());
        verify(productRepository).findByActiveTrueOrderByNameAsc();
        verify(productRepository, never()).searchActiveByTerm(anyString());
    }

    @Test
    void searchShouldNormalizeTermIgnoringCaseHyphensAndSpaces() {
        Category category = category(1L, "Filtros", true);
        Product product = product(10L, "Filtro", "FAP-9013", category, 1, 2, 1, true);
        when(productRepository.searchActiveByTerm("fap9013")).thenReturn(List.of(product));

        List<ProductResponse> responses = productService.search("  FAP-9013  ");

        assertEquals(1, responses.size());
        verify(productRepository).searchActiveByTerm("fap9013");
    }

    @Test
    void listLowStockShouldDelegateToRepository() {
        Category category = category(1L, "Filtros", true);
        Product product = product(10L, "Filtro", "F-1", category, 1, 1, 2, true);
        when(productRepository.findLowStockProducts()).thenReturn(List.of(product));

        List<ProductResponse> responses = productService.listLowStock();

        assertEquals(1, responses.size());
        verify(productRepository).findLowStockProducts();
    }

    @Test
    void transferStockShouldMoveStockFromWarehouseToLocal() {
        Category category = category(1L, "Filtros", true);
        Product product = product(10L, "Filtro", "F-1", category, 2, 10, 1, true);
        when(productRepository.findByIdForUpdate(10L)).thenReturn(Optional.of(product));
        when(productRepository.save(product)).thenReturn(product);

        ProductResponse response = productService.transferStock(10L, 3);

        assertEquals(5, response.localStock());
        assertEquals(7, response.warehouseStock());
        assertEquals(5, product.getLocalStock());
        assertEquals(7, product.getWarehouseStock());
    }

    @Test
    void transferStockShouldRejectInsufficientWarehouseStock() {
        Category category = category(1L, "Filtros", true);
        Product product = product(10L, "Filtro", "F-1", category, 2, 2, 1, true);
        when(productRepository.findByIdForUpdate(10L)).thenReturn(Optional.of(product));

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> productService.transferStock(10L, 3)
        );

        assertTrue(exception.getMessage().contains("stock suficiente"));
        verify(productRepository, never()).save(any(Product.class));
    }

    @Test
    void transferStockShouldRejectInactiveProduct() {
        Category category = category(1L, "Filtros", true);
        Product product = product(10L, "Filtro", "F-1", category, 2, 10, 1, false);
        when(productRepository.findByIdForUpdate(10L)).thenReturn(Optional.of(product));

        BusinessRuleException exception = assertThrows(
                BusinessRuleException.class,
                () -> productService.transferStock(10L, 1)
        );

        assertTrue(exception.getMessage().contains("inactivo"));
        verify(productRepository, never()).save(any(Product.class));
    }

    @Test
    void transferStockShouldRejectInvalidQuantity() {
        assertThrows(BusinessRuleException.class, () -> productService.transferStock(10L, 0));
        assertThrows(BusinessRuleException.class, () -> productService.transferStock(10L, null));

        verifyNoInteractions(productRepository);
    }

    @Test
    void transferStockShouldRejectMissingProduct() {
        when(productRepository.findByIdForUpdate(99L)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> productService.transferStock(99L, 1));
    }

    private ProductRequest request(
            Long categoryId,
            String code,
            String name,
            String brand,
            boolean tracksStock,
            int localStock,
            int warehouseStock,
            int minStock,
            String listPrice
    ) {
        return new ProductRequest(
                categoryId,
                code,
                name,
                brand,
                tracksStock,
                localStock,
                warehouseStock,
                minStock,
                new BigDecimal(listPrice)
        );
    }

    private Category category(Long id, String name, boolean active) {
        Category category = new Category();
        category.setId(id);
        category.setName(name);
        category.setActive(active);
        return category;
    }

    private Product product(
            Long id,
            String name,
            String code,
            Category category,
            int localStock,
            int warehouseStock,
            int minStock,
            boolean active
    ) {
        Product product = new Product();
        product.setId(id);
        product.setName(name);
        product.setCode(code);
        product.setCategory(category);
        product.setBrand("Marca");
        product.setTracksStock(true);
        product.setLocalStock(localStock);
        product.setWarehouseStock(warehouseStock);
        product.setMinStock(minStock);
        product.setListPrice(new BigDecimal("100.00"));
        product.setActive(active);
        return product;
    }
}

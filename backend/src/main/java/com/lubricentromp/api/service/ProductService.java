package com.lubricentromp.api.service;

import com.lubricentromp.api.dto.ProductRequest;
import com.lubricentromp.api.dto.ProductResponse;
import com.lubricentromp.api.entity.Category;
import com.lubricentromp.api.entity.Product;
import com.lubricentromp.api.exception.BusinessRuleException;
import com.lubricentromp.api.exception.ResourceNotFoundException;
import com.lubricentromp.api.mapper.ProductMapper;
import com.lubricentromp.api.repository.CategoryRepository;
import com.lubricentromp.api.repository.ProductRepository;
import java.util.List;
import java.util.Locale;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class ProductService {

    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;
    private final ProductMapper productMapper;
    private final StockMovementService stockMovementService;

    public ProductService(
            ProductRepository productRepository,
            CategoryRepository categoryRepository,
            ProductMapper productMapper,
            StockMovementService stockMovementService
    ) {
        this.productRepository = productRepository;
        this.categoryRepository = categoryRepository;
        this.productMapper = productMapper;
        this.stockMovementService = stockMovementService;
    }

    public List<ProductResponse> listActive() {
        return productRepository.findByActiveTrueOrderByNameAsc()
                .stream()
                .map(productMapper::toResponse)
                .toList();
    }

    public ProductResponse getById(Long id) {
        return productMapper.toResponse(findProduct(id));
    }

    public List<ProductResponse> search(String term) {
        String normalizedTerm = normalizeSearchTerm(term);
        List<Product> products = normalizedTerm.isEmpty()
                ? productRepository.findByActiveTrueOrderByNameAsc()
                : productRepository.searchActiveByTerm(normalizedTerm);
        return products.stream().map(productMapper::toResponse).toList();
    }

    public List<ProductResponse> listLowStock() {
        return productRepository.findLowStockProducts()
                .stream()
                .map(productMapper::toResponse)
                .toList();
    }

    @Transactional
    public ProductResponse create(ProductRequest request) {
        Category category = findActiveCategory(request.categoryId());
        String code = ProductMapper.normalizeCode(request.code());
        validateCodeAvailable(code, null);
        Product product = productMapper.toEntity(request, category);
        return productMapper.toResponse(productRepository.save(product));
    }

    @Transactional
    public ProductResponse update(Long id, ProductRequest request) {
        Product product = findProduct(id);
        Category category = findActiveCategory(request.categoryId());
        String code = ProductMapper.normalizeCode(request.code());
        validateCodeAvailable(code, id);
        productMapper.updateEntity(product, request, category);
        return productMapper.toResponse(productRepository.save(product));
    }

    @Transactional
    public void deactivate(Long id) {
        Product product = findProduct(id);
        product.setActive(false);
        productRepository.save(product);
    }

    @Transactional
    public ProductResponse activate(Long id) {
        Product product = findProduct(id);
        product.setActive(true);
        return productMapper.toResponse(productRepository.save(product));
    }

    @Transactional
    public ProductResponse transferStock(Long id, Integer quantity) {
        if (quantity == null || quantity <= 0) {
            throw new BusinessRuleException("La cantidad a trasladar debe ser mayor a cero.");
        }
        Product product = productRepository.findByIdForUpdate(id)
                .orElseThrow(() -> new ResourceNotFoundException("No existe el producto con id " + id + "."));
        if (!product.isActive()) {
            throw new BusinessRuleException("El producto '" + product.getName() + "' está inactivo.");
        }
        if (product.getWarehouseStock() < quantity) {
            throw new BusinessRuleException("No hay stock suficiente en depósito. Disponible: "
                    + product.getWarehouseStock() + ", solicitado: " + quantity + ".");
        }
        product.setWarehouseStock(product.getWarehouseStock() - quantity);
        product.setLocalStock(product.getLocalStock() + quantity);
        Product savedProduct = productRepository.save(product);
        stockMovementService.registerLocalTransfer(
                savedProduct,
                quantity,
                "Traslado de depósito a local: " + quantity + " unidad(es)."
        );
        return productMapper.toResponse(savedProduct);
    }

    private Product findProduct(Long id) {
        return productRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("No existe el producto con id " + id + "."));
    }

    private Category findActiveCategory(Long categoryId) {
        if (categoryId == null) {
            throw new BusinessRuleException("La categoría es obligatoria.");
        }
        Category category = categoryRepository.findById(categoryId)
                .orElseThrow(() -> new ResourceNotFoundException("No existe la categoría con id " + categoryId + "."));
        if (!category.isActive()) {
            throw new BusinessRuleException("La categoría '" + category.getName() + "' está inactiva.");
        }
        return category;
    }

    private void validateCodeAvailable(String code, Long productId) {
        if (code == null) {
            return;
        }
        boolean exists = productId == null
                ? productRepository.existsByCodeIgnoreCase(code)
                : productRepository.existsByCodeIgnoreCaseAndIdNot(code, productId);
        if (exists) {
            throw new BusinessRuleException("Ya existe un producto con el código '" + code + "'.");
        }
    }

    private String normalizeSearchTerm(String term) {
        if (term == null) {
            return "";
        }
        return term.trim()
                .replace("-", "")
                .replace(" ", "")
                .toLowerCase(Locale.ROOT);
    }
}

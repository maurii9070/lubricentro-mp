package com.lubricentromp.api.mapper;

import com.lubricentromp.api.dto.ProductRequest;
import com.lubricentromp.api.dto.ProductResponse;
import com.lubricentromp.api.entity.Category;
import com.lubricentromp.api.entity.Product;
import org.springframework.stereotype.Component;

@Component
public class ProductMapper {

    public Product toEntity(ProductRequest request, Category category) {
        Product product = new Product();
        product.setCategory(category);
        applyRequest(product, request);
        product.setActive(true);
        return product;
    }

    public void updateEntity(Product product, ProductRequest request, Category category) {
        product.setCategory(category);
        applyRequest(product, request);
    }

    public ProductResponse toResponse(Product product) {
        Category category = product.getCategory();
        return new ProductResponse(
                product.getId(),
                category.getId(),
                category.getName(),
                product.getCode(),
                product.getName(),
                product.getBrand(),
                product.isTracksStock(),
                product.getLocalStock(),
                product.getWarehouseStock(),
                product.getMinStock(),
                product.getListPrice(),
                product.isActive()
        );
    }

    public static String normalizeCode(String code) {
        return normalizeNullable(code);
    }

    private void applyRequest(Product product, ProductRequest request) {
        product.setCode(normalizeCode(request.code()));
        product.setName(request.name().trim());
        product.setBrand(normalizeNullable(request.brand()));
        product.setTracksStock(request.tracksStock());
        product.setLocalStock(request.localStock());
        product.setWarehouseStock(request.warehouseStock());
        product.setMinStock(request.minStock());
        product.setListPrice(request.listPrice());
    }

    private static String normalizeNullable(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }
}

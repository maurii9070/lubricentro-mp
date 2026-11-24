package com.lubricentromp.api.controller;

import com.lubricentromp.api.dto.ProductRequest;
import com.lubricentromp.api.dto.ProductResponse;
import com.lubricentromp.api.dto.StockTransferRequest;
import com.lubricentromp.api.service.ProductService;
import jakarta.validation.Valid;
import java.net.URI;
import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/products")
public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping
    public List<ProductResponse> findAll() {
        return productService.listActive();
    }

    @GetMapping("/search")
    public List<ProductResponse> search(
            @RequestParam(name = "term", required = false, defaultValue = "") String term
    ) {
        return productService.search(term);
    }

    @GetMapping("/low-stock")
    public List<ProductResponse> findLowStock() {
        return productService.listLowStock();
    }

    @GetMapping("/{id}")
    public ProductResponse findById(@PathVariable("id") Long id) {
        return productService.getById(id);
    }

    @PostMapping
    public ResponseEntity<ProductResponse> create(@Valid @RequestBody ProductRequest request) {
        ProductResponse response = productService.create(request);
        return ResponseEntity.created(URI.create("/api/v1/products/" + response.id())).body(response);
    }

    @PutMapping("/{id}")
    public ProductResponse update(
            @PathVariable("id") Long id,
            @Valid @RequestBody ProductRequest request
    ) {
        return productService.update(id, request);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deactivate(@PathVariable("id") Long id) {
        productService.deactivate(id);
        return ResponseEntity.noContent().build();
    }

    @PatchMapping("/{id}/activate")
    public ProductResponse activate(@PathVariable("id") Long id) {
        return productService.activate(id);
    }

    @PatchMapping("/{id}/stock-transfer")
    public ProductResponse transferStock(
            @PathVariable("id") Long id,
            @Valid @RequestBody StockTransferRequest request
    ) {
        return productService.transferStock(id, request.quantity());
    }
}

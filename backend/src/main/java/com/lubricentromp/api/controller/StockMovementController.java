package com.lubricentromp.api.controller;

import com.lubricentromp.api.dto.StockAdjustmentRequest;
import com.lubricentromp.api.dto.StockEntryRequest;
import com.lubricentromp.api.dto.StockMovementResponse;
import com.lubricentromp.api.service.StockMovementService;
import jakarta.validation.Valid;
import java.net.URI;
import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/stock-movements")
public class StockMovementController {

    private final StockMovementService stockMovementService;

    public StockMovementController(StockMovementService stockMovementService) {
        this.stockMovementService = stockMovementService;
    }

    @PostMapping("/entries")
    public ResponseEntity<StockMovementResponse> registerPurchaseEntry(
            @Valid @RequestBody StockEntryRequest request
    ) {
        StockMovementResponse response = stockMovementService.registerPurchaseEntry(
                request.productId(),
                request.location(),
                request.quantity(),
                request.reason()
        );
        return ResponseEntity
                .created(URI.create("/api/v1/stock-movements/" + response.id()))
                .body(response);
    }

    @PostMapping("/adjustments")
    public ResponseEntity<StockMovementResponse> registerManualAdjustment(
            @Valid @RequestBody StockAdjustmentRequest request
    ) {
        StockMovementResponse response = stockMovementService.registerManualAdjustment(
                request.productId(),
                request.location(),
                request.quantityDelta(),
                request.reason()
        );
        return ResponseEntity
                .created(URI.create("/api/v1/stock-movements/" + response.id()))
                .body(response);
    }

    @GetMapping("/product/{productId}")
    public List<StockMovementResponse> findByProduct(@PathVariable("productId") Long productId) {
        return stockMovementService.getMovementsByProduct(productId);
    }
}

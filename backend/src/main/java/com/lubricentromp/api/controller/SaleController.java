package com.lubricentromp.api.controller;

import com.lubricentromp.api.dto.SaleRequest;
import com.lubricentromp.api.dto.SaleResponse;
import com.lubricentromp.api.service.SaleService;
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
@RequestMapping("/api/v1/sales")
public class SaleController {

    private final SaleService saleService;

    public SaleController(SaleService saleService) {
        this.saleService = saleService;
    }

    @PostMapping
    public ResponseEntity<SaleResponse> create(@Valid @RequestBody SaleRequest request) {
        SaleResponse response = saleService.createSale(request);
        return ResponseEntity.created(URI.create("/api/v1/sales/" + response.id())).body(response);
    }

    @GetMapping("/{id}")
    public SaleResponse findById(@PathVariable("id") Long id) {
        return saleService.getSaleById(id);
    }

    @GetMapping("/vehicles/{vehicleId}/history")
    public List<SaleResponse> findServiceHistory(@PathVariable("vehicleId") Long vehicleId) {
        return saleService.getServiceHistoryByVehicleId(vehicleId);
    }
}

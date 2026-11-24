package com.lubricentromp.api.controller;

import com.lubricentromp.api.dto.OilDrumAdjustRequest;
import com.lubricentromp.api.dto.OilDrumCloseRequest;
import com.lubricentromp.api.dto.OilDrumOpenRequest;
import com.lubricentromp.api.dto.OilDrumResponse;
import com.lubricentromp.api.service.OilDrumService;
import jakarta.validation.Valid;
import java.net.URI;
import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/oil-drums")
public class OilDrumController {

    private final OilDrumService oilDrumService;

    public OilDrumController(OilDrumService oilDrumService) {
        this.oilDrumService = oilDrumService;
    }

    @GetMapping("/open")
    public List<OilDrumResponse> findOpenDrums() {
        return oilDrumService.listOpenDrums();
    }

    @GetMapping("/{id}")
    public OilDrumResponse findById(@PathVariable("id") Long id) {
        return oilDrumService.getById(id);
    }

    @PostMapping
    public ResponseEntity<OilDrumResponse> open(@Valid @RequestBody OilDrumOpenRequest request) {
        OilDrumResponse response = oilDrumService.openNewDrum(
                request.productId(),
                request.capacityLiters(),
                request.notes()
        );
        return ResponseEntity.created(URI.create("/api/v1/oil-drums/" + response.id())).body(response);
    }

    @PatchMapping("/{id}/adjust")
    public OilDrumResponse adjust(
            @PathVariable("id") Long id,
            @Valid @RequestBody OilDrumAdjustRequest request
    ) {
        return oilDrumService.adjustLiters(id, request.remainingLiters(), request.notes());
    }

    @PatchMapping("/{id}/close")
    public OilDrumResponse close(
            @PathVariable("id") Long id,
            @Valid @RequestBody(required = false) OilDrumCloseRequest request
    ) {
        String notes = request != null ? request.notes() : null;
        return oilDrumService.closeDrumWithShrinkage(id, notes);
    }
}

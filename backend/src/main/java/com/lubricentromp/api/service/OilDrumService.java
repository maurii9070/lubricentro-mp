package com.lubricentromp.api.service;

import com.lubricentromp.api.dto.OilDrumResponse;
import com.lubricentromp.api.entity.OilDrum;
import com.lubricentromp.api.entity.Product;
import com.lubricentromp.api.enums.DrumStatus;
import com.lubricentromp.api.exception.BusinessRuleException;
import com.lubricentromp.api.exception.ResourceNotFoundException;
import com.lubricentromp.api.mapper.OilDrumMapper;
import com.lubricentromp.api.repository.OilDrumRepository;
import com.lubricentromp.api.repository.ProductRepository;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class OilDrumService {

    private static final int NOTES_MAX_LENGTH = 255;

    private final OilDrumRepository oilDrumRepository;
    private final ProductRepository productRepository;
    private final OilDrumMapper oilDrumMapper;
    private final StockMovementService stockMovementService;

    public OilDrumService(
            OilDrumRepository oilDrumRepository,
            ProductRepository productRepository,
            OilDrumMapper oilDrumMapper,
            StockMovementService stockMovementService
    ) {
        this.oilDrumRepository = oilDrumRepository;
        this.productRepository = productRepository;
        this.oilDrumMapper = oilDrumMapper;
        this.stockMovementService = stockMovementService;
    }

    public List<OilDrumResponse> listOpenDrums() {
        return oilDrumRepository.findByStatusOrderByOpenedAtAsc(DrumStatus.OPEN)
                .stream()
                .map(oilDrumMapper::toResponse)
                .toList();
    }

    public OilDrumResponse getById(Long id) {
        return oilDrumMapper.toResponse(findDrum(id));
    }

    @Transactional
    public OilDrumResponse openNewDrum(Long productId, BigDecimal capacityLiters, String notes) {
        if (productId == null) {
            throw new BusinessRuleException("El producto es obligatorio.");
        }
        if (capacityLiters == null || capacityLiters.compareTo(BigDecimal.ZERO) <= 0) {
            throw new BusinessRuleException("La capacidad del tambor debe ser mayor a cero.");
        }
        Product product = productRepository.findByIdForUpdate(productId)
                .orElseThrow(() -> new ResourceNotFoundException("No existe el producto con id " + productId + "."));
        if (!product.isActive()) {
            throw new BusinessRuleException("El producto '" + product.getName() + "' está inactivo.");
        }
        if (oilDrumRepository.existsByProductIdAndStatus(productId, DrumStatus.OPEN)) {
            throw new BusinessRuleException("Ya existe un tambor abierto para el producto '" + product.getName() + "'.");
        }
        if (product.getLocalStock() < 1) {
            throw new BusinessRuleException("No hay stock local suficiente para abrir un tambor. "
                    + "Se requiere al menos 1 unidad y hay " + product.getLocalStock() + ".");
        }
        product.setLocalStock(product.getLocalStock() - 1);
        productRepository.save(product);

        OilDrum drum = oilDrumMapper.toEntity(product, capacityLiters, notes);
        OilDrum savedDrum = oilDrumRepository.save(drum);
        stockMovementService.registerDrumOpening(
                product,
                savedDrum,
                "Apertura de tambor: "
                        + savedDrum.getCapacityLiters().setScale(2, RoundingMode.HALF_UP).toPlainString()
                        + " L (se descuenta 1 unidad del stock local)."
        );
        return oilDrumMapper.toResponse(savedDrum);
    }

    @Transactional
    public OilDrumResponse closeDrumWithShrinkage(Long drumId, String notes) {
        OilDrum drum = findDrumForUpdate(drumId);
        if (drum.getStatus() != DrumStatus.OPEN) {
            throw new BusinessRuleException("El tambor ya está cerrado.");
        }
        BigDecimal shrinkage = drum.getRemainingLiters() == null
                ? BigDecimal.ZERO
                : drum.getRemainingLiters();
        drum.setStatus(DrumStatus.EMPTY);
        drum.setRemainingLiters(BigDecimal.ZERO.setScale(2, RoundingMode.HALF_UP));
        drum.setNotes(buildCloseNotes(drum.getNotes(), shrinkage, notes));
        return oilDrumMapper.toResponse(oilDrumRepository.save(drum));
    }

    @Transactional
    public OilDrumResponse adjustLiters(Long drumId, BigDecimal remainingLiters, String notes) {
        if (remainingLiters == null || remainingLiters.compareTo(BigDecimal.ZERO) < 0) {
            throw new BusinessRuleException("Los litros restantes no pueden ser negativos.");
        }
        OilDrum drum = findDrumForUpdate(drumId);
        if (drum.getStatus() != DrumStatus.OPEN) {
            throw new BusinessRuleException("El tambor no está abierto.");
        }
        BigDecimal normalizedLiters = OilDrumMapper.normalizeLiters(remainingLiters);
        if (normalizedLiters.compareTo(drum.getCapacityLiters()) > 0) {
            throw new BusinessRuleException("Los litros restantes no pueden superar la capacidad del tambor ("
                    + drum.getCapacityLiters().setScale(2, RoundingMode.HALF_UP).toPlainString() + " L).");
        }
        drum.setRemainingLiters(normalizedLiters);
        if (notes != null && !notes.isBlank()) {
            drum.setNotes(truncate(OilDrumMapper.normalizeNotes(notes)));
        }
        return oilDrumMapper.toResponse(oilDrumRepository.save(drum));
    }

    private OilDrum findDrum(Long id) {
        return oilDrumRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("No existe el tambor con id " + id + "."));
    }

    private OilDrum findDrumForUpdate(Long id) {
        return oilDrumRepository.findByIdForUpdate(id)
                .orElseThrow(() -> new ResourceNotFoundException("No existe el tambor con id " + id + "."));
    }

    private String buildCloseNotes(String existingNotes, BigDecimal shrinkage, String notes) {
        String shrinkageNote = "Cierre con merma de "
                + shrinkage.setScale(2, RoundingMode.HALF_UP).toPlainString() + " L.";
        StringBuilder builder = new StringBuilder(shrinkageNote);
        if (existingNotes != null && !existingNotes.isBlank()) {
            builder.append(" | ").append(existingNotes.trim());
        }
        if (notes != null && !notes.isBlank()) {
            builder.append(" | ").append(notes.trim());
        }
        return truncate(builder.toString());
    }

    private String truncate(String value) {
        if (value == null) {
            return null;
        }
        return value.length() <= NOTES_MAX_LENGTH ? value : value.substring(0, NOTES_MAX_LENGTH);
    }
}

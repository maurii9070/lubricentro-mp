package com.lubricentromp.api.service;

import com.lubricentromp.api.dto.StockMovementResponse;
import com.lubricentromp.api.entity.OilDrum;
import com.lubricentromp.api.entity.Product;
import com.lubricentromp.api.entity.Sale;
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
import java.math.RoundingMode;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class StockMovementService {

    private static final String LOCAL_LABEL = "local";
    private static final String WAREHOUSE_LABEL = "de depósito";

    private final StockMovementRepository stockMovementRepository;
    private final ProductRepository productRepository;
    private final OilDrumRepository oilDrumRepository;
    private final StockMovementMapper stockMovementMapper;

    public StockMovementService(
            StockMovementRepository stockMovementRepository,
            ProductRepository productRepository,
            OilDrumRepository oilDrumRepository,
            StockMovementMapper stockMovementMapper
    ) {
        this.stockMovementRepository = stockMovementRepository;
        this.productRepository = productRepository;
        this.oilDrumRepository = oilDrumRepository;
        this.stockMovementMapper = stockMovementMapper;
    }

    public List<StockMovementResponse> getMovementsByProduct(Long productId) {
        if (productId == null) {
            throw new BusinessRuleException("El producto es obligatorio.");
        }
        if (!productRepository.existsById(productId)) {
            throw new ResourceNotFoundException("No existe el producto con id " + productId + ".");
        }
        return stockMovementRepository.findHistoryByProductId(productId)
                .stream()
                .map(stockMovementMapper::toResponse)
                .toList();
    }

    @Transactional
    public StockMovementResponse registerPurchaseEntry(
            Long productId,
            StockLocation location,
            Integer quantity,
            String reason
    ) {
        if (productId == null) {
            throw new BusinessRuleException("El producto es obligatorio.");
        }
        if (location == null) {
            throw new BusinessRuleException("La ubicación del ingreso es obligatoria.");
        }
        if (location == StockLocation.OPEN_DRUM) {
            throw new BusinessRuleException("Los ingresos por compra solo pueden registrarse en local o depósito.");
        }
        if (quantity == null || quantity <= 0) {
            throw new BusinessRuleException("La cantidad del ingreso debe ser mayor a cero.");
        }
        Product product = findProductForUpdate(productId);
        if (!product.isActive()) {
            throw new BusinessRuleException("El producto '" + product.getName() + "' está inactivo.");
        }
        if (!product.isTracksStock()) {
            throw new BusinessRuleException("El producto '" + product.getName() + "' no controla stock.");
        }

        if (location == StockLocation.LOCAL) {
            long newStock = (long) product.getLocalStock() + quantity;
            validateStockRange(newStock, LOCAL_LABEL, product);
            product.setLocalStock((int) newStock);
        } else {
            long newStock = (long) product.getWarehouseStock() + quantity;
            validateStockRange(newStock, WAREHOUSE_LABEL, product);
            product.setWarehouseStock((int) newStock);
        }
        productRepository.save(product);

        StockMovement movement = stockMovementRepository.save(stockMovementMapper.toEntity(
                product,
                null,
                MovementType.PURCHASE_ENTRY,
                location,
                BigDecimal.valueOf(quantity),
                buildDefaultReason(reason, "Ingreso por compra de " + quantity + " unidad(es).")
        ));
        return stockMovementMapper.toResponse(movement);
    }

    @Transactional
    public StockMovementResponse registerManualAdjustment(
            Long productId,
            StockLocation location,
            BigDecimal quantityDelta,
            String reason
    ) {
        if (productId == null) {
            throw new BusinessRuleException("El producto es obligatorio.");
        }
        if (location == null) {
            throw new BusinessRuleException("La ubicación del ajuste es obligatoria.");
        }
        String normalizedReason = requireReason(reason);
        if (quantityDelta == null || quantityDelta.compareTo(BigDecimal.ZERO) == 0) {
            throw new BusinessRuleException("El ajuste debe ser distinto de cero.");
        }
        Product product = findProductForUpdate(productId);
        if (!product.isActive()) {
            throw new BusinessRuleException("El producto '" + product.getName() + "' está inactivo.");
        }

        BigDecimal normalizedDelta = StockMovementMapper.normalizeQuantity(quantityDelta);
        if (location == StockLocation.OPEN_DRUM) {
            applyDrumAdjustment(product, normalizedDelta);
        } else {
            applyStockAdjustment(product, location, normalizedDelta);
        }

        StockMovement movement = stockMovementRepository.save(stockMovementMapper.toEntity(
                product,
                null,
                MovementType.MANUAL_ADJUSTMENT,
                location,
                normalizedDelta,
                normalizedReason
        ));
        return stockMovementMapper.toResponse(movement);
    }

    @Transactional
    public void registerSaleExit(
            Product product,
            Sale sale,
            StockLocation location,
            BigDecimal quantity,
            String reason
    ) {
        stockMovementRepository.save(stockMovementMapper.toEntity(
                product,
                sale,
                MovementType.SALE_EXIT,
                location,
                quantity.negate(),
                reason
        ));
    }

    @Transactional
    public StockMovementResponse registerSaleCancellation(
            Product product,
            Sale sale,
            StockLocation location,
            BigDecimal quantity,
            String reason
    ) {
        StockMovement movement = stockMovementRepository.save(stockMovementMapper.toEntity(
                product,
                sale,
                MovementType.SALE_CANCELLATION,
                location,
                quantity.abs(),
                reason
        ));
        return stockMovementMapper.toResponse(movement);
    }

    @Transactional
    public void registerLocalTransfer(Product product, int quantity, String reason) {
        stockMovementRepository.save(stockMovementMapper.toEntity(
                product,
                null,
                MovementType.LOCAL_TRANSFER,
                StockLocation.LOCAL,
                BigDecimal.valueOf(quantity),
                reason
        ));
    }

    @Transactional
    public void registerDrumOpening(Product product, OilDrum drum, String reason) {
        BigDecimal openedLiters = drum.getCapacityLiters() == null ? BigDecimal.ZERO : drum.getCapacityLiters();
        stockMovementRepository.save(stockMovementMapper.toEntity(
                product,
                null,
                MovementType.DRUM_OPENING,
                StockLocation.OPEN_DRUM,
                openedLiters,
                reason
        ));
    }

    public List<StockMovement> findSaleExitMovementsBySaleId(Long saleId) {
        return stockMovementRepository.findBySaleIdOrderByMovementDateAscIdAsc(saleId)
                .stream()
                .filter(movement -> movement.getMovementType() == MovementType.SALE_EXIT)
                .toList();
    }

    private void applyStockAdjustment(Product product, StockLocation location, BigDecimal delta) {
        if (!product.isTracksStock()) {
            throw new BusinessRuleException("El producto '" + product.getName() + "' no controla stock.");
        }
        int deltaUnits = toIntegerUnits(delta, product);
        String locationLabel = location == StockLocation.LOCAL ? LOCAL_LABEL : WAREHOUSE_LABEL;
        int currentStock = location == StockLocation.LOCAL ? product.getLocalStock() : product.getWarehouseStock();
        long newStock = (long) currentStock + deltaUnits;
        if (newStock < 0) {
            throw new BusinessRuleException("El ajuste dejaría el stock "
                    + locationLabel
                    + " de '"
                    + product.getName()
                    + "' en negativo. Disponible: "
                    + currentStock
                    + ", ajuste: "
                    + deltaUnits
                    + ".");
        }
        validateStockRange(newStock, locationLabel, product);
        if (location == StockLocation.LOCAL) {
            product.setLocalStock((int) newStock);
        } else {
            product.setWarehouseStock((int) newStock);
        }
        productRepository.save(product);
    }

    private void applyDrumAdjustment(Product product, BigDecimal delta) {
        OilDrum drum = oilDrumRepository
                .findByProductIdAndStatusForUpdate(product.getId(), DrumStatus.OPEN)
                .stream()
                .findFirst()
                .orElseThrow(() -> new BusinessRuleException(
                        "No hay un tambor abierto para el producto '" + product.getName() + "'."
                ));
        BigDecimal currentLiters = drum.getRemainingLiters() == null ? BigDecimal.ZERO : drum.getRemainingLiters();
        BigDecimal newLiters = StockMovementMapper.normalizeQuantity(currentLiters.add(delta));
        if (newLiters.compareTo(BigDecimal.ZERO) < 0) {
            throw new BusinessRuleException("El ajuste dejaría el tambor de '"
                    + product.getName()
                    + "' en negativo. Disponible: "
                    + formatLiters(currentLiters)
                    + " L, ajuste: "
                    + formatLiters(delta)
                    + " L.");
        }
        if (drum.getCapacityLiters() != null && newLiters.compareTo(drum.getCapacityLiters()) > 0) {
            throw new BusinessRuleException("El ajuste supera la capacidad del tambor de '"
                    + product.getName()
                    + "' ("
                    + formatLiters(drum.getCapacityLiters())
                    + " L). Litros resultantes: "
                    + formatLiters(newLiters)
                    + " L.");
        }
        drum.setRemainingLiters(newLiters);
        oilDrumRepository.save(drum);
    }

    private Product findProductForUpdate(Long productId) {
        return productRepository.findByIdForUpdate(productId)
                .orElseThrow(() -> new ResourceNotFoundException("No existe el producto con id " + productId + "."));
    }

    private int toIntegerUnits(BigDecimal delta, Product product) {
        if (delta.stripTrailingZeros().scale() > 0) {
            throw new BusinessRuleException("El ajuste del producto '"
                    + product.getName()
                    + "' debe ser un número entero.");
        }
        try {
            return delta.intValueExact();
        } catch (ArithmeticException exception) {
            throw new BusinessRuleException("El ajuste del producto '"
                    + product.getName()
                    + "' es demasiado grande.");
        }
    }

    private void validateStockRange(long stock, String locationLabel, Product product) {
        if (stock > Integer.MAX_VALUE) {
            throw new BusinessRuleException("El stock "
                    + locationLabel
                    + " de '"
                    + product.getName()
                    + "' supera el máximo permitido.");
        }
    }

    private String requireReason(String reason) {
        String normalized = StockMovementMapper.normalizeReason(reason);
        if (normalized == null) {
            throw new BusinessRuleException("El motivo del ajuste es obligatorio.");
        }
        return normalized;
    }

    private String buildDefaultReason(String reason, String defaultReason) {
        String normalized = StockMovementMapper.normalizeReason(reason);
        return normalized == null ? defaultReason : normalized;
    }

    private String formatLiters(BigDecimal liters) {
        return liters.setScale(2, RoundingMode.HALF_UP).toPlainString();
    }
}

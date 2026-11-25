package com.lubricentromp.api.service;

import com.lubricentromp.api.dto.SaleCancellationResponse;
import com.lubricentromp.api.dto.SaleDetailRequest;
import com.lubricentromp.api.dto.SalePaymentRequest;
import com.lubricentromp.api.dto.SaleRequest;
import com.lubricentromp.api.dto.SaleResponse;
import com.lubricentromp.api.dto.StockMovementResponse;
import com.lubricentromp.api.entity.OilDrum;
import com.lubricentromp.api.entity.Product;
import com.lubricentromp.api.entity.Sale;
import com.lubricentromp.api.entity.SaleDetail;
import com.lubricentromp.api.entity.SalePayment;
import com.lubricentromp.api.entity.StockMovement;
import com.lubricentromp.api.entity.Vehicle;
// La entidad VehicleService convive con el servicio VehicleService de la Etapa 2; este import apunta a la entidad.
import com.lubricentromp.api.entity.VehicleService;
import com.lubricentromp.api.enums.DrumStatus;
import com.lubricentromp.api.enums.OperationType;
import com.lubricentromp.api.enums.SaleStatus;
import com.lubricentromp.api.enums.StockLocation;
import com.lubricentromp.api.exception.BusinessRuleException;
import com.lubricentromp.api.exception.ResourceNotFoundException;
import com.lubricentromp.api.mapper.SaleMapper;
import com.lubricentromp.api.repository.OilDrumRepository;
import com.lubricentromp.api.repository.ProductRepository;
import com.lubricentromp.api.repository.SaleDetailRepository;
import com.lubricentromp.api.repository.SalePaymentRepository;
import com.lubricentromp.api.repository.SaleRepository;
import com.lubricentromp.api.repository.VehicleRepository;
import com.lubricentromp.api.repository.VehicleServiceRepository;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class SaleService {

    private static final String DRUM_CATEGORY_NAME = "Aceite Tambor";
    private static final int DESCRIPTION_MAX_LENGTH = 255;
    private static final int NOTES_MAX_LENGTH = 255;

    private final SaleRepository saleRepository;
    private final VehicleServiceRepository vehicleServiceRepository;
    private final SaleDetailRepository saleDetailRepository;
    private final SalePaymentRepository salePaymentRepository;
    private final ProductRepository productRepository;
    private final OilDrumRepository oilDrumRepository;
    private final VehicleRepository vehicleRepository;
    private final StockMovementService stockMovementService;
    private final SaleMapper saleMapper;

    public SaleService(
            SaleRepository saleRepository,
            VehicleServiceRepository vehicleServiceRepository,
            SaleDetailRepository saleDetailRepository,
            SalePaymentRepository salePaymentRepository,
            ProductRepository productRepository,
            OilDrumRepository oilDrumRepository,
            VehicleRepository vehicleRepository,
            StockMovementService stockMovementService,
            SaleMapper saleMapper
    ) {
        this.saleRepository = saleRepository;
        this.vehicleServiceRepository = vehicleServiceRepository;
        this.saleDetailRepository = saleDetailRepository;
        this.salePaymentRepository = salePaymentRepository;
        this.productRepository = productRepository;
        this.oilDrumRepository = oilDrumRepository;
        this.vehicleRepository = vehicleRepository;
        this.stockMovementService = stockMovementService;
        this.saleMapper = saleMapper;
    }

    @Transactional
    public SaleResponse createSale(SaleRequest request) {
        validateRequest(request);
        Vehicle vehicle = resolveVehicle(request);
        validatePayments(request);

        Sale sale = saleMapper.toEntity(request);
        List<SaleDetail> details = new ArrayList<>();
        List<PendingMovement> pendingMovements = new ArrayList<>();
        BigDecimal calculatedSubtotal = BigDecimal.ZERO;

        for (SaleDetailRequest item : request.items()) {
            ResolvedItem resolvedItem = resolveItem(sale, item);
            details.add(resolvedItem.detail());
            if (resolvedItem.movement() != null) {
                pendingMovements.add(resolvedItem.movement());
            }
            calculatedSubtotal = calculatedSubtotal.add(resolvedItem.subtotal());
        }

        sale.setCalculatedSubtotal(SaleMapper.normalizeMoney(calculatedSubtotal));
        sale = saleRepository.save(sale);

        List<SaleDetail> savedDetails = new ArrayList<>();
        for (SaleDetail detail : details) {
            savedDetails.add(saleDetailRepository.save(detail));
        }

        List<SalePayment> savedPayments = new ArrayList<>();
        for (SalePaymentRequest paymentRequest : request.payments()) {
            savedPayments.add(salePaymentRepository.save(saleMapper.toPaymentEntity(sale, paymentRequest)));
        }

        VehicleService vehicleService = null;
        if (request.operationType() == OperationType.SERVICE) {
            vehicleService = saleMapper.toVehicleServiceEntity(sale, vehicle, request.vehicleService());
            vehicleService = vehicleServiceRepository.save(vehicleService);
        }

        registerSaleExits(sale, pendingMovements);

        return saleMapper.toResponse(sale, vehicleService, savedDetails, savedPayments);
    }

    @Transactional
    public SaleCancellationResponse cancelSale(Long saleId, String reason) {
        if (saleId == null) {
            throw new BusinessRuleException("El id de la venta es obligatorio.");
        }
        Sale sale = saleRepository.findByIdForUpdate(saleId)
                .orElseThrow(() -> new ResourceNotFoundException("No existe la venta con id " + saleId + "."));
        if (sale.getStatus() == SaleStatus.CANCELLED) {
            throw new BusinessRuleException("La venta #" + saleId + " ya está anulada.");
        }
        String cancellationReason = buildCancellationReason(saleId, reason);

        List<StockMovementResponse> movements = new ArrayList<>();
        for (Reversal reversal : resolveReversals(sale)) {
            Product product = productRepository.findByIdForUpdate(reversal.productId())
                    .orElseThrow(() -> new ResourceNotFoundException(
                            "No existe el producto con id " + reversal.productId() + "."
                    ));
            if (reversal.location() == StockLocation.OPEN_DRUM) {
                restoreDrumLiters(product, reversal.quantity(), saleId);
            } else {
                restoreLocalStock(product, reversal.quantity());
            }
            movements.add(stockMovementService.registerSaleCancellation(
                    product,
                    sale,
                    reversal.location(),
                    reversal.quantity(),
                    cancellationReason
            ));
        }

        sale.setStatus(SaleStatus.CANCELLED);
        saleRepository.save(sale);

        return new SaleCancellationResponse(
                sale.getId(),
                sale.getStatus(),
                sale.getOperationDate(),
                SaleMapper.normalizeMoney(sale.getTotalCharged()),
                cancellationReason,
                movements
        );
    }

    public SaleResponse getSaleById(Long id) {
        Sale sale = saleRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("No existe la venta con id " + id + "."));
        List<SaleDetail> details = saleDetailRepository.findBySaleIdOrderByIdAsc(id);
        List<SalePayment> payments = salePaymentRepository.findBySaleIdOrderByIdAsc(id);
        VehicleService vehicleService = vehicleServiceRepository.findBySaleIdWithVehicle(id).orElse(null);
        return saleMapper.toResponse(sale, vehicleService, details, payments);
    }

    public List<SaleResponse> getServiceHistoryByVehicleId(Long vehicleId) {
        if (!vehicleRepository.existsById(vehicleId)) {
            throw new ResourceNotFoundException("No existe el vehículo con id " + vehicleId + ".");
        }
        return vehicleServiceRepository.findHistoryByVehicleId(vehicleId)
                .stream()
                .map(vehicleService -> {
                    Sale sale = vehicleService.getSale();
                    List<SaleDetail> details = saleDetailRepository.findBySaleIdOrderByIdAsc(sale.getId());
                    List<SalePayment> payments = salePaymentRepository.findBySaleIdOrderByIdAsc(sale.getId());
                    return saleMapper.toResponse(sale, vehicleService, details, payments);
                })
                .toList();
    }

    private void validateRequest(SaleRequest request) {
        if (request == null) {
            throw new BusinessRuleException("La solicitud de venta es obligatoria.");
        }
        if (request.shift() == null) {
            throw new BusinessRuleException("El turno es obligatorio.");
        }
        if (request.operationType() == null) {
            throw new BusinessRuleException("El tipo de operación es obligatorio.");
        }
        if (request.totalCharged() == null || request.totalCharged().signum() < 0) {
            throw new BusinessRuleException("El total cobrado es obligatorio y no puede ser negativo.");
        }
        if (request.items() == null || request.items().isEmpty()) {
            throw new BusinessRuleException("La venta debe incluir al menos un ítem.");
        }
        if (request.payments() == null || request.payments().isEmpty()) {
            throw new BusinessRuleException("La venta debe incluir al menos un pago.");
        }
    }

    private Vehicle resolveVehicle(SaleRequest request) {
        if (request.operationType() == OperationType.SERVICE) {
            if (request.vehicleService() == null || request.vehicleService().vehicleId() == null) {
                throw new BusinessRuleException("Las operaciones de tipo SERVICE requieren los datos del vehículo.");
            }
            if (request.vehicleService().mileage() != null && request.vehicleService().mileage() < 0) {
                throw new BusinessRuleException("El kilometraje no puede ser negativo.");
            }
            return vehicleRepository.findById(request.vehicleService().vehicleId())
                    .orElseThrow(() -> new ResourceNotFoundException(
                            "No existe el vehículo con id " + request.vehicleService().vehicleId() + "."
                    ));
        }
        if (request.vehicleService() != null) {
            throw new BusinessRuleException("Las ventas rápidas no deben incluir datos de vehículo.");
        }
        return null;
    }

    private void validatePayments(SaleRequest request) {
        BigDecimal paymentsTotal = BigDecimal.ZERO;
        for (SalePaymentRequest payment : request.payments()) {
            if (payment == null || payment.paymentMethod() == null) {
                throw new BusinessRuleException("Cada pago debe tener un método de pago.");
            }
            if (payment.amount() == null || payment.amount().signum() <= 0) {
                throw new BusinessRuleException("El monto de cada pago debe ser mayor a cero.");
            }
            paymentsTotal = paymentsTotal.add(SaleMapper.normalizeMoney(payment.amount()));
        }
        BigDecimal totalCharged = SaleMapper.normalizeMoney(request.totalCharged());
        BigDecimal normalizedPaymentsTotal = SaleMapper.normalizeMoney(paymentsTotal);
        if (normalizedPaymentsTotal.compareTo(totalCharged) != 0) {
            throw new BusinessRuleException("La suma de los pagos ("
                    + normalizedPaymentsTotal.toPlainString()
                    + ") no coincide con el total cobrado ("
                    + totalCharged.toPlainString()
                    + ").");
        }
    }

    private ResolvedItem resolveItem(Sale sale, SaleDetailRequest item) {
        if (item == null) {
            throw new BusinessRuleException("Los ítems de la venta no pueden ser nulos.");
        }
        if (item.quantity() == null || item.quantity().signum() <= 0) {
            throw new BusinessRuleException("La cantidad de cada ítem debe ser mayor a cero.");
        }
        BigDecimal quantity = SaleMapper.normalizeQuantity(item.quantity());

        if (item.productId() == null) {
            return resolveFreeItem(sale, item, quantity);
        }
        return resolveProductItem(sale, item, quantity);
    }

    private ResolvedItem resolveFreeItem(Sale sale, SaleDetailRequest item, BigDecimal quantity) {
        String description = SaleMapper.normalizeNullable(item.customDescription());
        if (description == null) {
            throw new BusinessRuleException("Los ítems sin producto requieren una descripción.");
        }
        if (item.customUnitPrice() == null) {
            throw new BusinessRuleException("Los ítems sin producto requieren un precio unitario.");
        }
        BigDecimal unitPrice = SaleMapper.normalizeMoney(item.customUnitPrice());
        if (unitPrice.signum() < 0) {
            throw new BusinessRuleException("El precio unitario no puede ser negativo.");
        }
        return buildResolvedItem(sale, null, description, quantity, unitPrice, null);
    }

    private ResolvedItem resolveProductItem(Sale sale, SaleDetailRequest item, BigDecimal quantity) {
        Product product = productRepository.findByIdForUpdate(item.productId())
                .orElseThrow(() -> new ResourceNotFoundException(
                        "No existe el producto con id " + item.productId() + "."
                ));
        if (!product.isActive()) {
            throw new BusinessRuleException("El producto '" + product.getName() + "' está inactivo.");
        }

        BigDecimal unitPrice = item.customUnitPrice() != null
                ? SaleMapper.normalizeMoney(item.customUnitPrice())
                : SaleMapper.normalizeMoney(product.getListPrice());
        if (unitPrice == null || unitPrice.signum() < 0) {
            throw new BusinessRuleException("El producto '" + product.getName() + "' no tiene un precio válido.");
        }

        PendingMovement movement = null;
        if (product.isTracksStock()) {
            if (isDrumProduct(product)) {
                applyDrumDiscount(product, quantity);
                movement = new PendingMovement(product, StockLocation.OPEN_DRUM, quantity);
            } else {
                applyLocalStockDiscount(product, quantity);
                movement = new PendingMovement(product, StockLocation.LOCAL, quantity);
            }
        }

        return buildResolvedItem(
                sale,
                product,
                buildDescription(product),
                quantity,
                unitPrice,
                movement
        );
    }

    private ResolvedItem buildResolvedItem(
            Sale sale,
            Product product,
            String description,
            BigDecimal quantity,
            BigDecimal unitPrice,
            PendingMovement movement
    ) {
        if (description.length() > DESCRIPTION_MAX_LENGTH) {
            throw new BusinessRuleException(
                    "La descripción del ítem no puede superar los " + DESCRIPTION_MAX_LENGTH + " caracteres."
            );
        }
        SaleDetail detail = saleMapper.toDetailEntity(sale, product, description, quantity, unitPrice);
        BigDecimal subtotal = SaleMapper.normalizeMoney(quantity.multiply(unitPrice));
        return new ResolvedItem(detail, subtotal, movement);
    }

    private String buildDescription(Product product) {
        String code = SaleMapper.normalizeNullable(product.getCode());
        String name = product.getName() == null ? "" : product.getName().trim();
        return code == null ? name : code + " - " + name;
    }

    private boolean isDrumProduct(Product product) {
        return DRUM_CATEGORY_NAME.equalsIgnoreCase(product.getCategory().getName())
                || oilDrumRepository.existsByProductId(product.getId());
    }

    private void applyDrumDiscount(Product product, BigDecimal quantity) {
        List<OilDrum> openDrums = oilDrumRepository.findByProductIdAndStatusForUpdate(
                product.getId(),
                DrumStatus.OPEN
        );
        OilDrum drum = openDrums.stream()
                .findFirst()
                .orElseThrow(() -> new BusinessRuleException(
                        "No hay un tambor abierto para el producto '" + product.getName() + "'."
                ));
        BigDecimal remaining = drum.getRemainingLiters() == null ? BigDecimal.ZERO : drum.getRemainingLiters();
        if (remaining.compareTo(quantity) < 0) {
            throw new BusinessRuleException("No hay litros suficientes en el tambor de '"
                    + product.getName()
                    + "'. Disponible: "
                    + remaining.setScale(2, RoundingMode.HALF_UP).toPlainString()
                    + " L, solicitado: "
                    + quantity.toPlainString()
                    + " L.");
        }
        drum.setRemainingLiters(SaleMapper.normalizeMoney(remaining.subtract(quantity)));
        oilDrumRepository.save(drum);
    }

    private void applyLocalStockDiscount(Product product, BigDecimal quantity) {
        if (quantity.stripTrailingZeros().scale() > 0) {
            throw new BusinessRuleException("La cantidad del producto '"
                    + product.getName()
                    + "' debe ser un número entero.");
        }
        int requestedQuantity;
        try {
            requestedQuantity = quantity.intValueExact();
        } catch (ArithmeticException exception) {
            throw new BusinessRuleException("La cantidad del producto '"
                    + product.getName()
                    + "' es demasiado grande.");
        }
        if (product.getLocalStock() < requestedQuantity) {
            throw new BusinessRuleException("No hay stock local suficiente para '"
                    + product.getName()
                    + "'. Disponible: "
                    + product.getLocalStock()
                    + ", solicitado: "
                    + requestedQuantity
                    + ".");
        }
        product.setLocalStock(product.getLocalStock() - requestedQuantity);
        productRepository.save(product);
    }

    private void registerSaleExits(Sale sale, List<PendingMovement> pendingMovements) {
        for (PendingMovement pendingMovement : pendingMovements) {
            stockMovementService.registerSaleExit(
                    pendingMovement.product(),
                    sale,
                    pendingMovement.location(),
                    pendingMovement.quantity(),
                    "Salida por venta #" + sale.getId() + "."
            );
        }
    }

    private List<Reversal> resolveReversals(Sale sale) {
        List<StockMovement> exits = stockMovementService.findSaleExitMovementsBySaleId(sale.getId());
        if (!exits.isEmpty()) {
            return exits.stream()
                    .map(movement -> new Reversal(
                            movement.getProduct().getId(),
                            movement.getLocation(),
                            SaleMapper.normalizeQuantity(movement.getQuantity()).abs()
                    ))
                    .toList();
        }
        return buildReversalsFromDetails(sale);
    }

    private List<Reversal> buildReversalsFromDetails(Sale sale) {
        List<Reversal> reversals = new ArrayList<>();
        for (SaleDetail detail : saleDetailRepository.findBySaleIdOrderByIdAsc(sale.getId())) {
            Product product = detail.getProduct();
            if (product == null || !product.isTracksStock()) {
                continue;
            }
            StockLocation location = isDrumProduct(product) ? StockLocation.OPEN_DRUM : StockLocation.LOCAL;
            reversals.add(new Reversal(
                    product.getId(),
                    location,
                    SaleMapper.normalizeQuantity(detail.getQuantity())
            ));
        }
        return reversals;
    }

    private void restoreLocalStock(Product product, BigDecimal quantity) {
        if (quantity.stripTrailingZeros().scale() > 0) {
            throw new BusinessRuleException("La cantidad a devolver del producto '"
                    + product.getName()
                    + "' debe ser un número entero.");
        }
        int units;
        try {
            units = quantity.intValueExact();
        } catch (ArithmeticException exception) {
            throw new BusinessRuleException("La cantidad a devolver del producto '"
                    + product.getName()
                    + "' es demasiado grande.");
        }
        long newStock = (long) product.getLocalStock() + units;
        if (newStock > Integer.MAX_VALUE) {
            throw new BusinessRuleException("Devolver " + units + " unidad(es) de '"
                    + product.getName()
                    + "' supera el stock máximo permitido.");
        }
        product.setLocalStock((int) newStock);
        productRepository.save(product);
    }

    private void restoreDrumLiters(Product product, BigDecimal liters, Long saleId) {
        List<OilDrum> openDrums = oilDrumRepository.findByProductIdAndStatusForUpdate(
                product.getId(),
                DrumStatus.OPEN
        );
        OilDrum drum;
        if (!openDrums.isEmpty()) {
            drum = openDrums.get(0);
        } else {
            drum = oilDrumRepository.findLatestByProductIdAndStatusForUpdate(product.getId(), DrumStatus.EMPTY)
                    .stream()
                    .findFirst()
                    .orElseThrow(() -> new BusinessRuleException(
                            "No hay un tambor abierto ni cerrado para devolver "
                                    + formatLiters(liters)
                                    + " L del producto '"
                                    + product.getName()
                                    + "'."
                    ));
            drum.setStatus(DrumStatus.OPEN);
            drum.setNotes(appendCancellationNote(drum.getNotes(), saleId));
        }
        BigDecimal current = drum.getRemainingLiters() == null ? BigDecimal.ZERO : drum.getRemainingLiters();
        BigDecimal newRemaining = SaleMapper.normalizeMoney(current.add(liters));
        if (drum.getCapacityLiters() != null && newRemaining.compareTo(drum.getCapacityLiters()) > 0) {
            throw new BusinessRuleException("No se pueden devolver "
                    + formatLiters(liters)
                    + " L al tambor de '"
                    + product.getName()
                    + "': supera la capacidad de "
                    + formatLiters(drum.getCapacityLiters())
                    + " L.");
        }
        drum.setRemainingLiters(newRemaining);
        oilDrumRepository.save(drum);
    }

    private String appendCancellationNote(String notes, Long saleId) {
        String note = "Reabierto por anulación de venta #" + saleId + ".";
        String combined = notes == null || notes.isBlank() ? note : notes + " | " + note;
        return combined.length() <= NOTES_MAX_LENGTH ? combined : combined.substring(0, NOTES_MAX_LENGTH);
    }

    private String buildCancellationReason(Long saleId, String reason) {
        String normalized = SaleMapper.normalizeNullable(reason);
        if (normalized == null) {
            return "Anulación de venta #" + saleId + ".";
        }
        return normalized.length() <= NOTES_MAX_LENGTH
                ? normalized
                : normalized.substring(0, NOTES_MAX_LENGTH);
    }

    private String formatLiters(BigDecimal liters) {
        return liters.setScale(2, RoundingMode.HALF_UP).toPlainString();
    }

    private record ResolvedItem(SaleDetail detail, BigDecimal subtotal, PendingMovement movement) {
    }

    private record PendingMovement(Product product, StockLocation location, BigDecimal quantity) {
    }

    private record Reversal(Long productId, StockLocation location, BigDecimal quantity) {
    }
}

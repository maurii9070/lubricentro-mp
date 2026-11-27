import { useEffect, useMemo, useState } from 'react';

import { Button } from '@/components/ui/button';
import { Tabs, TabsList, TabsTrigger } from '@/components/ui/tabs';

import { CartItemsTable } from '@/components/pos/CartItemsTable';
import { PaymentSummaryCard } from '@/components/pos/PaymentSummaryCard';
import { ReviewSaleDialog } from '@/components/pos/ReviewSaleDialog';
import { ProductSearchBox } from '@/components/pos/ProductSearchBox';
import { ReceiptDialog } from '@/components/pos/ReceiptDialog';
import { VehicleServicePanel } from '@/components/pos/VehicleServicePanel';
import { listOpenOilDrums } from '@/api/oilDrumApi';
import { createSale } from '@/api/saleApi';
import { useAppStore } from '@/store/useAppStore';
import { usePosStore } from '@/store/usePosStore';
import { toast } from 'sonner';

import type { OilDrumResponse } from '@/types/oilDrum';
import type { ProductResponse } from '@/types/product';
import type { SaleResponse } from '@/types/sale';

export function PosPage() {
  const operationType = usePosStore((state) => state.operationType);
  const operationDate = usePosStore((state) => state.operationDate);
  const items = usePosStore((state) => state.items);
  const selectedVehicle = usePosStore((state) => state.selectedVehicle);
  const mileage = usePosStore((state) => state.mileage);
  const technicalNotes = usePosStore((state) => state.technicalNotes);
  const totalCharged = usePosStore((state) => state.totalCharged);
  const isTotalOverridden = usePosStore((state) => state.isTotalOverridden);
  const payments = usePosStore((state) => state.payments);

  const setOperationType = usePosStore((state) => state.setOperationType);
  const setOperationDate = usePosStore((state) => state.setOperationDate);
  const addItem = usePosStore((state) => state.addItem);
  const removeItem = usePosStore((state) => state.removeItem);
  const updateItemQuantity = usePosStore((state) => state.updateItemQuantity);
  const updateItemUnitPrice = usePosStore((state) => state.updateItemUnitPrice);
  const setSelectedVehicle = usePosStore((state) => state.setSelectedVehicle);
  const setMileage = usePosStore((state) => state.setMileage);
  const setTechnicalNotes = usePosStore((state) => state.setTechnicalNotes);
  const setTotalCharged = usePosStore((state) => state.setTotalCharged);
  const resetTotalCharged = usePosStore((state) => state.resetTotalCharged);
  const addPayment = usePosStore((state) => state.addPayment);
  const removePayment = usePosStore((state) => state.removePayment);
  const updatePayment = usePosStore((state) => state.updatePayment);
  const completeBalance = usePosStore((state) => state.completeBalance);
  const resetPos = usePosStore((state) => state.resetPos);

  const currentShift = useAppStore((state) => state.currentShift);
  const setCurrentShift = useAppStore((state) => state.setCurrentShift);

  const [openDrums, setOpenDrums] = useState<OilDrumResponse[]>([]);
  const [confirming, setConfirming] = useState(false);
  const [reviewOpen, setReviewOpen] = useState(false);
  const [receiptSale, setReceiptSale] = useState<SaleResponse | null>(null);
  const [receiptOpen, setReceiptOpen] = useState(false);

  useEffect(() => {
    void listOpenOilDrums()
      .then(setOpenDrums)
      .catch(() => {
        /* ignore */
      });
  }, []);

  const openDrumsByProduct = useMemo(() => {
    const map = new Map<number, number>();
    for (const drum of openDrums) {
      map.set(drum.productId, (map.get(drum.productId) ?? 0) + drum.remainingLiters);
    }
    return map;
  }, [openDrums]);

  const subtotal = useMemo(
    () => items.reduce((accumulator, item) => accumulator + item.quantity * item.unitPrice, 0),
    [items]
  );

  function handleAddProduct(product: ProductResponse) {
    const isDrumOil = product.categoryName === 'Aceite Tambor';
    addItem({
      productId: product.id,
      description: `${product.code} - ${product.name}`,
      isDrumOil,
      drumRemainingLiters: isDrumOil ? (openDrumsByProduct.get(product.id) ?? null) : null,
      quantity: 1,
      unitPrice: product.listPrice,
      isManual: false,
    });
  }

  function handleAddManualItem(description: string, unitPrice: number) {
    addItem({
      productId: null,
      description,
      isDrumOil: false,
      drumRemainingLiters: null,
      quantity: 1,
      unitPrice,
      isManual: true,
    });
  }

  function handleConfirm() {
    if (items.length === 0) {
      toast.error('Agregá al menos un ítem.');
      return;
    }
    if (operationType === 'SERVICE' && !selectedVehicle) {
      toast.error('Seleccioná un vehículo.');
      return;
    }
    const paymentsTotal = payments.reduce((accumulator, payment) => accumulator + payment.amount, 0);
    if (Math.abs(paymentsTotal - totalCharged) > 0.005) {
      toast.error('Los pagos no coinciden con el total cobrado.');
      return;
    }
    setReviewOpen(true);
  }

  async function handleConfirmSubmit() {
    setConfirming(true);
    try {
      const sale = await createSale({
        operationDate: operationDate || null,
        shift: currentShift,
        operationType,
        totalCharged,
        notes: null,
        vehicleService:
          operationType === 'SERVICE' && selectedVehicle
            ? {
                vehicleId: selectedVehicle.id,
                mileage,
                technicalNotes: technicalNotes.trim() || null,
              }
            : null,
        items: items.map((item) => ({
          productId: item.productId,
          customDescription: item.productId == null ? item.description : null,
          quantity: item.quantity,
          customUnitPrice: item.unitPrice,
        })),
        payments: payments.map((payment) => ({
          paymentMethod: payment.paymentMethod,
          amount: payment.amount,
        })),
      });
      toast.success('Operación registrada correctamente.');
      setReviewOpen(false);
      setReceiptSale(sale);
      setReceiptOpen(true);
      resetPos();
      void listOpenOilDrums().then(setOpenDrums).catch(() => undefined);
    } catch (error) {
      toast.error(error instanceof Error ? error.message : 'No se pudo registrar la operación.');
    } finally {
      setConfirming(false);
    }
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Mostrador / Ventas</h1>
        <p className="text-sm text-muted-foreground">
          Registro de ventas rápidas y services de vehículos.
        </p>
      </div>

      <div className="flex flex-col gap-4 rounded-lg border bg-background p-4 md:flex-row md:items-center md:justify-between">
        <Tabs value={operationType} onValueChange={(value) => setOperationType(value as 'QUICK_SALE' | 'SERVICE')}>
          <TabsList>
            <TabsTrigger value="QUICK_SALE">Venta Rápida</TabsTrigger>
            <TabsTrigger value="SERVICE">Service de Vehículo</TabsTrigger>
          </TabsList>
        </Tabs>

        <div className="flex flex-col gap-2 sm:flex-row sm:items-center">
          <div className="flex items-center gap-2">
            <span className="text-sm text-muted-foreground">Fecha y hora</span>
            <input
              type="datetime-local"
              value={operationDate}
              onChange={(event) => setOperationDate(event.target.value)}
              className="h-8 rounded-lg border border-input bg-transparent px-2.5 text-sm"
            />
          </div>
          <div className="flex gap-2">
            <Button
              variant={currentShift === 'MORNING' ? 'default' : 'outline'}
              size="sm"
              onClick={() => setCurrentShift('MORNING')}
            >
              Turno Mañana
            </Button>
            <Button
              variant={currentShift === 'AFTERNOON' ? 'default' : 'outline'}
              size="sm"
              onClick={() => setCurrentShift('AFTERNOON')}
            >
              Turno Tarde
            </Button>
          </div>
        </div>
      </div>

      <div className="grid gap-6 lg:grid-cols-[1fr_360px]">
        <div className="space-y-4">
          <ProductSearchBox
            openDrumsByProduct={openDrumsByProduct}
            onAddProduct={handleAddProduct}
            onAddManualItem={handleAddManualItem}
          />

          <CartItemsTable
            items={items}
            onUpdateQuantity={updateItemQuantity}
            onUpdateUnitPrice={updateItemUnitPrice}
            onRemove={removeItem}
          />

          {operationType === 'SERVICE' && (
            <VehicleServicePanel
              selectedVehicle={selectedVehicle}
              onSelectVehicle={setSelectedVehicle}
              mileage={mileage}
              onMileageChange={setMileage}
              technicalNotes={technicalNotes}
              onTechnicalNotesChange={setTechnicalNotes}
            />
          )}
        </div>

        <div className="lg:mt-16">
          <PaymentSummaryCard
          subtotal={subtotal}
          totalCharged={totalCharged}
          isTotalOverridden={isTotalOverridden}
          onTotalChargedChange={setTotalCharged}
          onResetTotal={resetTotalCharged}
          payments={payments}
          onAddPayment={addPayment}
          onRemovePayment={removePayment}
          onUpdatePayment={updatePayment}
          onCompleteBalance={completeBalance}
          itemsCount={items.length}
          isService={operationType === 'SERVICE'}
          hasVehicle={selectedVehicle != null}
          onConfirm={handleConfirm}
          confirming={confirming}
        />
        </div>
      </div>

      <ReviewSaleDialog
        open={reviewOpen}
        onOpenChange={setReviewOpen}
        operationType={operationType}
        shift={currentShift}
        operationDate={operationDate}
        items={items}
        subtotal={subtotal}
        totalCharged={totalCharged}
        payments={payments}
        selectedVehicle={selectedVehicle}
        mileage={mileage}
        technicalNotes={technicalNotes}
        onConfirm={handleConfirmSubmit}
        confirming={confirming}
      />

      <ReceiptDialog
        open={receiptOpen}
        onOpenChange={setReceiptOpen}
        sale={receiptSale}
      />
    </div>
  );
}
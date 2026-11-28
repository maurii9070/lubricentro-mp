import { useEffect, useState } from 'react';

import { Button } from '@/components/ui/button';
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';

import { registerManualAdjustment } from '@/api/stockMovementApi';
import { toast } from 'sonner';

import type { ProductResponse } from '@/types/product';
import type { StockLocation } from '@/types/stockMovement';

interface ManualAdjustmentDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  product: ProductResponse | null;
  onCompleted: () => void;
}

const DRUM_CATEGORY = 'Aceite Tambor';

export function ManualAdjustmentDialog({
  open,
  onOpenChange,
  product,
  onCompleted,
}: ManualAdjustmentDialogProps) {
  const isDrum = product?.categoryName === DRUM_CATEGORY;
  const [location, setLocation] = useState<StockLocation>('LOCAL');
  const [quantityDelta, setQuantityDelta] = useState(0);
  const [reason, setReason] = useState('');
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    if (open) {
      setLocation('LOCAL');
      setQuantityDelta(0);
      setReason('');
    }
  }, [open]);

  async function handleSubmit() {
    if (!product) return;
    if (!reason.trim()) {
      toast.error('El motivo del ajuste es obligatorio.');
      return;
    }
    if (!quantityDelta || quantityDelta === 0) {
      toast.error('El ajuste debe ser distinto de cero.');
      return;
    }
    if (location !== 'OPEN_DRUM' && !Number.isInteger(quantityDelta)) {
      toast.error('El ajuste debe ser un número entero.');
      return;
    }
    setSubmitting(true);
    try {
      await registerManualAdjustment({
        productId: product.id,
        location,
        quantityDelta,
        reason: reason.trim(),
      });
      toast.success('Ajuste manual registrado correctamente.');
      onCompleted();
      onOpenChange(false);
    } catch (error) {
      toast.error(error instanceof Error ? error.message : 'No se pudo registrar el ajuste.');
    } finally {
      setSubmitting(false);
    }
  }

  const step = location === 'OPEN_DRUM' ? 0.01 : 1;

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle>Ajuste manual</DialogTitle>
          <DialogDescription>
            Corregí diferencias de conteo físico para {product?.name ?? 'el producto'}.
            Usá valores positivos para sumar y negativos para restar.
          </DialogDescription>
        </DialogHeader>

        <div className="space-y-4">
          <div className="space-y-2">
            <Label>Ubicación</Label>
            <Select
              value={location}
              onValueChange={(value) => setLocation(value as StockLocation)}
              items={[
                { value: 'LOCAL', label: 'Mostrador' },
                { value: 'WAREHOUSE', label: 'Depósito' },
                ...(isDrum ? [{ value: 'OPEN_DRUM', label: 'Tambor abierto (litros)' }] : []),
              ]}
            >
              <SelectTrigger className="w-full">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="LOCAL">Mostrador</SelectItem>
                <SelectItem value="WAREHOUSE">Depósito</SelectItem>
                {isDrum && <SelectItem value="OPEN_DRUM">Tambor abierto (litros)</SelectItem>}
              </SelectContent>
            </Select>
          </div>

          <div className="space-y-2">
            <Label htmlFor="adjustment-delta">Ajuste *</Label>
            <Input
              id="adjustment-delta"
              type="number"
              step={step}
              value={quantityDelta}
              onChange={(event) => setQuantityDelta(Number(event.target.value))}
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="adjustment-reason">Motivo *</Label>
            <Input
              id="adjustment-reason"
              value={reason}
              onChange={(event) => setReason(event.target.value)}
              placeholder="Ej. Conteo físico, merma, rotura"
            />
          </div>
        </div>

        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)} disabled={submitting}>
            Cancelar
          </Button>
          <Button onClick={handleSubmit} disabled={submitting}>
            {submitting ? 'Registrando...' : 'Registrar ajuste'}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

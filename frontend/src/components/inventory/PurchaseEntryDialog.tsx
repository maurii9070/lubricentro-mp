import { useEffect, useState } from 'react';

import { Button } from '@/components/ui/button';
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';

import { registerPurchaseEntry } from '@/api/stockMovementApi';
import { toast } from 'sonner';

import type { ProductResponse } from '@/types/product';
import type { StockLocation } from '@/types/stockMovement';

interface PurchaseEntryDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  product: ProductResponse | null;
  onCompleted: () => void;
}

export function PurchaseEntryDialog({
  open,
  onOpenChange,
  product,
  onCompleted,
}: PurchaseEntryDialogProps) {
  const [location, setLocation] = useState<StockLocation>('WAREHOUSE');
  const [quantity, setQuantity] = useState(1);
  const [reason, setReason] = useState('');
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    if (open) {
      setLocation('WAREHOUSE');
      setQuantity(1);
      setReason('');
    }
  }, [open]);

  async function handleSubmit() {
    if (!product) return;
    if (!quantity || quantity <= 0) {
      toast.error('La cantidad debe ser mayor a cero.');
      return;
    }
    if (!Number.isInteger(quantity)) {
      toast.error('La cantidad debe ser un número entero.');
      return;
    }
    setSubmitting(true);
    try {
      await registerPurchaseEntry({
        productId: product.id,
        location,
        quantity,
        reason: reason.trim() ? reason.trim() : null,
      });
      toast.success('Ingreso de compra registrado correctamente.');
      onCompleted();
      onOpenChange(false);
    } catch (error) {
      toast.error(error instanceof Error ? error.message : 'No se pudo registrar el ingreso.');
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle>Ingreso de compra</DialogTitle>
          <DialogDescription>
            Sumá mercadería recibida de proveedor para {product?.name ?? 'el producto'}.
          </DialogDescription>
        </DialogHeader>

        <div className="space-y-4">
          <div className="space-y-2">
            <Label>Destino</Label>
            <Select
              value={location}
              onValueChange={(value) => setLocation(value as StockLocation)}
              items={[
                { value: 'LOCAL', label: 'Mostrador' },
                { value: 'WAREHOUSE', label: 'Depósito' },
              ]}
            >
              <SelectTrigger className="w-full">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="LOCAL">Mostrador</SelectItem>
                <SelectItem value="WAREHOUSE">Depósito</SelectItem>
              </SelectContent>
            </Select>
          </div>

          <div className="space-y-2">
            <Label htmlFor="entry-quantity">Cantidad *</Label>
            <Input
              id="entry-quantity"
              type="number"
              min={1}
              step={1}
              value={quantity}
              onChange={(event) => setQuantity(Number(event.target.value))}
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="entry-reason">Motivo / Remito (opcional)</Label>
            <Input
              id="entry-reason"
              value={reason}
              onChange={(event) => setReason(event.target.value)}
              placeholder="Ej. Remito 1234"
            />
          </div>
        </div>

        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)} disabled={submitting}>
            Cancelar
          </Button>
          <Button onClick={handleSubmit} disabled={submitting}>
            {submitting ? 'Registrando...' : 'Registrar ingreso'}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

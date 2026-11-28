import { useEffect, useState } from 'react';

import { Button } from '@/components/ui/button';
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';

import { transferStock } from '@/api/productApi';
import { toast } from 'sonner';

import type { ProductResponse } from '@/types/product';

interface TransferStockDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  product: ProductResponse | null;
  onCompleted: () => void;
}

export function TransferStockDialog({
  open,
  onOpenChange,
  product,
  onCompleted,
}: TransferStockDialogProps) {
  const [quantity, setQuantity] = useState(1);
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    if (open) setQuantity(1);
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
    if (quantity > product.warehouseStock) {
      toast.error('No hay stock suficiente en depósito.');
      return;
    }
    setSubmitting(true);
    try {
      await transferStock(product.id, { quantity });
      toast.success('Traslado realizado correctamente.');
      onCompleted();
      onOpenChange(false);
    } catch (error) {
      toast.error(error instanceof Error ? error.message : 'No se pudo realizar el traslado.');
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle>Traslado depósito → mostrador</DialogTitle>
          <DialogDescription>
            Mover unidades del depósito al mostrador para {product?.name ?? 'el producto'}.
            Disponible en depósito: {product?.warehouseStock ?? 0}.
          </DialogDescription>
        </DialogHeader>

        <div className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="transfer-quantity">Cantidad *</Label>
            <Input
              id="transfer-quantity"
              type="number"
              min={1}
              step={1}
              value={quantity}
              onChange={(event) => setQuantity(Number(event.target.value))}
            />
          </div>
        </div>

        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)} disabled={submitting}>
            Cancelar
          </Button>
          <Button onClick={handleSubmit} disabled={submitting}>
            {submitting ? 'Trasladando...' : 'Trasladar'}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

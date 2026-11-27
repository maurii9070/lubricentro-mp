import { useState } from 'react';

import { Button } from '@/components/ui/button';
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';

import type { ProductResponse } from '@/types/product';
import type { OpenOilDrumRequest } from '@/types/oilDrum';

interface OpenOilDrumDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  products: ProductResponse[];
  onCreate: (request: OpenOilDrumRequest) => Promise<void>;
}

const QUICK_CAPACITIES = [200, 205, 208];

export function OpenOilDrumDialog({
  open,
  onOpenChange,
  products,
  onCreate,
}: OpenOilDrumDialogProps) {
  const [productId, setProductId] = useState<string>('');
  const [capacity, setCapacity] = useState<number>(200);
  const [notes, setNotes] = useState('');
  const [submitting, setSubmitting] = useState(false);

  const availableProducts = products.filter(
    (product) => product.active && product.categoryName === 'Aceite Tambor' && product.localStock >= 1
  );

  async function handleSubmit() {
    if (!productId) {
      return;
    }
    setSubmitting(true);
    try {
      await onCreate({
        productId: Number(productId),
        capacityLiters: capacity,
        notes: notes.trim() || null,
      });
      setProductId('');
      setCapacity(200);
      setNotes('');
      onOpenChange(false);
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle>Abrir tambor nuevo</DialogTitle>
          <DialogDescription>
            Seleccioná el aceite de tambor disponible y la capacidad del tambor.
          </DialogDescription>
        </DialogHeader>

        <div className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="oil-drum-product">Producto</Label>
            <select
              id="oil-drum-product"
              value={productId}
              onChange={(event) => setProductId(event.target.value)}
              className="h-8 w-full rounded-lg border border-input bg-transparent px-2.5 py-1 text-sm"
            >
              <option value="">Seleccioná un aceite de tambor</option>
              {availableProducts.map((product) => (
                <option key={product.id} value={product.id}>
                  {product.name} {product.brand ? `(${product.brand})` : ''} — stock: {product.localStock}
                </option>
              ))}
            </select>
            {availableProducts.length === 0 && (
              <p className="text-xs text-muted-foreground">
                No hay aceites de tambor con stock disponible.
              </p>
            )}
          </div>

          <div className="space-y-2">
            <Label>Capacidad (litros)</Label>
            <div className="flex gap-2">
              {QUICK_CAPACITIES.map((value) => (
                <Button
                  key={value}
                  type="button"
                  variant={capacity === value ? 'default' : 'outline'}
                  size="sm"
                  onClick={() => setCapacity(value)}
                >
                  {value} L
                </Button>
              ))}
            </div>
            <Input
              type="number"
              min={0.01}
              step="0.01"
              value={capacity}
              onChange={(event) => setCapacity(Number(event.target.value))}
              placeholder="Capacidad en litros"
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="oil-drum-notes">Nota (opcional)</Label>
            <Input
              id="oil-drum-notes"
              value={notes}
              onChange={(event) => setNotes(event.target.value)}
              placeholder='Ej. "Tambor nuevo Petronas"'
              maxLength={255}
            />
          </div>
        </div>

        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)} disabled={submitting}>
            Cancelar
          </Button>
          <Button onClick={handleSubmit} disabled={submitting || !productId}>
            {submitting ? 'Abriendo...' : 'Confirmar'}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
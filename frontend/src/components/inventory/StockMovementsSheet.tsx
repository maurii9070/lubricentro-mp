import { useEffect, useState } from 'react';

import { Sheet, SheetContent, SheetDescription, SheetHeader, SheetTitle } from '@/components/ui/sheet';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';

import { getMovementsByProduct } from '@/api/stockMovementApi';
import { toast } from 'sonner';

import type { ProductResponse } from '@/types/product';
import type { StockMovementResponse } from '@/types/stockMovement';

interface StockMovementsSheetProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  product: ProductResponse | null;
}

const movementLabels: Record<string, string> = {
  PURCHASE_ENTRY: 'Compra',
  LOCAL_TRANSFER: 'Traslado',
  DRUM_OPENING: 'Apertura Tambor',
  SALE_EXIT: 'Venta',
  MANUAL_ADJUSTMENT: 'Ajuste Manual',
  SALE_CANCELLATION: 'Anulación',
};

const locationLabels: Record<string, string> = {
  LOCAL: 'Mostrador',
  WAREHOUSE: 'Depósito',
  OPEN_DRUM: 'Tambor Abierto',
};

function formatDate(value: string): string {
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return value;
  return date.toLocaleString('es-AR', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
  });
}

function formatQuantity(value: number, location: string): string {
  const isDrum = location === 'OPEN_DRUM';
  const decimals = isDrum ? 2 : 0;
  return value.toLocaleString('es-AR', {
    minimumFractionDigits: decimals,
    maximumFractionDigits: decimals,
  });
}

export function StockMovementsSheet({
  open,
  onOpenChange,
  product,
}: StockMovementsSheetProps) {
  const [movements, setMovements] = useState<StockMovementResponse[]>([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (!open || !product) return;
    let active = true;
    setLoading(true);
    void getMovementsByProduct(product.id)
      .then((data) => {
        if (active) setMovements(data);
      })
      .catch((error) => {
        if (active) toast.error(error instanceof Error ? error.message : 'No se pudo cargar el historial.');
      })
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, [open, product]);

  return (
    <Sheet open={open} onOpenChange={onOpenChange}>
      <SheetContent className="sm:max-w-2xl">
        <SheetHeader>
          <SheetTitle>Historial de movimientos</SheetTitle>
          <SheetDescription>
            {product ? `${product.code ?? '-'} — ${product.name}` : 'Producto'}
          </SheetDescription>
        </SheetHeader>

        <div className="flex-1 overflow-auto px-4">
          {loading ? (
            <p className="py-6 text-center text-sm text-muted-foreground">Cargando...</p>
          ) : movements.length === 0 ? (
            <p className="py-6 text-center text-sm text-muted-foreground">
              Sin movimientos registrados.
            </p>
          ) : (
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Fecha</TableHead>
                  <TableHead>Tipo</TableHead>
                  <TableHead>Ubicación</TableHead>
                  <TableHead className="text-right">Cantidad</TableHead>
                  <TableHead>Motivo</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {movements.map((movement) => {
                  const positive = movement.quantity > 0;
                  const negative = movement.quantity < 0;
                  return (
                    <TableRow key={movement.id}>
                      <TableCell className="whitespace-nowrap text-xs">
                        {formatDate(movement.movementDate)}
                      </TableCell>
                      <TableCell className="text-xs">
                        {movementLabels[movement.movementType] ?? movement.movementType}
                      </TableCell>
                      <TableCell className="text-xs">
                        {locationLabels[movement.location] ?? movement.location}
                      </TableCell>
                      <TableCell
                        className={`text-right tabular-nums text-xs font-medium ${
                          positive ? 'text-emerald-600' : negative ? 'text-destructive' : ''
                        }`}
                      >
                        {positive ? '+' : ''}
                        {formatQuantity(movement.quantity, movement.location)}
                      </TableCell>
                      <TableCell className="max-w-[200px] truncate text-xs text-muted-foreground">
                        {movement.reason ?? '-'}
                      </TableCell>
                    </TableRow>
                  );
                })}
              </TableBody>
            </Table>
          )}
        </div>
      </SheetContent>
    </Sheet>
  );
}

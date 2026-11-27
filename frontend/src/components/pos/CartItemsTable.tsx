import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';

import type { PosCartItem } from '@/store/usePosStore';

interface CartItemsTableProps {
  items: PosCartItem[];
  onUpdateQuantity: (key: string, quantity: number) => void;
  onUpdateUnitPrice: (key: string, unitPrice: number) => void;
  onRemove: (key: string) => void;
}

const currencyFormatter = new Intl.NumberFormat('es-AR', {
  style: 'currency',
  currency: 'ARS',
});

export function CartItemsTable({
  items,
  onUpdateQuantity,
  onUpdateUnitPrice,
  onRemove,
}: CartItemsTableProps) {
  if (items.length === 0) {
    return (
      <div className="rounded-lg border border-dashed p-6 text-center text-sm text-muted-foreground">
        No hay ítems en el carrito. Buscá un producto o agregá un ítem libre.
      </div>
    );
  }

  return (
    <Table>
      <TableHeader>
        <TableRow>
          <TableHead>Ítem</TableHead>
          <TableHead className="w-24 text-right">Cantidad</TableHead>
          <TableHead className="w-28 text-right">Precio unit.</TableHead>
          <TableHead className="w-24 text-right">Subtotal</TableHead>
          <TableHead className="w-12" />
        </TableRow>
      </TableHeader>
      <TableBody>
        {items.map((item) => {
          const subtotal = item.quantity * item.unitPrice;
          return (
            <TableRow key={item.key}>
              <TableCell>
                <div className="flex flex-col">
                  <span className="font-medium">{item.description}</span>
                  {item.isDrumOil && item.drumRemainingLiters != null && (
                    <span className="text-xs text-muted-foreground">
                      Tambor abierto: {item.drumRemainingLiters} L
                    </span>
                  )}
                </div>
              </TableCell>
              <TableCell className="text-right">
                <Input
                  type="number"
                  min={item.isDrumOil ? 0.1 : 1}
                  step={item.isDrumOil ? '0.1' : '1'}
                  inputMode={item.isDrumOil ? 'decimal' : 'numeric'}
                  value={item.quantity}
                  onChange={(event) =>
                    onUpdateQuantity(item.key, Number(event.target.value))
                  }
                  className="h-7 w-20 text-right"
                />
              </TableCell>
              <TableCell className="text-right">
                <Input
                  type="number"
                  min={0}
                  step="0.01"
                  value={item.unitPrice}
                  onChange={(event) =>
                    onUpdateUnitPrice(item.key, Number(event.target.value))
                  }
                  className="h-7 w-24 text-right"
                />
              </TableCell>
              <TableCell className="text-right tabular-nums">
                {currencyFormatter.format(subtotal)}
              </TableCell>
              <TableCell>
                <Button
                  variant="ghost"
                  size="icon-sm"
                  onClick={() => onRemove(item.key)}
                  aria-label="Quitar ítem"
                >
                  ✕
                </Button>
              </TableCell>
            </TableRow>
          );
        })}
      </TableBody>
    </Table>
  );
}
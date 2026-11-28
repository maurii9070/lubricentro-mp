import { Tooltip, TooltipContent, TooltipTrigger } from '@/components/ui/tooltip';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';

import {
  ArrowRightLeft,
  History,
  Pencil,
  Plus,
  SlidersHorizontal,
} from 'lucide-react';

import type { ProductResponse } from '@/types/product';

interface InventoryTableProps {
  products: ProductResponse[];
  onPurchase: (product: ProductResponse) => void;
  onTransfer: (product: ProductResponse) => void;
  onAdjust: (product: ProductResponse) => void;
  onEdit: (product: ProductResponse) => void;
  onHistory: (product: ProductResponse) => void;
}

const currencyFormatter = new Intl.NumberFormat('es-AR', {
  style: 'currency',
  currency: 'ARS',
});

function stockStatus(total: number, minStock: number): 'empty' | 'low' | 'ok' {
  if (total === 0) return 'empty';
  if (total <= minStock) return 'low';
  return 'ok';
}

function stockColor(status: 'empty' | 'low' | 'ok'): string {
  if (status === 'empty') return 'text-destructive';
  if (status === 'low') return 'text-amber-600';
  return 'text-foreground';
}

export function InventoryTable({
  products,
  onPurchase,
  onTransfer,
  onAdjust,
  onEdit,
  onHistory,
}: InventoryTableProps) {
  return (
    <div className="rounded-md border">
      <Table>
        <TableHeader>
          <TableRow>
            <TableHead>Código</TableHead>
            <TableHead>Producto / Marca</TableHead>
            <TableHead>Categoría</TableHead>
            <TableHead className="text-right">Mostrador</TableHead>
            <TableHead className="text-right">Depósito</TableHead>
            <TableHead className="text-right">Precio Lista</TableHead>
            <TableHead className="text-right">Acciones</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {products.length === 0 ? (
            <TableRow>
              <TableCell colSpan={7} className="py-8 text-center text-sm text-muted-foreground">
                Sin productos para mostrar.
              </TableCell>
            </TableRow>
          ) : (
            products.map((product) => {
              const total = product.localStock + product.warehouseStock;
              const status = stockStatus(total, product.minStock);
              const color = stockColor(status);
              return (
                <TableRow key={product.id}>
                  <TableCell>
                    {product.code ? (
                      <Badge variant="outline" className="font-mono text-xs">
                        {product.code}
                      </Badge>
                    ) : (
                      <span className="text-muted-foreground">-</span>
                    )}
                  </TableCell>
                  <TableCell>
                    <div className="flex flex-col">
                      <span className="font-medium">{product.name}</span>
                      {product.brand && (
                        <span className="text-xs text-muted-foreground">{product.brand}</span>
                      )}
                    </div>
                  </TableCell>
                  <TableCell className="text-sm text-muted-foreground">
                    {product.categoryName}
                  </TableCell>
                  <TableCell className={`text-right tabular-nums ${color}`}>
                    {product.localStock}
                  </TableCell>
                  <TableCell className={`text-right tabular-nums ${color}`}>
                    {product.warehouseStock}
                  </TableCell>
                  <TableCell className="text-right tabular-nums">
                    {currencyFormatter.format(product.listPrice)}
                  </TableCell>
                  <TableCell className="text-right">
                    <div className="flex items-center justify-end gap-1">
                      <Tooltip>
                        <TooltipTrigger
                          render={
                            <Button variant="ghost" size="icon-sm" onClick={() => onPurchase(product)}>
                              <Plus className="size-4" />
                            </Button>
                          }
                        />
                        <TooltipContent>Ingreso de compra</TooltipContent>
                      </Tooltip>

                      <Tooltip>
                        <TooltipTrigger
                          render={
                            <Button
                              variant="ghost"
                              size="icon-sm"
                              disabled={product.warehouseStock <= 0}
                              onClick={() => onTransfer(product)}
                            >
                              <ArrowRightLeft className="size-4" />
                            </Button>
                          }
                        />
                        <TooltipContent>Trasladar a mostrador</TooltipContent>
                      </Tooltip>

                      <Tooltip>
                        <TooltipTrigger
                          render={
                            <Button variant="ghost" size="icon-sm" onClick={() => onAdjust(product)}>
                              <SlidersHorizontal className="size-4" />
                            </Button>
                          }
                        />
                        <TooltipContent>Ajuste manual</TooltipContent>
                      </Tooltip>

                      <Tooltip>
                        <TooltipTrigger
                          render={
                            <Button variant="ghost" size="icon-sm" onClick={() => onEdit(product)}>
                              <Pencil className="size-4" />
                            </Button>
                          }
                        />
                        <TooltipContent>Editar producto</TooltipContent>
                      </Tooltip>

                      <Tooltip>
                        <TooltipTrigger
                          render={
                            <Button variant="ghost" size="icon-sm" onClick={() => onHistory(product)}>
                              <History className="size-4" />
                            </Button>
                          }
                        />
                        <TooltipContent>Historial de movimientos</TooltipContent>
                      </Tooltip>
                    </div>
                  </TableCell>
                </TableRow>
              );
            })
          )}
        </TableBody>
      </Table>
    </div>
  );
}

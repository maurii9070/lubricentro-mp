import { Button } from '@/components/ui/button';
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';

import type { SaleResponse } from '@/types/sale';

interface ReceiptDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  sale: SaleResponse | null;
}

const PAYMENT_METHOD_LABELS: Record<string, string> = {
  CASH: 'Efectivo',
  TRANSFER: 'Transferencia',
  DEBIT: 'Débito',
  CREDIT: 'Crédito',
  QR: 'QR',
};

const currencyFormatter = new Intl.NumberFormat('es-AR', {
  style: 'currency',
  currency: 'ARS',
});

const shiftLabels: Record<string, string> = {
  MORNING: 'Turno Mañana',
  AFTERNOON: 'Turno Tarde',
};

const operationLabels: Record<string, string> = {
  QUICK_SALE: 'Venta rápida',
  SERVICE: 'Service de vehículo',
};

export function ReceiptDialog({ open, onOpenChange, sale }: ReceiptDialogProps) {
  if (!sale) {
    return null;
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-lg">
        <DialogHeader>
          <DialogTitle>Operación registrada</DialogTitle>
          <DialogDescription>
            La venta #{sale.id} se registró correctamente.
          </DialogDescription>
        </DialogHeader>

        <div className="space-y-3 text-sm">
          <div className="grid grid-cols-2 gap-2">
            <span className="text-muted-foreground">Tipo</span>
            <span className="font-medium">{operationLabels[sale.operationType] ?? sale.operationType}</span>
            <span className="text-muted-foreground">Turno</span>
            <span className="font-medium">{shiftLabels[sale.shift] ?? sale.shift}</span>
            <span className="text-muted-foreground">Estado</span>
            <span className="font-medium">{sale.status === 'COMPLETED' ? 'Completada' : 'Anulada'}</span>
          </div>

          {sale.vehicleService && (
            <div className="rounded-md bg-muted/50 p-2">
              <p className="font-medium">{sale.vehicleService.licensePlate}</p>
              <p className="text-muted-foreground">{sale.vehicleService.brandModel}</p>
              {sale.vehicleService.mileage != null && (
                <p className="text-muted-foreground">Km: {sale.vehicleService.mileage}</p>
              )}
              {sale.vehicleService.technicalNotes && (
                <p className="text-muted-foreground">{sale.vehicleService.technicalNotes}</p>
              )}
            </div>
          )}

          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Ítem</TableHead>
                <TableHead className="text-right">Cant.</TableHead>
                <TableHead className="text-right">P. Unit.</TableHead>
                <TableHead className="text-right">Subtotal</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {sale.items.map((item) => (
                <TableRow key={item.id}>
                  <TableCell>{item.description}</TableCell>
                  <TableCell className="text-right tabular-nums">{item.quantity}</TableCell>
                  <TableCell className="text-right tabular-nums">
                    {currencyFormatter.format(item.unitPrice)}
                  </TableCell>
                  <TableCell className="text-right tabular-nums">
                    {currencyFormatter.format(item.subtotal)}
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>

          <div className="flex items-center justify-between border-t pt-2">
            <span className="font-semibold">Total cobrado</span>
            <span className="font-semibold tabular-nums">
              {currencyFormatter.format(sale.totalCharged)}
            </span>
          </div>

          <div className="space-y-1">
            <span className="text-xs font-medium text-muted-foreground">Pagos</span>
            {sale.payments.map((payment) => (
              <div key={payment.id} className="flex items-center justify-between text-xs">
                <span>{PAYMENT_METHOD_LABELS[payment.paymentMethod] ?? payment.paymentMethod}</span>
                <span className="tabular-nums">{currencyFormatter.format(payment.amount)}</span>
              </div>
            ))}
          </div>
        </div>

        <DialogFooter>
          <Button onClick={() => onOpenChange(false)}>Cerrar</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
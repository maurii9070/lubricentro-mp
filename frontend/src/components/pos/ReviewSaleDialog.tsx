import { Button } from '@/components/ui/button';
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';

import type { OperationType, PaymentMethod, Shift } from '@/types/common';
import type { PosCartItem, PosPayment } from '@/store/usePosStore';
import type { VehicleResponse } from '@/types/vehicle';

interface ReviewSaleDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  operationType: OperationType;
  shift: Shift;
  operationDate: string;
  items: PosCartItem[];
  subtotal: number;
  totalCharged: number;
  payments: PosPayment[];
  selectedVehicle: VehicleResponse | null;
  mileage: number | null;
  technicalNotes: string;
  onConfirm: () => void;
  confirming: boolean;
}

const PAYMENT_METHOD_LABELS: Record<PaymentMethod, string> = {
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

const shiftLabels: Record<Shift, string> = {
  MORNING: 'Turno Mañana',
  AFTERNOON: 'Turno Tarde',
};

const operationLabels: Record<OperationType, string> = {
  QUICK_SALE: 'Venta rápida',
  SERVICE: 'Service de vehículo',
};

export function ReviewSaleDialog({
  open,
  onOpenChange,
  operationType,
  shift,
  operationDate,
  items,
  subtotal,
  totalCharged,
  payments,
  selectedVehicle,
  mileage,
  technicalNotes,
  onConfirm,
  confirming,
}: ReviewSaleDialogProps) {
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-2xl">
        <DialogHeader>
          <DialogTitle>Revisar operación antes de confirmar</DialogTitle>
          <DialogDescription>
            Verificá los datos. Si todo es correcto, confirmá para registrar la operación.
          </DialogDescription>
        </DialogHeader>

        <div className="space-y-4 text-sm">
          <div className="grid grid-cols-2 gap-2">
            <span className="text-muted-foreground">Tipo</span>
            <span className="font-medium">{operationLabels[operationType]}</span>
            <span className="text-muted-foreground">Turno</span>
            <span className="font-medium">{shiftLabels[shift]}</span>
            <span className="text-muted-foreground">Fecha y hora</span>
            <span className="font-medium">{operationDate || 'Ahora'}</span>
          </div>

          {operationType === 'SERVICE' && selectedVehicle && (
            <div className="rounded-md bg-muted/50 p-3">
              <p className="font-medium">{selectedVehicle.licensePlate}</p>
              <p className="text-muted-foreground">{selectedVehicle.brandModel}</p>
              {mileage != null && <p className="text-muted-foreground">Km: {mileage}</p>}
              {technicalNotes && <p className="text-muted-foreground">{technicalNotes}</p>}
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
              {items.map((item) => (
                <TableRow key={item.key}>
                  <TableCell>{item.description}</TableCell>
                  <TableCell className="text-right tabular-nums">{item.quantity}</TableCell>
                  <TableCell className="text-right tabular-nums">
                    {currencyFormatter.format(item.unitPrice)}
                  </TableCell>
                  <TableCell className="text-right tabular-nums">
                    {currencyFormatter.format(item.quantity * item.unitPrice)}
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>

          <div className="space-y-1 border-t pt-2">
            <div className="flex items-center justify-between">
              <span className="text-muted-foreground">Subtotal calculado</span>
              <span className="tabular-nums">{currencyFormatter.format(subtotal)}</span>
            </div>
            <div className="flex items-center justify-between font-semibold">
              <span>Total a cobrar</span>
              <span className="tabular-nums">{currencyFormatter.format(totalCharged)}</span>
            </div>
          </div>

          <div className="space-y-1">
            <span className="text-xs font-medium text-muted-foreground">Pagos</span>
            {payments.map((payment, index) => (
              <div key={index} className="flex items-center justify-between text-xs">
                <span>{PAYMENT_METHOD_LABELS[payment.paymentMethod]}</span>
                <span className="tabular-nums">{currencyFormatter.format(payment.amount)}</span>
              </div>
            ))}
          </div>
        </div>

        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)} disabled={confirming}>
            Volver a editar
          </Button>
          <Button onClick={onConfirm} disabled={confirming}>
            {confirming ? 'Registrando...' : 'Confirmar y registrar'}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
import { useEffect, useMemo, useState } from 'react';

import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';

import type { PaymentMethod } from '@/types/common';
import type { PosPayment } from '@/store/usePosStore';

interface PaymentSummaryCardProps {
  subtotal: number;
  totalCharged: number;
  isTotalOverridden: boolean;
  onTotalChargedChange: (value: number) => void;
  onResetTotal: () => void;
  payments: PosPayment[];
  onAddPayment: () => void;
  onRemovePayment: (index: number) => void;
  onUpdatePayment: (index: number, patch: Partial<PosPayment>) => void;
  onCompleteBalance: (index: number) => void;
  itemsCount: number;
  isService: boolean;
  hasVehicle: boolean;
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

export function PaymentSummaryCard({
  subtotal,
  totalCharged,
  isTotalOverridden,
  onTotalChargedChange,
  onResetTotal,
  payments,
  onAddPayment,
  onRemovePayment,
  onUpdatePayment,
  onCompleteBalance,
  itemsCount,
  isService,
  hasVehicle,
  onConfirm,
  confirming,
}: PaymentSummaryCardProps) {
  const [totalInput, setTotalInput] = useState(String(totalCharged));

  const paymentsTotal = useMemo(
    () => payments.reduce((accumulator, payment) => accumulator + payment.amount, 0),
    [payments]
  );

  const difference = totalCharged - paymentsTotal;
  const isBalanced = Math.abs(difference) < 0.005;

  const canConfirm =
    itemsCount > 0 &&
    payments.length > 0 &&
    isBalanced &&
    (!isService || hasVehicle) &&
    !confirming;

  function handleTotalChange(value: string) {
    setTotalInput(value);
    const parsed = Number(value);
    if (!Number.isNaN(parsed)) {
      onTotalChargedChange(parsed);
    }
  }

  useEffect(() => {
    if (document.activeElement?.id !== 'total-charged-input') {
      setTotalInput(String(totalCharged));
    }
  }, [totalCharged]);

  return (
    <div className="space-y-4 rounded-lg border p-4">
      <h3 className="text-sm font-semibold">Totales y pagos</h3>

      <div className="space-y-2">
        <div className="flex items-center justify-between text-sm">
          <span className="text-muted-foreground">Subtotal calculado</span>
          <span className="font-medium tabular-nums">
            {currencyFormatter.format(subtotal)}
          </span>
        </div>

        <div className="space-y-1">
          <Label htmlFor="total-charged-input">Total a cobrar</Label>
          <div className="flex gap-2">
            <Input
              id="total-charged-input"
              type="number"
              min={0}
              step="0.01"
              value={totalInput}
              onChange={(event) => handleTotalChange(event.target.value)}
              onFocus={() => setTotalInput(String(totalCharged))}
              className="font-semibold"
            />
            {isTotalOverridden && (
              <Button type="button" variant="outline" size="sm" onClick={onResetTotal}>
                Reset
              </Button>
            )}
          </div>
          {isTotalOverridden && (
            <p className="text-xs text-muted-foreground">
              Total editado manualmente (promo/redondeo).
            </p>
          )}
        </div>
      </div>

      <div className="space-y-2">
        <div className="flex items-center justify-between">
          <span className="text-sm font-semibold">Medios de pago</span>
          <Button type="button" variant="outline" size="sm" onClick={onAddPayment}>
            + Agregar medio de pago
          </Button>
        </div>

        {payments.map((payment, index) => (
          <div key={index} className="flex items-center gap-2">
            <Select
              value={payment.paymentMethod}
              onValueChange={(value) =>
                onUpdatePayment(index, { paymentMethod: value as PaymentMethod })
              }
            >
              <SelectTrigger size="sm" className="w-36">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                {(Object.keys(PAYMENT_METHOD_LABELS) as PaymentMethod[]).map((method) => (
                  <SelectItem key={method} value={method}>
                    {PAYMENT_METHOD_LABELS[method]}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>

            <Input
              type="number"
              min={0.01}
              step="0.01"
              value={payment.amount}
              onChange={(event) =>
                onUpdatePayment(index, { amount: Number(event.target.value) })
              }
              className="h-7 flex-1 text-right"
            />

            <Button
              type="button"
              variant="outline"
              size="sm"
              onClick={() => onCompleteBalance(index)}
              title="Completar saldo"
            >
              Completar
            </Button>

            {payments.length > 1 && (
              <Button
                type="button"
                variant="ghost"
                size="icon-sm"
                onClick={() => onRemovePayment(index)}
                aria-label="Quitar pago"
              >
                ✕
              </Button>
            )}
          </div>
        ))}
      </div>

      <div
        className={`rounded-md p-3 text-sm font-medium ${
          isBalanced
            ? 'bg-emerald-50 text-emerald-700 dark:bg-emerald-950 dark:text-emerald-300'
            : 'bg-red-50 text-red-700 dark:bg-red-950 dark:text-red-300'
        }`}
      >
        {isBalanced
          ? `Pagos completos (${currencyFormatter.format(paymentsTotal)})`
          : difference > 0
            ? `Faltan ${currencyFormatter.format(difference)}`
            : `Sobran ${currencyFormatter.format(Math.abs(difference))}`}
      </div>

      <Button
        type="button"
        className="w-full"
        disabled={!canConfirm}
        onClick={onConfirm}
      >
        {confirming ? 'Registrando...' : 'Revisar operación'}
      </Button>
    </div>
  );
}
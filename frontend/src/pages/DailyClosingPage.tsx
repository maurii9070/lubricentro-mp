import { useEffect, useState } from 'react';

import { AlertDialog, AlertDialogAction, AlertDialogCancel, AlertDialogContent, AlertDialogDescription, AlertDialogFooter, AlertDialogHeader, AlertDialogTitle } from '@/components/ui/alert-dialog';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { Textarea } from '@/components/ui/textarea';
import { Copy, XCircle } from 'lucide-react';
import { toast } from 'sonner';

import { getDailyClosingReport } from '@/api/reportApi';
import { cancelSale } from '@/api/saleApi';

import type { DailyClosingOperationResponse, DailyClosingReportResponse, DrumConsumptionResponse } from '@/types/report';
import type { PaymentMethod } from '@/types/common';

const currencyFormatter = new Intl.NumberFormat('es-AR', {
  style: 'currency',
  currency: 'ARS',
});

const numberFormatter = new Intl.NumberFormat('es-AR', {
  minimumFractionDigits: 2,
  maximumFractionDigits: 2,
});

const paymentLabels: Record<PaymentMethod, string> = {
  CASH: 'Efectivo',
  TRANSFER: 'Transferencia',
  DEBIT: 'Débito',
  CREDIT: 'Crédito',
  QR: 'QR',
};

const paymentOrder: PaymentMethod[] = ['CASH', 'TRANSFER', 'DEBIT', 'CREDIT', 'QR'];

const operationTypeLabels: Record<string, string> = {
  QUICK_SALE: 'Venta Rápida',
  SERVICE: 'Service',
};

const shiftLabels: Record<string, string> = {
  ALL: 'Todo el día',
  MORNING: 'Turno Mañana',
  AFTERNOON: 'Turno Tarde',
};

function todayIso(): string {
  const now = new Date();
  const year = now.getFullYear();
  const month = String(now.getMonth() + 1).padStart(2, '0');
  const day = String(now.getDate()).padStart(2, '0');
  return `${year}-${month}-${day}`;
}

function formatTime(value: string): string {
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return value;
  return date.toLocaleTimeString('es-AR', { hour: '2-digit', minute: '2-digit' });
}

function paymentTotal(report: DailyClosingReportResponse | null, method: PaymentMethod): number {
  if (!report) return 0;
  const found = report.paymentsByMethod.find((item) => item.paymentMethod === method);
  return found?.total ?? 0;
}

export function DailyClosingPage() {
  const [date, setDate] = useState(todayIso());
  const [shiftFilter, setShiftFilter] = useState<'ALL' | 'MORNING' | 'AFTERNOON'>('ALL');
  const [report, setReport] = useState<DailyClosingReportResponse | null>(null);
  const [loading, setLoading] = useState(true);

  const [cancelTarget, setCancelTarget] = useState<DailyClosingOperationResponse | null>(null);
  const [cancelOpen, setCancelOpen] = useState(false);
  const [cancelReason, setCancelReason] = useState('');
  const [cancelling, setCancelling] = useState(false);

  async function loadReport() {
    setLoading(true);
    try {
      const shift = shiftFilter === 'ALL' ? undefined : (shiftFilter as 'MORNING' | 'AFTERNOON');
      const data = await getDailyClosingReport(date, shift);
      setReport(data);
    } catch (error) {
      toast.error(error instanceof Error ? error.message : 'No se pudo cargar el cierre de caja.');
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    void loadReport();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [date, shiftFilter]);

  function openCancel(operation: DailyClosingOperationResponse) {
    setCancelTarget(operation);
    setCancelReason('');
    setCancelOpen(true);
  }

  async function handleCancel() {
    if (!cancelTarget) return;
    if (!cancelReason.trim()) {
      toast.error('El motivo de anulación es obligatorio.');
      return;
    }
    setCancelling(true);
    try {
      await cancelSale(cancelTarget.saleId, cancelReason.trim());
      toast.success('Operación anulada correctamente.');
      setCancelOpen(false);
      setCancelTarget(null);
      setCancelReason('');
      await loadReport();
    } catch (error) {
      toast.error(error instanceof Error ? error.message : 'No se pudo anular la operación.');
    } finally {
      setCancelling(false);
    }
  }

  async function handleCopyWhatsApp() {
    if (!report) {
      toast.error('No hay datos para copiar.');
      return;
    }
    const totalOperations = report.completedSalesCount + report.completedServicesCount;
    const lines: string[] = [];
    lines.push('📊 *Cierre de Caja - Lubricentro MP*');
    lines.push(`📅 Fecha: ${report.date}`);
    lines.push(`🕐 Turno: ${shiftLabels[shiftFilter]}`);
    lines.push('');
    lines.push(`🧾 Operaciones: ${totalOperations} (${report.completedSalesCount} ventas rápidas, ${report.completedServicesCount} services)`);
    lines.push(`💰 Total recaudado: ${currencyFormatter.format(report.totalAmount)}`);
    lines.push('');
    lines.push('*Desglose por medio de pago:*');
    for (const method of paymentOrder) {
      lines.push(`  • ${paymentLabels[method]}: ${currencyFormatter.format(paymentTotal(report, method))}`);
    }
    if (report.drumConsumption.length > 0) {
      lines.push('');
      lines.push('*Litros descontados por tambor:*');
      for (const drum of report.drumConsumption) {
        lines.push(`  • ${drum.productName}: ${numberFormatter.format(drum.consumedLiters)} L descontados`);
      }
    }
    const text = lines.join('\n');
    try {
      await navigator.clipboard.writeText(text);
      toast.success('Resumen copiado al portapapeles.');
    } catch {
      toast.error('No se pudo copiar el resumen.');
    }
  }

  const totalOperations = (report?.completedSalesCount ?? 0) + (report?.completedServicesCount ?? 0);

  return (
    <div className="space-y-6">
      <div className="flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h1 className="text-2xl font-bold tracking-tight">Cierre de Caja</h1>
          <p className="text-sm text-muted-foreground">
            Cierre diario y reporte de operaciones por turno.
          </p>
        </div>
        <Button onClick={handleCopyWhatsApp} disabled={!report || loading}>
          <Copy className="size-4" />
          Copiar Resumen para WhatsApp
        </Button>
      </div>

      <div className="flex flex-col gap-3 rounded-lg border bg-background p-4 md:flex-row md:items-start md:gap-4">
        <div className="space-y-2 md:w-44">
          <Label htmlFor="closing-date">Fecha</Label>
          <Input
            id="closing-date"
            type="date"
            value={date}
            onChange={(event) => setDate(event.target.value)}
            className="h-8 box-border"
          />
        </div>

        <div className="space-y-2 md:w-56">
          <Label>Turno</Label>
          <Select
            value={shiftFilter}
            onValueChange={(value) => setShiftFilter(value as 'ALL' | 'MORNING' | 'AFTERNOON')}
            items={[
              { value: 'ALL', label: 'Todo el día' },
              { value: 'MORNING', label: 'Turno Mañana' },
              { value: 'AFTERNOON', label: 'Turno Tarde' },
            ]}
          >
            <SelectTrigger className="h-8 w-full box-border">
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="ALL">Todo el día</SelectItem>
              <SelectItem value="MORNING">Turno Mañana</SelectItem>
              <SelectItem value="AFTERNOON">Turno Tarde</SelectItem>
            </SelectContent>
          </Select>
        </div>
      </div>

      {loading ? (
        <p className="py-8 text-center text-sm text-muted-foreground">Cargando cierre de caja...</p>
      ) : !report ? (
        <p className="py-8 text-center text-sm text-muted-foreground">Sin datos.</p>
      ) : (
        <>
          {/* Totales */}
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            <Card className="sm:col-span-2 lg:col-span-1">
              <CardHeader>
                <CardDescription>Total General Cobrado</CardDescription>
                <CardTitle className="text-2xl">
                  {currencyFormatter.format(report.totalAmount)}
                </CardTitle>
                <CardDescription>
                  {totalOperations} operaciones ({report.completedSalesCount} ventas, {report.completedServicesCount} services)
                </CardDescription>
              </CardHeader>
            </Card>
            {paymentOrder.map((method) => (
              <Card key={method}>
                <CardHeader>
                  <CardDescription>{paymentLabels[method]}</CardDescription>
                  <CardTitle className="text-xl">
                    {currencyFormatter.format(paymentTotal(report, method))}
                  </CardTitle>
                </CardHeader>
              </Card>
            ))}
          </div>

          {/* Consumo de tambores */}
          <div className="space-y-3">
            <h2 className="text-lg font-semibold tracking-tight">Litros descontados de tambores</h2>
            {report.drumConsumption.length === 0 ? (
              <Card>
                <CardContent className="py-6 text-center text-sm text-muted-foreground">
                  Sin consumo de aceite a granel en el período.
                </CardContent>
              </Card>
            ) : (
              <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
                {report.drumConsumption.map((drum: DrumConsumptionResponse) => (
                  <Card key={drum.productId}>
                    <CardHeader>
                      <CardDescription>{drum.productName}</CardDescription>
                      <CardTitle className="text-xl">
                        {numberFormatter.format(drum.consumedLiters)} L
                      </CardTitle>
                      <CardDescription>descontados</CardDescription>
                    </CardHeader>
                  </Card>
                ))}
              </div>
            )}
          </div>

          {/* Operaciones */}
          <div className="space-y-3">
            <h2 className="text-lg font-semibold tracking-tight">Operaciones del período</h2>
            <div className="rounded-md border">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>Hora</TableHead>
                    <TableHead>Turno</TableHead>
                    <TableHead>Tipo</TableHead>
                    <TableHead>Patente</TableHead>
                    <TableHead>Resumen</TableHead>
                    <TableHead className="text-right">Total</TableHead>
                    <TableHead>Estado</TableHead>
                    <TableHead className="text-right">Acciones</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {report.operations.length === 0 ? (
                    <TableRow>
                      <TableCell colSpan={8} className="py-8 text-center text-sm text-muted-foreground">
                        Sin operaciones en el período.
                      </TableCell>
                    </TableRow>
                  ) : (
                    report.operations.map((operation) => (
                      <TableRow key={operation.saleId}>
                        <TableCell className="whitespace-nowrap text-xs">
                          {formatTime(operation.operationDate)}
                        </TableCell>
                        <TableCell className="text-xs">
                          {operation.shift === 'MORNING' ? 'Mañana' : 'Tarde'}
                        </TableCell>
                        <TableCell className="text-xs">
                          {operationTypeLabels[operation.operationType] ?? operation.operationType}
                        </TableCell>
                        <TableCell className="font-mono text-xs">
                          {operation.licensePlate ?? '-'}
                        </TableCell>
                        <TableCell className="max-w-[220px] truncate text-xs text-muted-foreground">
                          {operation.description}
                        </TableCell>
                        <TableCell className="text-right tabular-nums text-xs font-medium">
                          {currencyFormatter.format(operation.totalCharged)}
                        </TableCell>
                        <TableCell>
                          <Badge variant="outline" className="text-xs">
                            Completada
                          </Badge>
                        </TableCell>
                        <TableCell className="text-right">
                          <Button
                            variant="ghost"
                            size="sm"
                            className="text-destructive"
                            onClick={() => openCancel(operation)}
                          >
                            <XCircle className="size-4" />
                            Anular
                          </Button>
                        </TableCell>
                      </TableRow>
                    ))
                  )}
                </TableBody>
              </Table>
            </div>
          </div>
        </>
      )}

      <AlertDialog open={cancelOpen} onOpenChange={setCancelOpen}>
        <AlertDialogContent className="sm:max-w-md">
          <AlertDialogHeader>
            <AlertDialogTitle>Anular operación</AlertDialogTitle>
            <AlertDialogDescription>
              {cancelTarget
                ? `Vas a anular la operación #${cancelTarget.saleId}. Se devolverán filtros y litros al stock.`
                : 'Anular operación'}
            </AlertDialogDescription>
          </AlertDialogHeader>

          <div className="space-y-2">
            <Label htmlFor="cancel-reason">Motivo de anulación *</Label>
            <Textarea
              id="cancel-reason"
              value={cancelReason}
              onChange={(event) => setCancelReason(event.target.value)}
              placeholder="Ej. Error de carga, cliente desistió"
              rows={3}
            />
          </div>

          <AlertDialogFooter>
            <AlertDialogCancel disabled={cancelling}>Cancelar</AlertDialogCancel>
            <AlertDialogAction
              onClick={handleCancel}
              disabled={cancelling || !cancelReason.trim()}
            >
              {cancelling ? 'Anulando...' : 'Confirmar anulación'}
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  );
}
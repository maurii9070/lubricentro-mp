import { useEffect, useState } from 'react';

import { Button } from '@/components/ui/button';
import { Sheet, SheetContent, SheetDescription, SheetHeader, SheetTitle } from '@/components/ui/sheet';
import { Badge } from '@/components/ui/badge';
import { Separator } from '@/components/ui/separator';
import { toast } from 'sonner';

import { getVehicleServiceHistory } from '@/api/vehicleApi';

import type { VehicleResponse } from '@/types/vehicle';
import type { SaleResponse } from '@/types/sale';

interface VehicleHistorySheetProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  vehicle: VehicleResponse | null;
}

const currencyFormatter = new Intl.NumberFormat('es-AR', {
  style: 'currency',
  currency: 'ARS',
});

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

function serviceSummary(service: SaleResponse): string {
  const plate = service.vehicleService?.licensePlate ?? '';
  const km = service.vehicleService?.mileage;
  const items = service.items.map((item) => `${item.description} x${item.quantity}`).join(', ');
  const notes = service.vehicleService?.technicalNotes ?? service.notes ?? '';
  return [
    `Patente: ${plate}`,
    `Fecha: ${formatDate(service.operationDate)}`,
    `Kilometraje: ${km != null ? km : '-'}`,
    `Filtros/Ítems: ${items || '-'}`,
    `Aceite y repuestos: ${items || '-'}`,
    `Próximo cambio: ${notes || '-'}`,
  ].join('\n');
}

export function VehicleHistorySheet({ open, onOpenChange, vehicle }: VehicleHistorySheetProps) {
  const [history, setHistory] = useState<SaleResponse[]>([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (!open || !vehicle) return;
    let active = true;
    setLoading(true);
    void getVehicleServiceHistory(vehicle.id)
      .then((data) => {
        if (!active) return;
        const sorted = [...data].sort(
          (a, b) => new Date(b.operationDate).getTime() - new Date(a.operationDate).getTime()
        );
        setHistory(sorted);
      })
      .catch((error) => {
        if (active) {
          toast.error(error instanceof Error ? error.message : 'No se pudo cargar el historial.');
        }
      })
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, [open, vehicle]);

  async function handleCopyCard() {
    if (history.length === 0) {
      toast.error('No hay services registrados para copiar.');
      return;
    }
    const last = history[0];
    const text = serviceSummary(last);
    try {
      await navigator.clipboard.writeText(text);
      toast.success('Ficha copiada al portapapeles.');
    } catch {
      toast.error('No se pudo copiar la ficha.');
    }
  }

  return (
    <Sheet open={open} onOpenChange={onOpenChange}>
      <SheetContent className="sm:max-w-2xl">
        <SheetHeader>
          <SheetTitle>Historial de services</SheetTitle>
          <SheetDescription>
            {vehicle ? `${vehicle.licensePlate} — ${vehicle.brandModel}` : 'Vehículo'}
          </SheetDescription>
        </SheetHeader>

        {vehicle && (
          <div className="space-y-3 px-4">
            <div className="rounded-md bg-muted/50 p-3 text-sm">
              <div className="flex flex-wrap items-center gap-2">
                <Badge className="font-mono">{vehicle.licensePlate}</Badge>
                <span className="font-medium">{vehicle.brandModel}</span>
              </div>
              <p className="mt-1 text-muted-foreground">
                Dueño: {vehicle.ownerName ?? '-'} · Teléfono: {vehicle.phone ?? '-'}
              </p>
            </div>

            <div className="flex justify-end">
              <Button variant="outline" size="sm" onClick={handleCopyCard} disabled={history.length === 0}>
                Copiar Ficha / Tarjeta
              </Button>
            </div>
          </div>
        )}

        <Separator />

        <div className="flex-1 overflow-auto px-4 pb-4">
          {loading ? (
            <p className="py-6 text-center text-sm text-muted-foreground">Cargando historial...</p>
          ) : history.length === 0 ? (
            <p className="py-6 text-center text-sm text-muted-foreground">
              Sin services registrados para este vehículo.
            </p>
          ) : (
            <div className="space-y-4">
              {history.map((service) => (
                <div key={service.id} className="rounded-lg border p-4">
                  <div className="flex flex-wrap items-center justify-between gap-2">
                    <div className="flex items-center gap-2">
                      <Badge variant="outline" className="text-xs">
                        {formatDate(service.operationDate)}
                      </Badge>
                      {service.vehicleService?.mileage != null && (
                        <span className="text-xs text-muted-foreground">
                          {service.vehicleService.mileage.toLocaleString('es-AR')} km
                        </span>
                      )}
                    </div>
                    <span className="font-semibold tabular-nums">
                      {currencyFormatter.format(service.totalCharged)}
                    </span>
                  </div>

                  {service.items.length > 0 && (
                    <div className="mt-3">
                      <p className="text-xs font-semibold uppercase text-muted-foreground">
                        Filtros / Ítems utilizados
                      </p>
                      <ul className="mt-1 space-y-1 text-sm">
                        {service.items.map((item) => (
                          <li key={item.id} className="flex justify-between gap-2">
                            <span>{item.description}</span>
                            <span className="tabular-nums text-muted-foreground">
                              x{item.quantity}
                            </span>
                          </li>
                        ))}
                      </ul>
                    </div>
                  )}

                  {(service.vehicleService?.technicalNotes || service.notes) && (
                    <div className="mt-3">
                      <p className="text-xs font-semibold uppercase text-muted-foreground">
                        Notas técnicas / próximo service
                      </p>
                      <p className="mt-1 whitespace-pre-wrap text-sm">
                        {service.vehicleService?.technicalNotes ?? service.notes}
                      </p>
                    </div>
                  )}
                </div>
              ))}
            </div>
          )}
        </div>
      </SheetContent>
    </Sheet>
  );
}
import { useEffect, useMemo, useState } from 'react';

import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Plus } from 'lucide-react';

import { VehiclesTable } from '@/components/vehicles/VehiclesTable';
import { NewVehicleDialog } from '@/components/vehicles/NewVehicleDialog';
import { EditVehicleDialog } from '@/components/vehicles/EditVehicleDialog';
import { VehicleHistorySheet } from '@/components/vehicles/VehicleHistorySheet';

import { searchVehicles } from '@/api/vehicleApi';
import { toast } from 'sonner';

import type { VehicleResponse } from '@/types/vehicle';

function normalizePlate(value: string): string {
  return value.replace(/\s+/g, '').replace(/-/g, '').toUpperCase();
}

export function VehiclesPage() {
  const [vehicles, setVehicles] = useState<VehicleResponse[]>([]);
  const [loading, setLoading] = useState(true);

  const [searchTerm, setSearchTerm] = useState('');
  const [debouncedTerm, setDebouncedTerm] = useState('');

  const [newVehicleOpen, setNewVehicleOpen] = useState(false);
  const [editingVehicle, setEditingVehicle] = useState<VehicleResponse | null>(null);
  const [editOpen, setEditOpen] = useState(false);

  const [historyVehicle, setHistoryVehicle] = useState<VehicleResponse | null>(null);
  const [historyOpen, setHistoryOpen] = useState(false);

  useEffect(() => {
    let active = true;
    setLoading(true);
    void searchVehicles('')
      .then((data) => {
        if (active) setVehicles(data);
      })
      .catch((error) => {
        if (active) toast.error(error instanceof Error ? error.message : 'No se pudo cargar el padrón de vehículos.');
      })
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, []);

  useEffect(() => {
    const handle = window.setTimeout(() => setDebouncedTerm(searchTerm), 250);
    return () => window.clearTimeout(handle);
  }, [searchTerm]);

  const filteredVehicles = useMemo(() => {
    const term = debouncedTerm.trim();
    if (!term) return vehicles;
    const normalizedTerm = normalizePlate(term);
    const lowerTerm = term.toLowerCase();
    return vehicles.filter((vehicle) => {
      const plate = normalizePlate(vehicle.licensePlate);
      const model = vehicle.brandModel.toLowerCase();
      return plate.includes(normalizedTerm) || model.includes(lowerTerm);
    });
  }, [vehicles, debouncedTerm]);

  function handleEdit(vehicle: VehicleResponse) {
    setEditingVehicle(vehicle);
    setEditOpen(true);
  }

  function handleHistory(vehicle: VehicleResponse) {
    setHistoryVehicle(vehicle);
    setHistoryOpen(true);
  }

  function handleCreated(vehicle: VehicleResponse) {
    setVehicles((prev) => [vehicle, ...prev]);
  }

  function handleSaved(saved: VehicleResponse) {
    setVehicles((prev) => prev.map((v) => (v.id === saved.id ? saved : v)));
  }

  return (
    <div className="space-y-6">
      <div className="flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h1 className="text-2xl font-bold tracking-tight">Vehículos</h1>
          <p className="text-sm text-muted-foreground">
            Padrón de vehículos e historial de services.
          </p>
        </div>
        <Button onClick={() => setNewVehicleOpen(true)}>
          <Plus className="size-4" />
          + Nuevo Vehículo
        </Button>
      </div>

      <div className="flex flex-col gap-3 rounded-lg border bg-background p-4">
        <Input
          id="vehicle-search"
          value={searchTerm}
          onChange={(event) => setSearchTerm(event.target.value)}
          placeholder="Buscar por patente o modelo (ej. AB482YZ, COROLLA)"
          className="h-9"
        />
        <p className="text-xs text-muted-foreground">
          La búsqueda normaliza espacios y guiones y convierte la patente a mayúsculas automáticamente.
        </p>
      </div>

      {loading ? (
        <p className="py-8 text-center text-sm text-muted-foreground">Cargando padrón de vehículos...</p>
      ) : (
        <VehiclesTable vehicles={filteredVehicles} onEdit={handleEdit} onHistory={handleHistory} />
      )}

      <NewVehicleDialog
        open={newVehicleOpen}
        onOpenChange={setNewVehicleOpen}
        onCreated={handleCreated}
      />

      <EditVehicleDialog
        open={editOpen}
        onOpenChange={setEditOpen}
        vehicle={editingVehicle}
        onSaved={handleSaved}
      />

      <VehicleHistorySheet
        open={historyOpen}
        onOpenChange={setHistoryOpen}
        vehicle={historyVehicle}
      />
    </div>
  );
}
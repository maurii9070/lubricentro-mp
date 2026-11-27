import { useState } from 'react';

import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';

import { getVehicleByLicensePlate } from '@/api/vehicleApi';
import { NewVehicleDialog } from '@/components/vehicles/NewVehicleDialog';
import { toast } from 'sonner';

import type { VehicleResponse } from '@/types/vehicle';

interface VehicleServicePanelProps {
  selectedVehicle: VehicleResponse | null;
  onSelectVehicle: (vehicle: VehicleResponse | null) => void;
  mileage: number | null;
  onMileageChange: (value: number | null) => void;
  technicalNotes: string;
  onTechnicalNotesChange: (value: string) => void;
}

function normalizePlate(value: string): string {
  return value.replace(/\s+/g, '').replace(/-/g, '').toUpperCase();
}

export function VehicleServicePanel({
  selectedVehicle,
  onSelectVehicle,
  mileage,
  onMileageChange,
  technicalNotes,
  onTechnicalNotesChange,
}: VehicleServicePanelProps) {
  const [plateInput, setPlateInput] = useState('');
  const [searching, setSearching] = useState(false);
  const [newVehicleOpen, setNewVehicleOpen] = useState(false);

  async function handleSearch() {
    const normalized = normalizePlate(plateInput);
    if (!normalized) {
      return;
    }
    setSearching(true);
    try {
      const vehicle = await getVehicleByLicensePlate(normalized);
      onSelectVehicle(vehicle);
      toast.success('Vehículo encontrado.');
    } catch (error) {
      toast.error(error instanceof Error ? error.message : 'No se encontró el vehículo.');
      onSelectVehicle(null);
    } finally {
      setSearching(false);
    }
  }

  return (
    <div className="space-y-4 rounded-lg border p-4">
      <h3 className="text-sm font-semibold">Datos del vehículo / service</h3>

      <div className="space-y-2">
        <Label htmlFor="vehicle-plate">Patente</Label>
        <div className="flex gap-2">
          <Input
            id="vehicle-plate"
            value={plateInput}
            onChange={(event) => setPlateInput(normalizePlate(event.target.value))}
            placeholder="Ej. ABC123"
            onKeyDown={(event) => {
              if (event.key === 'Enter') {
                event.preventDefault();
                void handleSearch();
              }
            }}
          />
          <Button type="button" variant="outline" onClick={handleSearch} disabled={searching}>
            {searching ? 'Buscando...' : 'Buscar'}
          </Button>
          <Button type="button" onClick={() => setNewVehicleOpen(true)}>
            + Nuevo Vehículo
          </Button>
        </div>
      </div>

      {selectedVehicle && (
        <div className="rounded-md bg-muted/50 p-3 text-sm">
          <p className="font-medium">{selectedVehicle.licensePlate}</p>
          <p className="text-muted-foreground">{selectedVehicle.brandModel}</p>
          {selectedVehicle.ownerName && (
            <p className="text-muted-foreground">Dueño: {selectedVehicle.ownerName}</p>
          )}
        </div>
      )}

      <div className="space-y-2">
        <Label htmlFor="vehicle-mileage">Kilometraje actual</Label>
        <Input
          id="vehicle-mileage"
          type="number"
          min={0}
          step="1"
          value={mileage ?? ''}
          onChange={(event) =>
            onMileageChange(event.target.value === '' ? null : Number(event.target.value))
          }
          placeholder="Ej. 180000"
        />
      </div>

      <div className="space-y-2">
        <Label htmlFor="vehicle-notes">Observaciones técnicas / próximo service</Label>
        <Textarea
          id="vehicle-notes"
          value={technicalNotes}
          onChange={(event) => onTechnicalNotesChange(event.target.value)}
          placeholder='Ej. "Próximo cambio a los 185.000 km"'
          rows={3}
        />
      </div>

      <NewVehicleDialog
        open={newVehicleOpen}
        onOpenChange={setNewVehicleOpen}
        initialPlate={plateInput}
        onCreated={(vehicle) => {
          onSelectVehicle(vehicle);
          setPlateInput(vehicle.licensePlate);
        }}
      />
    </div>
  );
}
import { useState } from 'react';

import { Button } from '@/components/ui/button';
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';

import { createVehicle } from '@/api/vehicleApi';
import { toast } from 'sonner';

import type { VehicleResponse } from '@/types/vehicle';

interface NewVehicleDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  initialPlate?: string;
  onCreated: (vehicle: VehicleResponse) => void;
}

export function NewVehicleDialog({
  open,
  onOpenChange,
  initialPlate = '',
  onCreated,
}: NewVehicleDialogProps) {
  const [licensePlate, setLicensePlate] = useState(initialPlate);
  const [brandModel, setBrandModel] = useState('');
  const [ownerName, setOwnerName] = useState('');
  const [phone, setPhone] = useState('');
  const [submitting, setSubmitting] = useState(false);

  function normalizePlate(value: string): string {
    return value.replace(/\s+/g, '').replace(/-/g, '').toUpperCase();
  }

  async function handleSubmit() {
    if (!licensePlate.trim() || !brandModel.trim()) {
      return;
    }
    setSubmitting(true);
    try {
      const vehicle = await createVehicle({
        licensePlate: normalizePlate(licensePlate),
        brandModel: brandModel.trim(),
        ownerName: ownerName.trim() || null,
        phone: phone.trim() || null,
      });
      toast.success('Vehículo registrado correctamente.');
      onCreated(vehicle);
      setLicensePlate('');
      setBrandModel('');
      setOwnerName('');
      setPhone('');
      onOpenChange(false);
    } catch (error) {
      toast.error(error instanceof Error ? error.message : 'No se pudo registrar el vehículo.');
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle>Nuevo vehículo</DialogTitle>
          <DialogDescription>
            Ingresá la patente y el modelo. El dueño y teléfono son opcionales.
          </DialogDescription>
        </DialogHeader>

        <div className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="new-vehicle-plate">Patente *</Label>
            <Input
              id="new-vehicle-plate"
              value={licensePlate}
              onChange={(event) => setLicensePlate(normalizePlate(event.target.value))}
              placeholder="Ej. ABC123"
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="new-vehicle-model">Marca y modelo *</Label>
            <Input
              id="new-vehicle-model"
              value={brandModel}
              onChange={(event) => setBrandModel(event.target.value)}
              placeholder="Ej. Ford Ranger 2.2"
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="new-vehicle-owner">Dueño (opcional)</Label>
            <Input
              id="new-vehicle-owner"
              value={ownerName}
              onChange={(event) => setOwnerName(event.target.value)}
              placeholder="Nombre del propietario"
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="new-vehicle-phone">Teléfono (opcional)</Label>
            <Input
              id="new-vehicle-phone"
              value={phone}
              onChange={(event) => setPhone(event.target.value)}
              placeholder="Teléfono de contacto"
            />
          </div>
        </div>

        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)} disabled={submitting}>
            Cancelar
          </Button>
          <Button
            onClick={handleSubmit}
            disabled={submitting || !licensePlate.trim() || !brandModel.trim()}
          >
            {submitting ? 'Guardando...' : 'Guardar vehículo'}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
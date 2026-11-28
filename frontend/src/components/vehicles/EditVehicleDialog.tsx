import { useEffect, useState } from 'react';

import { Button } from '@/components/ui/button';
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';

import { updateVehicle } from '@/api/vehicleApi';
import { toast } from 'sonner';

import type { VehicleRequest, VehicleResponse } from '@/types/vehicle';

interface EditVehicleDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  vehicle: VehicleResponse | null;
  onSaved: (vehicle: VehicleResponse) => void;
}

export function EditVehicleDialog({ open, onOpenChange, vehicle, onSaved }: EditVehicleDialogProps) {
  const [licensePlate, setLicensePlate] = useState('');
  const [brandModel, setBrandModel] = useState('');
  const [ownerName, setOwnerName] = useState('');
  const [phone, setPhone] = useState('');
  const [submitting, setSubmitting] = useState(false);

  function normalizePlate(value: string): string {
    return value.replace(/\s+/g, '').replace(/-/g, '').toUpperCase();
  }

  useEffect(() => {
    if (!open || !vehicle) return;
    setLicensePlate(vehicle.licensePlate);
    setBrandModel(vehicle.brandModel);
    setOwnerName(vehicle.ownerName ?? '');
    setPhone(vehicle.phone ?? '');
  }, [open, vehicle]);

  async function handleSubmit() {
    if (!vehicle) return;
    if (!licensePlate.trim() || !brandModel.trim()) {
      return;
    }
    setSubmitting(true);
    try {
      const request: VehicleRequest = {
        licensePlate: normalizePlate(licensePlate),
        brandModel: brandModel.trim(),
        ownerName: ownerName.trim() || null,
        phone: phone.trim() || null,
      };
      const saved = await updateVehicle(vehicle.id, request);
      toast.success('Vehículo actualizado correctamente.');
      onSaved(saved);
      onOpenChange(false);
    } catch (error) {
      toast.error(error instanceof Error ? error.message : 'No se pudo actualizar el vehículo.');
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle>Editar vehículo</DialogTitle>
          <DialogDescription>
            Actualizá los datos del vehículo seleccionado.
          </DialogDescription>
        </DialogHeader>

        <div className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="edit-vehicle-plate">Patente *</Label>
            <Input
              id="edit-vehicle-plate"
              value={licensePlate}
              onChange={(event) => setLicensePlate(normalizePlate(event.target.value))}
              placeholder="Ej. ABC123"
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="edit-vehicle-model">Marca y modelo *</Label>
            <Input
              id="edit-vehicle-model"
              value={brandModel}
              onChange={(event) => setBrandModel(event.target.value)}
              placeholder="Ej. Ford Ranger 2.2"
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="edit-vehicle-owner">Dueño (opcional)</Label>
            <Input
              id="edit-vehicle-owner"
              value={ownerName}
              onChange={(event) => setOwnerName(event.target.value)}
              placeholder="Nombre del propietario"
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="edit-vehicle-phone">Teléfono (opcional)</Label>
            <Input
              id="edit-vehicle-phone"
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
            {submitting ? 'Guardando...' : 'Guardar cambios'}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
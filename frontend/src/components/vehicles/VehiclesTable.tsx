import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { History, Pencil } from 'lucide-react';

import type { VehicleResponse } from '@/types/vehicle';

interface VehiclesTableProps {
  vehicles: VehicleResponse[];
  onEdit: (vehicle: VehicleResponse) => void;
  onHistory: (vehicle: VehicleResponse) => void;
}

export function VehiclesTable({ vehicles, onEdit, onHistory }: VehiclesTableProps) {
  return (
    <div className="rounded-md border">
      <Table>
        <TableHeader>
          <TableRow>
            <TableHead>Patente</TableHead>
            <TableHead>Vehículo / Modelo</TableHead>
            <TableHead>Dueño / Contacto</TableHead>
            <TableHead>Teléfono</TableHead>
            <TableHead className="text-right">Acciones</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {vehicles.length === 0 ? (
            <TableRow>
              <TableCell colSpan={5} className="py-8 text-center text-sm text-muted-foreground">
                Sin vehículos para mostrar.
              </TableCell>
            </TableRow>
          ) : (
            vehicles.map((vehicle) => (
              <TableRow key={vehicle.id}>
                <TableCell>
                  <Badge className="font-mono text-sm tracking-wide">
                    {vehicle.licensePlate}
                  </Badge>
                </TableCell>
                <TableCell className="font-medium">{vehicle.brandModel}</TableCell>
                <TableCell className="text-sm text-muted-foreground">
                  {vehicle.ownerName ?? '-'}
                </TableCell>
                <TableCell className="text-sm text-muted-foreground">
                  {vehicle.phone ?? '-'}
                </TableCell>
                <TableCell className="text-right">
                  <div className="flex items-center justify-end gap-1">
                    <Button variant="ghost" size="sm" onClick={() => onEdit(vehicle)}>
                      <Pencil className="size-4" />
                      Editar
                    </Button>
                    <Button variant="ghost" size="sm" onClick={() => onHistory(vehicle)}>
                      <History className="size-4" />
                      Ver Historial
                    </Button>
                  </div>
                </TableCell>
              </TableRow>
            ))
          )}
        </TableBody>
      </Table>
    </div>
  );
}
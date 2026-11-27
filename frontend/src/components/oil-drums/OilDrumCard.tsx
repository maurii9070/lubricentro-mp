import { useState } from 'react';

import { AlertDialog, AlertDialogAction, AlertDialogCancel, AlertDialogContent, AlertDialogDescription, AlertDialogFooter, AlertDialogHeader, AlertDialogTitle, AlertDialogTrigger } from '@/components/ui/alert-dialog';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';

import type { OilDrumResponse } from '@/types/oilDrum';

interface OilDrumCardProps {
  drum: OilDrumResponse;
  onClose: (drum: OilDrumResponse, notes?: string | null) => void;
}

export function OilDrumCard({ drum, onClose }: OilDrumCardProps) {
  const [notes, setNotes] = useState('');

  const percentage = Math.max(0, Math.min(100, drum.remainingPercentage));

  let barColor = 'bg-emerald-500';
  let levelLabel = 'Nivel normal';
  let critical = false;

  if (percentage < 15) {
    barColor = 'bg-red-500';
    levelLabel = 'Nivel crítico';
    critical = true;
  } else if (percentage <= 40) {
    barColor = 'bg-amber-500';
    levelLabel = 'Nivel medio';
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base">{drum.productName}</CardTitle>
        <CardDescription>{drum.notes ?? 'Tambor abierto'}</CardDescription>
      </CardHeader>
      <CardContent className="space-y-3">
        <div className="flex items-center justify-between text-sm tabular-nums">
          <span>
            {drum.remainingLiters.toFixed(2)} L / {drum.capacityLiters.toFixed(2)} L
          </span>
          <span className="font-medium">{percentage.toFixed(1)}%</span>
        </div>

        <div className="h-3 w-full overflow-hidden rounded-full bg-muted">
          <div
            className={`h-full transition-all ${barColor}`}
            style={{ width: `${percentage}%` }}
          />
        </div>

        <p className="text-xs text-muted-foreground">{levelLabel}</p>
        {critical && (
          <p className="text-sm font-semibold text-red-600">
            Pedir reposición al jefe
          </p>
        )}
      </CardContent>
      <CardFooter>
        <AlertDialog>
          <AlertDialogTrigger render={<Button variant="destructive" size="sm" className="w-full" />}>
            Cerrar por Merma / Vacío
          </AlertDialogTrigger>
          <AlertDialogContent>
            <AlertDialogHeader>
              <AlertDialogTitle>Cerrar tambor</AlertDialogTitle>
              <AlertDialogDescription>
                Se liquidará el fondo del tambor y quedará inhabilitado. ¿Confirmás?
              </AlertDialogDescription>
            </AlertDialogHeader>
            <div className="space-y-2">
              <Label htmlFor={`notes-${drum.id}`}>Motivo (opcional)</Label>
              <Input
                id={`notes-${drum.id}`}
                value={notes}
                onChange={(event) => setNotes(event.target.value)}
                placeholder="Ej. Tambor vacío"
                maxLength={255}
              />
            </div>
            <AlertDialogFooter>
              <AlertDialogCancel onClick={() => setNotes('')}>Cancelar</AlertDialogCancel>
              <AlertDialogAction
                onClick={() => {
                  onClose(drum, notes.trim() || null);
                  setNotes('');
                }}
              >
                Confirmar
              </AlertDialogAction>
            </AlertDialogFooter>
          </AlertDialogContent>
        </AlertDialog>
      </CardFooter>
    </Card>
  );
}
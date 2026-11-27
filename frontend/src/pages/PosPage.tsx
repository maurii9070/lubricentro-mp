import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';

export function PosPage() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Mostrador / Ventas</h1>
        <p className="text-sm text-muted-foreground">
          Registro de ventas rápidas y services de vehículos.
        </p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Próximamente</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-sm text-muted-foreground">
            Esta sección se conectará en la Etapa F3.
          </p>
        </CardContent>
      </Card>
    </div>
  );
}

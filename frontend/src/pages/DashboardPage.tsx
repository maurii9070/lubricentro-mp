import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';

export function DashboardPage() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Panel y Tambores</h1>
        <p className="text-sm text-muted-foreground">
          Resumen general del mostrador y estado de los tambores de aceite.
        </p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Próximamente</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-sm text-muted-foreground">
            Esta sección se conectará en la Etapa F2.
          </p>
        </CardContent>
      </Card>
    </div>
  );
}

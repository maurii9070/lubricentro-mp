import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';

export function DailyClosingPage() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Cierre de Caja</h1>
        <p className="text-sm text-muted-foreground">
          Cierre diario y reportes de operaciones.
        </p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Próximamente</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-sm text-muted-foreground">
            Esta sección se conectará en la Etapa F5.
          </p>
        </CardContent>
      </Card>
    </div>
  );
}

import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';

export function InventoryPage() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Inventario</h1>
        <p className="text-sm text-muted-foreground">
          Gestión de productos, stock y movimientos.
        </p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Próximamente</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-sm text-muted-foreground">
            Esta sección se conectará en la Etapa F4.
          </p>
        </CardContent>
      </Card>
    </div>
  );
}

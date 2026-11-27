import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { toast } from 'sonner';

import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { OpenOilDrumDialog } from '@/components/oil-drums/OpenOilDrumDialog';
import { OilDrumCard } from '@/components/oil-drums/OilDrumCard';
import { getDailyClosingReport } from '@/api/reportApi';
import { listLowStockProducts, listProducts } from '@/api/productApi';
import { listOpenOilDrums, openOilDrum, closeOilDrum } from '@/api/oilDrumApi';

import type { DailyClosingReportResponse } from '@/types/report';
import type { OilDrumResponse } from '@/types/oilDrum';
import type { ProductResponse } from '@/types/product';
import type { OpenOilDrumRequest } from '@/types/oilDrum';

const currencyFormatter = new Intl.NumberFormat('es-AR', {
  style: 'currency',
  currency: 'ARS',
});

function todayIso(): string {
  return new Date().toISOString().slice(0, 10);
}

export function DashboardPage() {
  const [drums, setDrums] = useState<OilDrumResponse[]>([]);
  const [products, setProducts] = useState<ProductResponse[]>([]);
  const [lowStock, setLowStock] = useState<ProductResponse[]>([]);
  const [report, setReport] = useState<DailyClosingReportResponse | null>(null);
  const [loading, setLoading] = useState(true);
  const [drumDialogOpen, setDrumDialogOpen] = useState(false);
  const navigate = useNavigate();

  async function loadData() {
    setLoading(true);
    try {
      const [drumsData, productsData, lowStockData, reportData] = await Promise.all([
        listOpenOilDrums(),
        listProducts(),
        listLowStockProducts(),
        getDailyClosingReport(todayIso()),
      ]);
      setDrums(drumsData);
      setProducts(productsData);
      setLowStock(lowStockData);
      setReport(reportData);
    } catch (error) {
      toast.error(error instanceof Error ? error.message : 'No se pudieron cargar los datos del panel.');
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    void loadData();
  }, []);

  async function handleOpenOilDrum(request: OpenOilDrumRequest) {
    try {
      await openOilDrum(request);
      toast.success('Tambor abierto correctamente.');
      await loadData();
    } catch (error) {
      toast.error(error instanceof Error ? error.message : 'No se pudo abrir el tambor.');
      throw error;
    }
  }

  async function handleCloseOilDrum(drum: OilDrumResponse, notes?: string | null) {
    try {
      await closeOilDrum(drum.id, { notes: notes ?? null });
      toast.success('Tambor cerrado correctamente.');
      await loadData();
    } catch (error) {
      toast.error(error instanceof Error ? error.message : 'No se pudo cerrar el tambor.');
    }
  }

  const totalOperations =
    (report?.completedSalesCount ?? 0) + (report?.completedServicesCount ?? 0);

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Panel y Tambores</h1>
        <p className="text-sm text-muted-foreground">
          Resumen general del mostrador y estado de los tambores de aceite.
        </p>
      </div>

      {/* KPIs */}
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        <Card>
          <CardHeader>
            <CardDescription>Total recaudado hoy</CardDescription>
            <CardTitle className="text-2xl">
              {loading ? '...' : currencyFormatter.format(report?.totalAmount ?? 0)}
            </CardTitle>
          </CardHeader>
        </Card>
        <Card>
          <CardHeader>
            <CardDescription>Operaciones realizadas</CardDescription>
            <CardTitle className="text-2xl">{loading ? '...' : totalOperations}</CardTitle>
          </CardHeader>
        </Card>
        <Card>
          <CardHeader>
            <CardDescription>Tambores activos</CardDescription>
            <CardTitle className="text-2xl">{loading ? '...' : drums.length}</CardTitle>
          </CardHeader>
        </Card>
        <Card>
          <CardHeader>
            <CardDescription>Alertas de reposición</CardDescription>
            <CardTitle className="flex items-center gap-2 text-2xl">
              {loading ? '...' : lowStock.length}
              {!loading && lowStock.length > 0 && (
                <Badge variant="destructive">Reponer</Badge>
              )}
            </CardTitle>
          </CardHeader>
        </Card>
      </div>

      {/* Tambores */}
      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <div>
            <h2 className="text-lg font-semibold tracking-tight">Tambores de aceite abiertos</h2>
            <p className="text-sm text-muted-foreground">
              Control visual del nivel disponible de cada tambor.
            </p>
          </div>
          <Button onClick={() => setDrumDialogOpen(true)}>Abrir Tambor Nuevo</Button>
        </div>

        {drums.length === 0 ? (
          <Card>
            <CardContent className="flex flex-col items-center gap-3 py-8 text-center">
              <p className="text-sm text-muted-foreground">
                No hay tambores de aceite abiertos en este momento.
              </p>
              <Button onClick={() => setDrumDialogOpen(true)}>Abrir un tambor</Button>
            </CardContent>
          </Card>
        ) : (
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {drums.map((drum) => (
              <OilDrumCard
                key={drum.id}
                drum={drum}
                onClose={handleCloseOilDrum}
              />
            ))}
          </div>
        )}
      </div>

      {/* Alertas de stock bajo */}
      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <div>
            <h2 className="text-lg font-semibold tracking-tight">Alertas de stock bajo / sin stock</h2>
            <p className="text-sm text-muted-foreground">
              Productos que alcanzaron su stock mínimo.
            </p>
          </div>
          <Button variant="outline" onClick={() => navigate('/inventario')}>
            Ir a Inventario
          </Button>
        </div>

        {lowStock.length === 0 ? (
          <Card>
            <CardContent className="py-6 text-center text-sm text-muted-foreground">
              No hay alertas de stock en este momento.
            </CardContent>
          </Card>
        ) : (
          <Card>
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Código WEGA</TableHead>
                  <TableHead>Nombre</TableHead>
                  <TableHead>Categoría</TableHead>
                  <TableHead className="text-right">Stock mostrador</TableHead>
                  <TableHead className="text-right">Stock depósito</TableHead>
                  <TableHead>Estado</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {lowStock.map((product) => {
                  const outOfStock = product.localStock <= 0;
                  return (
                    <TableRow key={product.id}>
                      <TableCell className="font-medium">{product.code}</TableCell>
                      <TableCell>{product.name}</TableCell>
                      <TableCell>{product.categoryName}</TableCell>
                      <TableCell className="text-right tabular-nums">{product.localStock}</TableCell>
                      <TableCell className="text-right tabular-nums">{product.warehouseStock}</TableCell>
                      <TableCell>
                        {outOfStock ? (
                          <Badge variant="destructive">Sin Stock</Badge>
                        ) : (
                          <Badge className="bg-amber-100 text-amber-800 hover:bg-amber-100">
                            Stock Bajo
                          </Badge>
                        )}
                      </TableCell>
                    </TableRow>
                  );
                })}
              </TableBody>
            </Table>
          </Card>
        )}
      </div>

      <OpenOilDrumDialog
        open={drumDialogOpen}
        onOpenChange={setDrumDialogOpen}
        products={products}
        onCreate={handleOpenOilDrum}
      />
    </div>
  );
}
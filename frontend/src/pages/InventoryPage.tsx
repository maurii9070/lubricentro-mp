import { useEffect, useMemo, useState } from 'react';

import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Switch } from '@/components/ui/switch';

import { InventoryTable } from '@/components/inventory/InventoryTable';
import { ProductFormDialog } from '@/components/inventory/ProductFormDialog';
import { PurchaseEntryDialog } from '@/components/inventory/PurchaseEntryDialog';
import { TransferStockDialog } from '@/components/inventory/TransferStockDialog';
import { ManualAdjustmentDialog } from '@/components/inventory/ManualAdjustmentDialog';
import { StockMovementsSheet } from '@/components/inventory/StockMovementsSheet';

import { listProducts } from '@/api/productApi';
import { listCategories } from '@/api/categoryApi';
import { toast } from 'sonner';

import type { CategoryResponse, ProductResponse } from '@/types/product';

export function InventoryPage() {
  const [products, setProducts] = useState<ProductResponse[]>([]);
  const [categories, setCategories] = useState<CategoryResponse[]>([]);
  const [loading, setLoading] = useState(true);

  const [searchTerm, setSearchTerm] = useState('');
  const [categoryId, setCategoryId] = useState<number | null>(null);
  const [lowStockOnly, setLowStockOnly] = useState(false);

  const [formOpen, setFormOpen] = useState(false);
  const [editingProduct, setEditingProduct] = useState<ProductResponse | null>(null);

  const [purchaseOpen, setPurchaseOpen] = useState(false);
  const [transferOpen, setTransferOpen] = useState(false);
  const [adjustOpen, setAdjustOpen] = useState(false);
  const [historyOpen, setHistoryOpen] = useState(false);
  const [selectedProduct, setSelectedProduct] = useState<ProductResponse | null>(null);

  async function loadProducts() {
    try {
      const data = await listProducts();
      setProducts(data);
    } catch (error) {
      toast.error(error instanceof Error ? error.message : 'No se pudo cargar el inventario.');
    }
  }

  useEffect(() => {
    let active = true;
    setLoading(true);
    void Promise.all([listProducts(), listCategories()])
      .then(([productsData, categoriesData]) => {
        if (!active) return;
        setProducts(productsData);
        setCategories(categoriesData);
      })
      .catch((error) => {
        if (!active) return;
        toast.error(error instanceof Error ? error.message : 'No se pudo cargar el inventario.');
      })
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, []);

  const filteredProducts = useMemo(() => {
    const term = searchTerm.trim().toLowerCase();
    return products.filter((product) => {
      if (categoryId !== null && product.categoryId !== categoryId) {
        return false;
      }
      if (lowStockOnly) {
        const total = product.localStock + product.warehouseStock;
        if (!(total === 0 || total <= product.minStock)) {
          return false;
        }
      }
      if (term) {
        const normalize = (value: string) => value.toLowerCase().replace(/[-\s]/g, '');
        const nTerm = normalize(term);
        const code = normalize(product.code ?? '');
        const name = normalize(product.name);
        const brand = normalize(product.brand ?? '');
        if (!code.includes(nTerm) && !name.includes(nTerm) && !brand.includes(nTerm)) {
          return false;
        }
      }
      return true;
    });
  }, [products, searchTerm, categoryId, lowStockOnly]);

  function handleNewProduct() {
    setEditingProduct(null);
    setFormOpen(true);
  }

  function handleEdit(product: ProductResponse) {
    setEditingProduct(product);
    setFormOpen(true);
  }

  function handlePurchase(product: ProductResponse) {
    setSelectedProduct(product);
    setPurchaseOpen(true);
  }

  function handleTransfer(product: ProductResponse) {
    setSelectedProduct(product);
    setTransferOpen(true);
  }

  function handleAdjust(product: ProductResponse) {
    setSelectedProduct(product);
    setAdjustOpen(true);
  }

  function handleHistory(product: ProductResponse) {
    setSelectedProduct(product);
    setHistoryOpen(true);
  }

  async function handleCompleted() {
    await loadProducts();
  }

  function handleSaved(saved: ProductResponse) {
    setProducts((prev) => {
      const exists = prev.some((p) => p.id === saved.id);
      if (exists) {
        return prev.map((p) => (p.id === saved.id ? saved : p));
      }
      return [saved, ...prev];
    });
  }

  return (
    <div className="space-y-6">
      <div className="flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h1 className="text-2xl font-bold tracking-tight">Inventario</h1>
          <p className="text-sm text-muted-foreground">
            Gestión de productos, stock y movimientos.
          </p>
        </div>
        <Button onClick={handleNewProduct}>+ Nuevo Producto</Button>
      </div>

      <div className="flex flex-col gap-3 rounded-lg border bg-background p-4 md:flex-row md:items-center">
        <div className="flex-1">
          <Input
            id="inventory-search"
            value={searchTerm}
            onChange={(event) => setSearchTerm(event.target.value)}
            placeholder="Buscar por código o nombre (ej. fap9013, selenia)"
            className="h-9"
          />
        </div>

        <div className="md:w-64">
          <Select
            value={categoryId === null ? 'all' : String(categoryId)}
            onValueChange={(value) => setCategoryId(value === 'all' ? null : Number(value))}
            items={[
              { value: 'all', label: 'Todas las categorías' },
              ...categories.map((category) => ({ value: String(category.id), label: category.name })),
            ]}
          >
            <SelectTrigger className="h-9 w-full">
              <SelectValue className="truncate" placeholder="Todas las categorías" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">Todas las categorías</SelectItem>
              {categories.map((category) => (
                <SelectItem key={category.id} value={String(category.id)}>
                  {category.name}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>

        <label className="flex h-9 cursor-pointer items-center gap-2 whitespace-nowrap text-sm">
          <Switch checked={lowStockOnly} onCheckedChange={setLowStockOnly} />
          Solo stock bajo o agotado
        </label>
      </div>

      {loading ? (
        <p className="py-8 text-center text-sm text-muted-foreground">Cargando inventario...</p>
      ) : (
        <InventoryTable
          products={filteredProducts}
          onPurchase={handlePurchase}
          onTransfer={handleTransfer}
          onAdjust={handleAdjust}
          onEdit={handleEdit}
          onHistory={handleHistory}
        />
      )}

      <ProductFormDialog
        open={formOpen}
        onOpenChange={setFormOpen}
        product={editingProduct}
        categories={categories}
        onSaved={handleSaved}
      />

      <PurchaseEntryDialog
        open={purchaseOpen}
        onOpenChange={setPurchaseOpen}
        product={selectedProduct}
        onCompleted={handleCompleted}
      />

      <TransferStockDialog
        open={transferOpen}
        onOpenChange={setTransferOpen}
        product={selectedProduct}
        onCompleted={handleCompleted}
      />

      <ManualAdjustmentDialog
        open={adjustOpen}
        onOpenChange={setAdjustOpen}
        product={selectedProduct}
        onCompleted={handleCompleted}
      />

      <StockMovementsSheet
        open={historyOpen}
        onOpenChange={setHistoryOpen}
        product={selectedProduct}
      />
    </div>
  );
}

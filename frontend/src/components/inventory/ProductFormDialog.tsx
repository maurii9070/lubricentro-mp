import { useEffect, useState } from 'react';

import { Button } from '@/components/ui/button';
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Switch } from '@/components/ui/switch';

import { createProduct, updateProduct } from '@/api/productApi';
import { toast } from 'sonner';

import type { CategoryResponse, ProductRequest, ProductResponse } from '@/types/product';

interface ProductFormDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  product: ProductResponse | null;
  categories: CategoryResponse[];
  onSaved: (product: ProductResponse) => void;
}

export function ProductFormDialog({
  open,
  onOpenChange,
  product,
  categories,
  onSaved,
}: ProductFormDialogProps) {
  const isEdit = product !== null;

  const [categoryId, setCategoryId] = useState<number>(categories[0]?.id ?? 0);
  const [code, setCode] = useState('');
  const [name, setName] = useState('');
  const [brand, setBrand] = useState('');
  const [tracksStock, setTracksStock] = useState(true);
  const [minStock, setMinStock] = useState(0);
  const [listPrice, setListPrice] = useState(0);
  const [localStock, setLocalStock] = useState(0);
  const [warehouseStock, setWarehouseStock] = useState(0);
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    if (!open) return;
    if (product) {
      setCategoryId(product.categoryId);
      setCode(product.code ?? '');
      setName(product.name);
      setBrand(product.brand ?? '');
      setTracksStock(product.tracksStock);
      setMinStock(product.minStock);
      setListPrice(product.listPrice);
      setLocalStock(product.localStock);
      setWarehouseStock(product.warehouseStock);
    } else {
      setCategoryId(categories[0]?.id ?? 0);
      setCode('');
      setName('');
      setBrand('');
      setTracksStock(true);
      setMinStock(0);
      setListPrice(0);
      setLocalStock(0);
      setWarehouseStock(0);
    }
  }, [open, product, categories]);

  async function handleSubmit() {
    if (!name.trim()) {
      toast.error('El nombre del producto es obligatorio.');
      return;
    }
    if (!categoryId) {
      toast.error('La categoría es obligatoria.');
      return;
    }
    const price = Number(listPrice);
    if (Number.isNaN(price) || price < 0) {
      toast.error('El precio de lista no puede ser negativo.');
      return;
    }
    setSubmitting(true);
    try {
      const request: ProductRequest = {
        categoryId,
        code: code.trim() ? code.trim() : null,
        name: name.trim(),
        brand: brand.trim() ? brand.trim() : null,
        tracksStock,
        localStock: isEdit ? localStock : 0,
        warehouseStock: isEdit ? warehouseStock : 0,
        minStock: Number(minStock) || 0,
        listPrice: price,
      };
      const saved = isEdit
        ? await updateProduct(product!.id, request)
        : await createProduct(request);
      toast.success(isEdit ? 'Producto actualizado correctamente.' : 'Producto creado correctamente.');
      onSaved(saved);
      onOpenChange(false);
    } catch (error) {
      toast.error(error instanceof Error ? error.message : 'No se pudo guardar el producto.');
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-lg">
        <DialogHeader>
          <DialogTitle>{isEdit ? 'Editar producto' : 'Nuevo producto'}</DialogTitle>
          <DialogDescription>
            {isEdit
              ? 'Actualizá los datos del producto. El stock se gestiona desde las acciones de la tabla.'
              : 'Cargá un producto nuevo al catálogo.'}
          </DialogDescription>
        </DialogHeader>

        <div className="space-y-4">
          <div className="space-y-2">
            <Label>Categoría *</Label>
            <Select
              value={String(categoryId)}
              onValueChange={(value) => setCategoryId(Number(value))}
              items={categories.map((category) => ({ value: String(category.id), label: category.name }))}
            >
              <SelectTrigger className="w-full">
                <SelectValue placeholder="Seleccioná una categoría" />
              </SelectTrigger>
              <SelectContent>
                {categories.map((category) => (
                  <SelectItem key={category.id} value={String(category.id)}>
                    {category.name}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          <div className="grid grid-cols-2 gap-3">
            <div className="space-y-2">
              <Label htmlFor="product-code">Código</Label>
              <Input
                id="product-code"
                value={code}
                onChange={(event) => setCode(event.target.value)}
                placeholder="Ej. FAP9013"
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="product-brand">Marca</Label>
              <Input
                id="product-brand"
                value={brand}
                onChange={(event) => setBrand(event.target.value)}
                placeholder="Ej. WEGA"
              />
            </div>
          </div>

          <div className="space-y-2">
            <Label htmlFor="product-name">Nombre *</Label>
            <Input
              id="product-name"
              value={name}
              onChange={(event) => setName(event.target.value)}
              placeholder="Nombre del producto"
            />
          </div>

          <div className="grid grid-cols-2 gap-3">
            <div className="space-y-2">
              <Label htmlFor="product-min-stock">Stock mínimo</Label>
              <Input
                id="product-min-stock"
                type="number"
                min={0}
                value={minStock}
                onChange={(event) => setMinStock(Number(event.target.value))}
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="product-price">Precio de lista *</Label>
              <Input
                id="product-price"
                type="number"
                min={0}
                step="0.01"
                value={listPrice}
                onChange={(event) => setListPrice(Number(event.target.value))}
              />
            </div>
          </div>

          <div className="flex items-center justify-between rounded-md border p-3">
            <div>
              <p className="text-sm font-medium">Controla stock</p>
              <p className="text-xs text-muted-foreground">
                Desactivá para productos o servicios sin inventario.
              </p>
            </div>
            <Switch checked={tracksStock} onCheckedChange={setTracksStock} />
          </div>
        </div>

        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)} disabled={submitting}>
            Cancelar
          </Button>
          <Button onClick={handleSubmit} disabled={submitting}>
            {submitting ? 'Guardando...' : isEdit ? 'Guardar cambios' : 'Crear producto'}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

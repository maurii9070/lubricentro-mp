import { useEffect, useState } from 'react';

import { Button } from '@/components/ui/button';
import { Command, CommandEmpty, CommandGroup, CommandInput, CommandItem, CommandList } from '@/components/ui/command';
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Popover, PopoverContent, PopoverTrigger } from '@/components/ui/popover';

import { searchProducts } from '@/api/productApi';
import { toast } from 'sonner';

import type { ProductResponse } from '@/types/product';

interface ProductSearchBoxProps {
  openDrumsByProduct: Map<number, number>;
  onAddProduct: (product: ProductResponse) => void;
  onAddManualItem: (description: string, unitPrice: number) => void;
}

const DRUM_CATEGORY_NAME = 'Aceite Tambor';

export function ProductSearchBox({
  openDrumsByProduct,
  onAddProduct,
  onAddManualItem,
}: ProductSearchBoxProps) {
  const [open, setOpen] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const [debouncedTerm, setDebouncedTerm] = useState('');
  const [results, setResults] = useState<ProductResponse[]>([]);
  const [loading, setLoading] = useState(false);

  const [manualOpen, setManualOpen] = useState(false);
  const [manualDescription, setManualDescription] = useState('');
  const [manualPrice, setManualPrice] = useState('');

  useEffect(() => {
    const handle = window.setTimeout(() => setDebouncedTerm(searchTerm), 250);
    return () => window.clearTimeout(handle);
  }, [searchTerm]);

  useEffect(() => {
    let active = true;
    async function load() {
      if (debouncedTerm.trim().length < 2) {
        setResults([]);
        return;
      }
      setLoading(true);
      try {
        const data = await searchProducts(debouncedTerm);
        if (active) {
          setResults(data);
        }
      } catch (error) {
        if (active) {
          toast.error(error instanceof Error ? error.message : 'No se pudieron buscar productos.');
        }
      } finally {
        if (active) {
          setLoading(false);
        }
      }
    }
    void load();
    return () => {
      active = false;
    };
  }, [debouncedTerm]);

  function handleAddProduct(product: ProductResponse) {
    onAddProduct(product);
    setOpen(false);
    setSearchTerm('');
    setResults([]);
  }

  function handleManualSubmit() {
    if (!manualDescription.trim() || !manualPrice) {
      return;
    }
    const price = Number(manualPrice);
    if (Number.isNaN(price) || price < 0) {
      return;
    }
    onAddManualItem(manualDescription.trim(), price);
    setManualDescription('');
    setManualPrice('');
    setManualOpen(false);
  }

  return (
    <div className="space-y-3">
      <div className="flex flex-wrap items-center gap-2">
        <Popover open={open} onOpenChange={setOpen}>
          <PopoverTrigger
            render={
              <Button variant="outline" className="flex-1 justify-start text-muted-foreground">
                Buscar producto por código o nombre...
              </Button>
            }
          />
          <PopoverContent className="w-[360px] max-w-[calc(100vw-2rem)] p-0" align="start">
            <Command shouldFilter={false}>
              <CommandInput
                placeholder="Escribí al menos 2 caracteres..."
                value={searchTerm}
                onValueChange={setSearchTerm}
              />
              <CommandList>
                {loading && (
                  <div className="py-6 text-center text-sm text-muted-foreground">
                    Buscando...
                  </div>
                )}
                {!loading && debouncedTerm.trim().length >= 2 && results.length === 0 && (
                  <CommandEmpty>Sin resultados.</CommandEmpty>
                )}
                {!loading && results.length > 0 && (
                  <CommandGroup heading="Productos">
                    {results.map((product) => {
                      const isDrumOil = product.categoryName === DRUM_CATEGORY_NAME;
                      const drumRemaining = isDrumOil
                        ? (openDrumsByProduct.get(product.id) ?? 0)
                        : null;
                      const hasDrum = isDrumOil ? openDrumsByProduct.has(product.id) : true;
                      return (
                        <CommandItem
                          key={product.id}
                          value={String(product.id)}
                          onSelect={() => {
                            if (isDrumOil && !hasDrum) {
                              return;
                            }
                            handleAddProduct(product);
                          }}
                          className="flex items-center justify-between gap-2"
                        >
                          <div className="flex min-w-0 flex-col">
                            <span className="truncate text-sm font-medium">
                              {product.code} — {product.name}
                            </span>
                            <span className="truncate text-xs text-muted-foreground">
                              {product.brand} · ${product.listPrice.toFixed(2)}
                            </span>
                          </div>
                          <div className="shrink-0 text-right text-xs">
                            {isDrumOil ? (
                              hasDrum ? (
                                <span className="text-emerald-600">
                                  {drumRemaining} L disponibles
                                </span>
                              ) : (
                                <span className="font-medium text-destructive">
                                  Sin tambor abierto
                                </span>
                              )
                            ) : (
                              <span className="text-muted-foreground">
                                Local: {product.localStock} · Depósito: {product.warehouseStock}
                              </span>
                            )}
                          </div>
                        </CommandItem>
                      );
                    })}
                  </CommandGroup>
                )}
              </CommandList>
            </Command>
          </PopoverContent>
        </Popover>

        <Button type="button" onClick={() => setManualOpen(true)}>
          + Ítem Libre / Manual
        </Button>
      </div>

      <Dialog open={manualOpen} onOpenChange={setManualOpen}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader>
            <DialogTitle>Ítem libre / manual</DialogTitle>
            <DialogDescription>
              Cargá un servicio o repuesto eventual sin código de catálogo.
            </DialogDescription>
          </DialogHeader>

          <div className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="manual-description">Descripción *</Label>
              <Input
                id="manual-description"
                value={manualDescription}
                onChange={(event) => setManualDescription(event.target.value)}
                placeholder="Ej. Mano de obra, lavado"
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="manual-price">Precio unitario *</Label>
              <Input
                id="manual-price"
                type="number"
                min={0}
                step="0.01"
                value={manualPrice}
                onChange={(event) => setManualPrice(event.target.value)}
                placeholder="0.00"
              />
            </div>
          </div>

          <DialogFooter>
            <Button variant="outline" onClick={() => setManualOpen(false)}>
              Cancelar
            </Button>
            <Button onClick={handleManualSubmit}>Agregar</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
export interface ProductResponse {
  id: number;
  categoryId: number;
  categoryName: string;
  code: string | null;
  name: string;
  brand: string | null;
  tracksStock: boolean;
  localStock: number;
  warehouseStock: number;
  minStock: number;
  listPrice: number;
  active: boolean;
}

export interface CategoryResponse {
  id: number;
  name: string;
  active: boolean;
}

export interface ProductRequest {
  categoryId: number;
  code: string | null;
  name: string;
  brand: string | null;
  tracksStock: boolean;
  localStock: number;
  warehouseStock: number;
  minStock: number;
  listPrice: number;
}

export interface TransferStockRequest {
  quantity: number;
}

export interface ProductFilter {
  term?: string;
  categoryId?: number | null;
  lowStockOnly?: boolean;
}

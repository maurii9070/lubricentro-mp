export interface ProductResponse {
  id: number;
  categoryId: number;
  categoryName: string;
  code: string;
  name: string;
  brand: string;
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
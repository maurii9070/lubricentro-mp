import { create } from 'zustand';

import type { OperationType, PaymentMethod } from '@/types/common';
import type { VehicleResponse } from '@/types/vehicle';

export interface PosCartItem {
  key: string;
  productId: number | null;
  description: string;
  isDrumOil: boolean;
  drumRemainingLiters: number | null;
  quantity: number;
  unitPrice: number;
  isManual: boolean;
}

export interface PosPayment {
  paymentMethod: PaymentMethod;
  amount: number;
}

interface PosState {
  operationType: OperationType;
  operationDate: string;
  items: PosCartItem[];
  selectedVehicle: VehicleResponse | null;
  mileage: number | null;
  technicalNotes: string;
  totalCharged: number;
  isTotalOverridden: boolean;
  payments: PosPayment[];

  setOperationType: (value: OperationType) => void;
  setOperationDate: (value: string) => void;
  addItem: (item: Omit<PosCartItem, 'key'> & { key?: string }) => void;
  removeItem: (key: string) => void;
  updateItemQuantity: (key: string, quantity: number) => void;
  updateItemUnitPrice: (key: string, unitPrice: number) => void;
  setSelectedVehicle: (vehicle: VehicleResponse | null) => void;
  setMileage: (value: number | null) => void;
  setTechnicalNotes: (value: string) => void;
  setTotalCharged: (value: number) => void;
  resetTotalCharged: () => void;
  addPayment: () => void;
  removePayment: (index: number) => void;
  updatePayment: (index: number, patch: Partial<PosPayment>) => void;
  completeBalance: (index: number) => void;
  resetPos: () => void;
}

function nowLocalDateTime(): string {
  const date = new Date();
  const pad = (value: number) => String(value).padStart(2, '0');
  return `${date.getFullYear()}-${pad(date.getMonth() + 1)}-${pad(date.getDate())}T${pad(
    date.getHours()
  )}:${pad(date.getMinutes())}`;
}

function calculateSubtotal(items: PosCartItem[]): number {
  return items.reduce(
    (accumulator, item) => accumulator + item.quantity * item.unitPrice,
    0
  );
}

function normalizeMoney(value: number): number {
  return Math.round(value * 100) / 100;
}

export const usePosStore = create<PosState>((set, get) => ({
  operationType: 'QUICK_SALE',
  operationDate: nowLocalDateTime(),
  items: [],
  selectedVehicle: null,
  mileage: null,
  technicalNotes: '',
  totalCharged: 0,
  isTotalOverridden: false,
  payments: [{ paymentMethod: 'CASH', amount: 0 }],

  setOperationType: (value) => set({ operationType: value }),

  setOperationDate: (value) => set({ operationDate: value }),

  addItem: (item) => {
    const key = item.key ?? `${Date.now()}-${Math.random().toString(36).slice(2)}`;
    const newItem: PosCartItem = { ...item, key };
    set((state) => {
      const items = [...state.items, newItem];
      const subtotal = normalizeMoney(calculateSubtotal(items));
      return {
        items,
        totalCharged: state.isTotalOverridden ? state.totalCharged : subtotal,
      };
    });
  },

  removeItem: (key) => {
    set((state) => {
      const items = state.items.filter((item) => item.key !== key);
      const subtotal = normalizeMoney(calculateSubtotal(items));
      return {
        items,
        totalCharged: state.isTotalOverridden ? state.totalCharged : subtotal,
      };
    });
  },

  updateItemQuantity: (key, quantity) => {
    set((state) => {
      const items = state.items.map((item) =>
        item.key === key ? { ...item, quantity } : item
      );
      const subtotal = normalizeMoney(calculateSubtotal(items));
      return {
        items,
        totalCharged: state.isTotalOverridden ? state.totalCharged : subtotal,
      };
    });
  },

  updateItemUnitPrice: (key, unitPrice) => {
    set((state) => {
      const items = state.items.map((item) =>
        item.key === key ? { ...item, unitPrice } : item
      );
      const subtotal = normalizeMoney(calculateSubtotal(items));
      return {
        items,
        totalCharged: state.isTotalOverridden ? state.totalCharged : subtotal,
      };
    });
  },

  setSelectedVehicle: (vehicle) => set({ selectedVehicle: vehicle }),

  setMileage: (value) => set({ mileage: value }),

  setTechnicalNotes: (value) => set({ technicalNotes: value }),

  setTotalCharged: (value) => set({ totalCharged: value, isTotalOverridden: true }),

  resetTotalCharged: () => {
    const subtotal = normalizeMoney(calculateSubtotal(get().items));
    set({ totalCharged: subtotal, isTotalOverridden: false });
  },

  addPayment: () =>
    set((state) => ({
      payments: [...state.payments, { paymentMethod: 'CASH', amount: 0 }],
    })),

  removePayment: (index) =>
    set((state) => ({
      payments: state.payments.filter((_, currentIndex) => currentIndex !== index),
    })),

  updatePayment: (index, patch) =>
    set((state) => ({
      payments: state.payments.map((payment, currentIndex) =>
        currentIndex === index ? { ...payment, ...patch } : payment
      ),
    })),

  completeBalance: (index) => {
    set((state) => {
      const otherTotal = state.payments.reduce(
        (accumulator, payment, currentIndex) =>
          currentIndex === index ? accumulator : accumulator + payment.amount,
        0
      );
      const remaining = normalizeMoney(state.totalCharged - otherTotal);
      const payments = state.payments.map((payment, currentIndex) =>
        currentIndex === index ? { ...payment, amount: Math.max(remaining, 0) } : payment
      );
      return { payments };
    });
  },

  resetPos: () =>
    set({
      operationType: 'QUICK_SALE',
      operationDate: nowLocalDateTime(),
      items: [],
      selectedVehicle: null,
      mileage: null,
      technicalNotes: '',
      totalCharged: 0,
      isTotalOverridden: false,
      payments: [{ paymentMethod: 'CASH', amount: 0 }],
    }),
}));
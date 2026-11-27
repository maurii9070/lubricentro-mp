import { create } from 'zustand';

import type { Shift } from '@/types/common';

interface AppStore {
  currentShift: Shift;
  setCurrentShift: (shift: Shift) => void;
  // Prepared for future stages: stock alerts and sales cart.
}

const getInitialShift = (): Shift => {
  const currentHour = new Date().getHours();
  return currentHour < 14 ? 'MORNING' : 'AFTERNOON';
};

export const useAppStore = create<AppStore>((set) => ({
  currentShift: getInitialShift(),
  setCurrentShift: (shift) => set({ currentShift: shift }),
}));

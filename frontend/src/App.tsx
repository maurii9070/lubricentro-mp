import { BrowserRouter, Route, Routes } from 'react-router-dom';

import { Toaster } from '@/components/ui/sonner';
import { MainLayout } from '@/components/layout/MainLayout';
import { DashboardPage } from '@/pages/DashboardPage';
import { DailyClosingPage } from '@/pages/DailyClosingPage';
import { InventoryPage } from '@/pages/InventoryPage';
import { PosPage } from '@/pages/PosPage';
import { VehiclesPage } from '@/pages/VehiclesPage';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route element={<MainLayout />}>
          <Route index element={<DashboardPage />} />
          <Route path="mostrador" element={<PosPage />} />
          <Route path="inventario" element={<InventoryPage />} />
          <Route path="vehiculos" element={<VehiclesPage />} />
          <Route path="cierre-caja" element={<DailyClosingPage />} />
        </Route>
      </Routes>
      <Toaster richColors position="top-right" />
    </BrowserRouter>
  );
}

export default App;

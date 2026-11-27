import { NavLink, Outlet } from 'react-router-dom';
import {
  BarChart3,
  Car,
  LayoutDashboard,
  Package,
  ShoppingCart,
  Wallet,
} from 'lucide-react';

import { Button } from '@/components/ui/button';
import { Separator } from '@/components/ui/separator';
import { useAppStore } from '@/store/useAppStore';

const navigationItems = [
  { to: '/', label: 'Panel y Tambores', icon: LayoutDashboard, end: true },
  { to: '/mostrador', label: 'Mostrador / Ventas', icon: ShoppingCart },
  { to: '/inventario', label: 'Inventario', icon: Package },
  { to: '/vehiculos', label: 'Vehículos', icon: Car },
  { to: '/cierre-caja', label: 'Cierre de Caja', icon: Wallet },
];

export function MainLayout() {
  const currentShift = useAppStore((state) => state.currentShift);
  const setCurrentShift = useAppStore((state) => state.setCurrentShift);

  return (
    <div className="flex min-h-screen flex-col bg-muted/30 md:flex-row">
      <aside className="flex w-full flex-col gap-4 border-b bg-background p-4 md:w-64 md:border-b-0 md:border-r">
        <div className="flex items-center gap-2">
          <BarChart3 className="size-6 text-primary" />
          <span className="text-lg font-semibold tracking-tight">Lubricentro MP</span>
        </div>

        <div className="flex flex-col gap-2">
          <span className="text-xs font-medium uppercase text-muted-foreground">
            Turno activo
          </span>
          <div className="flex gap-2">
            <Button
              variant={currentShift === 'MORNING' ? 'default' : 'outline'}
              size="sm"
              className="flex-1"
              onClick={() => setCurrentShift('MORNING')}
            >
              Turno Mañana
            </Button>
            <Button
              variant={currentShift === 'AFTERNOON' ? 'default' : 'outline'}
              size="sm"
              className="flex-1"
              onClick={() => setCurrentShift('AFTERNOON')}
            >
              Turno Tarde
            </Button>
          </div>
        </div>

        <Separator />

        <nav className="flex flex-row gap-1 overflow-x-auto md:flex-col">
          {navigationItems.map((item) => {
            const Icon = item.icon;
            return (
              <NavLink
                key={item.to}
                to={item.to}
                end={item.end}
                className={({ isActive }) =>
                  `flex items-center gap-3 rounded-md px-3 py-2 text-sm font-medium transition-colors ${
                    isActive
                      ? 'bg-primary text-primary-foreground'
                      : 'text-muted-foreground hover:bg-muted hover:text-foreground'
                  }`
                }
              >
                <Icon className="size-4 shrink-0" />
                <span className="whitespace-nowrap">{item.label}</span>
              </NavLink>
            );
          })}
        </nav>
      </aside>

      <main className="flex-1 overflow-auto p-4 md:p-6">
        <Outlet />
      </main>
    </div>
  );
}

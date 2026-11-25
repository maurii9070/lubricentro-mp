-- V11: carga inicial de los kits de filtros WEGA desde la hoja 'STOCK MP' de
-- 'STOCK MP ESCRITORIO .xlsx' (filas 179 a 210, índices pandas 177 a 208).
-- Total: 32 registros.
-- Código NULL; nombre normalizado con composición de filtros entre paréntesis;
-- precios redondeados a 2 decimales; min_stock = 1; DEPOSITO no numérico -> 0.

INSERT INTO categories (name) VALUES ('Kits de Filtros') ON CONFLICT (name) DO NOTHING;

INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT S10 (AKX1993/FCD-0777/FCD-0777/WOE314/WR295)', 'WEGA', TRUE, 2, 0, 1, 88195.70, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT NISSAN FRONTIER2,3 N (AKX1993/FAP8001/FCD2173-1/WOE506)', 'WEGA', TRUE, 1, 0, 1, 159834.82, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT HILUX 2016 (AKX-1967, JFA-0282, JFC-207/3, JFO-0211)', 'WEGA', TRUE, 2, 0, 1, 68726.30, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT HILUX 2011 (AKX-1965/JFA-0292/2/JFC-207/2/JFO-0211)', 'WEGA', TRUE, 3, 0, 1, 66449.95, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT AMAROK 2,0 2016 (AKX-1140/C, FAP-4046/1, FCD-0922, WOE-680)', 'WEGA', TRUE, 1, 0, 1, 147511.94, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT AMAROK FAP 0919 (AKX-1140/C/FAP-4046/1/FCD-0919/WOE-680)', 'WEGA', TRUE, 2, 0, 1, 99596.23, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT TORO 2,0 2016 (JFA-0998 / WOE-626 / FCD-0793 / AKX-2108)', 'WEGA', TRUE, 1, 0, 1, 97790.83, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT TORO RENEGADE (JFA-0998 / WOE-912 / FCI-1661 / AKX-2108)', 'WEGA', TRUE, 0, 0, 1, 54803.59, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT AMAROK V6 (WOE 681/FAP 4046/1/AKX 1140/C/FCD 0923)', 'WEGA', TRUE, 1, 0, 1, 155897.17, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT RANGER 3,0 (FCD-2061/WOE-130/WR-198)', 'WEGA', TRUE, 3, 0, 1, 81540.71, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT RANGER 2,2 (WR-191/WOE-131/FCD0808/AKX-35177)', 'WEGA', TRUE, 3, 0, 1, 128072.74, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT RANGER RAPTOR2,0 (F8520/WOE131/F0810/A35177)', 'WEGA', TRUE, 1, 0, 1, 145260.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT KANGOO 1,5 DCI (FAP-9299/WO-215/FCD-0795/AKX-1944)', 'WEGA', TRUE, 1, 0, 1, 82812.72, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT CRUZE 1,8 (FAP-3261/WOE-313/AKX-35723)', 'WEGA', TRUE, 1, 0, 1, 44150.90, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT ARGO CRONO 1,3 (AKX-35323 /FAP-2829 /FCI-1600 /WO-121)', 'WEGA', TRUE, 1, 0, 1, 47296.76, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT TRACKER 1,8 (FAP-3270/WOE-313/AKX-35723)', 'WEGA', TRUE, 0, 0, 1, 40043.84, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT NISSAN KICKS (JFA-0137/JFO-0197/FCI-1630/AKX-1399)', 'WEGA', TRUE, 2, 0, 1, 46084.42, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT RENAULT KWID (FAP-5218 AKX-1215 FCI-1630 WO-412)', 'WEGA', TRUE, 2, 0, 1, 41892.01, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT ETIOS F4041 (FAP-4041/JFO-0210/AKX-2161)', 'WEGA', TRUE, 0, 0, 1, 36755.84, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT VENTO (WOE-640/FAP-6012/2/FCI-1303/AKX-1100/C)', 'WEGA', TRUE, 1, 0, 1, 108323.73, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT SURAN/FOX 1,6MSI (FAP-2219/WO-346/FCI-1630/AKX-1129F)', 'WEGA', TRUE, 0, 0, 1, 43979.77, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT COROLLA 1,8 (AKX-1965, JFA-0285, WOE-803)', 'WEGA', TRUE, 0, 0, 1, 32256.75, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT SURAN/FOX 1,6 (AKX-35163/FAP-7007/FCI-1620/WO-340)', 'WEGA', TRUE, 3, 0, 1, 40694.13, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT ONIX 1,4 (FAP-3286/WO-130/FCI-1660/AKX-35723)', 'WEGA', TRUE, 0, 0, 1, 43808.65, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT ONIX 1,2 (FAP-3233/WO-139/FCI-1660/AKX-35725)', 'WEGA', TRUE, 0, 0, 1, 44012.97, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT CRUZE 1,4T (WR-150/WO-138/AKX-35725)', 'WEGA', TRUE, 0, 0, 1, 53075.92, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT CAPTUR (FAP-9299 WO-200 FCI-1630 AKX-1399)', 'WEGA', TRUE, 0, 0, 1, 44150.90, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT RENAULT DUSTER OROCH 2.0 (FAP-9299/WO-200/FCI-1630/AKX-1397)', 'WEGA', TRUE, 0, 0, 1, 42295.96, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT FIAT PALIO (AKX-35321/FAP-2831/FCI-1600/WO-120)', 'WEGA', TRUE, 0, 0, 1, 33413.82, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT FIAT PALIO ETORQ (WOE-912/FAP-9121/FCI-1600/AKX-35321)', 'WEGA', TRUE, 0, 0, 1, 43506.17, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIT VW UP (FAP-3288 AKX-35280 FCI-1630 WO-346)', 'WEGA', TRUE, 0, 0, 1, 48187.18, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Kits de Filtros'), NULL, 'KIA CERATO 2,0 (AKX-2014/JFA-0H26/JFO-0598)', 'WEGA', TRUE, 0, 0, 1, 75152.45, TRUE);

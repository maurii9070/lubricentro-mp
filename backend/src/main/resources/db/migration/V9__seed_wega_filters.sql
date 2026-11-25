-- V9: carga inicial de los filtros WEGA desde la hoja 'STOCK MP' de
-- 'STOCK MP ESCRITORIO .xlsx' (filas 3 a 166; las lámparas empiezan en la fila 167).
-- Total: 162 registros (FCI-1650/1880 se separó en dos productos).
-- Precios redondeados a 2 decimales; stocks normalizados (X<n> -> n, '0/4' -> 0, vacío -> 0).

INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'JFA-0131', 'JFA-0131', 'WEGA', TRUE, 1, 0, 1, 20978.87, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'JFA-0134', 'JFA-0134', 'WEGA', TRUE, 1, 0, 1, 8630.88, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'JFA-0249', 'JFA-0249', 'WEGA', TRUE, 2, 0, 1, 20978.87, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'JFA-0285', 'JFA-0285', 'WEGA', TRUE, 5, 0, 1, 13574.80, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'JFA-0602', 'JFA-0602', 'WEGA', TRUE, 2, 0, 1, 15970.35, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'JFA-0H26', 'JFA-0H26', 'WEGA', TRUE, 1, 0, 1, 37800.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'JFA-0G03', 'JFA-0G03', 'WEGA', TRUE, 1, 0, 1, 27973.54, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'WR-150', 'WR-150', 'WEGA', TRUE, 3, 0, 1, 22828.40, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'WR-191', 'WR-191', 'WEGA', TRUE, 0, 0, 1, 30802.96, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'WR-192', 'WR-192', 'WEGA', TRUE, 4, 0, 1, 20535.29, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'WR-198', 'WR-198', 'WEGA', TRUE, 2, 0, 1, 30802.96, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'WR-245', 'WR-245', 'WEGA', TRUE, 1, 0, 1, 15230.36, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'WR-275', 'WR-275', 'WEGA', TRUE, 1, 0, 1, 16402.59, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-2219', 'FAP-2219', 'WEGA', TRUE, 4, 6, 1, 10609.90, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-2802', 'FAP-2802', 'WEGA', TRUE, 2, 0, 1, 20124.60, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-2822', 'FAP-2822', 'WEGA', TRUE, 1, 0, 1, 15230.35, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-2827', 'FAP-2827', 'WEGA', TRUE, 0, 0, 1, 8008.78, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-2829', 'FAP-2829', 'WEGA', TRUE, 4, 0, 1, 12729.96, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-2831', 'FAP-2831', 'WEGA', TRUE, 2, 0, 1, 8761.72, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-2832', 'FAP-2832', 'WEGA', TRUE, 2, 0, 1, 13952.96, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-2835', 'FAP-2835', 'WEGA', TRUE, 1, 0, 1, 15228.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-2840', 'FAP-2840', 'WEGA', TRUE, 2, 0, 1, 13727.17, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-3233', 'FAP-3233', 'WEGA', TRUE, 1, 0, 1, 13690.19, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-3269', 'FAP-3269', 'WEGA', TRUE, 8, 0, 1, 12002.87, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-3270', 'FAP-3270', 'WEGA', TRUE, 1, 0, 1, 13005.69, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-3281', 'FAP-3281', 'WEGA', TRUE, 2, 0, 1, 22832.18, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-3285', 'FAP-3285', 'WEGA', TRUE, 4, 0, 1, 20535.29, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-3286', 'FAP-3286', 'WEGA', TRUE, 2, 0, 1, 14032.46, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-3287', 'FAP-3287', 'WEGA', TRUE, 0, 0, 1, 9313.91, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-3288', 'FAP-3288', 'WEGA', TRUE, 6, 0, 1, 16770.50, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-3289', 'FAP-3289', 'WEGA', TRUE, 4, 0, 1, 11829.89, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-3599', 'FAP-3599', 'WEGA', TRUE, 2, 0, 1, 20535.29, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-3602', 'FAP-3602', 'WEGA', TRUE, 1, 5, 1, 10609.90, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-4033', 'FAP-4033', 'WEGA', TRUE, 5, 0, 1, 11431.30, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-4041', 'FAP-4041', 'WEGA', TRUE, 1, 0, 1, 10913.07, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-4042', 'FAP-4042', 'WEGA', TRUE, 1, 0, 1, 17112.60, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-4043', 'FAP-4043', 'WEGA', TRUE, 3, 0, 1, 13655.97, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-4045', 'FAP-4045', 'WEGA', TRUE, 0, 3, 1, 0.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-4045/1', 'FAP-4045/1', 'WEGA', TRUE, 2, 3, 1, 19029.37, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-4054', 'FAP-4054', 'WEGA', TRUE, 3, 3, 1, 13690.21, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-4054/2', 'FAP-4054/2', 'WEGA', TRUE, 3, 3, 1, 13815.62, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-4055', 'FAP-4055', 'WEGA', TRUE, 0, 0, 1, 13347.94, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-4811', 'FAP-4811', 'WEGA', TRUE, 3, 0, 1, 15230.35, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-4872', 'FAP-4872', 'WEGA', TRUE, 4, 0, 1, 13727.17, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-4872/1', 'FAP-4872/1', 'WEGA', TRUE, 1, 6, 1, 12002.87, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-4873', 'FAP-4873', 'WEGA', TRUE, 8, 5, 1, 10609.90, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-4878/1', 'FAP-4878/1', 'WEGA', TRUE, 4, 0, 1, 13238.17, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-4892', 'FAP-4892', 'WEGA', TRUE, 3, 0, 1, 15777.97, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-4895', 'FAP-4895', 'WEGA', TRUE, 5, 0, 1, 19850.79, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-6000', 'FAP-6000', 'WEGA', TRUE, 4, 0, 1, 15743.71, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-6012', 'FAP-6012', 'WEGA', TRUE, 1, 0, 1, 15812.19, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-6013', 'FAP-6013', 'WEGA', TRUE, 3, 0, 1, 15230.36, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-7007', 'FAP-7007', 'WEGA', TRUE, 5, 6, 1, 12663.46, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-7019', 'FAP-7019', 'WEGA', TRUE, 6, 0, 1, 16144.10, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-8001/1', 'FAP-8001/1', 'WEGA', TRUE, 0, 0, 1, 26353.65, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-9003', 'FAP-9003', 'WEGA', TRUE, 3, 10, 1, 11636.67, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-9013', 'FAP-9013', 'WEGA', TRUE, 2, 0, 1, 16945.57, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-9054', 'FAP-9054', 'WEGA', TRUE, 2, 0, 1, 12663.46, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-9121', 'FAP-9121', 'WEGA', TRUE, 2, 4, 1, 13349.94, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-9273', 'FAP-9273', 'WEGA', TRUE, 3, 2, 1, 13005.69, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-9283', 'FAP-9283', 'WEGA', TRUE, 1, 0, 1, 19029.37, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-9286', 'FAP-9286', 'WEGA', TRUE, 3, 0, 1, 16530.91, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-9295', 'FAP-9295', 'WEGA', TRUE, 7, 0, 1, 11978.92, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-9296', 'FAP-9296', 'WEGA', TRUE, 3, 0, 1, 15743.71, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aire'), 'FAP-9299', 'FAP-9299', 'WEGA', TRUE, 4, 13, 1, 15743.71, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-1129F', 'AKX-1129F', 'WEGA', TRUE, 3, 0, 1, 11431.30, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-1140/C', 'AKX-1140/C', 'WEGA', TRUE, 0, 0, 1, 14032.46, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-1393', 'AKX-1393', 'WEGA', TRUE, 3, 0, 1, 21201.51, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-1396', 'AKX-1396', 'WEGA', TRUE, 4, 0, 1, 15230.35, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-1397', 'AKX-1397', 'WEGA', TRUE, 2, 6, 1, 13347.96, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-1399', 'AKX-1399', 'WEGA', TRUE, 1, 3, 1, 9582.07, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AK-1430', 'AK-1430', 'WEGA', TRUE, 2, 0, 1, 11442.60, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-1444-2', 'AKX-1444-2', 'WEGA', TRUE, 2, 5, 1, 15230.36, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-1445-2', 'AKX-1445-2', 'WEGA', TRUE, 3, 0, 1, 31468.26, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-1446', 'AKX-1446', 'WEGA', TRUE, 3, 13, 1, 12002.87, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-1452-2', 'AKX-1452-2', 'WEGA', TRUE, 4, 0, 1, 18326.84, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-1925', 'AKX-1925', 'WEGA', TRUE, 1, 0, 1, 13953.95, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-1944', 'AKX-1944', 'WEGA', TRUE, 5, 0, 1, 15230.36, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-1956', 'AKX-1956', 'WEGA', TRUE, 1, 0, 1, 19029.37, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-1993', 'AKX-1993', 'WEGA', TRUE, 0, 0, 1, 13690.19, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-2108', 'AKX-2108', 'WEGA', TRUE, 0, 0, 1, 11431.30, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-2161', 'AKX-2161', 'WEGA', TRUE, 4, 0, 1, 12321.19, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-3534', 'AKX-3534', 'WEGA', TRUE, 0, 0, 1, 20535.29, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-3536', 'AKX-3536', 'WEGA', TRUE, 1, 0, 1, 10609.90, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-3594F', 'AKX-3594F', 'WEGA', TRUE, 3, 8, 1, 20535.29, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-35112', 'AKX-35112', 'WEGA', TRUE, 2, 11, 1, 10267.67, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-35163', 'AKX-35163', 'WEGA', TRUE, 2, 16, 1, 9240.88, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-35157', 'AKX-35157', 'WEGA', TRUE, 2, 3, 1, 11978.92, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-35174', 'AKX-35174', 'WEGA', TRUE, 1, 0, 1, 13193.56, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-35177', 'AKX-35177', 'WEGA', TRUE, 1, 0, 1, 12928.68, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-35321', 'AKX-35321', 'WEGA', TRUE, 1, 6, 1, 8556.38, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-35323', 'AKX-35323', 'WEGA', TRUE, 0, 16, 1, 13392.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-35346F', 'AKX-35346F', 'WEGA', TRUE, 4, 0, 1, 12937.25, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-35347F', 'AKX-35347F', 'WEGA', TRUE, 1, 8, 1, 10609.90, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-35723', 'AKX-35723', 'WEGA', TRUE, 9, 9, 1, 13690.19, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Habitáculo'), 'AKX-35725', 'AKX-35725', 'WEGA', TRUE, 0, 0, 1, 18816.20, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'JFC-207/2', 'JFC-207/2', 'WEGA', TRUE, 0, 0, 1, 17753.70, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'JFC-207/3', 'JFC-207/3', 'WEGA', TRUE, 2, 0, 1, 22828.40, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'JFC-383', 'JFC-383', 'WEGA', TRUE, 2, 0, 1, 17112.77, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCD-0110', 'FCD-0110', 'WEGA', TRUE, 1, 0, 1, 19029.37, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCD-0775', 'FCD-0775', 'WEGA', TRUE, 1, 0, 1, 34236.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCD-0777', 'FCD-0777', 'WEGA', TRUE, 1, 0, 1, 17121.64, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCD-0771', 'FCD-0771', 'WEGA', TRUE, 1, 0, 1, 22828.40, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCD-0785', 'FCD-0785', 'WEGA', TRUE, 1, 0, 1, 22198.78, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCD-0795', 'FCD-0795', 'WEGA', TRUE, 1, 0, 1, 37648.06, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCD-0812', 'FCD-0812', 'WEGA', TRUE, 1, 0, 1, 91219.70, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCD-0793', 'FCD-0793', 'WEGA', TRUE, 1, 0, 1, 51338.25, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCD-0797', 'FCD-0797', 'WEGA', TRUE, 1, 0, 1, 35936.77, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCD-0916', 'FCD-0916', 'WEGA', TRUE, 1, 0, 1, 65404.62, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCD-0922', 'FCD-0922', 'WEGA', TRUE, 0, 0, 1, 95831.40, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCD-2035', 'FCD-2035', 'WEGA', TRUE, 2, 0, 1, 51338.25, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCD-2058B', 'FCD-2058B', 'WEGA', TRUE, 1, 0, 1, 0.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCD-2173/1', 'FCD-2173/1', 'WEGA', TRUE, 1, 0, 1, 102676.51, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCI-1101C', 'FCI-1101C', 'WEGA', TRUE, 3, 0, 1, 13308.62, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCI-1288', 'FCI-1288', 'WEGA', TRUE, 2, 0, 1, 22828.42, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCI-1300', 'FCI-1300', 'WEGA', TRUE, 1, 0, 1, 48060.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCI-1304', 'FCI-1304', 'WEGA', TRUE, 1, 0, 1, 61702.54, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCI-1600', 'FCI-1600', 'WEGA', TRUE, 3, 3, 1, 11978.92, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCI-1610', 'FCI-1610', 'WEGA', TRUE, 2, 0, 1, 8157.08, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCI-1620', 'FCI-1620', 'WEGA', TRUE, 5, 0, 1, 8289.38, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCI-1630', 'FCI-1630', 'WEGA', TRUE, 1, 14, 1, 8898.62, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCI-1650', 'FCI-1650', 'WEGA', TRUE, 0, 0, 1, 21595.93, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCI-1880', 'FCI-1880', 'WEGA', TRUE, 4, 0, 1, 21595.93, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCI-1660', 'FCI-1660', 'WEGA', TRUE, 2, 0, 1, 8898.62, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCI-1661', 'FCI-1661', 'WEGA', TRUE, 5, 0, 1, 11990.16, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCI-1670', 'FCI-1670', 'WEGA', TRUE, 1, 0, 1, 18665.02, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCI-1694', 'FCI-1694', 'WEGA', TRUE, 6, 19, 1, 11430.72, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCI-1695', 'FCI-1695', 'WEGA', TRUE, 4, 0, 1, 10706.48, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCI-1880/2', 'FCI-1880/2', 'WEGA', TRUE, 0, 0, 1, 0.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'FCC-2160 TC', 'FCC-2160 TC', 'WEGA', TRUE, 4, 0, 1, 8638.34, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WO-120', 'WO-120', 'WEGA', TRUE, 7, 0, 1, 8556.38, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WO-121', 'WO-121', 'WEGA', TRUE, 8, 0, 1, 10267.67, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WO-130', 'WO-130', 'WEGA', TRUE, 8, 0, 1, 7187.36, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WO-138', 'WO-138', 'WEGA', TRUE, 5, 0, 1, 11431.30, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WO-139', 'WO-139', 'WEGA', TRUE, 0, 0, 1, 11506.58, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WO-150', 'WO-150', 'WEGA', TRUE, 2, 0, 1, 10267.67, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WO-152', 'WO-152', 'WEGA', TRUE, 11, 0, 1, 12674.84, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WO-156', 'WO-156', 'WEGA', TRUE, 1, 0, 1, 11431.30, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WO-160', 'WO-160', 'WEGA', TRUE, 1, 0, 1, 10267.67, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WO-180', 'WO-180', 'WEGA', TRUE, 5, 0, 1, 11978.92, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WO-200', 'WO-200', 'WEGA', TRUE, 5, 0, 1, 8556.38, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WO-205', 'WO-205', 'WEGA', TRUE, 1, 0, 1, 8932.87, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WO-215', 'WO-215', 'WEGA', TRUE, 0, 0, 1, 12821.57, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WO-280', 'WO-280', 'WEGA', TRUE, 1, 0, 1, 0.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WO-340', 'WO-340', 'WEGA', TRUE, 2, 5, 1, 9891.18, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WO-342', 'WO-342', 'WEGA', TRUE, 0, 0, 1, 27380.40, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WO-346', 'WO-346', 'WEGA', TRUE, 3, 0, 1, 15230.36, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WO-370', 'WO-370', 'WEGA', TRUE, 5, 0, 1, 11978.92, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WO-390', 'WO-390', 'WEGA', TRUE, 0, 0, 1, 10267.67, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WOE-110', 'WOE-110', 'WEGA', TRUE, 4, 0, 1, 12577.86, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WOE-313', 'WOE-313', 'WEGA', TRUE, 0, 0, 1, 13347.96, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WOE-506', 'WOE-506', 'WEGA', TRUE, 0, 0, 1, 17112.77, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WOE-610', 'WOE-610', 'WEGA', TRUE, 0, 0, 1, 12355.39, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WOE-640', 'WOE-640', 'WEGA', TRUE, 0, 0, 1, 13348.80, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WOE-710', 'WOE-710', 'WEGA', TRUE, 9, 0, 1, 8898.62, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WOE-803', 'WOE-803', 'WEGA', TRUE, 5, 0, 1, 8072.07, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'WOE-912', 'WOE-912', 'WEGA', TRUE, 7, 0, 1, 15401.48, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'JFO-0197', 'JFO-0197', 'WEGA', TRUE, 1, 0, 1, 14254.69, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'JFO-0209', 'JFO-0209', 'WEGA', TRUE, 1, 0, 1, 10609.90, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'JFO-0210', 'JFO-0210', 'WEGA', TRUE, 0, 0, 1, 13521.60, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Aceite'), 'JFO-0210/1', 'JFO-0210/1', 'WEGA', TRUE, 3, 0, 1, 17925.84, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Filtro de Combustible'), 'JFC-217', 'JFC-217', 'WEGA', TRUE, 1, 0, 1, 81007.52, TRUE);

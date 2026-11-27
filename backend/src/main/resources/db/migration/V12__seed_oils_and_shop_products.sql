-- V12: carga inicial de aceites envasados, aceites a tambor y productos de taller/estética
-- desde la hoja 'ACIETES ' de 'STOCK MP ESCRITORIO .xlsx'.
-- Total de productos: 99 registros (código NULL; warehouse_stock = 0; tracks_stock = TRUE; active = TRUE).
-- min_stock = 1 para aceites y tambores; min_stock = 2 para accesorios.
-- Apertura inicial de tambores abiertos (oil_drums) con stock local >= 1.

INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'SELENIA 4L 0W20', 'PETRONAS', TRUE, 0, 0, 1, 130000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'SYNTIUM 5000 4L 5W30', 'PETRONAS', TRUE, 1, 0, 1, 105000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'SYNTIUM 1000 4L 10W40', 'PETRONAS', TRUE, 1, 0, 1, 55000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'ACEITE CAJA 80W90 X1L', 'PETRONAS', TRUE, 1, 0, 1, 15000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'ACEITE CAJA 75W90 X1L', 'PETRONAS', TRUE, 0, 0, 1, 29000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'ATF D2 X20L', 'PETRONAS', TRUE, 0, 0, 1, 8200.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Tambor'), NULL, 'ACEITE 20W50 X205 L', 'PETRONAS', TRUE, 1, 0, 1, 8500.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'REFRIGERANTE X1L', 'PETRONAS', TRUE, 0, 0, 2, 15000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'REFRIGERANTE UP NARANJA X1L', 'PETRONAS', TRUE, 0, 0, 2, 17000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Tambor'), NULL, 'ACEITE TAMBOR 0W20', 'VALVOLINE', TRUE, 1, 0, 1, 17000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'EUROPEAN VEHICLE 5W30 X4,73L', 'VALVOLINE', TRUE, 0, 0, 1, 132000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'EUROPEAN VEHICLE 5W40 X4,73L', 'VALVOLINE', TRUE, 1, 0, 1, 132000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'ADVANCE 0W20 X4,73 L', 'VALVOLINE', TRUE, 2, 0, 1, 132000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'ADVANCE 0W20 X946ML', 'VALVOLINE', TRUE, 6, 0, 1, 35000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'HIGH MILEAGE 5W30 X946ML', 'VALVOLINE', TRUE, 4, 0, 1, 35000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'DURABLEND 10W40 X946', 'VALVOLINE', TRUE, 0, 0, 1, 18800.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'DEX/MERC ATF X946', 'VALVOLINE', TRUE, 1, 0, 1, 25000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Tambor'), NULL, 'BLEND 10W40 TAMBOR', 'VALVOLINE', TRUE, 0, 0, 1, 7000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Tambor'), NULL, 'ALL FLEET 15W40 TAMBOR', 'VALVOLINE', TRUE, 0, 0, 1, 7000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'ELAION EURO 0W20 4L', 'YPF', TRUE, 3, 0, 1, 155000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'ELAION AURO 5W40 4L', 'YPF', TRUE, 0, 0, 1, 155000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'FS 5W40 4L', 'YPF', TRUE, 1, 0, 1, 140000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'FS 5W40 X1L', 'YPF', TRUE, 1, 0, 1, 41000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'FS 5W30 X4L', 'YPF', TRUE, 1, 0, 1, 135000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'FS 5W30 1L', 'YPF', TRUE, 1, 0, 1, 40000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'TS 10W40 X 4 L', 'YPF', TRUE, 0, 0, 1, 81000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'TS 10W40 1L', 'YPF', TRUE, 1, 0, 1, 23000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'HIPOIDAL 80W90 X20L', 'YPF', TRUE, 0, 0, 1, 15000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'HIDRO ATF X 20L', 'YPF', TRUE, 1, 0, 1, 15000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'DOT 3 200 ML', 'YPF', TRUE, 0, 0, 2, 6500.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'DOT 3 500 ML', 'YPF', TRUE, 0, 0, 2, 12000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'DOT 3 1 LT', 'YPF', TRUE, 2, 0, 2, 20000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'DOT 4 200 ML', 'YPF', TRUE, 7, 0, 2, 12000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'DOT 4 500 ML', 'YPF', TRUE, 8, 0, 2, 22500.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'DOT 4 1LT', 'YPF', TRUE, 5, 0, 2, 40000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'LAVAPARABRISAS X1 LT', 'YPF', TRUE, 0, 0, 2, 0.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'REFRIGERANTE FUCSIA X1 LT', 'YPF', TRUE, 3, 0, 2, 18000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'ROD 2T 100CC', 'YPF', TRUE, 3, 0, 1, 3000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'ROD2T X200CC', 'YPF', TRUE, 8, 0, 1, 5000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'ROD 2T 1 LT', 'YPF', TRUE, 3, 0, 1, 14500.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'ROD 4T 1LT MOTO', 'YPF', TRUE, 6, 0, 1, 15000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'S.O.S GRANDE', 'WALKER', TRUE, 4, 0, 2, 15000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'S.O.S CHICO', 'WALKER', TRUE, 3, 0, 2, 12200.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'ACEITE PARA CADENA GDE', 'WALKER', TRUE, 5, 0, 2, 7000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'ACEITE PARA CADENA CHICO', 'WALKER', TRUE, 4, 0, 2, 5302.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'GRASA MULTISUO 240CC', 'WALKER', TRUE, 4, 0, 2, 6000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'ARRANCA MOTOR GRANDE', 'WALKER', TRUE, 0, 0, 2, 15000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'LIMPIA TAPIZADO ESPUMA', 'WALKER', TRUE, 3, 0, 2, 7500.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'LIMPIA TAPIZADO LIQ', 'WALKER', TRUE, 3, 0, 2, 7500.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'SILICONA PERFUMADA AEROSOL', 'WALKER', TRUE, 0, 0, 2, 7900.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'PERFUMES PINITOS', 'WALKER', TRUE, 15, 0, 2, 3000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'PERFUME LATA', 'WALKER', TRUE, 3, 0, 2, 7500.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'PERFUME SPORT', 'WALKER', TRUE, 0, 0, 2, 7000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'PERFUME CUBO', 'WALKER', TRUE, 0, 0, 2, 7000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'PAÑO MICROF 60X40', 'WALKER', TRUE, 2, 0, 2, 10000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'PAÑO SILICONADO 47X52', 'WALKER', TRUE, 3, 0, 2, 9800.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'FRANELA MULTIUSO 47X52', 'WALKER', TRUE, 4, 0, 2, 6000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'W400 X 400ML', 'WALKER', TRUE, 0, 0, 2, 7000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'DESENGRASANTE X 5L', 'WALKER', TRUE, 0, 0, 2, 6500.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'SILICONA PERFUMADA X5L', 'WALKER', TRUE, 0, 0, 2, 29000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'SHAMPOO SILICONADO X 5L', 'WALKER', TRUE, 0, 0, 2, 5000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'REVIVIDOR DE NEGRO X5 L', 'WALKER', TRUE, 0, 0, 2, 6000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'LAVAPARABRISAS X 500CC', 'WALKER', TRUE, 6, 0, 2, 8000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'LIMPIA CONTACTOS 360ML', 'WALKER', TRUE, 0, 0, 2, 6500.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'ROST OF 300 ML', 'WURTH', TRUE, 4, 0, 2, 16000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'LIMPIADOR DE CONTACTO', 'WURTH', TRUE, 4, 0, 2, 20500.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'PRE CINTO X 10 CM', 'WURTH', TRUE, 100, 0, 2, 55.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'PRE CINTO X 20 CM', 'WURTH', TRUE, 100, 0, 2, 75.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'SELLA DE RADI X250CC', 'WURTH', TRUE, 11, 0, 2, 14000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'LIMPIA RADIA X 250 CC', 'WURTH', TRUE, 3, 0, 2, 10000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'ADITIVO LIMPIA MOTOR', 'WURTH', TRUE, 6, 0, 2, 49000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'SILICONA ALTA TEMP', 'WURTH', TRUE, 0, 0, 2, 19000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'TAPAFUGAS DE ACEITE', 'WURTH', TRUE, 2, 0, 2, 46000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'TAPON CARTER 12', 'WURTH', TRUE, 2, 0, 2, 28000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'TAPON CARTER 14', 'WURTH', TRUE, 4, 0, 2, 30000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'TAPON DE CARTER 16', 'WURTH', TRUE, 4, 0, 2, 35000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'LIMPIA INY DIESEL', 'WURTH', TRUE, 4, 0, 2, 24000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'LIMPIA INY NAFTA', 'WURTH', TRUE, 3, 0, 2, 28000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'GOTITA 2GS', 'WURTH', TRUE, 1, 0, 2, 1200.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, '9000 5W40 X4L', 'TOTAL', TRUE, 4, 0, 1, 110000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'INEO MC3 5W30 X4L', 'TOTAL', TRUE, 0, 0, 1, 120000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, '7000 10W40 X4L', 'TOTAL', TRUE, 5, 0, 1, 65000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, '5000 15W40 X4L', 'TOTAL', TRUE, 0, 0, 1, 45000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'ACEITE GULF 0W20', 'GULF', TRUE, 5, 0, 1, 100000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'ACEITE GULF 5W30', 'GULF', TRUE, 1, 0, 1, 85000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'ACEITE GULF 10W40', 'GULF', TRUE, 1, 0, 1, 60000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'ACEITE GULF 5W40', 'GULF', TRUE, 2, 0, 1, 80000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'ACEITE GULF 15W40', 'GULF', TRUE, 4, 0, 1, 45000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'HELIX HX7 10W40 X4L', 'SHELL', TRUE, 5, 0, 1, 90000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'HELIX ULTRA 5W30 X4L', 'SHELL', TRUE, 2, 0, 1, 175000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'HELIX ULTRA 5W40 X4L', 'SHELL', TRUE, 0, 0, 1, 175000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'EVOL 900 5W40 X4L', 'ELF', TRUE, 1, 0, 1, 102000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'EVOL 700 10W40 X4L', 'ELF', TRUE, 1, 0, 1, 71000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Tambor'), NULL, 'EVOL 700 10W40 X208L', 'ELF', TRUE, 0, 0, 1, 8500.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'MOTORKRAF 10W40', 'MOTORCRAFT', TRUE, 1, 0, 1, 55000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'MOTORKRAF 5W30', 'MOTORCRAFT', TRUE, 1, 0, 1, 85000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Aceite Envasado'), NULL, 'MOTOS 4 T X 1 L', 'CASTROL', TRUE, 1, 0, 1, 15000.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'REFRIGERANTE ROJO X1L', 'BARDHAL', TRUE, 3, 0, 2, 24800.00, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Accesorios'), NULL, 'ARRANCA MOTOR', 'BARDHAL', TRUE, 5, 0, 2, 20000.00, TRUE);

-- Apertura inicial de tambores en uso (local_stock >= 1)
INSERT INTO oil_drums (product_id, capacity_liters, remaining_liters, status, notes)
VALUES ((SELECT id FROM products WHERE name = 'ACEITE 20W50 X205 L' AND brand = 'PETRONAS'), 205.00, 205.00, 'OPEN', 'Tambor abierto en carga inicial');
INSERT INTO oil_drums (product_id, capacity_liters, remaining_liters, status, notes)
VALUES ((SELECT id FROM products WHERE name = 'ACEITE TAMBOR 0W20' AND brand = 'VALVOLINE'), 200.00, 200.00, 'OPEN', 'Tambor abierto en carga inicial');

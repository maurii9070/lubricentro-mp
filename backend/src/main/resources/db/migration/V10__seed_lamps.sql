-- V10: carga inicial de las lámparas WEGA desde la hoja 'STOCK MP' de
-- 'STOCK MP ESCRITORIO .xlsx' (filas 167 a 177).
-- Total: 11 registros.
-- Código y nombre separados por el primer espacio del texto de PRODUCTO;
-- precios redondeados a 2 decimales; min_stock = 2.

INSERT INTO categories (name) VALUES ('Lámparas') ON CONFLICT (name) DO NOTHING;

INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Lámparas'), 'AS-2002', 'LAMPARA 1p', 'WEGA', TRUE, 31, 0, 2, 1434.24, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Lámparas'), 'AS-2007', 'LAMPARA 2p', 'WEGA', TRUE, 26, 0, 2, 2718.14, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Lámparas'), 'AS-2008', 'LAMPA PATA DES', 'WEGA', TRUE, 18, 0, 2, 882.49, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Lámparas'), 'AS-2111', 'LAMP 1p MINI', 'WEGA', TRUE, 0, 0, 2, 1111.10, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Lámparas'), 'AS-2346', 'MUELITA', 'WEGA', TRUE, 17, 0, 2, 706.75, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Lámparas'), 'AS-2377', 'MUELON', 'WEGA', TRUE, 0, 0, 2, 6424.70, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Lámparas'), 'AS-2802', 'LAM 1p AMBAR', 'WEGA', TRUE, 12, 0, 2, 1646.78, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Lámparas'), 'AH-2502', 'LAMPARA H1', 'WEGA', TRUE, 9, 0, 2, 3586.25, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Lámparas'), 'AH-2505', 'LAMPARA H3', 'WEGA', TRUE, 20, 0, 2, 3586.25, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Lámparas'), 'AH-2507', 'LAMPARA H4', 'WEGA', TRUE, 20, 0, 2, 10558.08, TRUE);
INSERT INTO products (category_id, code, name, brand, tracks_stock, local_stock, warehouse_stock, min_stock, list_price, active)
VALUES ((SELECT id FROM categories WHERE name = 'Lámparas'), 'AH-2550', 'LAMPARA H7', 'WEGA', TRUE, 7, 0, 2, 13588.99, TRUE);

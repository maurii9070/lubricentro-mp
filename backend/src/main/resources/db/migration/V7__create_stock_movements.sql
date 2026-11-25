CREATE TABLE stock_movements (
    id BIGSERIAL PRIMARY KEY,
    product_id BIGINT NOT NULL,
    sale_id BIGINT,
    movement_type VARCHAR(30) NOT NULL,
    location VARCHAR(20) NOT NULL,
    quantity NUMERIC(8, 2) NOT NULL,
    movement_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    reason VARCHAR(255),
    CONSTRAINT fk_stock_movements_product FOREIGN KEY (product_id) REFERENCES products (id),
    CONSTRAINT fk_stock_movements_sale FOREIGN KEY (sale_id) REFERENCES sales (id)
);

CREATE INDEX idx_stock_movements_product_date ON stock_movements (product_id, movement_date);
CREATE INDEX idx_stock_movements_sale_id ON stock_movements (sale_id);

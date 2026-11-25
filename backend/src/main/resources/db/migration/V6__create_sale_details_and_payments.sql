CREATE TABLE sale_details (
    id BIGSERIAL PRIMARY KEY,
    sale_id BIGINT NOT NULL,
    product_id BIGINT,
    description_snapshot VARCHAR(255) NOT NULL,
    quantity NUMERIC(8, 2) NOT NULL CHECK (quantity > 0),
    unit_price_snapshot NUMERIC(10, 2) NOT NULL CHECK (unit_price_snapshot >= 0),
    CONSTRAINT fk_sale_details_sale FOREIGN KEY (sale_id) REFERENCES sales (id),
    CONSTRAINT fk_sale_details_product FOREIGN KEY (product_id) REFERENCES products (id)
);

CREATE INDEX idx_sale_details_sale_id ON sale_details (sale_id);

CREATE TABLE sale_payments (
    id BIGSERIAL PRIMARY KEY,
    sale_id BIGINT NOT NULL,
    payment_method VARCHAR(20) NOT NULL,
    amount NUMERIC(10, 2) NOT NULL CHECK (amount > 0),
    CONSTRAINT fk_sale_payments_sale FOREIGN KEY (sale_id) REFERENCES sales (id)
);

CREATE INDEX idx_sale_payments_sale_id ON sale_payments (sale_id);

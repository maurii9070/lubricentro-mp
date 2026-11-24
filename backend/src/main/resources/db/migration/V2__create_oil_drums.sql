CREATE TABLE oil_drums (
    id BIGSERIAL PRIMARY KEY,
    product_id BIGINT NOT NULL,
    capacity_liters NUMERIC(8, 2) NOT NULL CHECK (capacity_liters > 0),
    remaining_liters NUMERIC(8, 2) NOT NULL CHECK (remaining_liters >= 0),
    status VARCHAR(20) NOT NULL DEFAULT 'OPEN',
    opened_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    notes VARCHAR(255),
    CONSTRAINT fk_oil_drums_product FOREIGN KEY (product_id) REFERENCES products (id)
);

CREATE INDEX idx_oil_drums_product_status ON oil_drums (product_id, status);

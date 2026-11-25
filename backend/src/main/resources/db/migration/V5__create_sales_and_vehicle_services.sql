CREATE TABLE sales (
    id BIGSERIAL PRIMARY KEY,
    operation_date TIMESTAMP NOT NULL,
    shift VARCHAR(20) NOT NULL,
    operation_type VARCHAR(20) NOT NULL,
    calculated_subtotal NUMERIC(10, 2) NOT NULL CHECK (calculated_subtotal >= 0),
    total_charged NUMERIC(10, 2) NOT NULL CHECK (total_charged >= 0),
    notes TEXT
);

CREATE INDEX idx_sales_operation_date ON sales (operation_date);

CREATE TABLE vehicle_services (
    sale_id BIGINT PRIMARY KEY,
    vehicle_id BIGINT NOT NULL,
    mileage INTEGER CHECK (mileage >= 0),
    technical_notes TEXT,
    CONSTRAINT fk_vehicle_services_sale FOREIGN KEY (sale_id) REFERENCES sales (id),
    CONSTRAINT fk_vehicle_services_vehicle FOREIGN KEY (vehicle_id) REFERENCES vehicles (id)
);

CREATE INDEX idx_vehicle_services_vehicle_id ON vehicle_services (vehicle_id);

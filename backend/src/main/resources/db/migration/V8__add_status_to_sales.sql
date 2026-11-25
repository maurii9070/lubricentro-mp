ALTER TABLE sales ADD COLUMN status VARCHAR(20) NOT NULL DEFAULT 'COMPLETED';

CREATE INDEX idx_sales_status_operation_date ON sales (status, operation_date);

CREATE TABLE categories (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE products (
    id BIGSERIAL PRIMARY KEY,
    category_id BIGINT NOT NULL,
    code VARCHAR(50) UNIQUE,
    name VARCHAR(200) NOT NULL,
    brand VARCHAR(100),
    tracks_stock BOOLEAN NOT NULL DEFAULT TRUE,
    local_stock INTEGER NOT NULL DEFAULT 0 CHECK (local_stock >= 0),
    warehouse_stock INTEGER NOT NULL DEFAULT 0 CHECK (warehouse_stock >= 0),
    min_stock INTEGER NOT NULL DEFAULT 0 CHECK (min_stock >= 0),
    list_price NUMERIC(10, 2) NOT NULL CHECK (list_price >= 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT fk_products_category FOREIGN KEY (category_id) REFERENCES categories (id)
);

CREATE INDEX idx_products_code ON products (code);
CREATE INDEX idx_products_name ON products (name);

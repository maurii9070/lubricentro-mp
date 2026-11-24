INSERT INTO categories (name) VALUES
    ('Filtro de Aire'),
    ('Filtro de Aceite'),
    ('Filtro de Combustible'),
    ('Filtro de Habitáculo'),
    ('Aceite Envasado'),
    ('Aceite Tambor'),
    ('Servicios / Lavados'),
    ('Accesorios')
ON CONFLICT (name) DO NOTHING;

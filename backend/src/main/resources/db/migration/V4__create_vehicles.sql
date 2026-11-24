CREATE TABLE vehicles (
    id BIGSERIAL PRIMARY KEY,
    license_plate VARCHAR(20) NOT NULL UNIQUE,
    brand_model VARCHAR(150) NOT NULL,
    owner_name VARCHAR(150),
    phone VARCHAR(50),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- La restricción UNIQUE sobre license_plate ya crea un índice implícito que
-- acelera las búsquedas por patente, por lo que no se agrega uno adicional.

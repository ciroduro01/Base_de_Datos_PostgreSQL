-- 1. CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE alquiler_scooters;

-- Conectarse a la base de datos (comando específico de psql, no SQL estándar)
-- \c alquiler_scooters; 

-- 2. CREACIÓN DE TABLAS (DDL)

CREATE TABLE Cliente (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(15)
);

CREATE TABLE Ubicacion (
    ubicacion_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    direccion VARCHAR(255),
    latitud NUMERIC(10, 6),
    longitud NUMERIC(10, 6)
);

CREATE TABLE Scooter (
    scooter_id SERIAL PRIMARY KEY,
    modelo VARCHAR(50) NOT NULL,
    bateria_porcentaje INT CHECK (bateria_porcentaje BETWEEN 0 AND 100),
    estado VARCHAR(20) NOT NULL DEFAULT 'Disponible', -- Ej: Disponible, Alquilado, Mantenimiento
    ubicacion_actual_id INT REFERENCES Ubicacion(ubicacion_id) NOT NULL
);

CREATE TABLE Alquiler (
    alquiler_id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES Cliente(cliente_id) NOT NULL,
    scooter_id INT REFERENCES Scooter(scooter_id) NOT NULL,
    ubicacion_recogida_id INT REFERENCES Ubicacion(ubicacion_id) NOT NULL,
    ubicacion_devolucion_id INT REFERENCES Ubicacion(ubicacion_id), -- Puede ser NULL
    fecha_hora_inicio TIMESTAMP NOT NULL,
    fecha_hora_fin TIMESTAMP, -- Puede ser NULL
    costo_total NUMERIC(10, 2) -- Puede ser NULL
);

-- 3. CREACIÓN DE VISTAS

-- Vista de Inventario: Muestra scooters disponibles con más del 70% de batería.
CREATE VIEW Scooters_Disponibles AS
SELECT
    S.scooter_id,
    S.modelo,
    S.bateria_porcentaje,
    U.nombre AS Nombre_Estacion,
    U.latitud,
    U.longitud
FROM
    Scooter S
INNER JOIN
    Ubicacion U ON S.ubicacion_actual_id = U.ubicacion_id
WHERE
    S.estado = 'Disponible'
    AND S.bateria_porcentaje > 70;

-- INSERCIÓN DE DATOS (DML)

-- UBICACIONES (1: Terminal Central, 2: Parque Norte, 3: Distrito Financiero)
INSERT INTO Ubicacion (nombre, direccion, latitud, longitud) VALUES
('Terminal Central', 'Av. 9 de Julio 123', -34.6037, -58.3816),
('Parque Norte', 'Av. Figueroa Alcorta 7000', -34.5555, -58.4485),
('Distrito Financiero', 'Calle Florida 500', -34.5997, -58.3752);

-- CLIENTES (1: Ana Gomez, 2: Pedro Lopez)
INSERT INTO Cliente (nombre, apellido, email, telefono) VALUES
('Ana', 'Gomez', 'ana.gomez@mail.com', '1122334455'),
('Pedro', 'Lopez', 'pedro.lopez@mail.com', '1166778899');

-- SCOOTERS (Inicialmente)
INSERT INTO Scooter (modelo, bateria_porcentaje, estado, ubicacion_actual_id) VALUES
( 'Modelo X100', 95, 'Disponible', 1), -- ID 1: En Terminal Central
( 'Modelo X100', 80, 'Disponible', 1), -- ID 2: En Terminal Central
( 'Modelo Y200', 100, 'Disponible', 2), -- ID 3: En Parque Norte
( 'Modelo Z300', 60, 'Mantenimiento', 3); -- ID 4: En Distrito Financiero

-- TRANSACCIÓN INICIAL (Alquiler finalizado de Pedro Lopez)
INSERT INTO Alquiler (cliente_id, scooter_id, ubicacion_recogida_id, ubicacion_devolucion_id, fecha_hora_inicio, fecha_hora_fin, costo_total)
VALUES (
    2, -- Cliente: Pedro Lopez
    3, -- Scooter: Modelo Y200
    2, -- Recogida: Parque Norte
    3, -- Devolución: Distrito Financiero
    '2025-11-30 15:30:00',
    '2025-11-30 16:00:00',
    15.00
);

-- Simulación de devolución de Ana Gomez (Alquiler ID 1, Scooter ID 1)
-- El scooter ID 1 regresa a la ubicación 2 (Parque Norte)
INSERT INTO Alquiler (cliente_id, scooter_id, ubicacion_recogida_id, fecha_hora_inicio)
VALUES (1, 1, 1, '2025-12-01 09:00:00');

UPDATE Alquiler
SET
    fecha_hora_fin = '2025-12-01 10:30:00',
    ubicacion_devolucion_id = 2,
    costo_total = 27.00
WHERE
    alquiler_id = 2; -- Asume que es el segundo alquiler insertado

UPDATE Scooter
SET
    estado = 'Disponible',
    bateria_porcentaje = 75,
    ubicacion_actual_id = 2
WHERE
    scooter_id = 1;
-- 1. CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE agencia_viajes;

-- Conectarse a la base de datos (comando específico de psql, no SQL estándar)
-- \c agencia_viajes;

-- 2. CREACIÓN DE TABLAS (DDL)

CREATE TABLE Cliente (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(15)
);

CREATE TABLE Destino (
    destino_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    país VARCHAR(50) NOT NULL,
    continente VARCHAR(50)
);

CREATE TABLE Alojamiento (
    alojamiento_id SERIAL PRIMARY KEY,
    destino_id INT REFERENCES Destino(destino_id) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    precio_noche NUMERIC(10, 2) NOT NULL CHECK (precio_noche >= 0)
);

CREATE TABLE Reserva (
    reserva_id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES Cliente(cliente_id) NOT NULL,
    alojamiento_id INT REFERENCES Alojamiento(alojamiento_id) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    costo_total NUMERIC(10, 2),
    estado VARCHAR(20) NOT NULL DEFAULT 'Confirmada',

    -- Restricción clave (simplificada): Evita que el mismo alojamiento se reserve para el mismo día de inicio.
    UNIQUE (alojamiento_id, fecha_inicio)
);


-- 3. CREACIÓN DE VISTAS

-- Vista: Reporte de Reservas Detallado (Simplifica la consulta de las 4 tablas)
CREATE VIEW Reporte_Reservas_Cliente AS
SELECT
    R.reserva_id,
    CL.nombre || ' ' || CL.apellido AS Nombre_Cliente,
    D.nombre AS Destino,
    A.nombre AS Alojamiento,
    A.precio_noche AS Precio_Diario,
    R.fecha_inicio AS Check_In,
    R.fecha_fin AS Check_Out,
    R.costo_total AS Costo_Total_Reserva,
    R.estado AS Estado_Reserva
FROM
    Reserva R
INNER JOIN Cliente CL ON R.cliente_id = CL.cliente_id
INNER JOIN Alojamiento A ON R.alojamiento_id = A.alojamiento_id
INNER JOIN Destino D ON A.destino_id = D.destino_id
ORDER BY
    R.fecha_inicio DESC;

-- INSERCIÓN DE DATOS (DML)

-- CLIENTES (IDs 1-5)
INSERT INTO Cliente (nombre, apellido, email, telefono) VALUES
('Elena', 'Torres', 'elena.torres@mail.com', '5491133445566'),
('Ricardo', 'Vidal', 'ricardo.vidal@mail.com', '5491199887766'),
('Javier', 'Sosa', 'javier.sosa@mail.com', '5491111223344'),
('Paula', 'García', 'paula.garcia@mail.com', '5491155667788'),
('Miguel', 'Rojas', 'miguel.rojas@mail.com', '5491122446688');

-- DESTINOS (IDs 1-5)
INSERT INTO Destino (nombre, país, continente) VALUES
('Machu Picchu', 'Perú', 'América del Sur'),
('Kyoto', 'Japón', 'Asia'),
('París', 'Francia', 'Europa'),
('Sidney', 'Australia', 'Oceanía'),
('Ciudad del Cabo', 'Sudáfrica', 'África');

-- ALOJAMIENTOS (IDs 1-5)
INSERT INTO Alojamiento (destino_id, nombre, tipo, precio_noche) VALUES
(1, 'Hotel Los Andes', 'Hotel', 150.00), -- ID 1 (en Machu Picchu)
(2, 'Ryokan Sakura', 'Ryokan', 250.00),  -- ID 2 (en Kyoto)
(3, 'Chateau Belle Vue', 'Apartamento', 180.50), -- ID 3 (en París)
(4, 'The Sydney Opera Suites', 'Hotel', 320.00), -- ID 4 (en Sidney)
(5, 'Lion''s Head Lodge', 'Hostal', 75.00);      -- ID 5 (en Ciudad del Cabo)

-- RESERVAS (Transacciones)

-- Reserva 1: Exitosa (Elena Torres en Hotel Los Andes)
INSERT INTO Reserva (cliente_id, alojamiento_id, fecha_inicio, fecha_fin, costo_total, estado)
VALUES (
    1, -- Cliente: Elena Torres
    1, -- Alojamiento: Hotel Los Andes
    '2026-03-15',
    '2026-03-20',
    750.00,
    'Confirmada'
);

-- Reserva 2: Exitosa (Paula García en Ryokan Sakura)
INSERT INTO Reserva (cliente_id, alojamiento_id, fecha_inicio, fecha_fin, costo_total, estado)
VALUES (
    4, -- Cliente: Paula García
    2, -- Alojamiento: Ryokan Sakura
    '2026-07-01',
    '2026-07-10',
    2250.00, -- 9 noches * $250.00
    'Confirmada'
);

-- Simular una cancelación con el filtro WHERE:
UPDATE Reserva
SET estado = 'Cancelada'
WHERE reserva_id = 2;
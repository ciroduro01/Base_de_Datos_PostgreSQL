-- 1. CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE salon_citas;

-- Conectarse a la base de datos (comando específico de psql, no SQL estándar)
-- \c salon_citas;

-- 2. CREACIÓN DE TABLAS (DDL)

CREATE TABLE Cliente (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(15),
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Empleado (
    empleado_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    especialidad VARCHAR(50)
);

CREATE TABLE Servicio (
    servicio_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    duracion_minutos INT NOT NULL CHECK (duracion_minutos > 0),
    precio NUMERIC(10, 2) NOT NULL CHECK (precio >= 0)
);

CREATE TABLE Cita (
    cita_id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES Cliente(cliente_id) NOT NULL,
    empleado_id INT REFERENCES Empleado(empleado_id) NOT NULL,
    servicio_id INT REFERENCES Servicio(servicio_id) NOT NULL,
    fecha_hora_inicio TIMESTAMP NOT NULL,
    fecha_hora_fin TIMESTAMP NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'Confirmada', -- Confirmada, Cancelada, Finalizada

    -- RESTRICCIÓN CLAVE para el planificador: Previene la doble reserva.
    UNIQUE (empleado_id, fecha_hora_inicio)
);


-- 3. CREACIÓN DE VISTAS

-- Vista: Agenda Detallada (Simplifica la consulta de las 4 tablas)
CREATE VIEW Agenda_Detallada AS
SELECT
    C.cita_id,
    C.fecha_hora_inicio AS Inicio,
    C.fecha_hora_fin AS Fin,
    CL.nombre || ' ' || CL.apellido AS Cliente,
    EM.nombre || ' ' || EM.apellido AS Empleado,
    S.nombre AS Servicio_Solicitado,
    S.duracion_minutos AS Duracion,
    C.estado AS Estado
FROM
    Cita C
INNER JOIN Cliente CL ON C.cliente_id = CL.cliente_id
INNER JOIN Empleado EM ON C.empleado_id = EM.empleado_id
INNER JOIN Servicio S ON C.servicio_id = S.servicio_id
ORDER BY
    C.fecha_hora_inicio;

-- INSERCIÓN DE DATOS (DML)

-- CLIENTES
INSERT INTO Cliente (nombre, apellido, telefono, email) VALUES
('Sofia', 'Ramos', '1155001234', 'sofia.ramos@mail.com'),
('Marcos', 'Perez', '1155005678', 'marcos.perez@mail.com');

-- EMPLEADOS (Estilistas)
INSERT INTO Empleado (nombre, apellido, especialidad) VALUES
('Laura', 'Diaz', 'Peluquería y Tinte'), -- ID 1
('Carlos', 'Molina', 'Manicura y Pedicura'); -- ID 2

-- SERVICIOS
INSERT INTO Servicio (nombre, duracion_minutos, precio) VALUES
('Corte de Pelo', 60, 45.00),         -- ID 1
('Manicura Completa', 45, 30.00),     -- ID 2
('Tinte de Raíz', 120, 85.00);        -- ID 3

-- CITAS (Transacciones)

-- Cita 1: Éxito (Laura Diaz)
INSERT INTO Cita (cliente_id, empleado_id, servicio_id, fecha_hora_inicio, fecha_hora_fin, estado)
VALUES (
    1, -- Sofia Ramos
    1, -- Laura Diaz
    1, -- Corte de Pelo (60 min)
    '2025-12-10 10:00:00',
    '2025-12-10 11:00:00',
    'Confirmada'
);

-- Cita 2: Éxito (Carlos Molina)
INSERT INTO Cita (cliente_id, empleado_id, servicio_id, fecha_hora_inicio, fecha_hora_fin, estado)
VALUES (
    2, -- Marcos Perez
    2, -- Carlos Molina
    2, -- Manicura (45 min)
    '2025-12-10 10:00:00',
    '2025-12-10 10:45:00',
    'Confirmada'
);

-- 1. Actualiza ESTADO a 'Completada' (para que funcione la Consulta 1)
--    y establece una duración de 2 horas.
UPDATE Cita
SET
    estado = 'Completada',
    fecha_hora_fin = '2025-12-10 12:00:00'
WHERE
    cita_id = 1;

-- 2. Actualiza la duración de la Cita 2 para que sea 1.25 horas (75 minutos).
UPDATE Cita
SET
    fecha_hora_fin = '2025-12-10 12:15:00'
WHERE
    cita_id = 2;
-- 1. CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE copa_del_mundo;

-- Conectarse a la base de datos (comando específico de psql, no SQL estándar)
-- \c copa_del_mundo;

-- 2. CREACIÓN DE TABLAS (DDL)

CREATE TABLE País (
    pais_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    código_fifa CHAR(3) NOT NULL UNIQUE
);

CREATE TABLE Jugador (
    jugador_id SERIAL PRIMARY KEY,
    pais_id INT REFERENCES País(pais_id) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    posición VARCHAR(50),
    fecha_nacimiento DATE
);

CREATE TABLE Partido (
    partido_id SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    ronda VARCHAR(50) NOT NULL,
    goles_local INT NOT NULL DEFAULT 0 CHECK (goles_local >= 0),
    goles_visitante INT NOT NULL DEFAULT 0 CHECK (goles_visitante >= 0)
);

-- Tabla de Enlace N:M (País y Partido)
CREATE TABLE Equipo_Partido (
    equipo_partido_id SERIAL PRIMARY KEY,
    partido_id INT REFERENCES Partido(partido_id) NOT NULL,
    pais_id INT REFERENCES País(pais_id) NOT NULL,
    es_local BOOLEAN NOT NULL,
    UNIQUE (partido_id, pais_id)
);

-- Tabla de Enlace N:M (Jugador y Partido)
CREATE TABLE Estadisticas_Jugador (
    jugador_id INT REFERENCES Jugador(jugador_id) NOT NULL,
    partido_id INT REFERENCES Partido(partido_id) NOT NULL,
    goles INT NOT NULL DEFAULT 0 CHECK (goles >= 0),
    asistencias INT NOT NULL DEFAULT 0 CHECK (asistencias >= 0),
    tarjetas_amarillas INT NOT NULL DEFAULT 0 CHECK (tarjetas_amarillas >= 0),
    tarjetas_rojas INT NOT NULL DEFAULT 0 CHECK (tarjetas_rojas >= 0),
    minutos_jugados INT NOT NULL CHECK (minutos_jugados BETWEEN 0 AND 120),

    PRIMARY KEY (jugador_id, partido_id)
);


-- 3. CREACIÓN DE VISTAS

-- Vista: Reporte de Partidos Detallado (Desenvuelve la relación N:M Equipo-Partido)
CREATE VIEW Reporte_Partido_Detallado AS
SELECT
    P.partido_id,
    P.fecha,
    P.ronda,
    PL.nombre AS País_Local,
    PV.nombre AS País_Visitante,
    P.goles_local AS Resultado_Local,
    P.goles_visitante AS Resultado_Visitante
FROM
    Partido P
INNER JOIN Equipo_Partido EP_L ON P.partido_id = EP_L.partido_id AND EP_L.es_local = TRUE
INNER JOIN País PL ON EP_L.pais_id = PL.pais_id
INNER JOIN Equipo_Partido EP_V ON P.partido_id = EP_V.partido_id AND EP_V.es_local = FALSE
INNER JOIN País PV ON EP_V.pais_id = PV.pais_id
ORDER BY
    P.fecha DESC;

-- INSERCIÓN DE DATOS (DML)

-- PAÍSES (IDs 1-3)
INSERT INTO País (nombre, código_fifa) VALUES
('Argentina', 'ARG'), -- ID 1
('Brasil', 'BRA'),    -- ID 2
('Francia', 'FRA');   -- ID 3

-- JUGADORES (IDs 1-6)
INSERT INTO Jugador (pais_id, nombre, posición, fecha_nacimiento) VALUES
(1, 'Lionel Messi', 'Delantero', '1987-06-24'), -- ID 1 (ARG)
(1, 'Rodrigo de Paul', 'Mediocampista', '1994-05-24'),  -- ID 2 (ARG)
(2, 'Neymar Jr', 'Delantero', '1992-02-05'),   -- ID 3 (BRA)
(2, 'Richarlison', 'Delantero', '1997-05-13'), -- ID 4 (BRA)
(3, 'Kylian Mbappé', 'Delantero', '1998-12-20'), -- ID 5 (FRA)
(3, 'Antoine Griezmann', 'Mediocampista', '1991-03-21'); -- ID 6 (FRA)

-- PARTIDOS (IDs 1-3)
INSERT INTO Partido (fecha, ronda, goles_local, goles_visitante) VALUES
('2026-12-10', 'Fase de Grupos', 2, 1),      -- Partido 1: ARG 2 - BRA 1
('2026-12-14', 'Octavos de Final', 2, 3), -- Partido 2: FRA 2 - ARG 3
('2026-12-18', 'Cuartos de Final', 0, 0);  -- Partido 3: BRA 0 - FRA 0

-- EQUIPO_PARTIDO (Conexión de Países a Partidos)
INSERT INTO Equipo_Partido (partido_id, pais_id, es_local) VALUES
(1, 1, TRUE), (1, 2, FALSE),  -- Partido 1: ARG vs BRA
(2, 3, TRUE), (2, 1, FALSE),  -- Partido 2: FRA vs ARG
(3, 2, TRUE), (3, 3, FALSE);  -- Partido 3: BRA vs FRA

-- ESTADISTICAS_JUGADOR (Detalle del rendimiento)
INSERT INTO Estadisticas_Jugador (jugador_id, partido_id, goles, asistencias, tarjetas_amarillas, minutos_jugados) VALUES
(1, 1, 2, 0, 0, 90), (2, 1, 0, 0, 1, 90),  -- ARG vs BRA
(3, 1, 1, 0, 0, 90), (4, 1, 0, 1, 0, 90),  -- ARG vs BRA

(5, 2, 2, 0, 0, 90), (6, 2, 0, 1, 0, 90),  -- FRA vs ARG
(1, 2, 3, 0, 0, 90), (2, 2, 0, 0, 1, 90),  -- FRA vs ARG

(3, 3, 0, 0, 0, 90), (4, 3, 0, 0, 0, 90),  -- BRA vs FRA
(5, 3, 0, 0, 0, 90), (6, 3, 0, 0, 0, 90);  -- BRA vs FRA
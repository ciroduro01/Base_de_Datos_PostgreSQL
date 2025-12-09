-- 1. CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE cuerpos_celestes;

-- Conectarse a la base de datos (comando específico de psql, no SQL estándar)
-- \c cuerpos_celestes; 

-- 2. CREACIÓN DE TABLAS (DDL)

CREATE TABLE Galaxia (
    galaxia_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    tipo VARCHAR(50), 
    distancia_millones_al NUMERIC(10, 2)
);

CREATE TABLE Estrella (
    estrella_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    galaxia_id INT REFERENCES Galaxia(galaxia_id) NOT NULL,
    tipo VARCHAR(50), 
    masa_solar NUMERIC(10, 2)
);

CREATE TABLE Planeta (
    planeta_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    estrella_id INT REFERENCES Estrella(estrella_id) NOT NULL,
    tipo VARCHAR(50), 
    tiene_anillos BOOLEAN,
    es_habitable BOOLEAN DEFAULT FALSE -- Columna añadida con ALTER TABLE
);

CREATE TABLE Luna (
    luna_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    planeta_id INT REFERENCES Planeta(planeta_id) NOT NULL,
    radio_km NUMERIC(10, 2)
);


-- 3. CREACIÓN DE VISTAS

-- Vista 1: Resumen detallado de Lunas
CREATE VIEW Resumen_Lunas AS
SELECT
    L.nombre AS Nombre_Luna,
    P.nombre AS Orbita_Planeta,
    E.nombre AS Orbita_Estrella,
    G.nombre AS Orbita_Galaxia
FROM
    Luna L
INNER JOIN Planeta P ON L.planeta_id = P.planeta_id
INNER JOIN Estrella E ON P.estrella_id = E.estrella_id
INNER JOIN Galaxia G ON E.galaxia_id = G.galaxia_id;

-- Vista 2: Información simplificada del Sistema Solar
CREATE VIEW Sistema_Solar_Info AS
SELECT
    P.nombre AS Nombre_Planeta,
    P.tipo AS Tipo_Clasificacion,
    P.tiene_anillos AS Posee_Anillos,
    P.es_habitable AS Es_Habitable,
    E.nombre AS Estrella_Central
FROM
    Planeta P
INNER JOIN Estrella E ON P.estrella_id = E.estrella_id
WHERE
    E.nombre = 'Sol';

-- INSERCIÓN DE DATOS (DML)

-- GALAXIAS (1: Vía Láctea, 2: Andrómeda)
INSERT INTO Galaxia (nombre, tipo, distancia_millones_al) VALUES ('Vía Láctea', 'Espiral Barrada', 0.027);
INSERT INTO Galaxia (nombre, tipo, distancia_millones_al) VALUES ('Andrómeda', 'Espiral', 2.537);

-- ESTRELLAS (1: Sol, 2: Proxima Centauri, 3: Andromeda Alpha)
INSERT INTO Estrella (nombre, galaxia_id, tipo, masa_solar) VALUES ('Sol', 1, 'Enana Amarilla', 1.00);
INSERT INTO Estrella (nombre, galaxia_id, tipo, masa_solar) VALUES ('Proxima Centauri', 1, 'Enana Roja', 0.12);
INSERT INTO Estrella (nombre, galaxia_id, tipo, masa_solar) VALUES ('Andromeda Alpha', 2, 'Gigante Azul', 15.5);

-- PLANETAS (Todos los del Sol son estrella_id=1, los de Proxima Centauri son estrella_id=2)
INSERT INTO Planeta (nombre, estrella_id, tipo, tiene_anillos, es_habitable) VALUES ('Tierra', 1, 'Rocoso', FALSE, TRUE); -- La Tierra se inserta como habitable
INSERT INTO Planeta (nombre, estrella_id, tipo, tiene_anillos) VALUES ('Mercurio', 1, 'Rocoso', FALSE);
INSERT INTO Planeta (nombre, estrella_id, tipo, tiene_anillos) VALUES ('Venus', 1, 'Rocoso', FALSE);
INSERT INTO Planeta (nombre, estrella_id, tipo, tiene_anillos) VALUES ('Marte', 1, 'Rocoso', FALSE);
INSERT INTO Planeta (nombre, estrella_id, tipo, tiene_anillos) VALUES ('Júpiter', 1, 'Gaseoso', TRUE);
INSERT INTO Planeta (nombre, estrella_id, tipo, tiene_anillos) VALUES ('Saturno', 1, 'Gaseoso', TRUE);
INSERT INTO Planeta (nombre, estrella_id, tipo, tiene_anillos) VALUES ('Urano', 1, 'Gigante de Hielo', TRUE);
INSERT INTO Planeta (nombre, estrella_id, tipo, tiene_anillos) VALUES ('Neptuno', 1, 'Gigante de Hielo', TRUE);

INSERT INTO Planeta (nombre, estrella_id, tipo, tiene_anillos) VALUES ('Proxima b', 2, 'Super-Tierra', FALSE);
INSERT INTO Planeta (nombre, estrella_id, tipo, tiene_anillos) VALUES ('Proxima c', 2, 'Gigante de Gas', FALSE);
INSERT INTO Planeta (nombre, estrella_id, tipo, tiene_anillos) VALUES ('Proxima d', 2, 'Sub-Tierra', FALSE);

INSERT INTO Planeta (nombre, estrella_id, tipo, tiene_anillos) VALUES ('Andromedian Prime', 3, 'Gigante de Hielo', TRUE);

-- LUNAS (planeta_id: 1=Tierra, 4=Marte, 5=Júpiter, asumiendo el orden de inserción)
INSERT INTO Luna (nombre, planeta_id, radio_km) VALUES ('Luna', 1, 1737.4);
INSERT INTO Luna (nombre, planeta_id, radio_km) VALUES ('Fobos', 4, 11.26);
INSERT INTO Luna (nombre, planeta_id, radio_km) VALUES ('Deimos', 4, 6.2);
INSERT INTO Luna (nombre, planeta_id, radio_km) VALUES ('Ío', 5, 1821.6);
INSERT INTO Luna (nombre, planeta_id, radio_km) VALUES ('Europa', 5, 1560.8);
INSERT INTO Luna (nombre, planeta_id, radio_km) VALUES ('Ganímedes', 5, 2634.1);
INSERT INTO Luna (nombre, planeta_id, radio_km) VALUES ('Calisto', 5, 2410.3);

-- ACTUALIZACIÓN FINAL (Aplica la clasificación a los Gigantes Gaseosos/de Hielo)
UPDATE Planeta SET tipo = 'Gigante Gaseoso o de Hielo' WHERE tiene_anillos = TRUE;
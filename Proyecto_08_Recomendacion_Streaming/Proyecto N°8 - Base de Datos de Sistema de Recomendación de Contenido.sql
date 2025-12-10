-- 1. CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE streaming_db;

-- Conectarse a la base de datos (comando específico de psql, no SQL estándar)
-- \c streaming_db;

-- 2. CREACIÓN DE TABLAS (DDL)

CREATE TABLE Usuario (
    usuario_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    fecha_registro DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE Género (
    genero_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Contenido (
    contenido_id SERIAL PRIMARY KEY,
    título VARCHAR(255) NOT NULL UNIQUE,
    tipo VARCHAR(50) NOT NULL, -- 'Película', 'Serie', 'Documental'
    fecha_lanzamiento DATE,
    director VARCHAR(100)
);

-- Tabla de Enlace N:M (Contenido y Género)
CREATE TABLE Contenido_Género (
    contenido_genero_id SERIAL PRIMARY KEY,
    contenido_id INT REFERENCES Contenido(contenido_id) NOT NULL,
    genero_id INT REFERENCES Género(genero_id) NOT NULL,
    UNIQUE (contenido_id, genero_id)
);

-- Tabla Transaccional N:M (Visualización y Calificación)
CREATE TABLE Visualización (
    visualización_id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES Usuario(usuario_id) NOT NULL,
    contenido_id INT REFERENCES Contenido(contenido_id) NOT NULL,
    fecha_vista TIMESTAMP NOT NULL DEFAULT NOW(),
    duración_min INT NOT NULL CHECK (duración_min > 0),
    calificación_usuario NUMERIC(2, 1) CHECK (calificación_usuario >= 1.0 AND calificación_usuario <= 5.0),

    UNIQUE (usuario_id, contenido_id, fecha_vista)
);


-- 3. CREACIÓN DE VISTAS

-- Vista: Historial de Visualización Detallado
CREATE VIEW Historial_Visualizacion_Detallado AS
SELECT
    V.visualización_id,
    U.nombre AS Nombre_Usuario,
    U.fecha_registro AS Usuario_Desde,
    C.título AS Título_Contenido,
    C.tipo AS Tipo_Contenido,
    C.fecha_lanzamiento,
    V.fecha_vista,
    V.duración_min,
    V.calificación_usuario
FROM
    Visualización V
INNER JOIN Usuario U ON V.usuario_id = U.usuario_id
INNER JOIN Contenido C ON V.contenido_id = C.contenido_id
ORDER BY
    U.nombre, V.fecha_vista DESC;

-- INSERCIÓN DE DATOS (DML)

-- USUARIOS (IDs 1-3)
INSERT INTO Usuario (nombre, email, fecha_registro) VALUES
('Alice Johnson', 'alice@stream.com', '2024-01-15'),  -- ID 1
('Bob Smith', 'bob@stream.com', '2024-03-20'),        -- ID 2
('Carol Davis', 'carol@stream.com', '2024-05-10');    -- ID 3

-- GÉNEROS (IDs 1-3)
INSERT INTO Género (nombre) VALUES
('Sci-Fi'),    -- ID 1
('Drama'),     -- ID 2
('Comedia');   -- ID 3

-- CONTENIDO (IDs 1-3)
INSERT INTO Contenido (título, tipo, fecha_lanzamiento, director) VALUES
('La Guerra Galáctica', 'Película', '2024-10-01', 'D. Nolan'), -- ID 1
('La Familia Real', 'Serie', '2023-05-15', 'J. Smith'),      -- ID 2
('Gatos Graciosos 5', 'Documental', '2020-01-01', 'P. Cat');  -- ID 3

-- CONTENIDO_GÉNERO (Relación N:M)
INSERT INTO Contenido_Género (contenido_id, genero_id) VALUES
(1, 1), (1, 2), -- La Guerra Galáctica es Sci-Fi y Drama
(2, 2),         -- La Familia Real es Drama
(3, 3);         -- Gatos Graciosos es Comedia

-- VISUALIZACIÓN (Transacciones y Calificaciones)
INSERT INTO Visualización (usuario_id, contenido_id, duración_min, calificación_usuario) VALUES
(1, 1, 120, 5.0), -- Alice: Guerra Galáctica (5.0)
(2, 1, 110, 4.0), -- Bob: Guerra Galáctica (4.0)
(2, 3, 30, 3.0),  -- Bob: Gatos Graciosos (3.0)
(3, 2, 60, 5.0); -- Carol: La Familia Real (5.0)
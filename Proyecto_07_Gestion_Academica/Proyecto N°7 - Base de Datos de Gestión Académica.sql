-- 1. CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE gestion_academica;

-- Conectarse a la base de datos (comando específico de psql, no SQL estándar)
-- \c gestion_academica;

-- 2. CREACIÓN DE TABLAS (DDL)

CREATE TABLE Departamento (
    depto_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Profesor (
    profesor_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    depto_id INT REFERENCES Departamento(depto_id) NOT NULL
);

CREATE TABLE Estudiante (
    estudiante_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    carrera VARCHAR(100)
);

CREATE TABLE Curso (
    curso_id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL UNIQUE,
    descripción TEXT,
    créditos INT NOT NULL CHECK (créditos > 0),
    depto_id INT REFERENCES Departamento(depto_id) NOT NULL,
    profesor_id INT REFERENCES Profesor(profesor_id)
);

-- Tabla de Enlace N:M (Historial Académico)
CREATE TABLE Inscripción (
    inscripción_id SERIAL PRIMARY KEY,
    estudiante_id INT REFERENCES Estudiante(estudiante_id) NOT NULL,
    curso_id INT REFERENCES Curso(curso_id) NOT NULL,
    semestre VARCHAR(10) NOT NULL,
    nota NUMERIC(4, 2) CHECK (nota >= 0 AND nota <= 10.00),
    estado VARCHAR(50) NOT NULL DEFAULT 'Inscrito',

    -- Restricción clave: Un estudiante solo puede inscribirse una vez en un curso por semestre.
    UNIQUE (estudiante_id, curso_id, semestre)
);


-- 3. CREACIÓN DE VISTAS

-- Vista: Historial Académico Completo (Desenvuelve las 5 tablas para reportes)
CREATE VIEW Historial_Academico_Estudiante AS
SELECT
    I.inscripción_id,
    E.nombre || ' ' || E.apellido AS Nombre_Estudiante,
    E.carrera AS Carrera_Estudiante,
    C.nombre AS Nombre_Curso,
    D.nombre AS Departamento,
    P.nombre || ' ' || P.apellido AS Nombre_Profesor,
    I.semestre,
    I.nota,
    I.estado
FROM
    Inscripción I
INNER JOIN Estudiante E ON I.estudiante_id = E.estudiante_id
INNER JOIN Curso C ON I.curso_id = C.curso_id
INNER JOIN Profesor P ON C.profesor_id = P.profesor_id
INNER JOIN Departamento D ON C.depto_id = D.depto_id
ORDER BY
    E.apellido, I.semestre DESC;

-- INSERCIÓN DE DATOS (DML)

-- DEPARTAMENTOS (IDs 1-3)
INSERT INTO Departamento (nombre) VALUES
('Ingeniería de Sistemas'), -- ID 1
('Ciencias Sociales'),       -- ID 2
('Artes y Diseño');         -- ID 3

-- PROFESORES (IDs 1-3)
INSERT INTO Profesor (depto_id, nombre, apellido, email) VALUES
(1, 'Dr. Javier', 'López', 'j.lopez@uni.edu'),    -- ID 1 (Sistemas)
(2, 'Dra. María', 'Rojas', 'm.rojas@uni.edu'),    -- ID 2 (Sociales)
(1, 'Ing. Ana', 'Pérez', 'a.perez@uni.edu');      -- ID 3 (Sistemas)

-- ESTUDIANTES (IDs 1-3)
INSERT INTO Estudiante (nombre, apellido, email, carrera) VALUES
('Sofía', 'Castro', 's.castro@uni.edu', 'Ingeniería de Sistemas'), -- ID 1
('Pedro', 'Méndez', 'p.mendez@uni.edu', 'Ciencias Políticas'),      -- ID 2
('Andrea', 'Giménez', 'a.gimenez@uni.edu', 'Diseño Gráfico'); -- ID 3

-- CURSOS (IDs 1-5)
INSERT INTO Curso (depto_id, profesor_id, nombre, descripción, créditos) VALUES
(1, 1, 'Bases de Datos I', 'Introducción a modelos relacionales', 4), -- ID 1
(1, 3, 'Programación Avanzada', 'Estructuras de datos y algoritmos', 5), -- ID 2
(2, 2, 'Sociología Contemporánea', 'Teoría social moderna', 3),    -- ID 3
(1, 3, 'Base de Datos II', 'Modelos No Relacionales y Optimización', 4), -- ID 4
(3, 2, 'Historia del Arte', 'Arte desde el Renacimiento hasta hoy', 3);    -- ID 5

-- INSCRIPCIONES (Notas - Semestres 2025-1 y 2025-2)
INSERT INTO Inscripción (estudiante_id, curso_id, semestre, nota, estado) VALUES
(1, 1, '2025-1', 9.50, 'Aprobado'),   -- Sofía: Bases de Datos I
(2, 3, '2025-1', 7.00, 'Aprobado'),   -- Pedro: Sociología

(1, 2, '2025-2', 6.80, 'Reprobado'),  -- Sofía: Prog. Avanzada
(2, 1, '2025-2', 8.20, 'Aprobado'),   -- Pedro: Bases de Datos I
(3, 5, '2025-2', 9.00, 'Aprobado'),   -- Andrea: Historia del Arte
(1, 4, '2025-2', 7.90, 'Aprobado');   -- Sofía: Base de Datos II
-- CONSULTAS ANALÍTICAS CLAVE del Proyecto N°7: Gestión Académica

-- CONSULTA N°1: REPORTE DE PROMEDIO POR CURSO (AVG y GROUP BY)
-- Objetivo: Determinar el rendimiento histórico de cada materia y profesor.
SELECT
    C.nombre AS Nombre_Curso,
    P.nombre || ' ' || P.apellido AS Profesor_Asignado,
    COUNT(I.estudiante_id) AS Total_Inscritos,
    ROUND(AVG(I.nota), 2) AS Nota_Promedio_Curso
FROM
    Inscripción I
INNER JOIN
    Curso C ON I.curso_id = C.curso_id
INNER JOIN
    Profesor P ON C.profesor_id = P.profesor_id
WHERE
    I.estado IN ('Aprobado', 'Reprobado')
GROUP BY
    C.curso_id, C.nombre, P.nombre, P.apellido
ORDER BY
    Nota_Promedio_Curso DESC;


-- CONSULTA N°2: HISTORIAL ACADÉMICO INDIVIDUAL (Usando la Vista)
-- Objetivo: Obtener la libreta de calificaciones completa de Sofía Castro.
SELECT
    Nombre_Curso,
    Nombre_Profesor,
    semestre,
    nota,
    estado
FROM
    Historial_Academico_Estudiante
WHERE
    Nombre_Estudiante = 'Sofía Castro'
ORDER BY
    semestre DESC;


-- CONSULTA N°3: PROMEDIO DE NOTAS POR ESTUDIANTE
-- Objetivo: Calcular el rendimiento académico global de cada estudiante.
SELECT
    E.nombre || ' ' || E.apellido AS Nombre_Estudiante,
    ROUND(AVG(I.nota), 2) AS Promedio_General
FROM
    Inscripción I
INNER JOIN
    Estudiante E ON I.estudiante_id = E.estudiante_id
WHERE
    I.estado IN ('Aprobado', 'Reprobado')
GROUP BY
    E.estudiante_id, E.nombre, E.apellido
ORDER BY
    Promedio_General DESC;
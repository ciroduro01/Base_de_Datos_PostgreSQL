-- CONSULTAS ANALÍTICAS CLAVE del Proyecto N°8: Sistema de Recomendación de Contenido

-- CONSULTA N°1: RANKING DE POPULARIDAD POR CALIFICACIÓN (AVG y GROUP BY)
-- Objetivo: Obtener el ranking de contenido mejor calificado.
SELECT
    C.título AS Título_Contenido,
    COUNT(V.usuario_id) AS Total_Calificaciones,
    ROUND(AVG(V.calificación_usuario), 1) AS Calificación_Promedio
FROM
    Visualización V
INNER JOIN
    Contenido C ON V.contenido_id = C.contenido_id
WHERE
    V.calificación_usuario IS NOT NULL
GROUP BY
    C.contenido_id, C.título
ORDER BY
    Calificación_Promedio DESC, Total_Calificaciones DESC;


-- CONSULTA N°2: GÉNERO DE MAYOR AFINIDAD POR USUARIO (SUM sobre 4 Tablas)
-- Objetivo: Determinar el género favorito del Usuario ID 2 (Bob Smith) basado en minutos de vista.
SELECT
    G.nombre AS Género,
    SUM(V.duración_min) AS Minutos_Totales_Vistos
FROM
    Visualización V
INNER JOIN
    Contenido C ON V.contenido_id = C.contenido_id
INNER JOIN
    Contenido_Género CG ON C.contenido_id = CG.contenido_id
INNER JOIN
    Género G ON CG.genero_id = G.genero_id
WHERE
    V.usuario_id = 2 -- Filtrar por Bob Smith
GROUP BY
    G.genero_id, G.nombre
ORDER BY
    Minutos_Totales_Vistos DESC;


-- CONSULTA N°3: HISTORIAL DE ACTIVIDAD COMPLETO (Usando la Vista)
-- Objetivo: Ver la actividad detallada de Alice Johnson.
SELECT
    Título_Contenido,
    tipo_contenido,
    fecha_vista,
    duración_min,
    calificación_usuario
FROM
    Historial_Visualizacion_Detallado
WHERE
    Nombre_Usuario = 'Alice Johnson'
ORDER BY
    fecha_vista DESC;
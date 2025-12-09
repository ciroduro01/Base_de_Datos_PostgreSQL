-- Consultas Clave del Proyecto N°3

--Consulta N°1: Utilización de Empleados (Métrica de Capacidad)
--Esta es la consulta más importante para el negocio: saber cuánto tiempo ha trabajado un empleado. Calcula el tiempo total (en horas) que cada empleado ha estado ocupado en citas completadas.
SELECT
    E.nombre || ' ' || E.apellido AS Empleado,
    ROUND(
        COALESCE(
            SUM(EXTRACT(EPOCH FROM (C.fecha_hora_fin - C.fecha_hora_inicio)))::NUMERIC / 3600
        , 0)
    , 2) AS Horas_Trabajadas_Total
FROM
    Empleado E
LEFT JOIN -- Usamos LEFT JOIN para incluir empleados sin citas completadas
    Cita C ON E.empleado_id = C.empleado_id AND C.estado = 'Completada'
GROUP BY
    E.empleado_id, Empleado
ORDER BY
    Horas_Trabajadas_Total DESC;
-- Consulta N°2: Ingreso por Especialidad
--Una métrica clave para la toma de decisiones financieras. Calcula el ingreso total generado por cada especialidad (ej. Peluquería, Manicura)
SELECT
    E.especialidad,
    SUM(S.precio) AS Ingreso_Total_Especialidad,
    COUNT(C.cita_id) AS Citas_Realizadas
FROM
    Empleado E
JOIN Cita C ON E.empleado_id = C.empleado_id
JOIN Servicio S ON C.servicio_id = S.servicio_id
WHERE
    C.estado = 'Completada'
GROUP BY
    E.especialidad
ORDER BY
    Ingreso_Total_Especialidad DESC;
--CONSULTAS ANALÍTICAS CLAVE del Proyecto N°2: Alquiler de Scooters
-- 1. CONSULTA DE INVENTARIO RÁPIDO (Usando la Vista)
-- Objetivo: Mostrar todos los scooters disponibles y cargados (batería > 70%) en sus respectivas estaciones.
SELECT
    *
FROM
    Scooters_Disponibles;


-- 2. REPORTE TRANSACCIONAL COMPLETO (JOIN Múltiple)
-- Objetivo: Mostrar el historial completo de un alquiler finalizado, incluyendo el nombre del cliente, el modelo del scooter y las ubicaciones de recogida y devolución.
SELECT
    C.nombre || ' ' || C.apellido AS Cliente,
    S.modelo AS Modelo_Scooter,
    A.fecha_hora_inicio AS Inicio,
    A.fecha_hora_fin AS Fin,
    U_Recogida.nombre AS Estacion_Recogida,
    U_Devolucion.nombre AS Estacion_Devolucion,
    A.costo_total AS Costo
FROM
    Alquiler A
INNER JOIN Cliente C ON A.cliente_id = C.cliente_id
INNER JOIN Scooter S ON A.scooter_id = S.scooter_id
INNER JOIN Ubicacion U_Recogida ON A.ubicacion_recogida_id = U_Recogida.ubicacion_id
INNER JOIN Ubicacion U_Devolucion ON A.ubicacion_devolucion_id = U_Devolucion.ubicacion_id
WHERE
    A.fecha_hora_fin IS NOT NULL;


-- 3. ANÁLISIS DE ACTIVIDAD (COUNT y GROUP BY)
-- Objetivo: Calcular el número total de alquileres realizados por cada cliente.
SELECT
    C.nombre || ' ' || C.apellido AS Nombre_Completo,
    COUNT(A.alquiler_id) AS Total_Alquileres_Realizados
FROM
    Cliente C
LEFT JOIN
    Alquiler A ON C.cliente_id = A.cliente_id
GROUP BY
    C.cliente_id
ORDER BY
    Total_Alquileres_Realizados DESC;


-- 4. ANÁLISIS DE LOGÍSTICA (HAVING)
-- Objetivo: Identificar qué ubicaciones han sido usadas como punto de DEVOLUCIÓN al menos 1 vez y cuántas devoluciones han recibido.
SELECT
    U.nombre AS Nombre_Ubicacion,
    COUNT(A.ubicacion_devolucion_id) AS Total_Devoluciones_Recibidas
FROM
    Ubicacion U
INNER JOIN
    Alquiler A ON U.ubicacion_id = A.ubicacion_devolucion_id
GROUP BY
    U.ubicacion_id, U.nombre
HAVING
    COUNT(A.ubicacion_devolucion_id) >= 1
ORDER BY
    Total_Devoluciones_Recibidas DESC;
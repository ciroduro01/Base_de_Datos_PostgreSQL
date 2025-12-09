--CONSULTAS ANALÍTICAS CLAVE del Proyecto N°4: Agencia de Viajes

-- CONSULTA N°1: REPORTE TRANSACCIONAL DETALLADO (Usando la Vista)
-- Objetivo: Obtener un listado de todas las reservas de los clientes, mostrando el destino y el costo.
SELECT
    Nombre_Cliente,
    Destino,
    Alojamiento,
    Check_In,
    Costo_Total_Reserva,
    Estado_Reserva
FROM
    Reporte_Reservas_Cliente
WHERE
    Estado_Reserva = 'Confirmada'
ORDER BY
    Check_In ASC;


--CONSULTA N°2: DETECCIÓN DE CONFLICTO DE RESERVA (Lógica de Fechas Avanzada)
-- Objetivo: Verificar si el Alojamiento ID 1 (Hotel Los Andes) está disponible entre el 18 y el 23 de marzo de 2026.
-- Si esta consulta devuelve alguna fila, significa que el alojamiento NO está disponible.
SELECT
    reserva_id,
    fecha_inicio,
    fecha_fin
FROM
    Reserva
WHERE
    alojamiento_id = 1
    AND estado = 'Confirmada'
    AND NOT (
        -- Lógica de NO superposición: [Nuevo fin <= Viejo inicio] OR [Nuevo inicio >= Viejo fin]
        '2026-03-23' <= fecha_inicio
        OR '2026-03-18' >= fecha_fin
    );


-- CONSULTA N°3: ANÁLISIS DE INGRESOS POR DESTINO (SUM y GROUP BY)
-- Objetivo: Calcular el ingreso total acumulado por cada destino turístico.
SELECT
    D.nombre AS Nombre_Destino,
    SUM(R.costo_total) AS Ingreso_Total_Acumulado
FROM
    Reserva R
INNER JOIN
    Alojamiento A ON R.alojamiento_id = A.alojamiento_id
INNER JOIN
    Destino D ON A.destino_id = D.destino_id
WHERE
    R.estado IN ('Confirmada', 'Finalizada')
GROUP BY
    D.destino_id, D.nombre
ORDER BY
    Ingreso_Total_Acumulado DESC;


-- CONSULTA N°4: CONSULTA DE CLIENTES MÁS ACTIVOS (COUNT y GROUP BY)
-- Objetivo: Identificar qué clientes han realizado más de una reserva (o una, en nuestro caso) para análisis de fidelidad.
SELECT
    CL.nombre || ' ' || CL.apellido AS Nombre_Cliente,
    COUNT(R.reserva_id) AS Total_Reservas
FROM
    Cliente CL
LEFT JOIN
    Reserva R ON CL.cliente_id = R.cliente_id
GROUP BY
    CL.cliente_id, CL.nombre, CL.apellido
HAVING
    COUNT(R.reserva_id) >= 1
ORDER BY
    Total_Reservas DESC;
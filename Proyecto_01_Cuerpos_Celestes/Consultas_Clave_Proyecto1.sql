--Consultas Clave para el Proyecto N°1
--Consulta 1: Conteo de Lunas por Planeta y Estrella
--Esta consulta verifica la profundidad del modelo, recorriendo las cuatro tablas (Luna, Planeta, Estrella, Galaxia) y utilizando COUNT y GROUP BY.
SELECT
    G.nombre AS Galaxia,
    E.nombre AS Estrella,
    P.nombre AS Planeta,
    COUNT(L.luna_id) AS Total_Lunas
FROM
    Galaxia G
JOIN Estrella E ON G.galaxia_id = E.galaxia_id
JOIN Planeta P ON E.estrella_id = P.estrella_id
LEFT JOIN Luna L ON P.planeta_id = L.planeta_id
GROUP BY
    G.nombre, E.nombre, P.nombre
ORDER BY
    Total_Lunas DESC, G.nombre, E.nombre;
--Consulta 2: Identificación de Planetas Habitables
--Esta consulta demuestra el uso de filtros lógicos (WHERE) en atributos de la base de datos, lo cual es la base para proyectos de análisis de datos como el que sugerimos.
SELECT
    G.nombre AS Galaxia,
    E.nombre AS Estrella,
    P.nombre AS Planeta,
    P.tipo
FROM
    Planeta P
JOIN Estrella E ON P.estrella_id = E.estrella_id
JOIN Galaxia G ON E.galaxia_id = G.galaxia_id
WHERE
    P.es_habitable = TRUE;

--Consulta N°3: Distribución de Tipos de Planetas
--Esta consulta será vital para nuestro último gráfico en Power BI
SELECT
    tipo AS Tipo_Planeta,
    COUNT(planeta_id) AS Cantidad
FROM
    Planeta
GROUP BY
    tipo
ORDER BY
    Cantidad DESC
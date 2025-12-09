--Consultas Clave del Proyecto N°5
--Consulta N°1: Clasificación por Rendimiento (Goles a Favor)
--Esta es la métrica básica de un torneo y requiere recorrer la tabla N:M. Calcula el total de Goles Anotados por cada país en el torneo.
SELECT
    P.nombre AS País,
    SUM(CASE
        -- Si el país fue local (es_local=TRUE), toma los goles_local.
        WHEN EP.es_local = TRUE THEN PA.goles_local
        -- Si el país fue visitante (es_local=FALSE), toma los goles_visitante.
        ELSE PA.goles_visitante
    END) AS Goles_Anotados_Total
FROM
    País P
JOIN Equipo_Partido EP ON P.pais_id = EP.pais_id
JOIN Partido PA ON EP.partido_id = PA.partido_id
GROUP BY
    P.nombre
ORDER BY
    Goles_Anotados_Total DESC;

--Consulta N°2: Resultado Detallado de un Partido (Lógica Condicional)
--Esta consulta demuestra la habilidad de usar lógica condicional (CASE WHEN) para determinar el resultado del partido (Victoria, Derrota o Empate) basado en la columna es_local.
--Muestra el resultado de un partido específico (ID 1), determinando el resultado y el marcador final.
SELECT
    P_Local.nombre AS Equipo_Local,
    PA.goles_local,
    PA.goles_visitante,
    P_Visitante.nombre AS Equipo_Visitante,
    CASE
        WHEN PA.goles_local > PA.goles_visitante THEN 'VICTORIA LOCAL'
        WHEN PA.goles_local < PA.goles_visitante THEN 'DERROTA LOCAL'
        ELSE 'EMPATE'
    END AS Resultado
FROM
    Partido PA
-- Unir para obtener el país LOCAL
JOIN Equipo_Partido EP_Local ON PA.partido_id = EP_Local.partido_id AND EP_Local.es_local = TRUE
JOIN País P_Local ON EP_Local.pais_id = P_Local.pais_id
-- Unir para obtener el país VISITANTE
JOIN Equipo_Partido EP_Visitante ON PA.partido_id = EP_Visitante.partido_id AND EP_Visitante.es_local = FALSE
JOIN País P_Visitante ON EP_Visitante.pais_id = P_Visitante.pais_id
WHERE
    PA.partido_id = 1;
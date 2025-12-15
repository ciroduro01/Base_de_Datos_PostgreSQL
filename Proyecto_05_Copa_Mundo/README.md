# Proyecto N°5: Modelado de Base de Datos - Copa del Mundo

## 1. Objetivo y Resumen Ejecutivo

Este proyecto tiene como objetivo diseñar y modelar una base de datos relacional avanzada para gestionar la información de un torneo de fútbol (Copa del Mundo). El foco está en el manejo de la **relación Muchos a Muchos (N:M)** entre países y partidos, y en el desarrollo de lógica condicional para el análisis de resultados.

**Resumen:** Se implementó un esquema relacional con una **tabla de enlace** (`Equipo_Partido`) para conectar países y partidos. Se desarrollaron consultas SQL con **`CASE WHEN`** para calcular métricas de rendimiento y determinar el resultado de cada encuentro, las cuales fueron visualizadas en un dashboard de Power BI.

---

## 2. Tecnologías y Herramientas Utilizadas

| Categoría | Herramienta | Uso Específico |
| :--- | :--- | :--- |
| **Base de Datos** | PostgreSQL | Almacenamiento, DDL, DML y ejecución de SQL. |
| **Modelado** | DBeaver | Diseño del Diagrama Entidad-Relación (ERD). |
| **Análisis** | SQL (N:M JOINs, CASE WHEN, SUM, GROUP BY) | Desarrollo de Consultas de rendimiento y resultados condicionales. |
| **Visualización** | Power BI | Creación del Dashboard de Ranking de Goles y Resultados Detallados. |

---

## 3. Resultados Clave y Visualizaciones

### A. Diseño del Modelo de Datos (ERD)
El esquema se basa en una relación de **Muchos a Muchos (N:M)** entre las tablas **`País`** y **`Partido`**, resuelta mediante la tabla de enlace **`Equipo_Partido`**. Esta tabla incluye el campo `es_local` para registrar la función de cada equipo, lo cual es vital para el análisis.

![Diagrama Entidad-Relación (ERD) del Modelo Copa del Mundo](assets/Proyecto5_ERD.png)

### B. Consultas Analíticas Clave
El proyecto se centró en dos métricas analíticas principales que demuestran el manejo de lógica compleja:

1.  **Ranking de Goles:** Uso de **`CASE WHEN`** dentro de una función **`SUM`** agregada para calcular el total de goles anotados por cada país, tomando el valor correcto de `goles_local` o `goles_visitante` según corresponda.
2.  **Lógica de Resultados:** Uso de **`CASE WHEN`** fuera de una función agregada para transformar la diferencia numérica de goles en una categoría textual de negocio (**"VICTORIA LOCAL"**, **"DERROTA LOCAL"**, o **"EMPATE"**).

### C. Dashboard de Power BI
Se generó un dashboard para visualizar los resultados analíticos:

* **Gráfico N°1:** **Ranking de Rendimiento Ofensivo: Total de Goles Anotados por País** (Gráfico de Barras).
    ![Gráfico de Barras del Ranking de Goles anotados por País](assets/Proyecto5_Goles_Pais.png)
* **Gráfico N°2:** **Resultados Detallados por Partido (Victoria/Derrota/Empate)** (Tabla).
    ![Tabla de Resultado de Partido](assets/Proyecto5_Resultados_Partido.png)
* **Gráfico N°3:** **Total General de Goles Anotados en el Torneo** (Tarjeta).
    ![Tarjeta con Total de Goles anotados en el Torneo](assets/Proyecto5_Goles_Torneo.png)

---

## 4. Metodología de Trabajo

El desarrollo del proyecto siguió un flujo de trabajo estructurado en las siguientes fases:

1.  **Fase 1: Modelado y DDL/DML:** Creación del esquema relacional N:M y carga de datos. Se puso énfasis en la correcta inserción de datos en la tabla `Equipo_Partido` para reflejar con precisión qué país jugó como local (`es_local = TRUE`) o visitante.
2.  **Fase 2: Consultas Analíticas (SQL Avanzado):** Desarrollo de las consultas clave, utilizando **múltiples `JOIN`s** para navegar la relación N:M y la implementación avanzada de la sentencia **`CASE WHEN`** para generar métricas de rendimiento y resultados categóricos.
3.  **Fase 3: Análisis de BI:** Conexión de Power BI a las consultas clave y visualización de las métricas. Se utilizó un Gráfico de Barras para el ranking y una Tabla para la verificación de la lógica condicional de los resultados.

---

## 5. Estructura del Repositorio y Archivos

* **`Proyecto N°5 - Base de Datos de la Copa del Mundo.sql`**: Contiene la sentencia `CREATE DATABASE`, el DDL (tablas), y el DML (inserción de datos de prueba).
* **`Consultas_Clave_Proyecto5.sql`**: Contiene las consultas analíticas clave, incluyendo la lógica condicional y la agregación de goles.
* **`README.md`**: Documentación del proyecto.
* **`assets/`**: Carpeta que contiene el Diagrama Entidad-Relación (ERD) y las capturas de los gráficos de Power BI.

---

## 6. Conclusiones

El modelo de datos de la Copa del Mundo prueba la habilidad de trabajar con relaciones complejas (N:M) y la lógica de negocio condicional directamente en SQL. Las consultas y visualizaciones permiten un **análisis de rendimiento** preciso y la categorización automática de resultados, ofreciendo información valiosa y en tiempo real sobre el progreso del torneo.

---

# Project 5: Database Modeling - World Cup

## 1. Objective and Project Overview

This project aims to design and model an advanced relational database to manage information for a football tournament (World Cup). The focus is on handling the Many-to-Many (M:M) relationship between countries and matches, and on developing conditional logic for results analysis.

**Summary**: A relational schema was implemented with a link table (`Equipo_Partido`) to connect countries and matches. SQL queries with CASE WHEN statements were developed to calculate performance metrics and determine the result of each match, which were then visualized in a Power BI dashboard.

---

## 2. Technologies and Tools Used

| Category | Tool | Specific Use |
| :--- | :--- | :--- |
| **Databases** | PostgreSQL | Storage, DDL, DML, and SQL execution. |
| **Modeling** | DBeaver | Entity-Relationship Diagram (ERD) design. |
| **Analysis** | SQL (N:M JOINs, CASE WHEN, SUM, GROUP BY) | Development of performance queries and conditional results. |
| **Visualization** | Power BI | Creation of the Goal Ranking and Detailed Results Dashboard. |

---

## 3. Key Results and Visualizations

### A. Data Model Design (ERD)
The schema is based on a Many-to-Many (N:M) relationship between the `País` and `Partido` tables, resolved using the `Equipo_Partido` link table. This table includes the `es_local` field to record each team's role, which is vital for the analysis.

![World Cup Model ERD diagram](assets/Proyecto5_ERD.png)

### B. Key Analytical Queries
The project focused on two main analytical metrics that demonstrate the handling of complex logic:

1. **Goal Ranking**: Use of `CASE WHEN` within an aggregated `SUM` function to calculate the total goals scored by each country, taking the correct value of `goles_local` or `goles_visitante` as appropriate.
2. **Results Logic**: Use of `CASE WHEN` outside of an aggregate function to transform the numerical goal difference into a business-oriented textual category: "HOME WIN" (*victoria local*), "HOME LOSS" (*derrota local*), or "DRAW" (*empate*).

### C. Power BI Dashboard
A dashboard was generated to visualize the analytical results:

* **Visualization 1**: Offensive Performance Ranking: Total Goals Scored by Country (Bar Chart).
    ![Total Goals Scored by Country chart](assets/Proyecto5_Goles_Pais.png)

* **Visualization 2**: Detailed Results by Match (Win/Loss/Draw) (Table).
    ![Detailed Results by Match table](assets/Proyecto5_Resultados_Partido.png)

* **Visualization 3**: Total Goals Scored in the Tournament (Card).
    ![Total Goals Scored card](assets/Proyecto5_Goles_Torneo.png)

---

## 4. Work Methodology
The project development followed a structured workflow in the following phases:

1. **Phase 1: Modeling and DDL/DML**: Creation of the N:M relational schema and data loading. Emphasis was placed on the correct insertion of data into the `Equipo_Partido` table to accurately reflect which country played as the home team (`es_local = TRUE`) or away team.
2. **Phase 2: Analytical Queries (Advanced SQL)**: Development of key queries, using multiple `JOINs` to navigate the N:M relationship and advanced implementation of the `CASE WHEN` statement to generate performance metrics and categorical results.
3. **Phase 3: BI Analysis**: Connection of Power BI to the key queries and visualization of the metrics. A bar chart was used for the ranking and a table for verifying the conditional logic of the results.

---

## 5. Repository Structure and Files

* **`Proyecto N°5 - Base de Datos de la Copa del Mundo.sql`**: Contains the `CREATE DATABASE` statement, the DDL (tables), and the DML (test data insertion).
* **`Consultas_Clave_Proyecto5.sql`**: Contains the key analytical queries, including the conditional logic and goal aggregation.
* **`README.md`**: Project documentation.
* **`assets/`**: Folder containing the Entity-Relationship Diagram (ERD) and Power BI chart screenshots.

---

## 6. Conclusions
The World Cup data model demonstrates the ability to work with complex (N:M) relationships and conditional business logic directly in SQL. The queries and visualizations enable accurate performance analysis and automatic categorization of results, providing valuable, real-time information on the tournament's progress.

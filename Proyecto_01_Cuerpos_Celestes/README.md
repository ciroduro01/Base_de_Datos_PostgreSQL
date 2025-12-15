# Proyecto N°1: Modelado de Base de Datos - Cuerpos Celestes

## 1. Objetivo y Resumen Ejecutivo

Este proyecto tiene como objetivo diseñar y modelar una base de datos relacional para gestionar información jerárquica de galaxias, estrellas, planetas y lunas.

**Resumen:** Se implementó un esquema relacional normalizado, se cargaron datos (DDL/DML) y se realizaron consultas analíticas que fueron visualizadas en un dashboard interactivo de Business Intelligence (Power BI) para obtener el ranking de lunas por planeta, los candidatos potenciales de mundos habitables, y la distribución porcentual de tipos de planeta.

---

## 2. Tecnologías y Herramientas Utilizadas

| Categoría | Herramienta | Uso Específico |
| :--- | :--- | :--- |
| **Base de Datos** | PostgreSQL | Almacenamiento y ejecución de SQL. |
| **Modelado** | DBeaver | Diseño del Diagrama Entidad-Relación (ERD). |
| **Análisis** | SQL (JOINs, GROUP BY, COUNT) | Desarrollo de las Consultas Analíticas Clave. |
| **Visualización** | Power BI | Creación del Dashboard de Conteo de Lunas, Mundos Habitables y Tipos de Planeta. |

---

## 3. Resultados Clave y Visualizaciones

### A. Diseño del Modelo de Datos (ERD)

El esquema utiliza un modelo relacional con jerarquía 1:N que conecta Galaxia -> Estrella -> Planeta -> Luna.

![Diagrama Entidad-Relación (ERD) del Modelo Cuerpos Celestes](assets/Proyecto1_ERD.png)

### B. Análisis de Business Intelligence (Power BI Dashboard)

El dashboard consolida tres visualizaciones clave basadas en consultas analíticas de la base de datos:

#### **Gráfico 1: Ranking de Conteo de Lunas**
* **Enfoque:** Jerarquía y Agregación. Determina el planeta con el mayor número de lunas, demostrando la capacidad de consolidar información a través de las cuatro tablas (`JOINs`, `COUNT`, `GROUP BY`).
* **Visualización:** Gráfico de barras interactivo.
    ![Gráfico de Barras del Ranking de Lunas por Planeta (Vista Inicial)](assets/Proyecto1_BI_Ranking_Final.png)
> **Nota:** El gráfico es interactivo y permite la navegación jerárquica (Drill Down). Se han incluido 3 vistas para demostrar la interactividad:
> 1.  ![Vista de Conteo por Galaxia](assets/Proyecto1_BI_Galaxia.png)
> 2.  ![Vista de Conteo por Estrella](assets/Proyecto1_BI_Estrella.png)
> 3.  ![Vista de Conteo por Planeta](assets/Proyecto1_BI_Planeta.png)

#### **Gráfico 2: Reporte de Mundos Habitables**
* **Enfoque:** Filtrado Lógico. Muestra la tabla de planetas que cumplen con el criterio `es_habitable = TRUE`. Demuestra la habilidad para extraer un reporte de estado clave para el negocio (el análisis de datos).
* **Visualización:** Tabla.
    ![Tabla de Planetas con Atributo 'Habitable' TRUE](assets/Proyecto1_BI_Mundos_Habitables.png)

#### **Gráfico 3: Distribución de Tipos de Planeta**
* **Enfoque:** Distribución Categórica. Muestra la proporción de los diferentes tipos de planetas (Gigante de Gas, Súper-Tierra, etc.). Demuestra la habilidad para generar una métrica de composición a partir de una columna categórica.
* **Visualización:** Gráfico de Anillo (*Donut* o Pastel).
    ![Gráfico de Anillo de Distribución por Tipo de Planeta](assets/Proyecto1_BI_Tipos_Planeta.png)

---

## 4. Procedimiento y Fases del Proyecto

1.  **Fase 1: Modelado y DDL/DML:** Creación del esquema con cuatro tablas (`Galaxia`, `Estrella`, `Planeta`, `Luna`) y definición de claves primarias y foráneas para asegurar la integridad referencial. Se utilizó el script principal para la carga de datos.
2.  **Fase 2: Consultas Analíticas (SQL):** Desarrollo de las consultas clave para responder a los requerimientos de negocio, incluyendo:
    * **Análisis Jerárquico:** Uso de `JOINs`, `COUNT` y `GROUP BY` para obtener el ranking de lunas por planeta.
    * **Filtrado Lógico:** Uso de la cláusula `WHERE` para identificar planetas habitables (`es_habitable = TRUE`).
    * **Análisis de Distribución:** Uso de `GROUP BY` para resumir la composición de la base de datos por tipo de planeta.
3.  **Fase 3: Análisis de BI:** Conexión de Power BI a la base de datos para la generación del Dashboard que visualiza las tres consultas analíticas en un único informe.

---

## 5. Estructura del Repositorio y Archivos

* **`Proyecto N°1 - Base de Datos de Cuerpos Celestes.sql`**: Contiene la sentencia `CREATE DATABASE`, el DDL (tablas) y el DML (inserción de datos).
* **`Consultas_Clave_Proyecto1.sql`**: Contiene las consultas analíticas clave.
* **`README.md`**: Documentación del proyecto.
* **`assets/`**: Carpeta que contiene todas las imágenes (ERD y gráficos de Power BI).

---

## 6. Conclusiones

La base de datos relacional modelada permite un almacenamiento eficiente y jerárquico de la información astronómica. El análisis de las consultas valida el modelo, demostrando que es posible obtener métricas de valor (ej. el conteo de lunas por planeta) cruciales para cualquier proyecto científico de datos.

---

# Project N°1: Database Modeling - Celestial Bodies

## 1. Objective and Project Overview

This project aims to design and model a relational database to manage hierarchical information about galaxies, stars, planets, and moons.

**Summary**: A normalized relational schema was implemented, data was loaded (DDL/DML), and analytical queries were performed and visualized in an interactive Business Intelligence dashboard (Power BI) to obtain the ranking of moons by planet, potential habitable world candidates, and the percentage distribution of planet types.

---

## 2. Technologies and Tools Used

|Category | Tool | Specific Use |
| :--- | :--- | :--- |
| **Databases** | PostgreSQL | SQL storage and execution. |
| **Modeling** | DBeaver | Entity-Relationship Diagram (ERD) design. | 
| **Analysis** | SQL (JOINs, GROUP BY, COUNT) | Development of Key Analytical Queries. |
| **Visualization** | Power BI | Creating a Dashboard for Moon Count, Habitable Worlds, and Planet Types. |

---

## 3. Key Results and Visualizations

### A. Data Model Design (ERD)

The schema uses a 1:N relational model that connects Galaxy -> Star -> Planet -> Moon.

![Celestial Bodies Model ERD Diagram](assets/Proyecto1_ERD.png)

### B. Business Intelligence Analysis (Power BI Dashboard)

The dashboard consolidates three key visualizations based on analytical database queries:

#### **Visualization 1: Moon Count Ranking**
* **Approach**: Hierarchy and Aggregation. It determines the planet with the highest number of moons, demonstrating the ability to consolidate information across four tables (JOINs, COUNT, GROUP BY).
* **Visualization**: Interactive bar chart.
    ![Moon Count Ranking bar char (General View)](assets/Proyecto1_BI_Ranking_Final.png)
> **Note**: The chart is interactive and allows hierarchical navigation (Drill Down). Three views have been included to demonstrate interactivity:
> 1.  ![per Galaxy](assets/Proyecto1_BI_Galaxia.png)
> 2.  ![per Star](assets/Proyecto1_BI_Estrella.png)
> 3.  ![per Planet](assets/Proyecto1_BI_Planeta.png)

#### **Visualization 2: Habitable Worlds Report**
* **Approach**: Logical Filtering. Shows the table of planets that meet the criterion `es_habitable = TRUE`. Demonstrates the ability to extract a key business status report (data analysis).
* **Visualization**: Table.
    ![ 'Habitable' Planet Table](assets/Proyecto1_BI_Mundos_Habitables.png)

#### **Visualization 3: Planet Type Distribution**
* **Approach**: Categorical Distribution. Shows the proportion of different planet types (Gas Giant, Super-Earth, etc.). Demonstrates the ability to generate a composition metric from a categorical column.
* **Visualization**: Donut Chart.
    ![Planet Type Distribution donut chart](assets/Proyecto1_BI_Tipos_Planeta.png)

---

## 4. Project Procedure and Phases

1. **Phase 1: Modeling and DDL/DML**: Creation of the schema with four tables (`Galaxy`, `Star`, `Planet`, `Moon`) and definition of primary and foreign keys to ensure referential integrity. The main script was used for data loading.
2. **Phase 2: Analytical Queries (SQL)**: Development of key queries to meet business requirements, including:
* **Hierarchical Analysis**: Use of `JOINs`, `COUNT`, and `GROUP BY` to obtain the ranking of moons by planet.
* **Logical Filtering**: Use of the `WHERE` clause to identify habitable planets (`es_habitable = TRUE`).
* **Distribution Analysis**: Use of `GROUP BY` to summarize the database composition by planet type.
3. **Phase 3: BI Analysis**: Connection of Power BI to the database to generate the dashboard that visualizes the three analytical queries in a single report.

---

## 5. Repository Structure and Files

* **`Proyecto N°1 - Base de Datos de Cuerpos Celestes.sql`**: Contains the `CREATE DATABASE` statement, the DDL (tables), and the DML (data insertion).
* **`Consultas_Clave_Proyecto1.sql`**: Contains the key analytical queries.
* **`README.md`**: Project documentation.
* **`assets/`**: Folder containing all images (ERD and Power BI charts).

---

## 6. Conclusions

The modeled relational database allows for efficient and hierarchical storage of astronomical information. The query analysis validates the model, demonstrating that it is possible to obtain valuable metrics (e.g., the number of moons per planet) crucial for any scientific data project.

---

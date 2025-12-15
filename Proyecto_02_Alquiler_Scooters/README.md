# Proyecto N°2: Base de Datos Transaccional para Alquiler de Scooters

## 1. Objetivo y Resumen Ejecutivo

Este proyecto tiene como objetivo diseñar y modelar una base de datos relacional para gestionar el **ciclo transaccional completo** de alquiler de *scooters* eléctricos. El sistema permite el registro de clientes, la gestión del inventario (estado y ubicación de *scooters*), el seguimiento de alquileres y el análisis logístico.

**Resumen:** Se implementó un esquema relacional para un negocio de movilidad (DDL/DML), se definieron claves foráneas complejas (doble relación con `Ubicacion`), se crearon consultas analíticas clave y se generó un *dashboard* interactivo en Power BI para el análisis logístico y operacional.

---

## 2. Tecnologías y Herramientas Utilizadas

| Categoría | Herramienta | Uso Específico |
| :--- | :--- | :--- |
| **Base de Datos** | PostgreSQL | Almacenamiento y ejecución de SQL. |
| **Modelado** | DBeaver | Diseño del Diagrama Entidad-Relación (ERD). |
| **Análisis** | SQL (VIEW, JOINs, GROUP BY, HAVING) | Desarrollo de las Consultas Analíticas Clave. |
| **Visualización** | Power BI | Creación del Dashboard de Inventario, Ranking de Clientes y Logística. |

---

## 3. Resultados Clave y Visualizaciones

### A. Diseño del Modelo de Datos (ERD)

El esquema utiliza un modelo relacional centrado en la tabla `Alquiler`, que gestiona las transacciones entre las entidades. El uso de claves foráneas asegura la integridad referencial en todo el flujo de trabajo del *scooter*.


* **Tablas Principales:**
    * `Cliente`: Información de los usuarios.
    * `Ubicacion`: Contiene los datos geográficos (`latitud`, `longitud`) de las estaciones.
    * `Scooter`: Estado operativo (`Disponible`, `Alquilado`) y nivel de batería.
    * `Alquiler`: Registro de la transacción, relacionado dos veces a `Ubicacion` (recogida y devolución).

![Diagrama Entidad-Relación (ERD) del Modelo Alquiler de Scooters](assets/Proyecto2_ERD.png)

### B. Análisis de Business Intelligence (Power BI Dashboard)

El *dashboard* consolida las métricas clave para la operación del negocio, basándose en las consultas analíticas de `Consultas_Clave_Proyecto2.sql`:

#### **Gráfico 1: Reporte de Inventario Operacional**
* **Enfoque:** Disponibilidad y Operación. Se basa en la **Vista `Scooters_Disponibles`** (Consulta 1), filtrando solo los *scooters* listos para alquilar (`estado = 'Disponible' AND bateria_porcentaje > 70`).
* **Visualización:** Tabla de reporte de *stock* en tiempo real.
    ![Tabla de Reporte de Inventario Operacional](assets/Proyecto2_Inventario_Operacional.png)
#### **Gráfico 2: Ranking de Clientes por Total de Alquileres**
* **Enfoque:** Fidelización. Utiliza la Consulta 3, aplicando `COUNT` y `GROUP BY` para generar un *ranking* de clientes basado en su actividad transaccional.
* **Visualización:** Gráfico de barras horizontal que clasifica a los clientes activos.
    ![Gráfico de Barras que clasifica a los clientes por total de alquileres](assets/Proyecto2_Clientes_Alquileres.png)
#### **Gráfico 3: Análisis Logístico de Devoluciones**
* **Enfoque:** Logística y Geografía. Utiliza la Consulta 4 y el comando **`HAVING`** para identificar las ubicaciones que más devoluciones reciben. Esta información es crítica para la redistribución de la flota.
* **Visualización:** Mapa geográfico con burbujas de diferente tamaño, donde el tamaño representa el `Total_Devoluciones_Recibidas`.
    ![Mapa geográfico con burbujas para representar el análisis logísitco de devoluciones](assets/Proyecto2_Mapa_Geográfico.png)
---

## 4. Procedimiento y Fases del Proyecto

1.  **Fase 1: Modelado y DDL/DML:** Creación del esquema con cuatro tablas y definición de claves primarias y foráneas. Se destaca la doble relación de la tabla `Alquiler` con `Ubicacion`.
2.  **Fase 2: Consultas Analíticas (SQL):** Desarrollo de las consultas clave para negocio: creación de una `VIEW` (Inventario), uso de *JOINs* múltiples (Reporte Transaccional), agregación con `GROUP BY` (Ranking de Clientes) y uso de la cláusula **`HAVING`** para filtrar por métricas agregadas (Logística).
3.  **Fase 3: Análisis de BI:** Conexión de Power BI a la base de datos para la generación del Dashboard, usando los resultados de las consultas analíticas como fuentes de datos.

---

## 5. Estructura del Repositorio y Archivos

* **`Proyecto N°2 - Base de Datos Transaccional para Alquiler de Scooters.sql`**: Contiene la sentencia `CREATE DATABASE`, el DDL (tablas) y el DML (inserción de datos).
* **`Consultas_Clave_Proyecto2.sql`**: Contiene las consultas analíticas clave.
* **`README.md`**: Documentación del proyecto.
* **`assets/`**: Carpeta que contiene las imágenes del ERD (`Proyecto2_ERD.png`) y los gráficos de Power BI (`Proyecto2_Inventario_Operacional.png`, `Proyecto2_Clientes_Alquileres.png`, `Proyecto2_Mapa_Geográfico.png`).

---

## 6. Conclusiones

La base de datos relacional modelada permite un seguimiento robusto de las transacciones. El análisis de las consultas, especialmente el uso del mapa logístico, valida la capacidad del modelo para proporcionar **información accionable** (decisiones logísticas) para una empresa de movilidad moderna.

---

# Project N°2: Transactional Database for Scooter Rentals

## 1. Objective and Project Overview

This project aims to design and model a relational database to manage the complete transactional cycle of electric scooter rentals. The system allows for customer registration, inventory management (scooter status and location), rental tracking, and logistical analysis.

**Summary**: A relational schema was implemented for a mobility business (DDL/DML), complex foreign keys were defined (double relationship with Location), key analytical queries were created, and an interactive dashboard was generated in Power BI for logistical and operational analysis.

---

## 2. Technologies and Tools Used

| Category | Tool | Specific Use |
| :--- | :--- | :--- |
| **Databases** | PostgreSQL | SQL storage and execution. |
| **Modeling** | DBeaver | Entity-Relationship Diagram (ERD) design. |
| **Analysis** | SQL (VIEW, JOINs, GROUP BY, HAVING) | Development of Key Analytical Queries. |
| **Visualization** | Power BI | Creation of Inventory, Customer Ranking, and Logistics Dashboard. |

---

## 3. Key Results and Visualizations

### A. Data Model Design (ERD)

The schema uses a relational model centered on the `Alquiler` table, which manages transactions between entities. The use of foreign keys ensures referential integrity throughout the scooter workflow.

* **Main Tables**:
* `Cliente`: User information.
* `Ubicacion`: Contains the geographic data (latitude, longitude) of the stations.
* `Scooter`: Operational status (Available, Rented) and battery level.
* `Alquiler`: Transaction record, linked twice to Location (pick-up and return).

![Scooter Rentals Model ERD Diagram](assets/Proyecto2_ERD.png)

### B. Business Intelligence Analysis (Power BI Dashboard)

The dashboard consolidates key metrics for business operations, based on the analytical queries in `Consultas_Clave_Proyecto2.sql`:

#### **Visualization 1: Operational Inventory Report**
* **Approach**: Availability and Operations. It is based on the **`Scooters_Disponibles`** view (Query 1), filtering only for scooters ready to rent (`estado = 'DISPONIBLE' AND bateria_porcentaje > 70`).
* **Visualization**: Real-time stock report table.
    ![Operational Inventory Report](assets/Proyecto2_Inventario_Operacional.png)
#### **Visualization 2: Customer Ranking by Total Rentals**
* **Approach**: Customer Loyalty. It uses Query 3, applying `COUNT` and `GROUP BY` to generate a customer ranking based on their transactional activity.
* **Visualization**: Horizontal bar chart classifying active customers.
    ![Active Customers bar chart](assets/Proyecto2_Clientes_Alquileres.png)
#### **Visualization 3: Returns Logistics Analysis**
* **Approach**: Logistics and Geography. Use Query 4 and the `HAVING` command to identify the locations receiving the most returns. This information is critical for fleet redistribution.
* **Visualization**: Geographic map with bubbles of varying sizes, where size represents `Total_Devoluciones_Recibidas`.
    ![Total Returns geographical map](assets/Proyecto2_Mapa_Geográfico.png)

---

## 4. Project Procedure and Phases

1. **Phase 1: Modeling and DDL/DML**: Creation of the schema with four tables and definition of primary and foreign keys. The two-way relationship between the `Alquiler` and `Ubicacion` tables is highlighted.
2. **Phase 2: Analytical Queries (SQL)**: Development of key business queries: creation of a `VIEW` (Inventory), use of multiple `JOINs` (Transactional Report), aggregation with `GROUP BY` (Customer Ranking), and use of the `HAVING` clause to filter by aggregated metrics (Logistics).
3. **Phase 3: BI Analysis**: Connection of Power BI to the database to generate the Dashboard, using the results of the analytical queries as data sources.

---

## 5. Repository and File Structure

* **`Proyecto N°2 - Base de Datos Transaccional para Alquiler de Scooters.sql`**: Contains the `CREATE DATABASE` statement, the DDL (tables), and the DML (data insertion).
* **`Consultas_Clave_Proyecto2.sql`**: Contains the key analytical queries.
* **`README.md`**: Project documentation.
* **`assets/`**: Folder containing the ERD diagram and the Power BI charts.

---

## 6. Conclusions
The modeled relational database allows for robust transaction tracking. The analysis of the queries, especially the use of the logistics map, validates the model's ability to provide actionable information (logistical decisions) for a modern mobility company.

---

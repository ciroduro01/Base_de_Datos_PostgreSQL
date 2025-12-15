# Proyecto N°6: Modelado de Base de Datos - Plataforma de E-Commerce

## 1. Objetivo y Resumen Ejecutivo

Este proyecto tiene como objetivo diseñar y modelar una base de datos relacional para una plataforma de comercio electrónico. El foco está en el manejo de transacciones de **facturación (pedidos y detalles)** y en la gestión de **inventario** en tiempo real.

**Resumen:** Se implementó un esquema relacional que utiliza una tabla de enlace (Muchos a Muchos) para gestionar el proceso de pedido y facturación. Se desarrollaron consultas SQL analíticas clave para calcular la **rentabilidad por producto** y para generar alertas de **inventario crítico**, las cuales fueron visualizadas en Power BI.

---

## 2. Tecnologías y Herramientas Utilizadas

| Categoría | Herramienta | Uso Específico |
| :--- | :--- | :--- |
| **Base de Datos** | PostgreSQL | Almacenamiento, DDL, DML y ejecución de SQL. |
| **Modelado** | DBeaver | Diseño y generación del **Diagrama Entidad-Relación (ERD)**. |
| **Análisis** | SQL (N:M JOINs, SUM, GROUP BY, Filtrado Condicional) | Desarrollo de Consultas de rentabilidad y gestión de stock. |
| **Visualización** | Power BI | Creación del Dashboard de Ranking de Ingresos e Inventario Crítico. |

---

## 3. Resultados Clave y Visualizaciones

### A. Diseño del Modelo de Datos (ERD)

El esquema relacional utiliza el patrón clásico de facturación (o Muchos a Muchos), donde las tablas **`Pedido`** y **`Producto`** se conectan a través de la tabla central **`Detalle_Pedido`** (la línea de la factura), lo que permite manejar múltiples productos por pedido.

![Diagrama Entidad-Relación (ERD) del Modelo Plataforma E-Commerce](assets/Proyecto6_ERD.png)

### B. Consultas Analíticas Clave

El proyecto se centró en métricas financieras (rentabilidad) y operacionales (inventario):

1.  **Ranking de Ingresos:** Uso de `SUM` y `GROUP BY` sobre el `Detalle_Pedido` para calcular la rentabilidad precisa de cada producto vendido (`cantidad * precio_unitario`).
2.  **Alerta de Inventario:** Desarrollo de una consulta simple pero crítica para la logística, utilizando `WHERE stock < 50` para identificar productos en **stock crítico** que requieren reabastecimiento urgente.
3.  **Detalle de Facturación:** Consulta que valida el modelo N:M al reconstruir la factura completa de un pedido específico, uniendo Cliente, Pedido y Detalle_Pedido.

### C. Dashboard de Power BI

Se generó un dashboard para visualizar los resultados analíticos y operativos:

* **Gráfico N°1:** **Ranking de Ingresos: Rentabilidad Total Acumulada por Producto** (Gráfico de Barras).
    ![Gráfico de Barras del Ranking de Ingresos (Rentabilidad)](assets/Proyecto6_Ingresos_Rentabilidad.png)

* **Gráfico N°2:** **Productos con Stock Crítico (Menos de 50 Unidades)** (Gráfico de Columnas).
    ![Gráfico de Columnas de Productos con Stock Crítico (Menos de 50 Unidades)](assets/Proyecto6_Productos_Stock.png)

* **Gráfico N°3:** **Detalle Transaccional de Pedido (Factura)** (Tabla).
    ![Tabla de Detalle Transaccional de Pedido (Factura)](assets/Proyecto6_Factura_Pedido.png)

---

## 4. Metodología de Trabajo

El desarrollo del proyecto siguió un flujo de trabajo estructurado en las siguientes fases:

1.  **Fase 1: Modelado y DDL/DML:** Creación del esquema relacional N:M, asegurando la integridad referencial y la correcta inserción de datos de clientes, productos y transacciones (pedidos y detalles).
2.  **Fase 2: Consultas Analíticas (SQL Avanzado):** Desarrollo de las consultas clave, destacando el uso de agregaciones (`SUM`) para cálculos financieros precisos y el filtrado condicional (`WHERE`) para la gestión de inventario.
3.  **Fase 3: Análisis de BI:** Conexión de Power BI a las tres consultas clave y visualización de las métricas. Se priorizó un diseño de dashboard que provee tanto una visión de alto nivel (rentabilidad) como alertas operativas (stock).

---

## 5. Estructura del Repositorio y Archivos

* **`Proyecto N°6 - Base de Datos de Plataforma de E-Commerce.sql`**: Contiene la sentencia `CREATE DATABASE`, el DDL (tablas) y el DML (inserción de datos de prueba).
* **`Consultas_Clave_Proyecto6.sql`**: Contiene las tres consultas analíticas clave (Rentabilidad, Inventario Crítico, Detalle de Facturación).
* **`README.md`**: Documentación del proyecto.
* **`assets/`**: Carpeta que contiene el Diagrama Entidad-Relación (ERD) y las capturas de los gráficos de Power BI.

---

## 6. Conclusiones

El modelo de E-Commerce es un esquema relacional estándar y robusto que permite análisis vitales. El proyecto demuestra la capacidad de calcular **métricas de rentabilidad** y generar **alertas operacionales** directamente desde la base de datos, proporcionando las herramientas esenciales para optimizar el inventario y maximizar los ingresos del negocio.

---

# Project 6: Database Modeling - E-Commerce Platform

## 1. Objective and Project Overview

This project aims to design and model a relational database for an e-commerce platform. The focus is on handling billing transactions (orders and details) and real-time inventory management.

**Summary**: A relational schema was implemented using a link table (Many-to-Many) to manage the order and billing process. Key analytical SQL queries were developed to calculate profitability per product and to generate critical inventory alerts, which were visualized in Power BI.

---

## 2. Technologies and Tools Used

| Category | Tool | Specific Use |
| :--- | :--- | :--- |
| **Databases** | PostgreSQL | Storage, DDL, DML, and SQL execution. |
| **Modeling** | DBeaver | Design and generation of the Entity-Relationship Diagram (ERD). |
| **Analysis** | (N:M JOINs, SUM, GROUP BY, Conditional Filtering) | Development of profitability and stock management queries. |
| **Visualization** | Power BI | Creation of the Revenue Ranking and Critical Inventory Dashboard. |

---

## 3. Key Results and Visualizations

### A. Data Model Design (ERD)

The relational schema uses the classic billing (or Many-to-Many) pattern, where the `Pedido` and `Producto` tables are connected through the central `Detalle_Pedido` table (the invoice line), allowing for the management of multiple products per order.

![E-Commerce Platform ERD diagram](assets/Proyecto6_ERD.png)

### B. Key Analytical Queries

The project focused on financial (profitability) and operational (inventory) metrics:

1. **Revenue Ranking**: Use of `SUM` and `GROUP BY` on the `Detalle_Pedido` table to calculate the precise profitability of each product sold (`cantidad * precio_unitario`).
2. **Inventory Alert**: Development of a simple but critical query for logistics, using `WHERE stock < 50` to identify products in critical stock that require urgent replenishment.
3. **Billing Details**: A query that validates the N:M model by reconstructing the complete invoice for a specific order, combining `Cliente`, `Pedido`, and `Detalle_Pedido`.

### C. Power BI Dashboard

A dashboard was generated to visualize the analytical and operational results:

* **Visualization 1**: Revenue Ranking: Total Accumulated Profitability per Product (Bar Chart).

    ![Total Accumulated Profitability per Product chart](assets/Proyecto6_Ingresos_Rentabilidad.png)

* **Visualization 2**: Products with Critical Stock (Less than 50 Units) (Column Chart).

    ![Products with Critical Stock chart](assets/Proyecto6_Productos_Stock.png)

* **Visualization 3**: Transactional Details of Order (Invoice) (Table).

    ![Transactional Details of Order table](assets/Proyecto6_Factura_Pedido.png)

---

## 4. Work Methodology

The project development followed a structured workflow in the following phases:

1. **Phase 1: Modeling and DDL/DML**: Creation of the N:M relational schema, ensuring referential integrity and the correct insertion of customer, product, and transaction data (orders and details).
2. **Phase 2: Analytical Queries (Advanced SQL)**: Development of key queries, emphasizing the use of aggregations (`SUM`) for accurate financial calculations and conditional filtering (`WHERE`) for inventory management.
3. **Phase 3: BI Analysis**: Connection of Power BI to the three key queries and visualization of the metrics. A dashboard design was prioritized that provides both a high-level view (profitability) and operational alerts (stock).

---

## 5. Repository and File Structure

* **`Proyecto N°6 - Base de Datos de Plataforma de E-Commerce.sql`**: Contains the `CREATE DATABASE` statement, the DDL (tables), and the DML (test data insertion).
* **`Consultas_Clave_Proyecto6.sql`**: Contains the three key analytical queries (Profitability, Critical Inventory, Billing Details).
* **`README.md`**: Project documentation.
* **`assets/`**: Folder containing the Entity-Relationship Diagram (ERD) and Power BI chart screenshots.

---

## 6. Conclusions
The E-Commerce model is a standard and robust relational schema that enables vital analysis. The project demonstrates the ability to calculate profitability metrics and generate operational alerts directly from the database, providing the essential tools to optimize inventory and maximize business revenue.

---

# Proyecto N°3: Modelado de Base de Datos - Planificador de Citas para Salón de Belleza

## 1. Objetivo y Resumen Ejecutivo

Este proyecto tiene como objetivo diseñar y modelar una base de datos relacional para la gestión operativa y financiera de un salón de belleza. El esquema permite registrar clientes, empleados, servicios y, lo más importante, las transacciones de citas con sus estados y duraciones.

**Resumen:** Se implementó un esquema relacional normalizado. Se cargaron datos DDL/DML y se desarrollaron consultas analíticas que fueron visualizadas en un dashboard de Business Intelligence (Power BI) para obtener métricas clave de **capacidad operativa** (Utilización de Empleados) y **rentabilidad** (Ingreso por Especialidad).

---

## 2. Tecnologías y Herramientas Utilizadas

| Categoría | Herramienta | Uso Específico |
| :--- | :--- | :--- |
| **Base de Datos** | PostgreSQL | Almacenamiento, DDL, DML y ejecución de SQL. |
| **Modelado** | DBeaver | Diseño y generación del Diagrama Entidad-Relación (ERD). |
| **Análisis** | SQL (EXTRACT, COALESCE, JOINs, GROUP BY) | Desarrollo de Consultas Analíticas con manejo de tiempo y agregación. |
| **Visualización** | Power BI | Creación del Dashboard de Utilización de Empleados e Ingreso por Especialidad. |

---

## 3. Resultados Clave y Visualizaciones

### A. Diseño del Modelo de Datos (ERD)

El esquema utiliza un modelo relacional centrado en la tabla transaccional **`Cita`**, que actúa como un punto de encuentro (many-to-many) entre las entidades principales: **`Cliente`**, **`Empleado`** y **`Servicio`**.

![Diagrama Entidad-Relación (ERD) del Modelo Planificador de Citas](assets/Proyecto3_ERD.png)

### B. Consultas Analíticas Clave

El proyecto se centró en dos métricas analíticas principales para la toma de decisiones:

1.  **Análisis de Capacidad:** Uso de funciones avanzadas de tiempo (`EXTRACT(EPOCH)`) para calcular las **Horas Trabajadas Totales** por cada empleado a partir de la diferencia entre `fecha_hora_inicio` y `fecha_hora_fin`.
2.  **Análisis Financiero:** Uso de `SUM` y `GROUP BY` sobre el precio del servicio para obtener el **Ingreso Total por Especialidad**, identificando las áreas más rentables del negocio.

### C. Dashboard de Power BI

Se realizó la conexión de Power BI a la base de datos para la generación del Dashboard que visualiza las dos consultas analíticas:

* **Gráfico N°1:** Ranking de Utilización de Empleados.
    ![Gráfico de Barras del Ranking de Utilización de Empleados](assets/Proyecto3_Empleados.png)
* **Gráfico N°2:** Distribución del Ingreso Total por Especialidad.
    ![Gráfico de Anillos de Distribución del Ingreso Total por Especialidad )](assets/Proyecto3_Especialidad.png)
---

## 4. Metodología de Trabajo

El desarrollo del proyecto siguió un flujo de trabajo estructurado en las siguientes fases:

1.  **Fase 1: Modelado y DDL/DML:** Creación del esquema relacional en DBeaver. Se implementaron el DDL y DML en PostgreSQL, incluyendo los comandos de **`UPDATE`** para asegurar que los datos de prueba fueran consistentes con las métricas de negocio requeridas.
2.  **Fase 2: Consultas Analíticas (SQL Avanzado):** Desarrollo de las consultas clave, utilizando **`LEFT JOIN`** y funciones de manejo de `TIMESTAMP` para calcular duraciones de tiempo, un requerimiento avanzado en bases de datos.
3.  **Fase 3: Análisis de BI:** Conexión de Power BI a PostgreSQL y visualización de las dos métricas clave de capacidad y rentabilidad, validando la funcionalidad del cálculo de horas con datos reales.

---

## 5. Estructura del Repositorio y Archivos

* **`Proyecto N°3 - Planificador de Citas para Salon de Belleza.sql`**: Contiene la sentencia `CREATE DATABASE`, el DDL, el DML y las correcciones de datos de prueba (`UPDATE`).
* **`Consultas_Clave_Proyecto3.sql`**: Contiene las consultas analíticas clave (`Consulta N°1` y `Consulta N°2`).
* **`README.md`**: Documentación del proyecto.
* **`assets/`**: Carpeta que contiene el Diagrama Entidad-Relación (ERD) y las capturas de los gráficos de Power BI.

---

## 6. Conclusiones

La base de datos modelada permite la gestión eficiente de transacciones de tiempo y personal. Las métricas de **Utilización de Empleados** y **Rentabilidad por Servicio** proporcionan a la administración del salón una visión crítica y en tiempo real sobre la capacidad operativa y la toma de decisiones estratégicas.

---
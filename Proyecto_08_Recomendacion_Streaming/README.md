# Proyecto N°8: Base de Datos para un Sistema de Recomendación de Contenido (Streaming)

## 1. Objetivo y Resumen Ejecutivo

Este proyecto tiene como objetivo diseñar y modelar una base de datos relacional orientada a soportar las funcionalidades clave de una plataforma de streaming y su motor de recomendación.

**Resumen:** Se implementó un esquema relacional para gestionar **Usuarios**, **Contenido** y la tabla transaccional **Visualización** (que incluye la duración de vista y la calificación). Se desarrollaron consultas analíticas para medir la popularidad de los títulos y la afinidad de los usuarios, las cuales fueron visualizadas en un dashboard de Business Intelligence (Power BI).

---

## 2. Tecnologías y Herramientas Utilizadas

| Categoría | Herramienta | Uso Específico |
| :--- | :--- | :--- |
| **Base de Datos** | PostgreSQL / MySQL | Almacenamiento, DDL, DML y ejecución de SQL. |
| **Modelado** | DBeaver | Diseño y visualización del Diagrama Entidad-Relación (ERD). |
| **Análisis** | SQL (JOINs complejos, AVG, SUM, GROUP BY) | Desarrollo de las Consultas Analíticas Clave. |
| **Visualización** | Power BI | Creación del Dashboard de Popularidad, Afinidad y Tendencia. |

---

## 3. Resultados Clave y Visualizaciones

### A. Diseño del Modelo de Datos (ERD)

El esquema se centra en la tabla de enlace **Visualización**, que captura las métricas de comportamiento (duración de vista y calificación) entre los Usuarios y el Contenido. Esto es fundamental para construir el modelo de afinidad y popularidad.

![Diagrama Entidad-Relación (ERD) del Modelo Sistema de Recomendación de Contenido](assets/Proyecto8_ERD.png)

### B. Consultas Analíticas Clave

Las consultas se orientaron a obtener las métricas esenciales para el negocio de streaming:

1.  **Top Contenido: Calificación Promedio y Total de Votos**
    * **Objetivo:** Ranking de popularidad y calidad de los títulos.
2.  **Análisis de Preferencias: Distribución por Género del Usuario Específico**
    * **Objetivo:** Base para la recomendación personalizada, midiendo la afinidad de un usuario por género (usando el tiempo total de vista).
3.  **Actividad Histórica de Visualizaciones por Mes**
    * **Objetivo:** Medir la tendencia y retención de la plataforma en el tiempo.

### C. Dashboard de Power BI (Visualizaciones)

El dashboard contiene los tres gráficos clave para el monitoreo del sistema:

* **Gráfico N°1:** **Top Contenido: Calificación Promedio y Total de Votos** (Gráfico de Barras Horizontal)
    ![Gráfico de Barras del Contenido Top (Calificación Promedio)](assets/Proyecto8_Top_Contenido.png)

* **Gráfico N°2:** **Análisis de Preferencias: Distribución por Género del Usuario Específico** (Gráfico de Anillo/Tarta)
    ![Gráfico de Anillo del Análisis de Preferencias por Género (Usuario Específico)](assets/Proyecto8_Preferencias_Genero.png)

* **Gráfico N°3:** **Actividad Histórica de Visualizaciones por Mes** (Tabla)
    ![Tabla de Actividad de Visualizaciones por Mes](assets/Proyecto8_Historial_Visualizaciones.png)

---

## 4. Desarrollo del Proyecto (Metodología)

El proyecto se dividió en tres fases principales:

1.  **Fase 1: Modelado e Implementación (SQL):** Diseño del esquema con enfoque en la tabla transaccional `Visualización`. Creación del DDL y la carga de datos (DML) para generar un entorno de prueba funcional.
2.  **Fase 2: Consultas Analíticas (SQL):** Desarrollo de las consultas clave (`AVG`, `SUM`, `GROUP BY` y `JOINs`) para extraer métricas de popularidad y afinidad.
3.  **Fase 3: Análisis de BI:** Conexión de Power BI a la base de datos para la generación del Dashboard que visualiza las tres consultas analíticas en un único informe, permitiendo un análisis rápido de la retención y la afinidad de los usuarios.

---

## 5. Estructura del Repositorio y Archivos

* **`Proyecto N°8 - Base de Datos de Sistema de Recomendación de Contenido.sql`**: Contiene la sentencia `CREATE DATABASE`, el DDL (tablas) y el DML (inserción de datos).
* **`Consultas_Clave_Proyecto8.sql`**: Contiene las consultas analíticas clave.
* **`README.md`**: Documentación del proyecto.
* **`assets/`**: Carpeta que contiene todas las imágenes (ERD y gráficos de Power BI).

---

## 6. Conclusiones

La base de datos relacional modelada ofrece un esqueleto robusto para un sistema de recomendación, permitiendo almacenar y consultar eficientemente el comportamiento del usuario. El análisis de las consultas clave proporciona una visión clara de la popularidad del contenido y las preferencias individuales, información indispensable para cualquier motor de recomendación.

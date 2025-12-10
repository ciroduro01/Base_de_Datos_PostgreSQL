# Proyecto N°7: Modelado de Base de Datos - Gestión Académica

## 1. Objetivo y Resumen Ejecutivo

Este proyecto tiene como objetivo diseñar y modelar una base de datos relacional para gestionar la **información académica** de una institución educativa, incluyendo estudiantes, profesores, cursos y el historial de calificaciones.

**Resumen:** Se implementó un esquema relacional que utiliza la tabla de enlace **`Inscripción`** para modelar la relación Muchos a Muchos (N:M) entre Estudiante y Curso. Se desarrollaron consultas SQL analíticas clave para calcular el **rendimiento promedio por curso** y el **promedio general por estudiante**, las cuales fueron visualizadas en un Dashboard de Power BI.

---

## 2. Tecnologías y Herramientas Utilizadas

| Categoría | Herramienta | Uso Específico |
| :--- | :--- | :--- |
| **Base de Datos** | PostgreSQL | Almacenamiento, DDL, DML y ejecución de SQL. |
| **Modelado** | DBeaver | Diseño y generación del **Diagrama Entidad-Relación (ERD)**. |
| **Análisis** | SQL (AVG, GROUP BY, N:M JOINs) | Desarrollo de Consultas de rendimiento académico. |
| **Visualización** | Power BI | Creación del Dashboard de Ranking de Cursos y Estudiantes. |

---

## 3. Resultados Clave y Visualizaciones

### A. Diseño del Modelo de Datos (ERD)

El esquema relacional utiliza una tabla de enlace central (`Inscripción`) que conecta la entidad **`Estudiante`** con la entidad **`Curso`**. Esta tabla de enlace almacena las calificaciones y el estado final, lo cual es la clave para todos los análisis de rendimiento.

![Diagrama Entidad-Relación (ERD) del Modelo Gestión Académica](assets/Proyecto7_ERD.png)

### B. Consultas Analíticas Clave

El proyecto se centró en métricas de rendimiento tanto a nivel de curso como a nivel de estudiante:

1.  **Rendimiento por Curso:** Uso de la función de agregación `AVG` y `GROUP BY` sobre la tabla `Inscripción` para determinar el rendimiento histórico de cada materia y profesor.
2.  **Promedio General por Estudiante:** Uso de `AVG` y `GROUP BY` para calcular la métrica de rendimiento individual más importante, permitiendo un ranking de los estudiantes más destacados.
3.  **Historial Individual:** Consulta que demuestra la capacidad del modelo para generar una **Libreta de Calificaciones** precisa, utilizando una `VIEW` o `JOINs` para obtener el detalle de todas las notas de un estudiante específico.

### C. Dashboard de Power BI

Se generó un dashboard para visualizar los resultados académicos:

* **Gráfico N°1:** **Ranking de Cursos: Rendimiento Histórico (Nota Promedio)** (Gráfico de Barras).
    ![Gráfico de Barras del Ranking de Cursos (Promedio por Curso)](assets/Proyecto7_Nota_Promedio.png)

* **Gráfico N°2:** **Ranking de Estudiantes: Promedio General Acumulado** (Gráfico de Anillo).
    ![Gráfico de Anillo del Ranking de Estudiantes (Promedio por Estudiante)](assets/Proyecto7_Promedio_General.png)

* **Gráfico N°3:** **Historial Académico Detallado (Libreta de Calificaciones)** (Tabla).
    ![Tabla del Historial Académico (Libreta de Calificaciones)](assets/Proyecto7_Libreta_Calificaciones.png)

---

## 4. Metodología de Trabajo

El desarrollo del proyecto siguió un flujo de trabajo estructurado en las siguientes fases:

1.  **Fase 1: Modelado y DDL/DML:** Creación del esquema relacional N:M, enfocándose en la tabla `Inscripción` para capturar la nota, el estado y el semestre, asegurando la integridad referencial.
2.  **Fase 2: Consultas Analíticas (SQL Avanzado):** Desarrollo de las consultas clave, utilizando funciones de agregación (`AVG`, `COUNT`) y la cláusula `GROUP BY` para generar reportes estadísticos a diferentes niveles (curso e individuo).
3.  **Fase 3: Análisis de BI:** Conexión de Power BI a las tres consultas clave y visualización de las métricas. Se priorizó un diseño de dashboard que provee tanto una visión de alto nivel (rankings) como la capacidad de detalle transaccional (libreta).

---

## 5. Estructura del Repositorio y Archivos

* **`Proyecto N°7 - Base de Datos de Gestión Académica.sql`**: Contiene la sentencia `CREATE DATABASE`, el DDL (tablas) y el DML (inserción de datos de prueba).
* **`Consultas_Clave_Proyecto7.sql`**: Contiene las tres consultas analíticas clave (Promedio por Curso, Promedio por Estudiante, Historial Individual).
* **`README.md`**: Documentación del proyecto.
* **`assets/`**: Carpeta que contiene el Diagrama Entidad-Relación (ERD) y las capturas de los gráficos de Power BI.

---

## 6. Conclusiones

El modelo de Gestión Académica es un esquema relacional probado que permite la administración precisa de la información de rendimiento. El proyecto demuestra la capacidad de transformar datos de calificaciones en métricas accionables (rankings) que son vitales para la toma de decisiones administrativas y el seguimiento individual del progreso del estudiante.

---
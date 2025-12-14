# 8 Proyectos de Modelado de Bases de Datos con PostgreSQL

## Resumen del Repositorio

Esta es una colección de **8 proyectos integrales** de bases de datos diseñados en **PostgreSQL**, que demuestran la capacidad de pasar del modelado de datos simple (1:N) a los esquemas complejos (N:M) orientados al **Análisis de Negocio (BI)**.

Cada proyecto incluye el **DDL**, el **DML**, las **Consultas Analíticas Clave** y el `README.md` de documentación, simulando entornos de negocio reales.

## Progresión de Habilidades y Niveles

Los proyectos están categorizados para mostrar una clara **progresión de aprendizaje** en diseño de esquemas y complejidad SQL:

### Nivel Básico: Fundamentos y Relaciones 1:N

| Proyectos | Enfoque |
| :--- | :--- |
| **P. N°1** | Primer contacto con `CREATE TABLE` y `JOINs` (Cuerpos Celestes). |
| **P. N°3** | Modelado de restricciones de tiempo y uso de `CHECK` (Planificador de Citas). |

### Nivel Intermedio: Tablas N:M y Lógica de Negocio

| Proyectos | Enfoque |
| :--- | :--- |
| **P. N°4** | Manejo de **lógica de fechas** y reservas (Agencia de Viajes). |
| **P. N°5** | **Relaciones N:M complejas** y agregaciones condicionales (`CASE WHEN`) (Copa del Mundo). |
| **P. N°6** | Modelo de **Transacciones/Facturación** (E-Commerce). |

### Nivel Avanzado: Análisis de Datos (BI) y Alto Rendimiento

| Proyectos | Enfoque Técnico |
| :--- | :--- |
| **P. N°7** | Esquema de **Gestión Académica** con cálculos de rendimiento (`AVG` con `GROUP BY`). |
| **P. N°8** | Modelo para **Sistema de Recomendación** (Afinidad y Popularidad), clave para el análisis en Power BI. |

---

## Cómo Usar Este Repositorio

Si deseas ejecutar cualquiera de los proyectos, sigue estos pasos:

1.  **Clonar el Repositorio:**
    ```bash
    git clone [https://github.com/ciroduro01/Base_de_Datos_PostgreSQL.git](https://github.com/ciroduro01/Base_de_Datos_PostgreSQL.git)
    ```

2.  **Configuración de la Base de Datos:**
    * Asegúrate de tener un servidor **PostgreSQL** corriendo localmente.
    * Ejecuta el archivo SQL principal (`Proyecto N°X - Base de Datos... .sql`) de la carpeta deseada en tu cliente SQL (DBeaver, pgAdmin, etc.).

3.  **Explora las Consultas:**
    * Cada carpeta contiene un archivo `Consultas_Clave_ProyectoX.sql` con el código analítico de valor de negocio para ser conectado a herramientas de Business Intelligence.

---

## Licencia

Este trabajo se comparte bajo la **[Licencia MIT](LICENSE)**, lo que permite su uso y modificación con fines de estudio o portafolio.

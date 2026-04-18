# base-de-datos-p-blicas

# Base de Datos: Información Documental de la Agroindustria Azucarera
# Fuente: https://www.datos.gob.mx/
**Autor:** Uriel Espinoza de la Rosa
**Carrera:** Ingeniería en Sistemas Computacionales (Instituto Tecnológico de Oaxaca)

## Descripción del Proyecto
Este repositorio contiene el diseño, estructuración e importación de una base de datos relacional orientada a la información documental del sector agroindustrial azucarero en México. Los datos fuente fueron obtenidos directamente de la Plataforma Nacional de Datos Abiertos del Gobierno de México.

## Contenido del Repositorio
* `si_investigacion_2026_enero.csv`: Archivo original.
* `agroindustrial.sql`: Script de exportación.

## Base de Datos: Censo de Población y Vivienda (INEGI)

**Fuente:** [https://www.inegi.org.mx/](https://www.inegi.org.mx/)

### Descripción del Proyecto
Este apartado integra los datos estadísticos del Censo 2020 a nivel Entidad y Distrito. La base de datos permite analizar variables demográficas, sociales y de vivienda, facilitando la correlación entre la distribución poblacional y otros sectores económicos.

### Estructura de las Tablas
Se diseñaron dos tablas principales para organizar la información:

1. **`datos_entidad`**: Información agregada por estado (32 registros).
2. **`datos_por_distrito`**: Información detallada por distrito electoral/geográfico.

### Contenido Relacionado en el Repositorio
* `INE_DISTRITO_2020.csv`: Datos fuente procesados para su importación.
* `importacion_inegi.sql`: Script con la estructura de las tablas y comandos `LOAD DATA` para la carga masiva.

## Base de Datos: Instalaciones de la NASA (NASA Facilities)

**Fuente:** [https://data.nasa.gov/](https://data.nasa.gov/)

### Descripción del Proyecto
Este apartado integra el conjunto de datos oficial de las instalaciones de la NASA a nivel global. La base de datos permite consultar información técnica e histórica sobre la infraestructura de la agencia, incluyendo centros de investigación, laboratorios y plataformas de lanzamiento. Los datos son públicos bajo la política de datos abiertos de EE. UU. para fomentar la transparencia y la colaboración científica.

### Estructura de la Tabla
Se diseñó una tabla optimizada para la gestión de metadatos científicos:

### Contenido Relacionado en el Repositorio
* `NASA_Facilities_rows.csv`: Datos fuente originales obtenidos del portal Open Data de la NASA.
* `NASA_Instalaciones.sql`: Script que contiene la estructura DDL de la tabla y las consultas de verificación.

---

## Base de Datos: Yelp Open Dataset (Negocios comerciales y reseñas)

**Fuente:** [https://business.yelp.com/data/resources/open-dataset/](https://business.yelp.com/data/resources/open-dataset/)
**Autor:** Jafet Jose Sebastian
**Carrera:** Ingeniería en Sistemas Computacionales (Instituto Tecnológico de Oaxaca)

### Descripción del Proyecto
Este apartado contiene una base de datos relacional construida a partir de un subconjunto de datos reales del Yelp Open Dataset. Yelp hace pública esta información con fines educativos para que estudiantes e investigadores trabajen con datos reales en proyectos de análisis. 

El objetivo de esta integración fue la extracción y transformación de un archivo masivo (NDJSON) a un formato manejable (CSV), para posteriormente importar una muestra representativa de establecimientos, facilitando así el análisis de negocios, ubicación y reputación digital mediante consultas SQL.

### Estructura de las Tablas
Para optimizar el manejo de la información, se implementó un diseño de tabla única:

1. **`business`**: Almacena más de 2,100 registros funcionales con los datos principales de los locales (ID del negocio, nombre, dirección, ciudad, estado, código postal, coordenadas geográficas, calificación de estrellas y cantidad de reseñas).

### Contenido Relacionado en el Repositorio
* `datos_yelp.sql`: Script de exportación autocontenido generado en MySQL Workbench. Incluye la sentencia de creación de la tabla y los comandos `INSERT` para la carga inmediata de los datos en cualquier gestor local.


## Base de Datos: World Bank Open Data (PIB actual en US$)

**Fuente:** [https://data.worldbank.org/](https://data.worldbank.org/)
**Autor:** Jhoan Marvin Cruz Sanchez
**Carrera:** Ingeniería en Sistemas Computacionales (Instituto Tecnológico de Oaxaca)

### Descripción del Proyecto
Este apartado contiene una base de datos relacional construida a partir de datos públicos de **World Bank Open Data**, utilizando el indicador **GDP (current US$)** con clave **NY.GDP.MKTP.CD**. 

El Banco Mundial publica esta información como parte de su iniciativa de datos abiertos, con el propósito de fomentar la transparencia, el análisis económico, la investigación académica y la reutilización de información estadística por parte de estudiantes, investigadores, instituciones y desarrolladores.

En este proyecto, los datos fueron descargados en formato CSV, adaptados para su importación y posteriormente integrados en MySQL Workbench mediante una tabla única, con el fin de facilitar consultas relacionadas con el comportamiento del Producto Interno Bruto de distintos países a lo largo del tiempo.

### Estructura de la Tabla
Para simplificar la administración y consulta de la información, se diseñó una tabla principal:

1. **`wb_gdp_current_usd`**: Almacena los registros del indicador económico por país y año, incluyendo nombre del país, código, nombre del indicador, clave del indicador, año y valor del PIB en dólares corrientes.

### Contenido Relacionado en el Repositorio
* `API_NY.GDP.MKTP.CD_DS2_EN_csv_v2_23606_LIST.csv`: Archivo fuente en formato CSV utilizado para la importación de datos.
* `API_NY.GDP.MKTP.CD_DS2_EN_csv_v2_23606_LIST.sql`: Script de exportación que contiene la estructura de la tabla y los datos cargados en MySQL.

### Observación
La base de datos fue creada con fines académicos, como ejemplo práctico de descarga, transformación, importación y consulta de datos abiertos provenientes de una fuente internacional oficial.

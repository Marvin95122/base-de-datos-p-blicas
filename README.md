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

-- 1. CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE IF NOT EXISTS nasa_projects;
USE nasa_projects;

-- 2. ESTRUCTURA DE LA TABLA (METADATOS DE LA NASA)
-- Esta tabla fue diseñada para recibir los datos históricos de instalaciones
CREATE TABLE IF NOT EXISTS instalaciones_nasa (
    Center VARCHAR(100),
    Center_Search_Status VARCHAR(50),
    Facility VARCHAR(255),
    FacilityURL VARCHAR(255),
    Occupied VARCHAR(20),
    Status VARCHAR(50),
    URL_Link VARCHAR(255),
    Record_Date VARCHAR(50),
    Last_Update VARCHAR(50),
    Country VARCHAR(10),
    Contact VARCHAR(100),
    Phone VARCHAR(50),
    Location VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(50),
    Zipcode VARCHAR(20)
);

-- 3. CONSULTA DE DATOS IMPORTADOS
SELECT * FROM instalaciones_nasa;
-- Creacion de DB
CREATE DATABASE Automotores
GO
--- Seleccion de la DB
USE Automotores

-- Comenzamos creando las Tablas Auxiliares
CREATE TABLE marcas_vehiculos (
	id_marca INT IDENTITY (1,1) NOT NULL,
	nombre VARCHAR(50),
	CONSTRAINT pk_id_marca PRIMARY KEY (id_marca), 
)
CREATE TABLE modelos_vehiculos (
	id_modelo INT IDENTITY (1,1) NOT NULL,
	nombre VARCHAR(50),
	id_marca int,
	CONSTRAINT pk_id_modelo PRIMARY KEY (id_modelo),
	CONSTRAINT fk_id_marca FOREIGN KEY (id_marca) REFERENCES marcas_vehiculos(id_marca)
)
CREATE TABLE tipos_productos (
    id_tipoprod INT IDENTITY (1,1) NOT NULL,
    nombre VARCHAR(50),
    CONSTRAINT pk_id_tipoprod PRIMARY KEY (id_tipoprod)
)
CREATE TABLE tipos_factura (
    id_tipofact INT IDENTITY (1,1) NOT NULL,
    nombre VARCHAR(50),
    CONSTRAINT pk_id_tipofact PRIMARY KEY (id_tipofact)
)
CREATE TABLE cargos (
    id_cargo INT IDENTITY (1,1) NOT NULL,
    nombre VARCHAR(50),
    CONSTRAINT pk_id_cargo PRIMARY KEY (id_cargo)
)
CREATE TABLE tipos_clientes (
    id_tipocli INT IDENTITY (1,1) NOT NULL,
    nombre VARCHAR(50)
    CONSTRAINT pk_id_tipocli PRIMARY KEY (id_tipocli)
)
CREATE TABLE generos (
    id_genero INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50),
    CONSTRAINT pk_id_genero PRIMARY KEY (id_genero)
)
CREATE TABLE tipos_documentos (
    id_tipodoc INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50),
    CONSTRAINT pk_id_tipodoc PRIMARY KEY (id_tipodoc)
)
CREATE TABLE paises (
    id_pais INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50),
    CONSTRAINT pk_id_paises PRIMARY KEY (id_pais)
)
CREATE TABLE provincias (
    id_provincia INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50),
    id_pais INT,
    CONSTRAINT pk_id_provincia PRIMARY KEY (id_provincia),
    CONSTRAINT fk_id_pais FOREIGN KEY (id_pais) REFERENCES paises(id_pais),
)
CREATE TABLE localidades (
    id_localidad INT IDENTITY (1,1) NOT NULL,
    nombre VARCHAR(50),
    id_provincia INT,
    CONSTRAINT pk_id_localidad PRIMARY KEY (id_localidad),
    CONSTRAINT fk_id_provincia FOREIGN KEY (id_provincia) REFERENCES provincias(id_provincia)
)
CREATE TABLE barrios (
    id_barrio INT IDENTITY (1,1) NOT NULL,
    nombre VARCHAR(50),
    id_localidad INT,
    CONSTRAINT pk_id_barrio PRIMARY KEY (id_barrio),
    CONSTRAINT fk_id_localidad FOREIGN KEY (id_localidad) REFERENCES localidades(id_localidad)
)
CREATE TABLE formas_pago (
    id_formapago INT IDENTITY (1,1) NOT NULL,
    nombre VARCHAR(50),
    interes INT,
    cuotas INT,
    CONSTRAINT pk_id_formapago PRIMARY KEY (id_formapago)
)
CREATE TABLE tipos_contacto (
    id_tipocont INT IDENTITY (1,1) NOT NULL,
    nombre VARCHAR(50),
    CONSTRAINT pk_id_tipocont PRIMARY KEY (id_tipocont)
)
-- Comenzamos a crear las tablas principales
CREATE TABLE personas (
    id_persona INT IDENTITY (1,1) NOT NULL,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    id_tipodoc INT,
    nro_documento INT,
    id_genero INT,
    fecha_nacimiento DATETIME,
    CONSTRAINT pk_id_persona PRIMARY KEY (id_persona),
    CONSTRAINT fk_id_tipodoc FOREIGN KEY (id_tipodoc) REFERENCES tipos_docuementos(id_tipodoc),
    CONSTRAINT fk_id_genero FOREIGN KEY (id_genero) REFERENCES generos(id_genero)
)
CREATE TABLE clientes (
    id_cliente INT IDENTITY (1,1) NOT NULL,
    id_tipocli INT,
    fecha_alta DATETIME,
    id_persona INT,
    CONSTRAINT pk_id_cliente PRIMARY KEY (id_cliente),
    CONSTRAINT fk_id_tipocli FOREIGN KEY (id_tipocli) REFERENCES tipos_clientes(id_tipocli),
    CONSTRAINT fk_id_persona FOREIGN KEY (id_persona) REFERENCES personas(id_persona)
)
CREATE TABLE empleados (
    id_empleado INT IDENTITY (1,1) NOT NULL,
    id_persona INT,
    id_cargo INT,
    CONSTRAINT pk_id_empleado PRIMARY KEY (id_empleado),
    CONSTRAINT fk_id_persona FOREIGN KEY (id_persona) REFERENCES personas(id_persona),
    CONSTRAINT fk_id_cargo FOREIGN KEY (id_cargo) REFERENCES cargos(id_cargo)
)
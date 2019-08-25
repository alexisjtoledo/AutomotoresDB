-- Creaci�n de DB
create database Automotores
go
--- Selecci�n de la DB
use Automotores

-- Comenzamos creando las Tablas Auxiliares
create table marcas_vehiculos (
	id_marca int identity (1,1) NOT NULL,
	nombre varchar(50)
	constraint pk_id_marca primary key (id_marca), 
)
create table modelos_vehiculos (
	id_modelo int identity (1,1) NOT NULL,
	nombre varchar(50),
	id_marca int,
	constraint pk_id_modelo primary key (id_modelo),
	constraint fk_id_marca foreign key (id_marca) references marcas_vehiculos(id_marca)
)
create table tipos_productos (
    id_tipoprod int identity (1,1) NOT NULL,
    nombre varchar(50),
    constraint pk_id_tipoprod primary key (id_tipoprod)
)
create table tipos_factura(
    id_tipofact int identity (1,1) not null, 
    nombre VARCHAR(50),
    CONSTRAINT pk_id_tipofact PRIMARY KEY (id_tipofact)
)
CREATE TABLE cargos(
    id_cargo INT IDENTITY (1,1) NOT NULL,
    nombre VARCHAR(50),
    CONSTRAINT pk_id_cargo PRIMARY KEY (id_cargo)
)
CREATE TABLE tipos_clientes(
    id_tipocli INT IDENTITY (1,1) NOT NULL,
    nombre VARCHAR(50)
    CONSTRAINT pk_id_tipocli PRIMARY KEY (id_tipocli)
)

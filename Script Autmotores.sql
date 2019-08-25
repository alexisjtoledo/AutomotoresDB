-- Creación de DB
create database Automotores
go
--- Selección de la DB
use Automotores

-- Comenzamos creando las Tablas Auxiliares
create table marcas_vehiculos (
	id int identity (1,1) NOT NULL,
	nombre varchar(50)
	constraint pk_id primary key (id), 
)
create table modelos_vehiculos (
	id int identity (1,1) NOT NULL,
	nombre varchar(50),
	id_marca int,
	constraint pk_id primary key (id),
	constraint fk_marcas foreign key (id) references marcas_vehiculos(id)
)

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
    CONSTRAINT fk_id_tipodoc FOREIGN KEY (id_tipodoc) REFERENCES tipos_documentos(id_tipodoc),
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
CREATE TABLE productos (
    id_producto INT IDENTITY (1,1) NOT NULL,
    nombre VARCHAR(50),
    precio INT,
    id_tipoprod INT,
    id_paisorigen INT,
    color VARCHAR(20),
    detalles VARCHAR(100),
    id_modelo INT,
    stock_minimo INT,
    stock_actual INT,
    CONSTRAINT pk_id_producto PRIMARY KEY (id_producto),
    CONSTRAINT fk_id_tipoprod FOREIGN KEY (id_tipoprod) REFERENCES tipos_productos(id_tipoprod),
    CONSTRAINT fk_id_paisorigen FOREIGN KEY (id_paisorigen) REFERENCES paises(id_pais),
    CONSTRAINT fk_id_modelo FOREIGN KEY (id_modelo) REFERENCES modelos(id_modelo)
)
CREATE TABLE ordenes_pedido (
    id_ordenpedido INT IDENTITY (1,1) NOT NULL,
    fecha_pedido DATETIME,
    fecha_entrega DATETIME,
    id_cliente INT,
    id_empleado INT,
    observaciones VARCHAR(150),
    CONSTRAINT pk_id_ordenpedido PRIMARY KEY (id_ordenpedido),
    CONSTRAINT fk_id_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT fk_id_empleado FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
)
CREATE TABLE detalle_orden_pedido (
    id_detalle_ordenpedido INT IDENTITY (1,1) NOT NULL,
    id_producto INT,
    cant_pedida INT,
    precio_unitario INT,
    id_ordenpedido INT,
    CONSTRAINT pk_id_detalle_ordenpedido PRIMARY KEY (id_detalle_ordenpedido),
    CONSTRAINT fk_id_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    CONSTRAINT fk_id_ordenpedido FOREIGN KEY (id_ordenpedido) REFERENCES ordenes_pedido(id_ordenpedido)
)
CREATE TABLE direcciones (
    id_direccion INT IDENTITY (1,1) NOT NULL,
    nro_calle INT,
    nombre_calle VARCHAR(50),
    id_barrio INT,
    id_persona INT,
    CONSTRAINT pk_id_direcciones PRIMARY KEY (id_direccion),
    CONSTRAINT fk_id_barrio FOREIGN KEY (id_barrio) REFERENCES barrios(id_barrio),
    CONSTRAINT fk_id_persona FOREIGN KEY (id_persona) REFERENCES personas(id_persona)
)
CREATE TABLE contactos (
    id_contacto INT IDENTITY (1,1) NOT NULL,
    id_persona INT,
    contacto VARCHAR(50),
    id_tipocont INT,
    CONSTRAINT pk_id_contacto PRIMARY KEY (id_contacto),
    CONSTRAINT fk_id_persona FOREIGN KEY (id_persona) REFERENCES personas(id_persona),
    CONSTRAINT fk_id_tipocont FOREIGN KEY (id_tipocont) REFERENCES tipos_contacto(id_tipocont)
)

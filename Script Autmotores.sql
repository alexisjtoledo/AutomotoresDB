-- Creacion de DB
CREATE DATABASE Automotores
GO
--- Seleccion de la DB
USE Automotores
-- Comenzamos creando las Tablas Auxiliares
CREATE TABLE marcas
(
    id_marca INT IDENTITY (1,1) NOT NULL,
    nombre VARCHAR(50),
    CONSTRAINT pk_id_marca PRIMARY KEY (id_marca),
)
CREATE TABLE modelos
(
    id_modelo INT IDENTITY (1,1) NOT NULL,
    nombre VARCHAR(50),
    id_marca int,
    CONSTRAINT pk_id_modelo PRIMARY KEY (id_modelo),
    CONSTRAINT fk_id_marca FOREIGN KEY (id_marca) REFERENCES marcas(id_marca)
)
CREATE TABLE tipos_producto
(
    id_tipo_producto INT IDENTITY (1,1) NOT NULL,
    nombre VARCHAR(50),
    CONSTRAINT pk_id_tipo_producto PRIMARY KEY (id_tipo_producto)
)
CREATE TABLE tipos_factura
(
    id_tipo_factura INT IDENTITY (1,1) NOT NULL,
    nombre VARCHAR(50),
    CONSTRAINT pk_id_tipo_factura PRIMARY KEY (id_tipo_factura)
)
CREATE TABLE cargos_empleados
(
    id_cargo_empleado INT IDENTITY (1,1) NOT NULL,
    nombre VARCHAR(50),
    CONSTRAINT pk_id_cargo_empleado PRIMARY KEY (id_cargo_empleado)
)
CREATE TABLE tipos_clientes
(
    id_tipo_cliente INT IDENTITY (1,1) NOT NULL,
    nombre VARCHAR(50)
        CONSTRAINT pk_id_tipo_cliente PRIMARY KEY (id_tipo_cliente)
)
CREATE TABLE generos
(
    id_genero INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50),
    CONSTRAINT pk_id_genero PRIMARY KEY (id_genero)
)
CREATE TABLE tipos_documentos
(
    id_tipo_doc INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50),
    CONSTRAINT pk_id_tipo_doc PRIMARY KEY (id_tipo_doc)
)
CREATE TABLE paises
(
    id_pais INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50),
    CONSTRAINT pk_id_paises PRIMARY KEY (id_pais)
)
CREATE TABLE provincias
(
    id_provincia INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50),
    id_pais INT,
    CONSTRAINT pk_id_provincia PRIMARY KEY (id_provincia),
    CONSTRAINT fk_id_pais FOREIGN KEY (id_pais) REFERENCES paises(id_pais),
)
CREATE TABLE localidades
(
    id_localidad INT IDENTITY (1,1) NOT NULL,
    nombre VARCHAR(50),
    id_provincia INT,
    CONSTRAINT pk_id_localidad PRIMARY KEY (id_localidad),
    CONSTRAINT fk_id_provincia FOREIGN KEY (id_provincia) REFERENCES provincias(id_provincia)
)
CREATE TABLE barrios
(
    id_barrio INT IDENTITY (1,1) NOT NULL,
    nombre VARCHAR(50),
    id_localidad INT,
    CONSTRAINT pk_id_barrio PRIMARY KEY (id_barrio),
    CONSTRAINT fk_id_localidad FOREIGN KEY (id_localidad) REFERENCES localidades(id_localidad)
)
CREATE TABLE formas_pago
(
    id_forma_pago INT IDENTITY (1,1) NOT NULL,
    nombre VARCHAR(50),
    interes INT,
    cuotas INT,
    CONSTRAINT pk_id_forma_pago PRIMARY KEY (id_forma_pago)
)
CREATE TABLE tipos_contacto
(
    id_tipo_contacto INT IDENTITY (1,1) NOT NULL,
    nombre VARCHAR(50),
    CONSTRAINT pk_id_tipo_contacto PRIMARY KEY (id_tipo_contacto)
)
-- Comenzamos a crear las tablas principales
CREATE TABLE personas
(
    id_persona INT IDENTITY (1,1) NOT NULL,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    id_tipo_doc INT,
    nro_documento INT,
    id_genero INT,
    fecha_nacimiento DATETIME,
    CONSTRAINT pk_id_persona PRIMARY KEY (id_persona),
    CONSTRAINT fk_id_tipo_documento FOREIGN KEY (id_tipo_doc) REFERENCES tipos_documentos(id_tipo_doc),
    CONSTRAINT fk_id_genero FOREIGN KEY (id_genero) REFERENCES generos(id_genero)
)
CREATE TABLE clientes
(
    id_cliente INT IDENTITY (1,1) NOT NULL,
    id_tipo_cliente INT,
    fecha_alta DATETIME,
    id_persona INT,
    CONSTRAINT pk_id_cliente PRIMARY KEY (id_cliente),
    CONSTRAINT fk_id_tipo_cliente FOREIGN KEY (id_tipo_cliente) REFERENCES tipos_clientes(id_tipo_cliente),
    CONSTRAINT fk_id_persona FOREIGN KEY (id_persona) REFERENCES personas(id_persona)
)
CREATE TABLE empleados
(
    id_empleado INT IDENTITY (1,1) NOT NULL,
    id_persona INT,
    id_cargo_empleado INT,
    CONSTRAINT pk_id_empleado PRIMARY KEY (id_empleado),
    CONSTRAINT fk_id_persona2 FOREIGN KEY (id_persona) REFERENCES personas(id_persona),
    CONSTRAINT fk_id_cargo_empleado FOREIGN KEY (id_cargo_empleado) REFERENCES cargos_empleados(id_cargo_empleado)
)
CREATE TABLE productos
(
    id_producto INT IDENTITY (1,1) NOT NULL,
    nombre VARCHAR(50),
    precio INT,
    id_tipo_producto INT,
    color VARCHAR(20),
    detalles VARCHAR(100),
    id_modelo INT,
    stock_minimo INT,
    stock_actual INT,
    CONSTRAINT pk_id_producto PRIMARY KEY (id_producto),
    CONSTRAINT fk_id_tipo_producto FOREIGN KEY (id_tipo_producto) REFERENCES tipos_producto(id_tipo_producto),
    CONSTRAINT fk_id_modelo FOREIGN KEY (id_modelo) REFERENCES modelos_vehiculos(id_modelo)
)
CREATE TABLE ordenes_pedido
(
    num_orden INT IDENTITY (1,1) NOT NULL,
    fecha_pedido DATETIME,
    fecha_entrega DATETIME,
    id_cliente INT,
    id_empleado INT,
    observaciones VARCHAR(150),
    CONSTRAINT pk_id_num_orden PRIMARY KEY (num_orden),
    CONSTRAINT fk_id_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT fk_id_empleado FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
)
CREATE TABLE detalle_orden_pedido
(
    id_detalle_pedido INT IDENTITY (1,1) NOT NULL,
    id_producto INT,
    cant_pedida INT,
    precio_unitario INT,
    num_orden INT,
    CONSTRAINT pk_id_detalle_pedido PRIMARY KEY (id_detalle_pedido),
    CONSTRAINT fk_id_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    CONSTRAINT fk_num_orden FOREIGN KEY (num_orden) REFERENCES ordenes_pedido(num_orden)
)
CREATE TABLE direcciones
(
    id_direccion INT IDENTITY (1,1) NOT NULL,
    num_calle INT,
    nombre_calle VARCHAR(50),
    id_barrio INT,
    id_persona INT,
    CONSTRAINT pk_id_direcciones PRIMARY KEY (id_direccion),
    CONSTRAINT fk_id_barrio FOREIGN KEY (id_barrio) REFERENCES barrios(id_barrio),
    CONSTRAINT fk_id_persona3 FOREIGN KEY (id_persona) REFERENCES personas(id_persona)
)
CREATE TABLE contactos
(
    id_contacto INT IDENTITY (1,1) NOT NULL,
    id_persona INT,
    contacto VARCHAR(50),
    id_tipo_contacto INT,
    CONSTRAINT pk_id_contacto PRIMARY KEY (id_contacto),
    CONSTRAINT fk_id_persona4 FOREIGN KEY (id_persona) REFERENCES personas(id_persona),
    CONSTRAINT fk_id_tipo_contacto FOREIGN KEY (id_tipo_contacto) REFERENCES tipos_contacto(id_tipo_contacto)
)
CREATE TABLE facturas
(
    num_factura INT IDENTITY (1,1) NOT NULL,
    id_cliente INT,
    id_empleado INT,
    fecha_factura DATETIME,
    observaciones VARCHAR(150),
    id_tipo_factura INT,
    num_orden INT,
    descuento INT,
    CONSTRAINT pk_num_factura PRIMARY KEY (num_factura),
    CONSTRAINT fk_id_cliente2 FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT fk_id_empleado2 FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    CONSTRAINT fk_id_tipofact FOREIGN KEY (id_tipo_factura) REFERENCES tipos_factura(id_tipo_factura),
    CONSTRAINT fk_num_orden2 FOREIGN KEY (num_orden) REFERENCES ordenes_pedido(num_orden)
)
CREATE TABLE detalles_facturas
(
    id_detalle_factura INT IDENTITY (1,1) NOT NULL,
    num_factura INT,
    id_producto INT,
    cantidad INT,
    precio_unitario INT,
    CONSTRAINT pk_id_detalle_factura PRIMARY KEY (id_detalle_factura),
    CONSTRAINT fk_num_factura FOREIGN KEY (num_factura) REFERENCES facturas(num_factura),
    CONSTRAINT fk_id_producto2 FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
)
CREATE TABLE formaspago_x_factura
(
    id_formxfact INT IDENTITY (1,1) NOT NULL,
    num_factura INT,
    id_forma_pago INT,
    monto INT,
    nro_cuota INT,
    CONSTRAINT pk_id_formxfact PRIMARY KEY (id_formxfact),
    CONSTRAINT fk_num_factura2 FOREIGN KEY (num_factura) REFERENCES facturas(num_factura),
    CONSTRAINT fk_id_formapago FOREIGN KEY (id_forma_pago) REFERENCES formas_pago(id_forma_pago)
)
CREATE TABLE historial_precios
(
    id_historial INT IDENTITY (1,1) NOT NULL,
    id_producto INT,
    fecha_ingreso DATETIME,
    precio INT,
    CONSTRAINT pk_id_historial PRIMARY KEY (id_historial),
    CONSTRAINT fk_id_producto3 FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
)

CREATE DATABASE mercadolibre
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;
USE mercadolibre;

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50),
    correo VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(20),
    contrasena VARCHAR(255) NOT NULL,
    tipo_usuario ENUM('comprador','vendedor','ambos','admin') NOT NULL DEFAULT 'comprador',
    fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado_cuenta ENUM('activa','suspendida','eliminada') NOT NULL DEFAULT 'activa'
) ENGINE=InnoDB;

CREATE TABLE direcciones (
    id_direccion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    calle VARCHAR(100) NOT NULL,
    numero_exterior VARCHAR(10) NOT NULL,
    numero_interior VARCHAR(10),
    colonia VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    estado VARCHAR(100) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    codigo_postal VARCHAR(10) NOT NULL,
    referencia VARCHAR(255),
    tipo_direccion ENUM('casa','trabajo','otro') NOT NULL DEFAULT 'casa',
    CONSTRAINT fk_direcciones_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE tiendas (
    id_tienda INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    nombre_tienda VARCHAR(100) NOT NULL,
    descripcion TEXT,
    logo_url VARCHAR(255),
    reputacion DECIMAL(3,2) DEFAULT 0.00,
    fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado_tienda ENUM('activa','inactiva','suspendida') NOT NULL DEFAULT 'activa',
    CONSTRAINT uq_tiendas_usuario UNIQUE (id_usuario),
    CONSTRAINT fk_tiendas_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
    id_categoria_padre INT NULL,
    CONSTRAINT fk_categorias_padre
        FOREIGN KEY (id_categoria_padre)
        REFERENCES categorias(id_categoria)
        ON UPDATE CASCADE
        ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE marcas (
    id_marca INT AUTO_INCREMENT PRIMARY KEY,
    nombre_marca VARCHAR(100) NOT NULL UNIQUE,
    pais_origen VARCHAR(100),
    estado_marca ENUM('activa','inactiva') NOT NULL DEFAULT 'activa'
) ENGINE=InnoDB;

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    id_tienda INT NOT NULL,
    id_categoria INT NOT NULL,
    id_marca INT NOT NULL,
    nombre_producto VARCHAR(150) NOT NULL,
    descripcion TEXT,
    modelo VARCHAR(100),
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    condicion_producto ENUM('nuevo','usado','reacondicionado') NOT NULL DEFAULT 'nuevo',
    estado_producto ENUM('activo','pausado','agotado','eliminado') NOT NULL DEFAULT 'activo',
    fecha_publicacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_productos_tienda
        FOREIGN KEY (id_tienda)
        REFERENCES tiendas(id_tienda)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_productos_categoria
        FOREIGN KEY (id_categoria)
        REFERENCES categorias(id_categoria)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_productos_marca
        FOREIGN KEY (id_marca)
        REFERENCES marcas(id_marca)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE producto_imagenes (
    id_imagen INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    url_imagen VARCHAR(255) NOT NULL,
    texto_alternativo VARCHAR(150),
    orden_imagen INT NOT NULL DEFAULT 1,
    CONSTRAINT fk_producto_imagenes_producto
        FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_comprador INT NOT NULL,
    id_tienda INT NOT NULL,
    id_direccion_envio INT NOT NULL,
    fecha_pedido DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    subtotal DECIMAL(10,2) NOT NULL,
    costo_envio DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    total_pagar DECIMAL(10,2) NOT NULL,
    estado_pedido ENUM('pendiente','pagado','enviado','entregado','cancelado') NOT NULL DEFAULT 'pendiente',
    CONSTRAINT fk_pedidos_comprador
        FOREIGN KEY (id_comprador)
        REFERENCES usuarios(id_usuario)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_pedidos_tienda
        FOREIGN KEY (id_tienda)
        REFERENCES tiendas(id_tienda)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_pedidos_direccion
        FOREIGN KEY (id_direccion_envio)
        REFERENCES direcciones(id_direccion)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE pedido_detalle (
    id_pedido_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal_linea DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_pedido_detalle_pedido
        FOREIGN KEY (id_pedido)
        REFERENCES pedidos(id_pedido)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_pedido_detalle_producto
        FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE pagos (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    metodo_pago ENUM('tarjeta','debito','credito','transferencia','mercado_pago','efectivo') NOT NULL,
    monto_pagado DECIMAL(10,2) NOT NULL,
    fecha_pago DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado_pago ENUM('pendiente','aprobado','rechazado','reembolsado') NOT NULL DEFAULT 'pendiente',
    referencia_pago VARCHAR(100),
    CONSTRAINT uq_pagos_pedido UNIQUE (id_pedido),
    CONSTRAINT fk_pagos_pedido
        FOREIGN KEY (id_pedido)
        REFERENCES pedidos(id_pedido)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE envios (
    id_envio INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    empresa_envio VARCHAR(100) NOT NULL,
    numero_guia VARCHAR(100) NOT NULL UNIQUE,
    fecha_envio DATETIME,
    fecha_entrega_estimada DATETIME,
    fecha_entrega_real DATETIME,
    estado_envio ENUM('preparando','en_transito','entregado','devuelto','cancelado') NOT NULL DEFAULT 'preparando',
    CONSTRAINT uq_envios_pedido UNIQUE (id_pedido),
    CONSTRAINT fk_envios_pedido
        FOREIGN KEY (id_pedido)
        REFERENCES pedidos(id_pedido)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE resenas (
    id_resena INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    id_comprador INT NOT NULL,
    calificacion INT NOT NULL,
    comentario TEXT,
    fecha_resena DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_resenas_pedido
        FOREIGN KEY (id_pedido)
        REFERENCES pedidos(id_pedido)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_resenas_producto
        FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_resenas_comprador
        FOREIGN KEY (id_comprador)
        REFERENCES usuarios(id_usuario)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE INDEX idx_direcciones_usuario ON direcciones(id_usuario);
CREATE INDEX idx_productos_tienda ON productos(id_tienda);
CREATE INDEX idx_productos_categoria ON productos(id_categoria);
CREATE INDEX idx_productos_marca ON productos(id_marca);
CREATE INDEX idx_producto_imagenes_producto ON producto_imagenes(id_producto);
CREATE INDEX idx_pedidos_comprador ON pedidos(id_comprador);
CREATE INDEX idx_pedidos_tienda ON pedidos(id_tienda);
CREATE INDEX idx_pedidos_direccion ON pedidos(id_direccion_envio);
CREATE INDEX idx_pedido_detalle_pedido ON pedido_detalle(id_pedido);
CREATE INDEX idx_pedido_detalle_producto ON pedido_detalle(id_producto);
CREATE INDEX idx_resenas_producto ON resenas(id_producto);
CREATE INDEX idx_resenas_comprador ON resenas(id_comprador);
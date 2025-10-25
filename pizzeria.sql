CREATE DATABASE IF NOT EXISTS pizzeria_sql;
USE pizzeria_sql;

SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    apellido VARCHAR(120),
    correo VARCHAR(150),
    telefono VARCHAR(30),
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE direccion (
    id_direccion INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    tipo ENUM('Casa','Trabajo','Otro') DEFAULT 'Casa',
    calle VARCHAR(200),
    ciudad VARCHAR(100),
    departamento VARCHAR(100),
    codigo_postal VARCHAR(20),
    referencia TEXT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    tipo ENUM('Pizza','Panzarotti','Bebida','Postre','Otro') NOT NULL,
    descripcion TEXT,
    activo BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE producto_variant (
    id_variant INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    nombre_variant VARCHAR(80),
    precio DECIMAL(10,2) NOT NULL,
    costo DECIMAL(10,2),
    sku VARCHAR(80),
    stock INT DEFAULT NULL,
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE ingrediente (
    id_ingrediente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    descripcion VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE producto_ingrediente (
    id_producto INT NOT NULL,
    id_ingrediente INT NOT NULL,
    cantidad_estimada VARCHAR(50), 
    PRIMARY KEY (id_producto, id_ingrediente),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE,
    FOREIGN KEY (id_ingrediente) REFERENCES ingrediente(id_ingrediente) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE adicion (
    id_adicion INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    descripcion VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE producto_adicion (
    id_producto INT NOT NULL,
    id_adicion INT NOT NULL,
    disponible BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id_producto, id_adicion),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE,
    FOREIGN KEY (id_adicion) REFERENCES adicion(id_adicion) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE combo (
    id_combo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE combo_item (
    id_combo_item INT AUTO_INCREMENT PRIMARY KEY,
    id_combo INT NOT NULL,
    id_variant INT NOT NULL,
    cantidad INT DEFAULT 1,
    FOREIGN KEY (id_combo) REFERENCES combo(id_combo) ON DELETE CASCADE,
    FOREIGN KEY (id_variant) REFERENCES producto_variant(id_variant) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE menu_item (
    id_menu_item INT AUTO_INCREMENT PRIMARY KEY,
    id_variant INT NOT NULL,
    disponible BOOLEAN DEFAULT TRUE,
    orden INT DEFAULT 0,
    FOREIGN KEY (id_variant) REFERENCES producto_variant(id_variant) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NULL,
    fecha_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    tipo_entrega ENUM('Local','Recoger','Domicilio') DEFAULT 'Local',
    id_direccion INT NULL, 
    estado ENUM('Pendiente','En preparación','En entrega','Finalizado','Cancelado') DEFAULT 'Pendiente',
    subtotal DECIMAL(12,2) DEFAULT 0,
    total_adiciones DECIMAL(12,2) DEFAULT 0,
    total DECIMAL(12,2) DEFAULT 0,
    observaciones TEXT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE SET NULL,
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE pedido_item (
    id_pedido_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_variant INT NULL,
    id_combo INT NULL,
    cantidad INT DEFAULT 1,
    precio_unit DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(12,2) GENERATED ALWAYS AS (precio_unit * cantidad) STORED,
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_variant) REFERENCES producto_variant(id_variant) ON DELETE SET NULL,
    FOREIGN KEY (id_combo) REFERENCES combo(id_combo) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



CREATE TABLE pedido_item_adicion (
    id_pedido_item_adicion INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido_item INT NOT NULL,
    id_adicion INT NOT NULL,
    cantidad INT DEFAULT 1,
    precio_unit DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(12,2) GENERATED ALWAYS AS (precio_unit * cantidad) STORED,
    FOREIGN KEY (id_pedido_item) REFERENCES pedido_item(id_pedido_item) ON DELETE CASCADE,
    FOREIGN KEY (id_adicion) REFERENCES adicion(id_adicion) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE pago (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    fecha_pago DATETIME DEFAULT CURRENT_TIMESTAMP,
    metodo ENUM('Efectivo','Tarjeta','Transferencia') DEFAULT 'Efectivo',
    monto DECIMAL(12,2) NOT NULL,
    referencia VARCHAR(200),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX idx_producto_tipo ON producto(tipo);
CREATE INDEX idx_pedido_fecha ON pedido(fecha_pedido);
CREATE INDEX idx_pedido_tipo ON pedido(tipo_entrega);

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `productos`(
    `id_producto` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `precio` INT NOT NULL,
    `nombre_producto` VARCHAR(100) NOT NULL
);

CREATE TABLE `pedidos`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` BIGINT NOT NULL,
    `precio` INT NOT NULL,
    `estado` ENUM(
        'en_camino',
        'despachado',
        'entregado',
        'preparacion',
        'devolucion...'
    ) NOT NULL DEFAULT 'entregado'
);

ALTER TABLE
    `pedidos` ADD CONSTRAINT `pedidos_nombre_foreign` FOREIGN KEY(`nombre`) REFERENCES `ordenes`(`id`);

CREATE TABLE `usuarios`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(100) NOT NULL,
    `telefono` VARCHAR(100) NOT NULL,
    `correo` BIGINT NOT NULL
);

ALTER TABLE `usuarios` ADD UNIQUE `usuarios_telefono_unique`(`telefono`);

ALTER TABLE `usuarios` ADD CONSTRAINT `usuarios_nombre_foreign` FOREIGN KEY(`nombre`) REFERENCES `ordenes`(`cliente_fk`);


CREATE TABLE `menu`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `producto_fk` BIGINT NOT NULL,
    `Precio` INT NOT NULL,
    `combo_adicional` BIGINT NOT NULL,
    `categoria` ENUM('bebidas', 'pizza', 'adicionales') NOT NULL
);

ALTER TABLE `menu` ADD CONSTRAINT `menu_producto_fk_foreign` FOREIGN KEY(`producto_fk`) REFERENCES `productos`(`id_producto`);

ALTER TABLE
    `menu` ADD CONSTRAINT `menu_precio_foreign` FOREIGN KEY(`Precio`) REFERENCES `combos`(`id`);

CREATE TABLE `combos`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `precio` INT NOT NULL,
    `nombre` ENUM(
        'familiar',
        'personal',
        'extra',
        'mini'
    ) NOT NULL DEFAULT 'familiar'
);

CREATE TABLE `ordenes`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `cliente_fk` BIGINT NOT NULL,
    `precio` BIGINT NOT NULL,
    `fecha_orden` BIGINT NOT NULL
);

CREATE TABLE `ingredientes`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `ingredintesvarchar(100)` ENUM('queso', 'piña', 'pepperoni', 'tomate') NOT NULL DEFAULT 'queso'
);

CREATE TABLE `preparacion`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `ingredientes_fk` BIGINT NOT NULL,
    `producto_fk` BIGINT NOT NULL
);

ALTER TABLE
    `preparacion` ADD CONSTRAINT `preparacion_producto_fk_foreign` FOREIGN KEY(`producto_fk`) REFERENCES `productos`(`id_producto`);

CREATE TABLE `adicional`(
    `id_extra` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `adicional` VARCHAR(100) NOT NULL,
    `valor` INT NOT NULL
);

ALTER TABLE `adicional` ADD CONSTRAINT `adicional_valor_foreign` FOREIGN KEY(`valor`) REFERENCES `ordenes`(`precio`);

CREATE TABLE `transacciones`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `pago` ENUM(
        'targeta_credito',
        'targeta_debito',
        'nequi',
        'bancolombia....'
    ) NOT NULL DEFAULT 'nequi',
    `cliente` BIGINT NOT NULL,
    `fecha_pago` BIGINT NOT NULL
);

ALTER TABLE `ingredientes` ADD CONSTRAINT `ingredientes_ingredintesvarchar(100)_foreign` FOREIGN KEY(`ingredintesvarchar(100)`) REFERENCES `preparacion`(`ingredientes_fk`);


CREATE TABLE `pago_ordenes`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `orden` BIGINT NOT NULL,
    `transaccion` BIGINT NOT NULL
);

ALTER TABLE `pago_ordenes` ADD CONSTRAINT `pago_ordenes_transaccion_foreign` FOREIGN KEY(`transaccion`) REFERENCES `transacciones`(`id`);


ALTER TABLE `pago_ordenes` ADD CONSTRAINT `pago_ordenes_orden_foreign` FOREIGN KEY(`orden`) REFERENCES `ordenes`(`id`);







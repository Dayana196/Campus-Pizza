CREATE DATABASE IF NOT EXISTS `pizzeria_campus`

USE `pizzeria_campus`;

CREATE TABLE `Productos` (
    `producto_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(50) NOT NULL,
    `precio` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
);
CREATE TABLE `pedidos`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `nombre_pedido_fk` BIGINT NOT NULL,
    `usuarios_id` int DEFAULT NULL,
    `precio` decimal(10,2) DEFAULT NULL,
    `fecha_pedido_fk` DATE NOT NULL,
    `especificaciones` ENUM ('domicilio para llevar', 'Pedido para aca') DEFAULT 'pedido para aca' NOT NULL,
    PRIMARY KEY ('nombre_pedido_fk'), REFERENCES `productos` ('usuarios_id') 
);

CREATE TABLE `usuarios`(
    `usuario_id` int NOT NULL AUTO_INCREMENT;
    `nombre` VARCHAR(50) DEFAULT NULL,
    `apellido` VARCHAR(50) DEFAULT NULL,
    `telefono` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`usuario_id`)
);
ALTER TABLE
    `usuarios` ADD UNIQUE `usuarios_telefono_unique`(`telefono`);

CREATE TABLE `menu`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre_producto_fk` BIGINT NOT NULL,
    `nombre_combo_fk` BIGINT NOT NULL
);
CREATE TABLE `combos`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `precio` INT NOT NULL,
    `nombre` BIGINT NOT NULL
);
CREATE TABLE `ordenes`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre_menu_fk` BIGINT NOT NULL,
    `nombre_cliente_fk` BIGINT NOT NULL,
    `nombre_adicional_fk` BIGINT NOT NULL
);
CREATE TABLE `ingredientes`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre_ingredintes` VARCHAR(100) NOT NULL
);
CREATE TABLE `prepearacion`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre_ingredientes_fk` BIGINT NOT NULL,
    `nombre_producto_fk` BIGINT NOT NULL
);
CREATE TABLE `adicional`(
    `id_extra` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre_adicional` VARCHAR(100) NOT NULL,
    `valor` INT NOT NULL
);
ALTER TABLE
    `ordenes` ADD CONSTRAINT `ordenes_nombre_menu_fk_foreign` FOREIGN KEY(`nombre_menu_fk`) REFERENCES `menu`(`id`);
ALTER TABLE
    `usuarios` ADD CONSTRAINT `usuarios_nombre_foreign` FOREIGN KEY(`nombre`) REFERENCES `ordenes`(`nombre_cliente_fk`);
ALTER TABLE
    `adicional` ADD CONSTRAINT `adicional_valor_foreign` FOREIGN KEY(`valor`) REFERENCES `ordenes`(`nombre_adicional_fk`);
ALTER TABLE
    `menu` ADD CONSTRAINT `menu_nombre_combo_fk_foreign` FOREIGN KEY(`nombre_combo_fk`) REFERENCES `combos`(`id`);
ALTER TABLE
    `prepearacion` ADD CONSTRAINT `prepearacion_nombre_producto_fk_foreign` FOREIGN KEY(`nombre_producto_fk`) REFERENCES `productos`(`id_producto`);
ALTER TABLE
    `pedidos` ADD CONSTRAINT `pedidos_nombre_pedido_fk_foreign` FOREIGN KEY(`nombre_pedido_fk`) REFERENCES `ordenes`(`id`);
ALTER TABLE
    `menu` ADD CONSTRAINT `menu_nombre_producto_fk_foreign` FOREIGN KEY(`nombre_producto_fk`) REFERENCES `productos`(`id_producto`);
ALTER TABLE
    `ingredientes` ADD CONSTRAINT `ingredientes_nombre_ingredintes_foreign` FOREIGN KEY(`nombre_ingredintes`) REFERENCES `prepearacion`(`nombre_ingredientes_fk`);
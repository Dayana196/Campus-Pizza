USE pizzeria_sql;

-- Clientes
INSERT INTO cliente (nombre, apellido, correo, telefono) VALUES
('Carlos', 'gomez', 'carlosgomez25@gmail.com', '3101234567'),
('Laura', 'pereira', 'laupereira00@gmail.com', '3204567890'),
('Diego', 'Martínez', 'diegoruiz@gmail.com', '3135678901'),
('Sofía', 'Rodríguez', 'sofirodriguez@gmail.com', '3017892345'),
('Adrian', 'Villamil', 'adrian67h@gmail.com', '3125689300');

-- Direcciones
INSERT INTO direccion (id_cliente, tipo, calle, ciudad, departamento, codigo_postal)
VALUES
(1, 'Casa', 'Calle 10 #25-30', 'Bogotá', 'Cundinamarca', '110111'),
(2, 'Trabajo', 'Av 80 #45-90', 'Medellín', 'Antioquia', '050021'),
(3, 'Casa', 'Carrera 50 #15-20', 'Cali', 'Valle del Cauca', '760001'),
(4, 'Casa', 'Cl 22 #33-45', 'Barranquilla', 'Centro', '080001'),
(5, 'Otro', 'Mz C Casa 12', 'Bucaramanga', 'giron', '130001');

-- Productos
INSERT INTO producto (nombre, tipo, descripcion) VALUES
('Pizza Hawaiana', 'Pizza', 'Pizza con piña, jamon y queso mozzarella'),
('Pizza Carnes', 'Pizza', 'Pizza con pepperoni, jamon, tocineta y salchicha italiana'),
('Panzarotti de Pollo', 'Panzarotti', 'Panzarotti relleno de pollo y queso'),
('Gaseosa Colombiana 1.5L', 'Bebida', 'Bebida gaseosa sabor original'),
('Postre de Tres Leches', 'Postre', 'Delicioso postre de tres leches casero');

-- Variantes de productos
INSERT INTO producto_variant (id_producto, nombre_variant, precio, costo, sku, stock)
VALUES
(1, 'Mediana', 28000, 15000, 'PIZHAW-MED', 25),
(1, 'Grande', 35000, 19000, 'PIZHAW-GRA', 20),
(2, 'Mediana', 29000, 16000, 'PIZCAR-MED', 25),
(2, 'Grande', 37000, 20000, 'PIZCAR-GRA', 15),
(3, 'Individual', 16000, 9000, 'PANPOL-IND', 30),
(4, '1.5L', 8000, 4000, 'GASCOL-15', 40),
(5, 'Porción', 12000, 6000, 'POSTRE-TL', 15);

-- Ingredientes
INSERT INTO ingrediente (nombre, descripcion) VALUES
('Queso Mozzarella', 'Base de las pizzas'),
('Piña', 'Trozos dulces para pizza hawaiana'),
('Jamon', 'Carne de cerdo cocida'),
('Pepperoni', 'Embutido italiano picante'),
('Tocineta', 'Corte de cerdo ahumado'),
('Salsa de Tomate', 'Salsa artesanal italiana'),
('Pollo', 'Pollo desmenuzado');

-- Relación producto-ingrediente
INSERT INTO producto_ingrediente (id_producto, id_ingrediente, cantidad_estimada)
VALUES
(1,1,'100g'),(1,2,'50g'),(1,3,'50g'),(1,6,'50ml'),
(2,1,'100g'),(2,3,'30g'),(2,4,'30g'),(2,5,'30g'),(2,6,'50ml'),
(3,1,'50g'),(3,7,'80g');

-- Adiciones
INSERT INTO adicion (nombre, precio, descripcion) VALUES
('Extra Queso', 4000, 'Queso adicional para cualquier pizza'),
('Borde de Queso', 5000, 'Orilla rellena de queso mozzarella'),
('Salsa BBQ', 2000, 'Salsa barbacoa extra'),
('Salsa de Ajo', 1000, 'Salsa de ajo artesanal');

-- Relación producto-adición
INSERT INTO producto_adicion (id_producto, id_adicion) VALUES
(1,1),(1,2),(2,1),(2,2),(3,3);

-- Combos
INSERT INTO combo (nombre, descripcion, precio)
VALUES
('Combo Familiar', 'Pizza Grande + 2 Gaseosas 1.5L + Postre', 65000),
('Combo Pareja', '2 Panzarottis + 1 Gaseosa 1.5L', 42000);

-- Combos items
INSERT INTO combo_item (id_combo, id_variant, cantidad)
VALUES
(1, 2, 1),  
(1, 6, 2),  
(1, 7, 1),  
(2, 5, 2),  
(2, 6, 1);  

-- Menú
INSERT INTO menu_item (id_variant, disponible, orden)
VALUES
(1, TRUE, 1),(2, TRUE, 2),(3, TRUE, 3),(4, TRUE, 4),(5, TRUE, 5),(6, TRUE, 6),(7, TRUE, 7);

-- Pedidos
INSERT INTO pedido (id_cliente, tipo_entrega, id_direccion, estado, subtotal, total_adiciones, total, observaciones)
VALUES
(1, 'Domicilio', 1, 'Finalizado', 65000, 4000, 69000, 'Con borde de queso'),
(2, 'Local', NULL, 'Finalizado', 42000, 0, 42000, 'Sin adiciones'),
(3, 'Recoger', 3, 'Finalizado', 37000, 0, 37000, 'Pizza carnes grande'),
(4, 'Local', NULL, 'En preparación', 16000, 2000, 18000, 'Con salsa BBQ');

-- Detalle pedido
INSERT INTO pedido_item (id_pedido, id_variant, cantidad, precio_unit)
VALUES
(6, 2, 1, 35000),
(6, 6, 1, 8000),
(6, 7, 1, 12000),
(7, 5, 2, 16000),
(7, 6, 1, 8000),
(8, 4, 1, 37000),
(5, 5, 1, 16000);


-- Pedido-item adiciones
INSERT INTO pedido_item_adicion (id_pedido_item, id_adicion, cantidad, precio_unit)
VALUES
(14, 2, 1, 5000), 
(8, 3, 1, 2000);   


-- Pagos
INSERT INTO pago (id_pedido, metodo, monto)
VALUES
(5, 'Tarjeta', 69000),
(6, 'Efectivo', 42000),
(7, 'Transferencia', 37000),
(8, 'Efectivo', 18000);


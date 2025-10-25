-- productos mas vendidos

SELECT p.nombre, SUM(pi.cantidad) AS cantidad_vendida
FROM pedido_item pi
JOIN producto_variant pv ON pi.id_variant = pv.id_variant
JOIN producto p ON pv.id_producto = p.id_producto
GROUP BY p.nombre
ORDER BY cantidad_vendida DESC;

-- ingresos generados por cada combo

SELECT c.nombre AS combo_nombre, SUM(pi.subtotal) AS total_ingresos
FROM combo_item ci
JOIN combo c ON ci.id_combo = c.id_combo
JOIN pedido_item pi ON ci.id_variant = pi.id_variant
GROUP BY c.nombre;

-- recoger vs. comer en la pizzería

SELECT tipo_entrega, COUNT(*) AS cantidad_pedidos
FROM pedido
GROUP BY tipo_entrega;

-- Adiciones más solicitadas en pedidos personalizados

SELECT a.nombre AS adicion_nombre, SUM(pia.cantidad) AS cantidad_solicitada
FROM pedido_item_adicion pia
JOIN adicion a ON pia.id_adicion = a.id_adicion
GROUP BY a.nombre
ORDER BY cantidad_solicitada DESC;

-- Cantidad total de productos vendidos por categoría

SELECT p.tipo, SUM(pi.cantidad) AS cantidad_vendida
FROM pedido_item pi
JOIN producto_variant pv ON pi.id_variant = pv.id_variant
JOIN producto p ON pv.id_producto = p.id_producto
GROUP BY p.tipo;

-- Promedio de pizzas pedidas por cliente

SELECT p.id_cliente, AVG(pi.cantidad) AS promedio_pizzas
FROM pedido_item pi
JOIN producto_variant pv ON pi.id_variant = pv.id_variant
JOIN producto prod ON pv.id_producto = prod.id_producto
JOIN pedido p ON pi.id_pedido = p.id_pedido
WHERE prod.tipo = 'Pizza'
GROUP BY p.id_cliente;

-- Total de ventas por día de la semana

SELECT DAYOFWEEK(fecha_pedido) AS dia_semana, SUM(total) AS total_ventas
FROM pedido
GROUP BY dia_semana
ORDER BY dia_semana;

-- Cantidad de panzarottis vendidos con extra queso

SELECT SUM(pi.cantidad) AS cantidad_vendida
FROM pedido_item pi
JOIN producto_variant pv ON pi.id_variant = pv.id_variant
JOIN producto p ON pv.id_producto = p.id_producto
JOIN pedido_item_adicion pia ON pi.id_pedido_item = pia.id_pedido_item
JOIN adicion a ON pia.id_adicion = a.id_adicion
WHERE p.nombre = 'Panzarotti de Pollo' AND a.nombre = 'Extra Queso';

-- Pedidos que incluyen bebidas como parte de un combo

SELECT DISTINCT pi.id_pedido
FROM pedido_item pi
JOIN producto_variant pv ON pi.id_variant = pv.id_variant
JOIN producto p ON pv.id_producto = p.id_producto
WHERE p.tipo = 'Bebida';

-- Clientes que han realizado más de 5 pedidos en el último mes

SELECT id_cliente, COUNT(*) AS cantidad_pedidos
FROM pedido
WHERE fecha_pedido > NOW() - INTERVAL 1 MONTH
GROUP BY id_cliente
ORDER BY cantidad_pedidos DESC;

-- Ingresos totales

SELECT SUM(p.total) AS total_ingresos
FROM pedido p
JOIN pedido_item pi ON p.id_pedido = pi.id_pedido
JOIN producto_variant pv ON pi.id_variant = pv.id_variant
JOIN producto prod ON pv.id_producto = prod.id_producto
WHERE prod.tipo IN ('Bebida', 'Postre', 'Otro');

-- Promedio de adiciones por pedido

SELECT AVG(adiciones_por_pedido) AS promedio_adiciones
FROM (
    SELECT COUNT(*) AS adiciones_por_pedido
    FROM pedido_item pi
    JOIN pedido_item_adicion pia ON pi.id_pedido_item = pia.id_pedido_item
    GROUP BY pi.id_pedido
) AS subquery;

-- Total de combos vendidos en el último mes

SELECT SUM(pi.cantidad) AS total_combos_vendidos
FROM pedido_item pi
JOIN combo_item ci ON pi.id_combo = ci.id_combo
JOIN pedido p ON pi.id_pedido = p.id_pedido
WHERE p.fecha_pedido > NOW() - INTERVAL 1 MONTH;

-- Clientes con pedidos tanto para recoger como para consumir en el lugar

SELECT id_cliente, tipo_entrega, COUNT(*) AS cantidad_pedidos
FROM pedido
WHERE tipo_entrega IN ('Recoger', 'Local')
GROUP BY id_cliente, tipo_entrega;

-- Total de productos personalizados con adiciones

SELECT COUNT(DISTINCT pi.id_pedido_item) AS total_personalizados
FROM pedido_item pi
JOIN pedido_item_adicion pia ON pi.id_pedido_item = pia.id_pedido_item;

-- Pedidos con más de 3 productos diferentes

SELECT id_pedido, COUNT(DISTINCT id_variant) AS cantidad_productos_diferentes
FROM pedido_item
GROUP BY id_pedido
HAVING cantidad_productos_diferentes > 2;

-- Promedio de ingresos generados por día

SELECT AVG(dia_ingresos) AS promedio_ingresos_diarios
FROM (
    SELECT SUM(total) AS dia_ingresos
    FROM pedido
    GROUP BY DATE(fecha_pedido)
) AS subquery;

-- Clientes que han pedido pizzas con adiciones en más del 50% de sus pedidos

SELECT p2.id_cliente
FROM pedido_item pi
JOIN pedido_item_adicion pia ON pi.id_pedido_item = pia.id_pedido_item
JOIN producto_variant pv ON pi.id_variant = pv.id_variant
JOIN producto prd ON pv.id_producto = prd.id_producto
JOIN pedido p2 ON pi.id_pedido = p2.id_pedido
WHERE prd.tipo = 'Pizza'
GROUP BY p2.id_cliente
HAVING COUNT(DISTINCT pia.id_pedido_item) / COUNT(DISTINCT pi.id_pedido_item) > 0.5;

-- Porcentaje de ventas provenientes de productos no elaborados

SELECT (SUM(CASE WHEN p.tipo IN ('Bebida', 'Postre', 'Otro') THEN pi.subtotal ELSE 0 END) / SUM(pi.subtotal)) * 100 AS porcentaje_ventas_no_elaborados
FROM pedido_item pi
JOIN producto_variant pv ON pi.id_variant = pv.id_variant
JOIN producto p ON pv.id_producto = p.id_producto;

-- Día de la semana con mayor número de pedidos para recoger

SELECT DAYOFWEEK(fecha_pedido) AS dia_semana, COUNT(*) AS cantidad_pedidos
FROM pedido
WHERE tipo_entrega = 'Recoger'
GROUP BY dia_semana
ORDER BY cantidad_pedidos DESC
LIMIT 1;

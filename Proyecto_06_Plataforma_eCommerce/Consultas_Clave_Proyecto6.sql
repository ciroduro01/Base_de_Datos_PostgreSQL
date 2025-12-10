-- CONSULTAS ANALÍTICAS CLAVE del Proyecto N°6: Plataforma de E-commerce

-- CONSULTA N°1: FACTURACIÓN DETALLADA POR PEDIDO (Usando la Vista)
-- Objetivo: Obtener la factura completa del Pedido N° 1.
SELECT
    Nombre_Cliente,
    fecha_pedido,
    Estado_Pedido,
    Nombre_Producto,
    Cantidad_Comprada,
    Precio_Unitario_Facturado,
    Subtotal_Linea
FROM
    Factura_Cliente_Completa
WHERE
    pedido_id = 1;


-- CONSULTA N°2: INGRESO TOTAL ACUMULADO POR PRODUCTO (SUM y GROUP BY)
-- Objetivo: Determinar la rentabilidad de cada producto.
SELECT
    P.nombre AS Producto_Vendido,
    SUM(DP.cantidad * DP.precio_unitario) AS Ingreso_Total
FROM
    Detalle_Pedido DP
INNER JOIN
    Producto P ON DP.producto_id = P.producto_id
GROUP BY
    P.producto_id, P.nombre
ORDER BY
    Ingreso_Total DESC;


-- CONSULTA N°3: PRODUCTOS CON BAJO INVENTARIO
-- Objetivo: Identificar productos con menos de 50 unidades en stock para reabastecimiento.
SELECT
    nombre,
    stock
FROM
    Producto
WHERE
    stock < 50
ORDER BY
    stock ASC;


-- CONSULTA N°4: CONSULTA DE CLIENTES QUE MÁS HAN COMPRADO
-- Objetivo: Identificar el cliente con el mayor gasto total.
SELECT
    CL.nombre || ' ' || CL.apellido AS Nombre_Cliente,
    SUM(P.costo_total) AS Gasto_Total
FROM
    Pedido P
INNER JOIN
    Cliente CL ON P.cliente_id = CL.cliente_id
GROUP BY
    CL.cliente_id, CL.nombre, CL.apellido
ORDER BY
    Gasto_Total DESC;
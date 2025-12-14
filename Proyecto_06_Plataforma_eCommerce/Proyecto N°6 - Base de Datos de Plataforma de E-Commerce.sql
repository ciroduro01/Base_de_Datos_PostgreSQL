-- 1. CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE e_commerce_db;

-- Conectarse a la base de datos (comando específico de psql, no SQL estándar)
-- \c e_commerce_db;

-- 2. CREACIÓN DE TABLAS (DDL)

CREATE TABLE Cliente (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    telefono VARCHAR(15),
    dirección TEXT
);

CREATE TABLE Producto (
    producto_id SERIAL PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL UNIQUE,
    descripción TEXT,
    precio NUMERIC(10, 2) NOT NULL CHECK (precio > 0),
    stock INT NOT NULL CHECK (stock >= 0)
);

CREATE TABLE Pedido (
    pedido_id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES Cliente(cliente_id) NOT NULL,
    fecha_pedido TIMESTAMP NOT NULL DEFAULT NOW(),
    estado VARCHAR(50) NOT NULL DEFAULT 'Pendiente',
    costo_total NUMERIC(10, 2) NOT NULL CHECK (costo_total >= 0)
);

-- Tabla de Enlace N:M (Detalle/Factura)
CREATE TABLE Detalle_Pedido (
    detalle_id SERIAL PRIMARY KEY,
    pedido_id INT REFERENCES Pedido(pedido_id) ON DELETE CASCADE NOT NULL,
    producto_id INT REFERENCES Producto(producto_id) NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    -- Almacena el precio al momento de la compra (esto es crucial para la facturación histórica)
    precio_unitario NUMERIC(10, 2) NOT NULL CHECK (precio_unitario > 0),

    UNIQUE (pedido_id, producto_id)
);


-- 3. CREACIÓN DE VISTAS

-- Vista: Factura Completa (Desenvuelve la relación N:M para reportes de facturación)
CREATE VIEW Factura_Cliente_Completa AS
SELECT
    P.pedido_id,
    CL.nombre || ' ' || CL.apellido AS Nombre_Cliente,
    CL.email AS Email_Cliente,
    P.fecha_pedido,
    P.estado AS Estado_Pedido,
    PR.nombre AS Nombre_Producto,
    DP.cantidad AS Cantidad_Comprada,
    DP.precio_unitario AS Precio_Unitario_Facturado,
    (DP.cantidad * DP.precio_unitario) AS Subtotal_Linea
FROM
    Pedido P
INNER JOIN Cliente CL ON P.cliente_id = CL.cliente_id
INNER JOIN Detalle_Pedido DP ON P.pedido_id = DP.pedido_id
INNER JOIN Producto PR ON DP.producto_id = PR.producto_id
ORDER BY
    P.fecha_pedido DESC, P.pedido_id, PR.nombre;

-- INSERCIÓN DE DATOS (DML)

-- CLIENTES (IDs 1-5)
INSERT INTO Cliente (nombre, apellido, email, telefono, dirección) VALUES
('Ana', 'Gómez', 'ana.gomez@mail.com', '5491112345678', 'Av. Corrientes 1000, Buenos Aires'),
('Beto', 'Silva', 'beto.silva@mail.com', '5491187654321', 'Rua Augusta 500, São Paulo'),
('Carlos', 'Díaz', 'carlos.diaz@mail.com', '5511987654321', 'Avenida Paulista 200, São Paulo'), -- ID 3
('Diana', 'Flores', 'diana.flores@mail.com', '56922334455', 'Calle Falsa 123, Santiago'),
('Ernesto', 'Ramos', 'ernesto.ramos@mail.com', '5491177665544', 'Calle Sarmiento 450, Córdoba');

-- PRODUCTOS (IDs 1-3)
INSERT INTO Producto (nombre, descripción, precio, stock) VALUES
('Teclado Mecánico RGB', 'Teclado de alta respuesta para gaming.', 85.50, 50),     -- ID 1
('Mouse Inalámbrico Ergonómico', 'Mouse con diseño vertical para comodidad.', 35.00, 120),  -- ID 2
('Monitor Curvo 27"', 'Monitor 144Hz para experiencia inmersiva.', 350.99, 30);      -- ID 3

-- TRANSACCIÓN COMPLETA (PEDIDO ID 1)

-- 1. Inserción del Pedido (Cabecera)
INSERT INTO Pedido (cliente_id, costo_total, estado)
VALUES (3, 120.50, 'Completado'); -- Carlos Díaz compró por $120.50

-- 2. Inserción de Detalle_Pedido (Facturación N:M)
INSERT INTO Detalle_Pedido (pedido_id, producto_id, cantidad, precio_unitario)
VALUES (1, 1, 1, 85.50); -- Teclado
INSERT INTO Detalle_Pedido (pedido_id, producto_id, cantidad, precio_unitario)
VALUES (1, 2, 1, 35.00); -- Mouse

-- 3. Lógica de Negocio: Actualización de Inventario (Simulación de la salida de stock)
UPDATE Producto
SET stock = stock - 1
WHERE producto_id IN (1, 2);

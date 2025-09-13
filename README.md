# Topicos_Tarea

CREATE DATABASE lab_indexacion;
USE lab_indexacion;

CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    direccion VARCHAR(100),
    telefono VARCHAR(20)
);
INSERT INTO cliente (id_cliente, nombre, apellido, direccion, telefono) VALUES
(1, 'Juan', 'Pérez', 'Calle Falsa 123', '555-1234'),
(2, 'Ana', 'Gómez', 'Av. Siempre Viva 742', '555-5678'),
(3, 'Luis', 'Martínez', 'Calle Luna 456', '555-8765'),
(4, 'Carla', 'Fernández', 'Calle Sol 789', '555-4321'),
(5, 'Pedro', 'López', 'Av. Central 100', '555-0000');

EXPLAIN SELECT * FROM cliente WHERE nombre = 'Ana';
EXPLAIN SELECT * FROM cliente WHERE apellido = 'Pérez';

CREATE INDEX idx_nombre ON cliente(nombre);
CREATE INDEX idx_apellido ON cliente(apellido);

EXPLAIN SELECT * FROM cliente WHERE nombre = 'Ana';
EXPLAIN SELECT * FROM cliente WHERE apellido = 'Pérez';

EXPLAIN SELECT * FROM cliente ORDER BY nombre;
EXPLAIN SELECT * FROM cliente WHERE nombre = 'Juan' AND apellido = 'Pérez';
CREATE INDEX idx_nombre_apellido ON cliente(nombre, apellido);
EXPLAIN SELECT * FROM cliente WHERE nombre = 'Juan' AND apellido = 'Pérez';

DROP INDEX idx_nombre ON cliente;
DROP INDEX idx_apellido ON cliente;
DROP INDEX idx_nombre_apellido ON cliente;

DROP TABLE cliente;
DROP DATABASE lab_indexacion;


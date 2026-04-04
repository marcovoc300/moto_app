DROP DATABASE IF EXISTS motoapp;
CREATE DATABASE motoapp;
USE motoapp;

CREATE TABLE usuario(
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(200),
email VARCHAR(200) UNIQUE,
fecha_de_nacimiento DATE,
moto VARCHAR(200)
);

CREATE TABLE rutas(
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(200),
pais VARCHAR(200),
provincia VARCHAR(200)
);

CREATE TABLE mecanico(
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(200),
telefono VARCHAR(200),
email VARCHAR(200) UNIQUE
);

CREATE TABLE alojamientos(
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(200),
telefono VARCHAR(200),
email VARCHAR(200),
id_ruta INT,
FOREIGN KEY (id_ruta) REFERENCES rutas(id)
);

CREATE TABLE viajes(
id INT AUTO_INCREMENT PRIMARY KEY,
id_usuario INT,
id_ruta INT,
id_mecanico INT,
id_alojamiento INT,
fecha DATE,

FOREIGN KEY (id_usuario) REFERENCES usuario(id),
FOREIGN KEY (id_ruta) REFERENCES rutas(id),
FOREIGN KEY (id_mecanico) REFERENCES mecanico(id),
FOREIGN KEY (id_alojamiento) REFERENCES alojamientos(id)
);


-----VISTAS----
CREATE VIEW vista_viajes_completos AS
SELECT 
u.nombre AS usuario,
r.nombre AS ruta,
r.provincia,
m.nombre AS mecanico,
a.nombre AS alojamiento,
v.fecha
FROM viajes v
JOIN usuario u ON v.id_usuario = u.id
JOIN rutas r ON v.id_ruta = r.id
JOIN mecanico m ON v.id_mecanico = m.id
JOIN alojamientos a ON v.id_alojamiento = a.id;

CREATE VIEW vista_viajes_por_usuario AS
SELECT 
u.nombre,
COUNT(v.id) AS cantidad_viajes
FROM usuario u
LEFT JOIN viajes v ON u.id = v.id_usuario
GROUP BY u.nombre;

------FUNCIONES------
CREATE VIEW vista_viajes_completos AS
SELECT 
u.nombre AS usuario,
r.nombre AS ruta,
r.provincia,
m.nombre AS mecanico,
a.nombre AS alojamiento,
v.fecha
FROM viajes v
JOIN usuario u ON v.id_usuario = u.id
JOIN rutas r ON v.id_ruta = r.id
JOIN mecanico m ON v.id_mecanico = m.id
JOIN alojamientos a ON v.id_alojamiento = a.id;

CREATE VIEW vista_viajes_por_usuario AS
SELECT 
u.nombre,
COUNT(v.id) AS cantidad_viajes
FROM usuario u
LEFT JOIN viajes v ON u.id = v.id_usuario
GROUP BY u.nombre;

-----PROCEDURES----

DELIMITER //

CREATE PROCEDURE registrar_viaje(
IN p_id_usuario INT,
IN p_id_ruta INT,
IN p_id_mecanico INT,
IN p_id_alojamiento INT,
IN p_fecha DATE
)
BEGIN
INSERT INTO viajes(id_usuario, id_ruta, id_mecanico, id_alojamiento, fecha)
VALUES(p_id_usuario, p_id_ruta, p_id_mecanico, p_id_alojamiento, p_fecha);
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE ver_viajes_usuario(
IN p_id_usuario INT
)
BEGIN
SELECT 
u.nombre AS usuario,
r.nombre AS ruta,
r.provincia,
m.nombre AS mecanico,
a.nombre AS alojamiento,
v.fecha
FROM viajes v
JOIN usuario u ON v.id_usuario = u.id
JOIN rutas r ON v.id_ruta = r.id
JOIN mecanico m ON v.id_mecanico = m.id
JOIN alojamientos a ON v.id_alojamiento = a.id
WHERE v.id_usuario = p_id_usuario;
END //

DELIMITER ;

------TRIGGER-----

DELIMITER //

CREATE TRIGGER validar_ruta_alojamiento
BEFORE INSERT ON alojamientos
FOR EACH ROW
BEGIN
IF NOT EXISTS (
    SELECT 1 FROM rutas WHERE id = NEW.id_ruta
) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'La ruta no existe';
END IF;
END //

----tablas maestras agregadas-----
-- 6. Provincias (Tabla Maestra principal)
CREATE TABLE provincias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

-- 7. Localidades (Para dar más detalle a las rutas y alojamientos)
CREATE TABLE localidades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_provincia INT,
    FOREIGN KEY (id_provincia) REFERENCES provincias(id)
);

-- 8. Marcas de Motos
CREATE TABLE marcas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

-- 9. Modelos de Motos (Relacionada con Marcas)
CREATE TABLE modelos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_marca INT,
    FOREIGN KEY (id_marca) REFERENCES marcas(id)
);

-- 10. Tipo de Alojamiento (Hotel, Camping, Posta de Motos)
CREATE TABLE tipo_alojamiento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL
);
DELIMITER ;

----- tablas tansaccionales y de hecho-----

-- 11. Gastos de Viaje (TABLA DE HECHOS)
-- Aquí se registra cada peso gastado, ideal para informes de costos.
CREATE TABLE gastos_viaje (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_viaje INT,
    categoria ENUM('Combustible', 'Peaje', 'Comida', 'Hospedaje', 'Otros'),
    monto DECIMAL(12,2) NOT NULL,
    fecha_gasto DATE,
    FOREIGN KEY (id_viaje) REFERENCES viajes(id)
);

-- 12. Mantenimiento Preventivo (Tabla Transaccional)
CREATE TABLE mantenimientos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_mecanico INT,
    fecha DATE NOT NULL,
    km_unidad INT,
    tareas_realizadas TEXT,
    costo_total DECIMAL(12,2),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (id_mecanico) REFERENCES mecanico(id)
);

-- 13. Repuestos y Consumibles
CREATE TABLE productos_repuestos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(200),
    marca_producto VARCHAR(100),
    precio_referencia DECIMAL(12,2)
);

-- 14. Bitácora de Paradas de Ruta
CREATE TABLE paradas_ruta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_viaje INT,
    id_localidad INT,
    comentarios TEXT,
    FOREIGN KEY (id_viaje) REFERENCES viajes(id),
    FOREIGN KEY (id_localidad) REFERENCES localidades(id)
);

-- 15. Auditoría de Cambios (Tabla de control exigida)
CREATE TABLE auditoria_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_db VARCHAR(100),
    accion VARCHAR(50), -- INSERT, UPDATE, DELETE
    tabla_afectada VARCHAR(50),
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

---- vistas nuevas---
CREATE OR REPLACE VIEW vista_alojamientos_detalle AS 
SELECT     
    a.nombre AS alojamiento,     
    t.descripcion AS tipo,     
    p.nombre AS provincia,     
    r.nombre AS ruta_cercana 
FROM alojamientos a 
JOIN tipo_alojamiento t ON a.id_tipo = t.id 
JOIN rutas r ON a.id_ruta = r.id 
JOIN provincias p ON r.id_provincia = p.id;
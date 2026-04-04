INSERT INTO usuario (nombre, email, fecha_de_nacimiento, moto) VALUES
('Juan Pérez', 'juan1@gmail.com', '1995-03-12', 'Yamaha MT-07'),
('María López', 'maria2@gmail.com', '1990-07-25', 'Honda CB500F'),
('Carlos Gómez', 'carlos3@gmail.com', '1988-11-03', 'Kawasaki Ninja 400'),
('Lucía Fernández', 'lucia4@gmail.com', '1998-01-19', 'Suzuki GSX-R600'),
('Pedro Martínez', 'pedro5@gmail.com', '1992-05-30', 'BMW G310R'),
('Sofía Ramírez', 'sofia6@gmail.com', '1996-09-14', 'KTM Duke 390'),
('Diego Torres', 'diego7@gmail.com', '1985-12-22', 'Harley Davidson 883'),
('Valentina Castro', 'vale8@gmail.com', '2000-04-10', 'Yamaha R3'),
('Martín Suárez', 'martin9@gmail.com', '1993-06-18', 'Honda Tornado'),
('Camila Díaz', 'camila10@gmail.com', '1997-08-27', 'Bajaj Dominar 400');

INSERT INTO rutas (nombre, pais, provincia) VALUES
('Ruta 40 Norte', 'Argentina', 'Jujuy'),
('Ruta 40 Centro', 'Argentina', 'Mendoza'),
('Ruta de los 7 Lagos', 'Argentina', 'Neuquén'),
('Camino del Cuadrado', 'Argentina', 'Córdoba'),
('Ruta Atlántica', 'Argentina', 'Buenos Aires'),
('Ruta del Vino', 'Argentina', 'Mendoza'),
('Ruta Patagónica', 'Argentina', 'Chubut'),
('Ruta Serrana', 'Argentina', 'San Luis'),
('Ruta Costera', 'Argentina', 'Río Negro'),
('Ruta Andina', 'Argentina', 'Salta');

INSERT INTO mecanico (nombre, telefono, email) VALUES
('Taller MotoFix', '1111111111', 'motofix@gmail.com'),
('Service BikePro', '2222222222', 'bikepro@gmail.com'),
('MotoTech', '3333333333', 'mototech@gmail.com'),
('Full Moto', '4444444444', 'fullmoto@gmail.com'),
('Riders Garage', '5555555555', 'riders@gmail.com'),
('Speed Moto', '6666666666', 'speed@gmail.com'),
('Moto Service Sur', '7777777777', 'sur@gmail.com'),
('Garage Norte', '8888888888', 'norte@gmail.com'),
('Moto Expert', '9999999999', 'expert@gmail.com'),
('Taller Central', '1010101010', 'central@gmail.com');

INSERT INTO alojamientos (nombre, telefono, email, id_ruta) VALUES
('Hotel Norte', '111111111', 'hotel1@gmail.com', 1),
('Hostel Andino', '222222222', 'hotel2@gmail.com', 2),
('Cabañas del Lago', '333333333', 'hotel3@gmail.com', 3),
('Hotel Serrano', '444444444', 'hotel4@gmail.com', 4),
('Hotel Atlántico', '555555555', 'hotel5@gmail.com', 5),
('Posada del Vino', '666666666', 'hotel6@gmail.com', 6),
('Hostería Patagónica', '777777777', 'hotel7@gmail.com', 7),
('Refugio Serrano', '888888888', 'hotel8@gmail.com', 8),
('Hotel Costero', '999999999', 'hotel9@gmail.com', 9),
('Hostel Andino Sur', '101010101', 'hotel10@gmail.com', 10);


INSERT INTO viajes (id_usuario, id_ruta, id_mecanico, id_alojamiento, fecha) VALUES
(1,1,1,1,'2024-01-10'),
(2,2,2,2,'2024-02-15'),
(3,3,3,3,'2024-03-20'),
(4,4,4,4,'2024-04-05'),
(5,5,5,5,'2024-05-12'),
(6,6,6,6,'2024-06-18'),
(7,7,7,7,'2024-07-22'),
(8,8,8,8,'2024-08-30'),
(9,9,9,9,'2024-09-10'),
(10,10,10,10,'2024-10-25');

----datos nuevos tablas maestras-----

-- 6. PROVINCIAS
INSERT INTO provincias (nombre) VALUES 
('Buenos Aires'), ('Córdoba'), ('Santa Fe'), ('Mendoza'), ('Neuquén'), 
('Río Negro'), ('Chubut'), ('Santa Cruz'), ('Salta'), ('Jujuy');

-- 7. LOCALIDADES (Vinculadas a las provincias anteriores)
INSERT INTO localidades (nombre, id_provincia) VALUES 
('La Plata', 1), ('Villa Carlos Paz', 2), ('Rosario', 3), ('San Rafael', 4), ('San Martín de los Andes', 5),
('Bariloche', 6), ('Puerto Madryn', 7), ('El Calafate', 8), ('Cafayate', 9), ('Purmamarca', 10);

-- 8. MARCAS
INSERT INTO marcas (nombre) VALUES 
('Yamaha'), ('Honda'), ('Kawasaki'), ('Suzuki'), ('BMW'), 
('KTM'), ('Harley Davidson'), ('Bajaj'), ('Benelli'), ('Royal Enfield');

-- 9. MODELOS (Vinculados a las marcas anteriores)
INSERT INTO modelos (nombre, id_marca) VALUES 
('MT-07', 1), ('CB500F', 2), ('Ninja 400', 3), ('GSX-R600', 4), ('G310R', 5),
('Duke 390', 6), ('Iron 883', 7), ('Dominar 400', 8), ('TRK 502', 9), ('Himalayan 411', 10);

-- 10. TIPO DE ALOJAMIENTO
INSERT INTO tipo_alojamiento (descripcion) VALUES 
('Hotel'), ('Hostel'), ('Cabaña'), ('Camping'), ('Posada'), 
('Motel'), ('Refugio de Montaña'), ('Hostería'), ('Apart Hotel'), ('Casa de Campo');

---- datos nuevos tablas transaccionales y de hecho-----

-- 11. GASTOS DE VIAJE (Tabla de Hechos)
INSERT INTO gastos_viaje (id_viaje, categoria, monto, fecha_gasto) VALUES 
(1, 'Combustible', 15000.00, '2024-01-10'),
(2, 'Peaje', 2500.00, '2024-02-15'),
(3, 'Comida', 8000.00, '2024-03-20'),
(4, 'Hospedaje', 45000.00, '2024-04-05'),
(5, 'Otros', 5000.00, '2024-05-12'),
(6, 'Combustible', 18000.00, '2024-06-18'),
(7, 'Comida', 9500.00, '2024-07-22'),
(8, 'Peaje', 3000.00, '2024-08-30'),
(9, 'Hospedaje', 55000.00, '2024-09-10'),
(10, 'Combustible', 20000.00, '2024-10-25');

-- 12. MANTENIMIENTOS
INSERT INTO mantenimientos (id_usuario, id_mecanico, fecha, km_unidad, tareas_realizadas, costo_total) VALUES 
(1, 1, '2024-01-05', 5000, 'Cambio de aceite y filtro', 25000.00),
(2, 2, '2024-02-10', 12000, 'Regulación de válvulas', 45000.00),
(3, 3, '2024-03-15', 8500, 'Lubricación de cadena y frenos', 15000.00),
(4, 4, '2024-04-01', 20000, 'Service general y bujías', 60000.00),
(5, 5, '2024-05-05', 3200, 'Primer service oficial', 35000.00),
(6, 6, '2024-06-10', 15000, 'Cambio de cubiertas', 180000.00),
(7, 7, '2024-07-15', 45000, 'Cambio de transmisión', 95000.00),
(8, 8, '2024-08-20', 6000, 'Escaneo electrónico', 12000.00),
(9, 9, '2024-09-05', 25000, 'Cambio de pastillas de freno', 22000.00),
(10, 10, '2024-10-20', 11000, 'Limpieza de inyectores', 38000.00);

-- 13. PRODUCTOS Y REPUESTOS
INSERT INTO productos_repuestos (nombre, marca_producto, precio_referencia) VALUES 
('Aceite 10W40', 'Motul', 8500.00),
('Filtro de Aceite', 'HifloFiltro', 4200.00),
('Pastillas de Freno', 'EBC', 15000.00),
('Cadena 520', 'DID', 45000.00),
('Bujía Iridium', 'NGK', 9000.00),
('Cubierta Delantera', 'Pirelli', 85000.00),
('Cubierta Trasera', 'Michelin', 110000.00),
('Batería 12V', 'Yuasa', 55000.00),
('Líquido de Freno', 'Brembo', 7000.00),
('Kit de Transmisión', 'JT Sprockets', 65000.00);

-- 14. PARADAS DE RUTA (Bitácora)
INSERT INTO paradas_ruta (id_viaje, id_localidad, comentarios) VALUES 
(1, 1, 'Parada técnica para cargar nafta'),
(2, 2, 'Almuerzo en el centro'),
(3, 3, 'Foto en el monumento principal'),
(4, 4, 'Descanso por lluvia'),
(5, 5, 'Carga de combustible y café'),
(6, 6, 'Mirador panorámico increíble'),
(7, 7, 'Ajuste de equipaje'),
(8, 8, 'Parada para hidratación'),
(9, 9, 'Compra de regionales'),
(10, 10, 'Control policial de rutina');

-- 15. AUDITORIA_LOG (Simulamos los primeros registros de control)
INSERT INTO auditoria_log (usuario_db, accion, tabla_afectada) VALUES 
('root@localhost', 'INSERT', 'usuario'),
('root@localhost', 'INSERT', 'rutas'),
('admin_moto', 'INSERT', 'mecanico'),
('root@localhost', 'UPDATE', 'alojamientos'),
('root@localhost', 'INSERT', 'viajes'),
('admin_moto', 'INSERT', 'provincias'),
('root@localhost', 'INSERT', 'marcas'),
('root@localhost', 'INSERT', 'modelos'),
('root@localhost', 'DELETE', 'gastos_viaje'),
('admin_moto', 'INSERT', 'mantenimientos');

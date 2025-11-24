USE ESTETICA_BD
go

/* --- INSERCIÓN DE DATOS --- */

-- Deshabilitamos temporalmente las FK
EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'

-- 1. Catálogos Base (Estados, Roles, Tipos de Pago)
INSERT INTO EstadoTurno (Descripcion) VALUES
('Confirmado'),
('Pendiente'),
('CanceladoCliente'),
('CanceladoProfesional'),
('Finalizado')
('Solicitud de Devolución');
-- IDs: 1-Confirmado, 2- Pendiente de pado, 3-CanceladoCliente, 4-CanceladoProfesional, 5-Finalizado, 6-Solicitud de Devolución

INSERT INTO Rol (NombreRol) VALUES 
('Admin'), ('Profesional'), ('Cliente'), ('Recepcionista'), ('ProfesionalUnico')
-- IDs: 1-Admin, 2-Profesional, 3-Cliente, 4-Recepcionista, 5- Profesioal-Administrador

INSERT INTO TipoPago (Nombre) VALUES 
('Seña'), ('Total');
-- IDs: 1-Seña, 2-Total

INSERT INTO FormaPago (Nombre) VALUES 
('Efectivo'), ('Electrónico');
-- IDs: 1-Paga en Efectivo, 2-Paga de forma electrónica (transferencia-mp-etc).

INSERT INTO Especialidad (Nombre, Descripcion, Foto) VALUES
('Manicura', 'Servicios de belleza para manos y pies.','https://lafemmebeauty.es/wp-content/uploads/2024/06/Consejos-para-Mantener-Tu-Pedicura-Semipermanente-Perfecta-1.jpeg'),
('Esteticista', 'Tratamientos faciales, corporales y depilación.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3Mvo09I7M19WqW-2RbnOT-aw5bo-WOd9PtA&s'),
('Masajista', 'Masajes terapéuticos y de relajación.', 'https://www.anamanao.com/imagecache/width/uploads/tratamientos/tratamientos-corporales/aromassage-relax.jpg?size=680'),
('Lashista', 'Servicios de pestañas y cejas.', 'https://inlashacademy.com/wp-content/uploads/2022/04/lashista-1-1360x902.jpg');
-- IDs: 1-Manicura, 2-Esteticista, 3-Masajista, 4-Lashista

-- 2. Servicios (Vinculados a Especialidad)

-- Servicios de Manicura (Especialidad 1)
INSERT INTO Servicio (IDEspecialidad, Nombre, Precio, DuracionMinutos, Activo) VALUES
(1, 'Belleza de Manos', 15000, 40, 1),
(1, 'Belleza de Pies', 18000, 45, 1),
(1, 'Esmaltado semipermanente', 20000, 60, 1),
(1, 'Capping', 22000, 75, 1),
(1, 'Esmaltado comun', 12000, 30, 1),
(1, 'Soft Gel', 28000, 90, 1),
(1, 'Diseño de uñas (simple)', 3000, 15, 1);
-- Servicios de Esteticista (Especialidad 2)
INSERT INTO Servicio (IDEspecialidad, Nombre, Precio, DuracionMinutos, Activo) VALUES
(2, 'Dermaplaning', 35000, 60, 1),
(2, 'Dermapen', 45000, 75, 1),
(2, 'Hi-FU (Facial)', 80000, 90, 1),
(2, 'Tratamiento facial con activos', 30000, 50, 1),
(2, 'Bronceado (Sol Pleno)', 22000, 30, 1),
(2, 'Depilación laser cuerpo entero', 70000, 120, 1),
(2, 'Depilación laser pecho', 25000, 30, 1),
(2, 'Depilación laser espalda', 25000, 30, 1),
(2, 'Depilacion rostro', 18000, 20, 1),
(2, 'Depilación laser una zona (cavado)', 20000, 30, 1);
-- Servicios de Masajista (Especialidad 3)
INSERT INTO Servicio (IDEspecialidad, Nombre, Precio, DuracionMinutos, Activo) VALUES
(3, 'Masaje Descontracturante', 40000, 60, 1),
(3, 'Masaje reducctor', 42000, 60, 1),
(3, 'Masaje relajante', 40000, 60, 1),
(3, 'Drenaje Linfático (Manual)', 48000, 50, 1),
(3, 'Reflexologia', 38000, 45, 1);
-- Servicios de LASHISTA (Especialidad 4)
INSERT INTO Servicio (IDEspecialidad, Nombre, Precio, DuracionMinutos, Activo) VALUES
(4, 'Perfilado de cejas', 18000, 30, 1),
(4, 'Laminado de cejas', 28000, 50, 1),
(4, 'Lifting de pestañas', 30000, 60, 1);



-- 3. Usuarios 
DECLARE @PassHash VARCHAR(255) = '$2a$10$9A014.JhG379V054ZG4uiOlnBQ25eKTHskhx0lvEh313Qo/wzabSK';

-- Admins (IDRol 1)
INSERT INTO Usuario (Nombre, Apellido, Dni, Telefono, Mail, ContraseniaHash, IDRol) VALUES
('Lucas', 'Berlingeri', '30111222','22233377889', 'lucas.berlingeri@admin.com', @PassHash, 1),
('Natalia', 'Mucci', '31222333', '22336677991', 'natalia.mucci@admin.com', @PassHash, 4);
-- IDs: 1, 2, 


-- Profesionales (IDRol 2)
INSERT INTO Usuario (Nombre, Apellido, Dni,Telefono, Mail, ContraseniaHash, Foto, IDRol) VALUES
('Ana', 'Bianchi', '35111111','1136547895', 'ana.bianchi@prof.com', @PassHash,'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg', 2),
('Sofia', 'Mancini', '35333333', '1124574120', 'sofia.mancini@prof.com', @PassHash, 'https://img.freepik.com/foto-gratis/retrato-mujer-joven-expresiva_1258-48167.jpg', 2),
('Laura', 'Schneider', '36444444','1122336699' ,'laura.schneider@prof.com', @PassHash, 'https://image.jimcdn.com/app/cms/image/transf/none/path/s70f5679ceb3714b2/image/i2cceb8a4aa75b9cf/version/1666629063/image.jpg', 2),
('Elena', 'Macedo', '36666666', '1144770022','elena.macedo@prof.com', @PassHash, 'https://images.pexels.com/photos/1036623/pexels-photo-1036623.jpeg', 2),
('Diego', 'Ferrara', '34111222','1234567890', 'diego.ferrara@prof.com', @PassHash, 'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg', 2),
('Franco', 'Leone', '34222333','1155880033', 'franco.leone@prof.com', @PassHash, 'https://media.istockphoto.com/id/1200677760/es/foto/retrato-de-apuesto-joven-sonriente-con-los-brazos-cruzados.jpg?s=612x612&w=0&k=20&c=RhKR8pxX3y_YVe5CjrRnTcNFEGDryD2FVOcUT_w3m4w=', 2),
('Martina', 'Wagner', '36555555','1199887766', 'martina.wagner@prof.com', @PassHash,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8gi0ZLlmIhYygwOcEO3zEkR2fm8sjSNzA64N5kvyKrkULkrH6EX2uo0_BzXqJOtUb0P0&usqp=CAU', 2),

-- Usuario unipersonal (Profesional Único - IDRol 5)
('Clara', 'Castro', '37222444','1155990033', 'clara.castro@prof.com', @PassHash, 'https://images.pexels.com/photos/1181686/pexels-photo-1181686.jpeg', 5);

-- IDs: 3 a 10

-- Clientes (IDRol 3)

INSERT INTO Usuario (Nombre, Apellido, Dni, Telefono, Domicilio, Mail, ContraseniaHash, IDRol) VALUES
('Maria', 'Gonzalez', '40111111','1150001111','Av. Rivadavia 1234',  'maria.gonzalez@cliente.com', @PassHash, 3),
('Juan', 'Rodriguez', '40222222','1150018888','Cerrito 900',  'juan.rodriguez@cliente.com', @PassHash, 3),
('Florencia', 'Gomez', '40333333', '1150003333','Av. Corrientes 5678', 'flor.gomez@cliente.com', @PassHash, 3),
('Pedro', 'Fernandez', '40444444','1150005555', 'Bolivar 158', 'pedro.fernandez@cliente.com', @PassHash, 3),
('Camila', 'Lopez', '40555555','1150007777','Florida 550',  'camila.lopez@cliente.com', @PassHash, 3),
('Martin', 'Diaz', '40666666','1150009999','Peru 345',  'martin.diaz@cliente.com', @PassHash, 3),
('Lucia', 'Martinez', '40777777','1150013333','Uruguay 300',  'lucia.martinez@cliente.com', @PassHash, 3),
('Agustin', 'Perez', '40888888','1150015555','Esmeralda 600',  'agustin.perez@cliente.com', @PassHash, 3),
('Julieta', 'Sanchez', '40999999','1150017777','Carlos Pellegrini 800',  'julieta.sanchez@cliente.com', @PassHash, 3),
('Valeria', 'Acosta', '41222222','1150019999','Libertad 1000', 'valeria.acosta@cliente.com', @PassHash, 3);

--IDs: 11 a 20



-- 5. ProfesionalEspecialidad
INSERT INTO ProfesionalEspecialidad (IDUsuario, IDEspecialidad) VALUES
(4, 1), (5, 1), -- Manicuras
(7, 2), (10, 2), -- Esteticistas
(8, 3), (3, 3),       -- Masajistas
(9, 4), (6, 4);       -- Lashistas

-- 6. Horarios de Atención
INSERT INTO HorarioAtencion (IDUsuario, DiaSemana, HorarioInicio, HorarioFin, Activo) VALUES
(4, 'Lunes', '09:00:00', '18:00:00', 1),(4, 'Martes', '09:00:00', '18:00:00', 1),
(4, 'Miercoles', '09:00:00', '14:00:00', 1),(7, 'Miercoles', '10:00:00', '20:00:00', 1),
(7, 'Jueves', '10:00:00', '20:00:00', 1),(7, 'Viernes', '10:00:00', '20:00:00', 1),
(10, 'Lunes', '14:00:00', '21:00:00', 1),(10, 'Miercoles', '14:00:00', '21:00:00', 1),
(8, 'Jueves', '08:00:00', '16:00:00', 1),(8, 'Viernes', '08:00:00', '16:00:00', 1);


-- 7. Turnos
INSERT INTO Turno (Fecha, HoraInicio, IDUsuarioProfesional, IDUsuarioCliente, IDServicio, IDEstado) VALUES
(DATEADD(day, 7, GETDATE()), '10:00:00', 4, 14, 3, 1),
(DATEADD(day, -5, GETDATE()), '11:00:00', 7, 15, 9, 4),
(DATEADD(day, 3, GETDATE()), '15:00:00', 10, 16, 18, 2),
(DATEADD(day, 4, GETDATE()), '16:00:00', 9, 17, 20, 1),
(DATEADD(day, -3, GETDATE()), '09:00:00', 4, 18, 1, 4),
(DATEADD(day, -1, GETDATE()), '14:00:00', 7, 19, 11, 4),
(DATEADD(day, 2, GETDATE()), '11:00:00', 8, 20, 19, 3),
(CONVERT(date, GETDATE()), '17:00:00', 3, 11, 25, 1),
(DATEADD(day, -2, GETDATE()), '13:00:00', 4, 12, 6, 4),
(DATEADD(day, 10, GETDATE()), '10:00:00', 7, 16, 13, 1);



-- 8. Pagos
INSERT INTO Pago (IDTurno, Fecha, Monto, IDTipoPago, IDFormaPago)
VALUES
(1, DATEADD(day, -1, GETDATE()), 30000, 2, 1),  
(2, DATEADD(day, -1, GETDATE()), 8000, 1, 1),  
(3, DATEADD(day, -2, GETDATE()), 28000, 2, 2),  
(4, DATEADD(day, -3, GETDATE()), 15000, 2, 1), 
(5, DATEADD(day, -5, GETDATE()), 45000, 2, 2), 
(6, DATEADD(day, -1, GETDATE()), 10000, 1, 2),  
(7, DATEADD(day, -1, GETDATE()), 15000, 1, 1), 
(8, DATEADD(day, -1, GETDATE()), 15000, 1, 1), 
(9, CONVERT(date, GETDATE()), 10000, 1, 2),     
(10, DATEADD(day, -2, GETDATE()), 30000, 1, 1); 

-- Reactivamos todas las constraints
EXEC sp_MSforeachtable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL'; 
go






-- insert para probar turnos confrimados
INSERT INTO Turno (Fecha, HoraInicio, IDUsuarioCliente, IDUsuarioProfesional, IDServicio, IDEstado)
VALUES ('2025-11-15', '10:30:00', 12, 8, 20, 2);

INSERT INTO Turno (Fecha, HoraInicio, IDUsuarioProfesional, IDUsuarioCliente, IDServicio, IDEstado)
VALUES (DATEADD(day, 1, CAST(GETDATE() AS DATE)), '16:30:00', 5, 14, 3, 1);

INSERT INTO Turno (Fecha, HoraInicio, IDUsuarioProfesional, IDUsuarioCliente, IDServicio, IDEstado)
VALUES (DATEADD(day, 2, CAST(GETDATE() AS DATE)), '18:00:00', 5, 14, 3, 1);

INSERT INTO Turno (Fecha, HoraInicio, IDUsuarioProfesional, IDUsuarioCliente, IDServicio, IDEstado)
VALUES (CAST(GETDATE() AS DATE), '12:00:00', 5, 15, 3, 3);


-- Pago para Turno 11
INSERT INTO Pago (IDTurno, Fecha, Monto, IDTipoPago, IDFormaPago)
VALUES ( 11, GETDATE(), 10000, 1, 1);

-- Pago para Turno 12
INSERT INTO Pago (IDTurno, Fecha, Monto, IDTipoPago, IDFormaPago)
VALUES (12, GETDATE(), 8000, 1, 1);

-- Pago para Turno 13
INSERT INTO Pago (IDTurno, Fecha, Monto, IDTipoPago, IDFormaPago)
VALUES (13, GETDATE(), 8000, 1, 1);

-- Pago para Turno 14
INSERT INTO Pago (IDTurno, Fecha, Monto, IDTipoPago, IDFormaPago)
VALUES (14, GETDATE(), 15000, 1, 1);

-- Pago para Turno 14
INSERT INTO Pago (IDTurno, Fecha,EsDevolucion, Monto, IDTipoPago, IDFormaPago)
VALUES (14, GETDATE(),1, -15000, 1, 1);
















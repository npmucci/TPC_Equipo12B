CREATE DATABASE ESTETICA_BD;
GO
USE ESTETICA_BD;
GO

-- 1. Cat�logos 
CREATE TABLE Rol (
    IDRol INT IDENTITY(1,1) PRIMARY KEY,
    NombreRol NVARCHAR(50) NOT NULL
);

CREATE TABLE TipoPago (
    IDTipoPago INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE FormaPago (
    IDFormaPago INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL UNIQUE
);


CREATE TABLE EstadoTurno (
    IDEstado INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(100) NOT NULL UNIQUE
);

-- 2. Tabla base de Usuarios 
CREATE TABLE Usuario (
	IDUsuario INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Dni VARCHAR(20) UNIQUE NOT NULL,
	Telefono NVARCHAR(20) UNIQUE NOT NULL,
	Domicilio  VARCHAR(255) NULL,
    Mail VARCHAR(255) UNIQUE NOT NULL,
    ContraseniaHash VARCHAR(255) NOT NULL, 
	Foto NVARCHAR(255),
    Activo BIT NOT NULL DEFAULT 1
    
);

-- nueva tabla que permite que un mismo usuario pueda tener mas de un rol
CREATE TABLE UsuarioRol (
    IDUsuario INT NOT NULL,
    IDRol INT NOT NULL,
    PRIMARY KEY (IDUsuario, IDRol),
    FOREIGN KEY (IDUsuario) REFERENCES Usuario(IDUsuario) ON DELETE CASCADE,
    FOREIGN KEY (IDRol) REFERENCES Rol(IDRol) ON DELETE CASCADE
);


-- 4. Cat�logo de Especialidad
CREATE TABLE Especialidad (
    IDEspecialidad INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL UNIQUE,
    Descripcion VARCHAR(MAX),
	Foto VARCHAR (150),
	Activo BIT NOT NULL DEFAULT 1
);

-- 5. Cat�logo de Servicios 
CREATE TABLE Servicio (
    IDServicio INT IDENTITY(1,1) PRIMARY KEY,
    IDEspecialidad INT NOT NULL, 
    Nombre VARCHAR(150) NOT NULL,
    Descripcion VARCHAR(MAX),
    Precio DECIMAL(10, 2) NOT NULL,
    DuracionMinutos INT NOT NULL, 
    Activo BIT NOT NULL DEFAULT 1,
    
    FOREIGN KEY (IDEspecialidad) REFERENCES Especialidad(IDEspecialidad)
);

-- 6. Uni�n Usuario (Profesional) - Especialidad
CREATE TABLE ProfesionalEspecialidad (
    IDUsuario INT NOT NULL,
    IDEspecialidad INT NOT NULL,
    PRIMARY KEY (IDUsuario, IDEspecialidad),
    FOREIGN KEY (IDUsuario) REFERENCES Usuario(IDUsuario) ON DELETE CASCADE,
    FOREIGN KEY (IDEspecialidad) REFERENCES Especialidad(IDEspecialidad) ON DELETE CASCADE
);

-- 7. Horarios de Disponibilidad 
CREATE TABLE HorarioAtencion (
    IDHorarioAtencion INT IDENTITY(1,1) PRIMARY KEY,
    IDUsuario INT NOT NULL,
    DiaSemana VARCHAR(15) NOT NULL, 
    HorarioInicio TIME NOT NULL,
    HorarioFin TIME NOT NULL,
    Activo BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (IDUsuario) REFERENCES Usuario(IDUsuario) ON DELETE CASCADE
);

-- 8. Pagos 
CREATE TABLE Pago (
    IDPago INT IDENTITY(1,1) PRIMARY KEY,
    FechaPago DATETIME NOT NULL,
    Monto DECIMAL(10, 2) NOT NULL,
    IDTipoPago INT NOT NULL, 
    IDFormaPago INT NOT NULL,
    FOREIGN KEY (IDTipoPago) REFERENCES TipoPago(IDTipoPago),
    FOREIGN KEY (IDFormaPago) REFERENCES FormaPago(IDFormaPago)
);

CREATE TABLE Turno (
    IDTurno INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATE NOT NULL,
    HoraInicio TIME NOT NULL,
    IDUsuarioProfesional INT NOT NULL,
    IDUsuarioCliente INT NOT NULL,
    IDServicio INT NOT NULL,
    IDPago INT NOT NULL, 
    IDEstado INT NOT NULL,
    FOREIGN KEY (IDUsuarioProfesional) REFERENCES Usuario(IDUsuario),
    FOREIGN KEY (IDUsuarioCliente) REFERENCES Usuario(IDUsuario),
    FOREIGN KEY (IDServicio) REFERENCES Servicio(IDServicio),
    FOREIGN KEY (IDPago) REFERENCES Pago(IDPago),
    FOREIGN KEY (IDEstado) REFERENCES EstadoTurno(IDEstado)
);


/* --- INSERCI�N DE DATOS --- */

-- Deshabilitamos temporalmente las FK
EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'

-- 1. Cat�logos Base (Estados, Roles, Tipos de Pago)
INSERT INTO EstadoTurno (Descripcion) VALUES
('Confirmado'),
('CanceladoCliente'),
('CanceladoProfesional'),
('Finalizado');
-- IDs: 1-Confirmado, 2-CanceladoCliente, 3-CanceladoProfesional, 4-Finalizado

INSERT INTO Rol (NombreRol) VALUES 
('Admin'), ('Profesional'), ('Cliente'), ('Recepcionista')
-- IDs: 1-Admin, 2-Profesional, 3-Cliente, 4-Recepcionista

INSERT INTO TipoPago (Nombre) VALUES 
('Se�a'), ('Total');
-- IDs: 1-Se�a, 2-Total

INSERT INTO FormaPago (Nombre) VALUES 
('Efectivo'), ('Electronico');
-- IDs: 1-Paga en Efectivo, 2-Paga de forma electrnica (transferencia-mp-etc).

INSERT INTO Especialidad (Nombre, Descripcion, Foto) VALUES
('Manicura', 'Servicios de belleza para manos y pies.','https://lafemmebeauty.es/wp-content/uploads/2024/06/Consejos-para-Mantener-Tu-Pedicura-Semipermanente-Perfecta-1.jpeg'),
('Esteticista', 'Tratamientos faciales, corporales y depilaci�n.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3Mvo09I7M19WqW-2RbnOT-aw5bo-WOd9PtA&s'),
('Masajista', 'Masajes terap�uticos y de relajaci�n.', 'https://www.anamanao.com/imagecache/width/uploads/tratamientos/tratamientos-corporales/aromassage-relax.jpg?size=680'),
('Lashista', 'Servicios de pesta�as y cejas.', 'https://inlashacademy.com/wp-content/uploads/2022/04/lashista-1-1360x902.jpg');
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
(1, 'Dise�o de u�as (simple)', 3000, 15, 1);
-- Servicios de Esteticista (Especialidad 2)
INSERT INTO Servicio (IDEspecialidad, Nombre, Precio, DuracionMinutos, Activo) VALUES
(2, 'Dermaplaning', 35000, 60, 1),
(2, 'Dermapen', 45000, 75, 1),
(2, 'Hi-FU (Facial)', 80000, 90, 1),
(2, 'Tratamiento facial con activos', 30000, 50, 1),
(2, 'Bronceado (Sol Pleno)', 22000, 30, 1),
(2, 'Depilaci�n laser cuerpo entero', 70000, 120, 1),
(2, 'Depilaci�n laser pecho', 25000, 30, 1),
(2, 'Depilaci�n laser espalda', 25000, 30, 1),
(2, 'Depilacion rostro', 18000, 20, 1),
(2, 'Depilaci�n laser una zona (cavado)', 20000, 30, 1);
-- Servicios de Masajista (Especialidad 3)
INSERT INTO Servicio (IDEspecialidad, Nombre, Precio, DuracionMinutos, Activo) VALUES
(3, 'Masaje Descontracturante', 40000, 60, 1),
(3, 'Masaje reducctor', 42000, 60, 1),
(3, 'Masaje relajante', 40000, 60, 1),
(3, 'Drenaje Linfatico (Manual)', 48000, 50, 1),
(3, 'Reflexologia', 38000, 45, 1);
-- Servicios de LASHISTA (Especialidad 4)
INSERT INTO Servicio (IDEspecialidad, Nombre, Precio, DuracionMinutos, Activo) VALUES
(4, 'Perfilado de cejas', 18000, 30, 1),
(4, 'Laminado de cejas', 28000, 50, 1),
(4, 'Lifting de pesta�as', 30000, 60, 1);



-- 3. Usuarios 
DECLARE @PassHash VARCHAR(255) = 'HASH_PLACEHOLDER_123456';

-- Admins (IDRol 1)
INSERT INTO Usuario (Nombre, Apellido, Dni, Telefono, Mail, ContraseniaHash) VALUES
('Lucas', 'Berlingeri', '30111222','22233377889', 'lucas.berlingeri@admin.com', @PassHash),
('Natalia', 'Mucci', '31222333', '22336677991', 'natalia.mucci@admin.com', @PassHash);
-- IDs: 1, 2, 

-- Profesionales (IDRol 2)
INSERT INTO Usuario (Nombre, Apellido, Dni,Telefono, Mail, ContraseniaHash, foto) VALUES
('Ana', 'Bianchi', '35111111','1136547895', 'ana.bianchi@prof.com', @PassHash,'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg'),
('Sofia', 'Mancini', '35333333', '1124574120', 'sofia.mancini@prof.com', @PassHash, 'https://img.freepik.com/foto-gratis/retrato-mujer-joven-expresiva_1258-48167.jpg'),
('Laura', 'Schneider', '36444444','1122336699' ,'laura.schneider@prof.com', @PassHash, 'https://image.jimcdn.com/app/cms/image/transf/none/path/s70f5679ceb3714b2/image/i2cceb8a4aa75b9cf/version/1666629063/image.jpg'),
('Elena', 'Macedo', '36666666', '1144770022','elena.macedo@prof.com', @PassHash, 'https://images.pexels.com/photos/1036623/pexels-photo-1036623.jpeg'),
('Diego', 'Ferrara', '34111222','1234567890', 'diego.ferrara@prof.com', @PassHash, 'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg'),
('Franco', 'Leone', '34222333','1155880033', 'franco.leone@prof.com', @PassHash, 'https://media.istockphoto.com/id/1200677760/es/foto/retrato-de-apuesto-joven-sonriente-con-los-brazos-cruzados.jpg?s=612x612&w=0&k=20&c=RhKR8pxX3y_YVe5CjrRnTcNFEGDryD2FVOcUT_w3m4w='),
('Martina', 'Wagner', '36555555','1199887766', 'martina.wagner@prof.com', @PassHash,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8gi0ZLlmIhYygwOcEO3zEkR2fm8sjSNzA64N5kvyKrkULkrH6EX2uo0_BzXqJOtUb0P0&usqp=CAU'),
('Clara', 'Castro', '37222444','1155990033', 'clara.castro@prof.com', @PassHash, 'https://images.pexels.com/photos/1181686/pexels-photo-1181686.jpeg');
-- IDs: 3 a 10

-- Clientes (IDRol 3)
INSERT INTO Usuario (Nombre, Apellido, Dni, Telefono, Domicilio, Mail, ContraseniaHash) VALUES
('Maria', 'Gonzalez', '40111111','1150001111','Av. Rivadavia 1234',  'maria.gonzalez@cliente.com', @PassHash),
('Juan', 'Rodriguez', '40222222','1150018888','Cerrito 900',  'juan.rodriguez@cliente.com', @PassHash),
('Florencia', 'Gomez', '40333333', '1150003333','Av. Corrientes 5678', 'flor.gomez@cliente.com', @PassHash),
('Pedro', 'Fernandez', '40444444','1150005555', 'Bolivar 158', 'pedro.fernandez@cliente.com', @PassHash),
('Camila', 'Lopez', '40555555','1150007777','Florida 550',  'camila.lopez@cliente.com', @PassHash),
('Martin', 'Diaz', '40666666','1150009999','Peru 345',  'martin.diaz@cliente.com', @PassHash),
('Lucia', 'Martinez', '40777777','1150013333','Uruguay 300',  'lucia.martinez@cliente.com', @PassHash),
('Agustin', 'Perez', '40888888','1150015555','Esmeralda 600',  'agustin.perez@cliente.com', @PassHash),
('Julieta', 'Sanchez', '40999999','1150017777','Carlos Pellegrini 800',  'julieta.sanchez@cliente.com', @PassHash),
('Valeria', 'Acosta', '41222222','1150019999','Libertad 1000', 'valeria.acosta@cliente.com', @PassHash);

--IDs: 11 a 20


-- Asignaci�n de roles (UsuarioRol)
INSERT INTO UsuarioRol (IDUsuario, IDRol) VALUES
(1, 1), -- Lucas - Administrador 
(2, 4), -- Natalia - Recepcionista
(3, 2), (4, 2), (5, 2), (6, 2), (7, 2), (8, 2), (9, 2), (10,2),
(11,3),(12,3),(13,3), (14,3),(15,3), (16,3), (17,3), (18,3), (19,3), (20,3);




-- 5. ProfesionalEspecialidad
INSERT INTO ProfesionalEspecialidad (IDUsuario, IDEspecialidad) VALUES
(4, 1), (5, 1), -- Manicuras
(7, 2), (8, 2), -- Esteticistas
(10, 3), (3, 3),       -- Masajistas
(9, 4), (6, 4);       -- Lashistas

-- 6. Horarios de Atenci�n
INSERT INTO HorarioAtencion (IDUsuario, DiaSemana, HorarioInicio, HorarioFin, Activo) VALUES
(4, 'Lunes', '09:00:00', '18:00:00', 1),(4, 'Martes', '09:00:00', '18:00:00', 1),
(4, 'Miercoles', '09:00:00', '14:00:00', 1),(7, 'Miercoles', '10:00:00', '20:00:00', 1),
(7, 'Jueves', '10:00:00', '20:00:00', 1),(7, 'Viernes', '10:00:00', '20:00:00', 1),
(10, 'Lunes', '14:00:00', '21:00:00', 1),(10, 'Miercoles', '14:00:00', '21:00:00', 1),
(8, 'Jueves', '08:00:00', '16:00:00', 1),(8, 'Viernes', '08:00:00', '16:00:00', 1);

-- 7. Pagos 
-- IDs: 1-Se�a, 2-Total
INSERT INTO Pago (FechaPago, Monto, IDTipoPago, IDFormaPago) VALUES
(DATEADD(day, -1, GETDATE()), 30000, 2,1), -- Pago 1 (Total)
(DATEADD(day, -1, GETDATE()), 8000, 1,1),   -- Pago 2 (Se�a)
(DATEADD(day, -2, GETDATE()), 28000, 2,2), -- Pago 3 (Total)
(DATEADD(day, -3, GETDATE()), 15000, 2,1), -- Pago 4 (Total)
(DATEADD(day, -5, GETDATE()), 45000, 2,2), -- Pago 5 (Total)
(DATEADD(day, -1, GETDATE()), 10000, 1,2),  -- Pago 6 (Se�a)
(DATEADD(day, -1, GETDATE()), 15000, 1,1),  -- Pago 7 (Se�a)
(DATEADD(day, -1, GETDATE()), 15000, 1,1),  -- Pago 8 (Se�a)
(CONVERT(date, GETDATE()), 10000, 1,2),  -- Pago 9 (Se�a)
(DATEADD(day, -2, GETDATE()), 30000, 1,1);  -- Pago 10 (Se�a)
-- IDs: 1 a 10

-- 8. Turnos
INSERT INTO Turno (Fecha, HoraInicio, IDUsuarioProfesional, IDUsuarioCliente, IDServicio, IDPago, IDEstado) VALUES
(DATEADD(day, 7, GETDATE()), '10:00:00', 4, 14, 3, 6, 1),
(DATEADD(day, -5, GETDATE()), '11:00:00', 7, 15, 9, 5, 4),
(DATEADD(day, 3, GETDATE()), '15:00:00', 10, 16, 18, 7, 2),
(DATEADD(day, 4, GETDATE()), '16:00:00', 9, 17, 20, 2, 1),
(DATEADD(day, -3, GETDATE()), '09:00:00', 4, 18, 1, 4, 4),
(DATEADD(day, -1, GETDATE()), '14:00:00', 7, 19, 11, 1, 4),
(DATEADD(day, 2, GETDATE()), '11:00:00', 8, 20, 19, 8, 3),
(CONVERT(date, GETDATE()), '17:00:00', 3, 11, 25, 9, 1),
(DATEADD(day, -2, GETDATE()), '13:00:00', 4, 12, 6, 3, 4),
(DATEADD(day, 10, GETDATE()), '10:00:00', 7, 16, 13, 10, 1);

-- Reactivamos todas las constraints
EXEC sp_MSforeachtable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL'; 
go


--Procedimientos Almacenados
CREATE PROCEDURE ListarEspecialidades
AS
BEGIN
    SELECT IDEspecialidad, Nombre, Descripcion, Foto, Activo
    FROM Especialidad
    ORDER BY Nombre;
END
GO



CREATE OR ALTER PROCEDURE ListarProfesionales
AS
BEGIN
    SELECT 
        U.IDUsuario,
        U.Nombre,
        U.Apellido,
        U.Dni,
        U.Mail,
        UR.IDRol,
		U.Foto,
        U.Activo
    FROM Usuario U
    INNER JOIN UsuarioRol UR ON U.IDUsuario = UR.IDUsuario
    WHERE UR.IDRol = 2;
END


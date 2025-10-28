CREATE DATABASE ESTETICA_BD;
GO
USE ESTETICA_BD;
GO

-- 1. Catálogos 

CREATE TABLE Rol (
    IDRol INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE TipoPago (
    IDTipoPago INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE EstadoTurno (
    IDEstado INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(50) NOT NULL UNIQUE
);

-- 2. Tabla base de Usuarios 
CREATE TABLE Usuario (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Dni VARCHAR(20) UNIQUE NOT NULL,
    Mail VARCHAR(255) UNIQUE NOT NULL,
    ContraseniaHash VARCHAR(255) NOT NULL, 
    IDRol INT NOT NULL, 
    Activo BIT NOT NULL DEFAULT 1,
    
    
    FOREIGN KEY (IDRol) REFERENCES Rol(IDRol)
);

-- 3. Especializaciones de Usuario 
CREATE TABLE Cliente (
    IDUsuario INT PRIMARY KEY,
    Domicilio VARCHAR(255),
    Telefono VARCHAR(50),
    FOREIGN KEY (IDUsuario) REFERENCES Usuario(ID) ON DELETE CASCADE
);

CREATE TABLE Profesional (
    IDUsuario INT PRIMARY KEY,
    FOREIGN KEY (IDUsuario) REFERENCES Usuario(ID) ON DELETE CASCADE
);

CREATE TABLE Administrador (
    IDUsuario INT PRIMARY KEY,
    FOREIGN KEY (IDUsuario) REFERENCES Usuario(ID) ON DELETE CASCADE
);

-- 4. Catálogo de Especialidad
CREATE TABLE Especialidad (
    IDEspecialidad INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL UNIQUE,
    Descripcion TEXT
);

-- 5. Catálogo de Servicios 
CREATE TABLE Servicio (
    IDServicio INT IDENTITY(1,1) PRIMARY KEY,
    IDEspecialidad INT NOT NULL, 
    Nombre VARCHAR(150) NOT NULL,
    Descripcion TEXT,
    Precio DECIMAL(10, 2) NOT NULL,
    DuracionMinutos INT NOT NULL, 
    Activo BIT NOT NULL DEFAULT 1,
    
    FOREIGN KEY (IDEspecialidad) REFERENCES Especialidad(IDEspecialidad)
);

-- 6. Tabla de Unión Profesional-Especialidad
CREATE TABLE ProfesionalEspecialidad (
    IDUsuarioProfesional INT NOT NULL,
    IDEspecialidad INT NOT NULL,
    PRIMARY KEY (IDUsuarioProfesional, IDEspecialidad),
    FOREIGN KEY (IDUsuarioProfesional) REFERENCES Profesional(IDUsuario),
    FOREIGN KEY (IDEspecialidad) REFERENCES Especialidad(IDEspecialidad)
);

-- 7. Horarios de Disponibilidad 
CREATE TABLE HorarioAtencion (
    IDHorarioAtencion INT IDENTITY(1,1) PRIMARY KEY,
    IDUsuarioProfesional INT NOT NULL,
    DiaSemana VARCHAR(15) NOT NULL, 
    HorarioInicio TIME NOT NULL,
    HorarioFin TIME NOT NULL,
    Activo BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (IDUsuarioProfesional) REFERENCES Profesional(IDUsuario)
);

-- 8. Pagos 
CREATE TABLE Pago (
    IDPago INT IDENTITY(1,1) PRIMARY KEY,
    FechaPago DATETIME NOT NULL,
    Monto DECIMAL(10, 2) NOT NULL,
    IDTipoPago INT NOT NULL, 
    
    FOREIGN KEY (IDTipoPago) REFERENCES TipoPago(IDTipoPago)
);

-- 9. Turnos (Tabla central)
CREATE TABLE Turno (
    IDTurno INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATE NOT NULL,
    HoraInicio TIME NOT NULL,
    IDUsuarioProfesional INT NOT NULL,
    IDUsuarioCliente INT NOT NULL,
    IDServicio INT NOT NULL,
    IDPago INT NOT NULL, 
    IDEstado INT NOT NULL, 
    
    FOREIGN KEY (IDUsuarioProfesional) REFERENCES Profesional(IDUsuario),
    FOREIGN KEY (IDUsuarioCliente) REFERENCES Cliente(IDUsuario),
    FOREIGN KEY (IDServicio) REFERENCES Servicio(IDServicio),
    FOREIGN KEY (IDPago) REFERENCES Pago(IDPago), 
    FOREIGN KEY (IDEstado) REFERENCES EstadoTurno(IDEstado)
);


/* --- INSERCIÓN DE DATOS --- */

-- Deshabilitamos temporalmente las FK
EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'

-- 1. Catálogos Base (Estados, Roles, Tipos de Pago)
INSERT INTO EstadoTurno (Descripcion) VALUES
('Confirmado'),
('CanceladoCliente'),
('CanceladoProfesional'),
('Finalizado');
-- IDs: 1-Confirmado, 2-CanceladoCliente, 3-CanceladoProfesional, 4-Finalizado

INSERT INTO Rol (Nombre) VALUES 
('Admin'), ('Profesional'), ('Cliente');
-- IDs: 1-Admin, 2-Profesional, 3-Cliente

INSERT INTO TipoPago (Nombre) VALUES 
('Seña'), ('Total');
-- IDs: 1-Seña, 2-Total

INSERT INTO Especialidad (Nombre, Descripcion) VALUES
('Manicura', 'Servicios de belleza para manos y pies.'),
('Esteticista', 'Tratamientos faciales, corporales y depilación.'),
('Masajista', 'Masajes terapéuticos y de relajación.'),
('LASHISTA', 'Servicios de pestañas y cejas.');
-- IDs: 1-Manicura, 2-Esteticista, 3-Masajista, 4-LASHISTA

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
(3, 'Drenaje Linfatico (Manual)', 48000, 50, 1),
(3, 'Reflexologia', 38000, 45, 1);
-- Servicios de LASHISTA (Especialidad 4)
INSERT INTO Servicio (IDEspecialidad, Nombre, Precio, DuracionMinutos, Activo) VALUES
(4, 'Perfilado de cejas', 18000, 30, 1),
(4, 'Laminado de cejas', 28000, 50, 1),
(4, 'Lifting de pestañas', 30000, 60, 1);

-- 3. Usuarios 
DECLARE @PassHash VARCHAR(255) = 'HASH_PLACEHOLDER_123456';

-- Admins (IDRol 1)
INSERT INTO Usuario (Nombre, Apellido, Dni, Mail, ContraseniaHash, IDRol, Activo) VALUES
('Lucas', 'Berlingeri', '30111222', 'lucas.berlingeri@admin.com', @PassHash, 1, 1),
('Natalia', 'Mucci', '31222333', 'natalia.mucci@admin.com', @PassHash, 1, 1),
('Mateo', 'Maciel', '32333444', 'mateo.maciel@admin.com', @PassHash, 1, 1);
-- IDs: 1, 2, 3

-- Profesionales (IDRol 2)
INSERT INTO Usuario (Nombre, Apellido, Dni, Mail, ContraseniaHash, IDRol, Activo) VALUES
('Ana', 'Bianchi', '35111111', 'ana.bianchi@prof.com', @PassHash, 2, 1),
('Carla', 'Rossini', '35222222', 'carla.rossini@prof.com', @PassHash, 2, 1),
('Sofia', 'Mancini', '35333333', 'sofia.mancini@prof.com', @PassHash, 2, 1),
('Laura', 'Schneider', '36444444', 'laura.schneider@prof.com', @PassHash, 2, 1),
('Martina', 'Wagner', '36555555', 'martina.wagner@prof.com', @PassHash, 2, 1),
('Elena', 'Macedo', '36666666', 'elena.macedo@prof.com', @PassHash, 2, 1),
('Diego', 'Ferrara', '34111222', 'diego.ferrara@prof.com', @PassHash, 2, 1),
('Franco', 'Leone', '34222333', 'franco.leone@prof.com', @PassHash, 2, 1),
('Valentina', 'Rizzo', '37111333', 'valentina.rizzo@prof.com', @PassHash, 2, 1),
('Clara', 'Castro', '37222444', 'clara.castro@prof.com', @PassHash, 2, 1);
-- IDs: 4 a 13

-- Clientes (IDRol 3)
INSERT INTO Usuario (Nombre, Apellido, Dni, Mail, ContraseniaHash, IDRol, Activo) VALUES
('Maria', 'Gonzalez', '40111111', 'maria.gonzalez@cliente.com', @PassHash, 3, 1),
('Juan', 'Rodriguez', '40222222', 'juan.rodriguez@cliente.com', @PassHash, 3, 1),
('Florencia', 'Gomez', '40333333', 'flor.gomez@cliente.com', @PassHash, 3, 1),
('Pedro', 'Fernandez', '40444444', 'pedro.fernandez@cliente.com', @PassHash, 3, 1),
('Camila', 'Lopez', '40555555', 'camila.lopez@cliente.com', @PassHash, 3, 1),
('Martin', 'Diaz', '40666666', 'martin.diaz@cliente.com', @PassHash, 3, 1),
('Lucia', 'Martinez', '40777777', 'lucia.martinez@cliente.com', @PassHash, 3, 1),
('Agustin', 'Perez', '40888888', 'agustin.perez@cliente.com', @PassHash, 3, 1),
('Julieta', 'Sanchez', '40999999', 'julieta.sanchez@cliente.com', @PassHash, 3, 1),
('Nicolas', 'Romero', '41111111', 'nicolas.romero@cliente.com', @PassHash, 3, 1),
('Valeria', 'Acosta', '41222222', 'valeria.acosta@cliente.com', @PassHash, 3, 1),
('Matias', 'Suarez', '41333333', 'matias.suarez@cliente.com', @PassHash, 3, 1),
('Catalina', 'Alvarez', '41444444', 'catalina.alvarez@cliente.com', @PassHash, 3, 1),
('Bautista', 'Benitez', '41555555', 'bautista.benitez@cliente.com', @PassHash, 3, 1),
('Antonella', 'Ramirez', '41666666', 'antonella.ramirez@cliente.com', @PassHash, 3, 1),
('Facundo', 'Sosa', '41777777', 'facundo.sosa@cliente.com', @PassHash, 3, 1),
('Paula', 'Medina', '41888888', 'paula.medina@cliente.com', @PassHash, 3, 1),
('Enzo', 'Ruiz', '41999999', 'enzo.ruiz@cliente.com', @PassHash, 3, 1),
('Carolina', 'Castro', '42111111', 'carolina.castro@cliente.com', @PassHash, 3, 1),
('Leonardo', 'Torres', '42222222', 'leo.torres@cliente.com', @PassHash, 3, 1);
-- IDs: 14 a 33

-- 4. Sub-Tablas de Usuario 
INSERT INTO Administrador (IDUsuario) VALUES (1), (2), (3);

-- Profesionales 
INSERT INTO Profesional (IDUsuario) VALUES
(4), (5), (6), -- Manicuras
(7), (8), (9), -- Esteticistas
(10), (11),    -- Masajistas
(12), (13);    -- Lashistas

-- Clientes
INSERT INTO Cliente (IDUsuario, Domicilio, Telefono) VALUES
(14, 'Av. Rivadavia 1234', '1150001111'),(15, 'Calle Falsa 123', '1150002222'),
(16, 'Av. Corrientes 5678', '1150003333'),(17, 'Av. Santa Fe 910', '1150004444'),
(18, 'Bolivar 1', '1150005555'),(19, 'Av. de Mayo 333', '1150006666'),
(20, 'Florida 550', '1150007777'),(21, 'Defensa 210', '1150008888'),
(22, 'Peru 345', '1150009999'),(23, 'Av. Belgrano 789', '1150010000'),
(24, 'Av. Callao 1122', '1150011111'),(25, 'Paraguay 2020', '1150012222'),
(26, 'Uruguay 300', '1150013333'),(27, 'Talcahuano 450', '1150014444'),
(28, 'Esmeralda 600', '1150015555'),(29, 'Suipacha 700', '1150016666'),
(30, 'Carlos Pellegrini 800', '1150017777'),(31, 'Cerrito 900', '1150018888'),
(32, 'Libertad 1000', '1150019999'),(33, 'Av. 9 de Julio 1200', '1150020000');

-- 5. ProfesionalEspecialidad
INSERT INTO ProfesionalEspecialidad (IDUsuarioProfesional, IDEspecialidad) VALUES
(4, 1), (5, 1), (6, 1), -- Manicuras
(7, 2), (8, 2), (9, 2), -- Esteticistas
(10, 3), (11, 3),       -- Masajistas
(12, 4), (13, 4);       -- Lashistas

-- 6. Horarios de Atención
INSERT INTO HorarioAtencion (IDUsuarioProfesional, DiaSemana, HorarioInicio, HorarioFin, Activo) VALUES
(4, 'Lunes', '09:00:00', '18:00:00', 1),(4, 'Martes', '09:00:00', '18:00:00', 1),
(4, 'Miercoles', '09:00:00', '14:00:00', 1),(7, 'Miercoles', '10:00:00', '20:00:00', 1),
(7, 'Jueves', '10:00:00', '20:00:00', 1),(7, 'Viernes', '10:00:00', '20:00:00', 1),
(10, 'Lunes', '14:00:00', '21:00:00', 1),(10, 'Miercoles', '14:00:00', '21:00:00', 1),
(12, 'Jueves', '08:00:00', '16:00:00', 1),(12, 'Viernes', '08:00:00', '16:00:00', 1);

-- 7. Pagos 
-- IDs: 1-Seña, 2-Total
INSERT INTO Pago (FechaPago, Monto, IDTipoPago) VALUES
(DATEADD(day, -1, GETDATE()), 30000, 2), -- Pago 1 (Total)
(DATEADD(day, -1, GETDATE()), 8000, 1),   -- Pago 2 (Seña)
(DATEADD(day, -2, GETDATE()), 28000, 2), -- Pago 3 (Total)
(DATEADD(day, -3, GETDATE()), 15000, 2), -- Pago 4 (Total)
(DATEADD(day, -5, GETDATE()), 45000, 2), -- Pago 5 (Total)
(DATEADD(day, -1, GETDATE()), 10000, 1),  -- Pago 6 (Seña)
(DATEADD(day, -1, GETDATE()), 15000, 1),  -- Pago 7 (Seña)
(DATEADD(day, -1, GETDATE()), 15000, 1),  -- Pago 8 (Seña)
(CONVERT(date, GETDATE()), 10000, 1),  -- Pago 9 (Seña)
(DATEADD(day, -2, GETDATE()), 30000, 1);  -- Pago 10 (Seña)
-- IDs: 1 a 10

-- 8. Turnos
INSERT INTO Turno (Fecha, HoraInicio, IDUsuarioProfesional, IDUsuarioCliente, IDServicio, IDPago, IDEstado) VALUES
(DATEADD(day, 7, GETDATE()), '10:00:00', 4, 14, 3, 6, 1),
(DATEADD(day, -5, GETDATE()), '11:00:00', 7, 15, 9, 5, 4),
(DATEADD(day, 3, GETDATE()), '15:00:00', 10, 16, 18, 7, 2),
(DATEADD(day, 4, GETDATE()), '16:00:00', 12, 17, 23, 2, 1),
(DATEADD(day, -3, GETDATE()), '09:00:00', 4, 18, 1, 4, 4),
(DATEADD(day, -1, GETDATE()), '14:00:00', 7, 19, 11, 1, 4),
(DATEADD(day, 2, GETDATE()), '11:00:00', 10, 20, 19, 8, 3),
(CONVERT(date, GETDATE()), '17:00:00', 12, 21, 25, 9, 1),
(DATEADD(day, -2, GETDATE()), '13:00:00', 4, 22, 6, 3, 4),
(DATEADD(day, 10, GETDATE()), '10:00:00', 7, 23, 13, 10, 1);

-- Reactivamos todas las constraints
EXEC sp_MSforeachtable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL'
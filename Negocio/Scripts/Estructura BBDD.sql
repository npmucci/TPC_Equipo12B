CREATE DATABASE ESTETICA_BD;
GO
USE ESTETICA_BD;
GO

-- 1. Catálogos 
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
	IDRol INT NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Dni VARCHAR(20) UNIQUE NOT NULL,
	Telefono NVARCHAR(20) UNIQUE NOT NULL,
	Domicilio  VARCHAR(255) NULL,
    Mail VARCHAR(255) UNIQUE NOT NULL,
    ContraseniaHash VARCHAR(255) NOT NULL, 
	Foto NVARCHAR(255),
    Activo BIT NOT NULL DEFAULT 1,
	FOREIGN KEY (IDRol) REFERENCES Rol(IDRol)
    
);


-- 4. Catálogo de Especialidad
CREATE TABLE Especialidad (
    IDEspecialidad INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL UNIQUE,
    Descripcion VARCHAR(MAX),
	Foto VARCHAR (150),
	Activo BIT NOT NULL DEFAULT 1
);

-- 5. Catálogo de Servicios 
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

-- 6. Unión Usuario (Profesional) - Especialidad
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

--8 Turno
CREATE TABLE Turno (
    IDTurno INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATE NOT NULL,
    HoraInicio TIME NOT NULL,
    IDUsuarioProfesional INT NOT NULL,
    IDUsuarioCliente INT NOT NULL,
    IDServicio INT NOT NULL,
    IDEstado INT NOT NULL,
    FOREIGN KEY (IDUsuarioProfesional) REFERENCES Usuario(IDUsuario),
    FOREIGN KEY (IDUsuarioCliente) REFERENCES Usuario(IDUsuario),
    FOREIGN KEY (IDServicio) REFERENCES Servicio(IDServicio),
    FOREIGN KEY (IDEstado) REFERENCES EstadoTurno(IDEstado)
);

-- 9. Pagos 
CREATE TABLE Pago (
    IDPago INT IDENTITY(1,1) PRIMARY KEY,
	IDTurno INT NOT NULL,
    Fecha DATETIME NOT NULL DEFAULT GETDATE(),
	EsDevolucion BIT NOT NULL DEFAULT 0,
    Monto DECIMAL(10, 2) NOT NULL,
    IDTipoPago INT NOT NULL, 
    IDFormaPago INT NOT NULL,
	FOREIGN KEY (IDTurno) REFERENCES Turno(IDTurno),
    FOREIGN KEY (IDTipoPago) REFERENCES TipoPago(IDTipoPago),
    FOREIGN KEY (IDFormaPago) REFERENCES FormaPago(IDFormaPago)
);


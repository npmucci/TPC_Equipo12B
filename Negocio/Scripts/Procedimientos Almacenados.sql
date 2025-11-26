USE ESTETICA_BD
GO


-- SP USUARIOS

CREATE OR ALTER PROCEDURE ListarUsuariosPorRol
    @IDRol INT  -- siempre se pasa desde el codigo
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        U.IDUsuario,
        U.Nombre,
        U.Apellido,
        U.Dni,
        U.Telefono,
        U.Domicilio,
        U.Mail,
        U.Foto,
        U.Activo,
        U.IDRol
    FROM Usuario U
    WHERE
        (
            -- Si pido profesionales, incluyo tambien a ProfesionalUnico
            (@IDRol = 2 AND U.IDRol IN (2,5))
        )
        OR
        (
            -- Si pido ProfesionalUnico explicitamente
            (@IDRol = 5 AND U.IDRol = 5)
        )
        OR
        (
            -- Si pido cualquier otro rol
            (@IDRol NOT IN (2,5) AND U.IDRol = @IDRol)
        )
    ORDER BY U.Apellido, U.Nombre;
END
GO

CREATE OR ALTER PROCEDURE sp_RegistrarUsuario
    
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @Dni VARCHAR(20),
    @Telefono NVARCHAR(20),
    @Domicilio VARCHAR(255),
    @Mail VARCHAR(255),
    @Hash VARCHAR(255), 
    @Foto NVARCHAR(255),
    @IDRol INT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Usuario (
        Nombre, 
        Apellido, 
        Dni, 
        Telefono, 
        Domicilio, 
        Mail, 
        ContraseniaHash,  
        Foto, 
        Activo,           
        IDRol
    )
    VALUES (
        @Nombre, 
        @Apellido, 
        @Dni, 
        @Telefono, 
        @Domicilio, 
        @Mail, 
        @Hash,            
        @Foto, 
        1,               
        @IDRol
    );
    SELECT CAST(SCOPE_IDENTITY() AS INT);
END
GO


CREATE PROCEDURE sp_ModificarUsuario
(
    @IDUsuario INT,
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Telefono VARCHAR(20),
    @Domicilio VARCHAR(100),
    @Mail VARCHAR(100),
    @Dni VARCHAR(20),
    @Foto VARCHAR(255),
    @Activo BIT
)
AS
BEGIN
    UPDATE Usuario
    SET
        Nombre = @Nombre,
        Apellido = @Apellido,
        Telefono = @Telefono,
        Domicilio = @Domicilio,
        Mail = @Mail,
        Dni = @Dni,
        Foto = @Foto,
        Activo = @Activo
    WHERE IDUsuario = @IDUsuario;
END
GO

-- SP ESPECIALIDADES

CREATE or ALTER PROCEDURE ListarEspecialidades
AS
BEGIN
    SELECT IDEspecialidad, Nombre, Descripcion, Foto, Activo
    FROM Especialidad
    ORDER BY Nombre;
END
GO

CREATE OR ALTER PROCEDURE sp_AgregarEspecialidad
    @Nombre VARCHAR(100),
    @Descripcion VARCHAR(MAX),
    @Foto VARCHAR(150)
AS
BEGIN
    INSERT INTO Especialidad (Nombre, Descripcion, Foto, Activo)
    VALUES (@Nombre, @Descripcion, @Foto, 1)
END
GO

CREATE OR ALTER PROCEDURE sp_ModificarEspecialidad
    @ID INT,
    @Nombre VARCHAR(100),
    @Descripcion VARCHAR(MAX),
    @Foto VARCHAR(150),
    @Activo BIT
AS
BEGIN
    UPDATE Especialidad
    SET 
        Nombre = @Nombre,
        Descripcion = @Descripcion,
        Foto = @Foto,
        Activo = @Activo
    WHERE 
        IDEspecialidad = @ID
END
GO

CREATE OR ALTER PROCEDURE sp_EliminarLogicoEspecialidad
    @ID INT
AS
BEGIN
    UPDATE Especialidad
    SET 
        Activo = 0
    WHERE 
        IDEspecialidad = @ID
END
GO

-- SP SERVICIOS

CREATE OR ALTER PROCEDURE sp_AgregarServicio
    @IDEspecialidad INT,
    @Nombre VARCHAR(150),
    @Descripcion VARCHAR(MAX),
    @Precio DECIMAL(10, 2),
    @DuracionMinutos INT
AS
BEGIN
    INSERT INTO Servicio (IDEspecialidad, Nombre, Descripcion, Precio, DuracionMinutos, Activo)
    VALUES (@IDEspecialidad, @Nombre, @Descripcion, @Precio, @DuracionMinutos, 1)
END
GO

CREATE OR ALTER PROCEDURE sp_ModificarServicio
    @IDServicio INT,
    @IDEspecialidad INT,
    @Nombre VARCHAR(150),
    @Descripcion VARCHAR(MAX),
    @Precio DECIMAL(10, 2),
    @DuracionMinutos INT,
    @Activo BIT
AS
BEGIN
    UPDATE Servicio
    SET 
        IDEspecialidad = @IDEspecialidad,
        Nombre = @Nombre,
        Descripcion = @Descripcion,
        Precio = @Precio,
        DuracionMinutos = @DuracionMinutos,
        Activo = @Activo
    WHERE 
        IDServicio = @IDServicio
END
GO

CREATE OR ALTER PROCEDURE sp_EliminarLogicoServicio
    @IDServicio INT
AS
BEGIN
    UPDATE Servicio
    SET 
        Activo = 0
    WHERE 
        IDServicio = @IDServicio
END
GO

-- SP HORARIO ATENCION

CREATE PROCEDURE sp_AgregarHorario
    @IDUsuario INT,
    @DiaSemana VARCHAR(15),
    @HorarioInicio TIME,
    @HorarioFin TIME
AS
BEGIN
    INSERT INTO HorarioAtencion (IDUsuario, DiaSemana, HorarioInicio, HorarioFin, Activo)
    VALUES (@IDUsuario, @DiaSemana, @HorarioInicio, @HorarioFin, 1)
END
GO

CREATE PROCEDURE sp_ModificarHorario
    @IDHorarioAtencion INT,
    @DiaSemana VARCHAR(15),
    @HorarioInicio TIME,
   @HorarioFin TIME,
    @Activo BIT
AS
BEGIN
    UPDATE HorarioAtencion 
    SET 
        DiaSemana = @DiaSemana, 
        HorarioInicio = @HorarioInicio, 
        HorarioFin = @HorarioFin, 
        Activo = @Activo 
    WHERE 
        IDHorarioAtencion = @IDHorarioAtencion
END
GO

CREATE PROCEDURE sp_EliminarHorario
    @IDHorarioAtencion INT
AS
BEGIN
    -- Borrado físico, NO LOGICO
    DELETE FROM HorarioAtencion 
    WHERE IDHorarioAtencion = @IDHorarioAtencion
END
GO

--SP PARA TURNOS

CREATE or ALTER PROCEDURE sp_ListarTurnosCliente
    @IDCliente INT 
AS
BEGIN
    SELECT 
        T.IDTurno,
        T.Fecha,
        T.HoraInicio,
        T.IDEstado,
        E.Descripcion AS EstadoDescripcion,
        P.Nombre AS NombreProfesional,
        P.Apellido AS ApellidoProfesional,
        C.Nombre AS NombreCliente,
        C.Apellido AS ApellidoCliente,
        S.Nombre AS Servicio
    FROM Turno T
    INNER JOIN Usuario C
        ON T.IDUsuarioCliente = C.IDUsuario
    INNER JOIN Usuario P
        ON T.IDUsuarioProfesional = P.IDUsuario
    INNER JOIN Servicio S
        ON T.IDServicio = S.IDServicio
    INNER JOIN EstadoTurno E
        ON T.IDEstado = E.IDEstado
    WHERE C.IDUsuario = @IDCliente  
    ORDER BY T.Fecha, T.HoraInicio;
END
GO

-- 2. Obtener un turno por ID
CREATE OR ALTER PROCEDURE sp_ObtenerTurnoPorID
    @IDTurno INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT
        T.IDTurno,
        T.Fecha,
        T.HoraInicio,
        T.IDEstado,
        T.IDUsuarioCliente,     
        T.IDUsuarioProfesional,  
        T.IDServicio,            
        E.Descripcion AS DescripcionEstado,
        P.Nombre AS NombreProfesional,
        P.Apellido AS ApellidoProfesional,
        C.Nombre AS NombreCliente,
        C.Apellido AS ApellidoCliente,
        C.Telefono AS TelefonoCliente,
        C.Mail AS EmailCliente,
        C.Domicilio AS DomicilioCliente,
        S.Nombre AS Servicio
    FROM Turno T
    INNER JOIN Usuario P ON T.IDUsuarioProfesional = P.IDUsuario
    INNER JOIN Usuario C ON T.IDUsuarioCliente = C.IDUsuario
    INNER JOIN Servicio S ON T.IDServicio = S.IDServicio
    INNER JOIN EstadoTurno E ON T.IDEstado = E.IDEstado
    WHERE T.IDTurno = @IDTurno;
END
GO

CREATE OR ALTER PROCEDURE sp_ListarTodosLosTurnos
AS
BEGIN
    SELECT 
        T.IDTurno,
        T.Fecha,
        T.HoraInicio,
        T.IDEstado,
        E.Descripcion AS DescripcionEstado,
        P.Nombre AS NombreProfesional,
        P.Apellido AS ApellidoProfesional,
        C.Nombre AS NombreCliente,
        C.Apellido AS ApellidoCliente,
		T.IDUsuarioProfesional, 
        T.IDUsuarioCliente,     
        S.Nombre AS Servicio
    FROM Turno T
    INNER JOIN Usuario P
        ON T.IDUsuarioProfesional = P.IDUsuario
    INNER JOIN Usuario C
        ON T.IDUsuarioCliente = C.IDUsuario
    INNER JOIN Servicio S
        ON T.IDServicio = S.IDServicio
    INNER JOIN EstadoTurno E
        ON T.IDEstado = E.IDEstado
    ORDER BY T.Fecha, T.HoraInicio;
END
GO

CREATE OR ALTER PROCEDURE sp_ListarTurnosParaDevolucion
AS
BEGIN
    SELECT 
        T.IDTurno,
        T.Fecha,
        T.HoraInicio,
        T.IDEstado,
        E.Descripcion AS DescripcionEstado,
        T.IDUsuarioProfesional, T.IDUsuarioCliente, T.IDServicio, 
        P.Nombre AS NombreProfesional,
        P.Apellido AS ApellidoProfesional,
        C.Nombre AS NombreCliente,
        C.Apellido AS ApellidoCliente,
        S.Nombre AS Servicio,
        S.DuracionMinutos,
        ISNULL((SELECT SUM(Monto) FROM Pago WHERE IDTurno = T.IDTurno AND EsDevolucion = 0), 0) as TotalPagado
    FROM Turno T
    INNER JOIN Usuario C ON T.IDUsuarioCliente = C.IDUsuario
    INNER JOIN Usuario P ON T.IDUsuarioProfesional = P.IDUsuario
    INNER JOIN Servicio S ON T.IDServicio = S.IDServicio
    INNER JOIN EstadoTurno E ON T.IDEstado = E.IDEstado
    WHERE E.Descripcion = 'Solicitud de Devolución' 
    ORDER BY T.Fecha ASC;
END
GO

CREATE PROCEDURE sp_contarTurnos
    @IDProfesional INT,
    @FechaInicio DATE,
    @FechaFin DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        COUNT(T.IDTurno) AS CantidadTurnos
    FROM 
        Turno T
    WHERE 
        T.IDUsuarioProfesional = @IDProfesional
        AND T.Fecha >= @FechaInicio
        AND T.Fecha <= @FechaFin
        AND T.IDEstado IN (1, 3);  
END
GO

CREATE OR ALTER PROCEDURE sp_ListarTurnosPorProfesionalYFecha
    @IDProfesional INT,
    @FechaInicio DATE,
	@FechaFin DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        T.IDTurno,
        T.Fecha,
        T.HoraInicio,
        T.IDEstado,
        E.Descripcion AS DescripcionEstado,
        T.IDUsuarioProfesional,
        T.IDUsuarioCliente,
        T.IDServicio,
        S.Nombre AS Servicio,
        S.DuracionMinutos, 
        P.Nombre AS NombreProfesional,
        P.Apellido AS ApellidoProfesional,
        C.Nombre AS NombreCliente,
        C.Apellido AS ApellidoCliente
    FROM Turno T
    INNER JOIN Usuario P ON T.IDUsuarioProfesional = P.IDUsuario
    INNER JOIN Usuario C ON T.IDUsuarioCliente = C.IDUsuario
    INNER JOIN Servicio S ON T.IDServicio = S.IDServicio
    INNER JOIN EstadoTurno E ON T.IDEstado = E.IDEstado
    WHERE 
        T.IDUsuarioProfesional = @IDProfesional 
        AND T.Fecha BETWEEN @FechaInicio AND @FechaFin
        AND T.IDEstado IN (1, 2) 
    ORDER BY T.HoraInicio;
END
GO

--sp para pagos
    
CREATE OR ALTER PROCEDURE sp_ListarPagosPorTurno
    @IDTurno INT
AS
BEGIN
    SELECT 
        p.IDPago,
        p.IDTurno,
        p.Fecha,
        p.EsDevolucion,
        p.Monto,
        p.CodigoTransaccion,  
        p.IDTipoPago,
        tp.Nombre AS TipoPagoDescripcion,
        p.IDFormaPago,
        fp.Nombre AS FormaPagoDescripcion
    FROM Pago p
    LEFT JOIN TipoPago tp ON p.IDTipoPago = tp.IDTipoPago
    LEFT JOIN FormaPago fp ON p.IDFormaPago = fp.IDFormaPago
    WHERE p.IDTurno = @IDTurno
END
GO
    
CREATE  PROCEDURE sp_AgregarPago
    @IDTurno INT,
    @Fecha DATETIME,
    @EsDevolucion BIT,
    @Monto DECIMAL(10,2),
    @IDTipoPago INT,
    @IDFormaPago INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Pago (IDTurno, Fecha, EsDevolucion, Monto, IDTipoPago, IDFormaPago)
    VALUES (@IDTurno, @Fecha, @EsDevolucion, @Monto, @IDTipoPago, @IDFormaPago);
END
GO

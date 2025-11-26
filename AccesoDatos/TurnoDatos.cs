using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;


namespace AccesoDatos
{
    public class TurnoDatos
    {
        PagoDatos pagoDatos = new PagoDatos();
        public List<Turno> ListarTodos()
        {

            List<Turno> lista = new List<Turno>();
            using (Datos datos = new Datos())
            {
                datos.SetearProcedimiento("sp_ListarTodosLosTurnos");
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Turno aux = new Turno();
                    aux.IDTurno = (int)datos.Lector["IDTurno"];
                    aux.Fecha = ((DateTime)datos.Lector["Fecha"]).Date;
                    aux.HoraInicio = (TimeSpan)datos.Lector["HoraInicio"];

                    aux.Cliente = new Cliente()
                    {
                        Nombre = (string)datos.Lector["NombreCliente"],
                        Apellido = (string)datos.Lector["ApellidoCliente"]
                    };

                    aux.Profesional = new Profesional()
                    {
                        Nombre = (string)datos.Lector["NombreProfesional"],
                        Apellido = (string)datos.Lector["ApellidoProfesional"]
                    };

                    aux.Servicio = new Servicio()
                    {
                        Nombre = (string)datos.Lector["Servicio"],
                        Precio = (decimal)datos.Lector["PrecioServicio"]
                    };

                    aux.Estado = new EstadoTurno
                    {
                        IDEstado = (int)datos.Lector["IDEstado"],
                        Descripcion = (string)datos.Lector["DescripcionEstado"]
                    };

                    // Cargar pagos del turno 
                    aux.Pago = pagoDatos.ListarPagosDelTurno(aux.IDTurno);

                    lista.Add(aux);
                }
            }

            return lista;
        }

        public List<Turno> ListarPorProfesionalYFecha(int idProf, DateTime fechaInicio, DateTime fechaFin)
        {
            List<Turno> lista = new List<Turno>();
            using (Datos datos = new Datos())
            {
                try
                {
                    datos.SetearProcedimiento("sp_ListarTurnosPorProfesionalYFecha");
                    datos.SetearParametro("@IDProfesional", idProf);
                    datos.SetearParametro("@FechaInicio", fechaInicio);
                    datos.SetearParametro("@FechaFin", fechaFin);
                    datos.EjecutarLectura();

                    while (datos.Lector.Read())
                    {
                        Turno aux = new Turno();
                        aux.IDTurno = (int)datos.Lector["IDTurno"];
                        aux.Fecha = ((DateTime)datos.Lector["Fecha"]).Date;
                        aux.HoraInicio = (TimeSpan)datos.Lector["HoraInicio"];


                        aux.Profesional = new Profesional();
                        aux.Profesional.ID = (int)datos.Lector["IDUsuarioProfesional"];
                        aux.Profesional.Nombre = (string)datos.Lector["NombreProfesional"];
                        aux.Profesional.Apellido = (string)datos.Lector["ApellidoProfesional"];


                        aux.Servicio = new Servicio();
                        aux.Servicio.IDServicio = (int)datos.Lector["IDServicio"];
                        aux.Servicio.Nombre = (string)datos.Lector["Servicio"];
                        aux.Servicio.DuracionMinutos = (int)datos.Lector["DuracionMinutos"];


                        aux.Estado = new EstadoTurno();
                        aux.Estado.IDEstado = (int)datos.Lector["IDEstado"];
                        aux.Estado.Descripcion = (string)datos.Lector["DescripcionEstado"];


                        aux.Cliente = new Cliente();
                        aux.Cliente.ID = (int)datos.Lector["IDUsuarioCliente"];
                        aux.Cliente.Nombre = (string)datos.Lector["NombreCliente"];
                        aux.Cliente.Apellido = (string)datos.Lector["ApellidoCliente"];

                        lista.Add(aux);
                    }
                    return lista;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }


        public Turno BuscarTurnoPorId(int idTurno)
        {
            Turno turno = null;
            using (Datos datos = new Datos())
            {
                try
                {
                    datos.SetearProcedimiento("sp_ObtenerTurnoPorID");
                    datos.SetearParametro("@IDTurno", idTurno);
                    datos.EjecutarLectura();
                    if (datos.Lector.Read())
                    {
                        turno = new Turno();
                        turno.IDTurno = (int)datos.Lector["IDTurno"];
                        turno.Fecha = ((DateTime)datos.Lector["Fecha"]).Date;
                        turno.HoraInicio = (TimeSpan)datos.Lector["HoraInicio"];
                        turno.Cliente = new Cliente()
                        {
                            ID = (int)datos.Lector["IDUsuarioCliente"],                                        
                            Nombre = (string)datos.Lector["NombreCliente"],
                            Apellido = (string)datos.Lector["ApellidoCliente"],
                            Mail = (string)datos.Lector["EmailCliente"] 
                        };
                        turno.Profesional = new Profesional()
                        {
                            ID = (int)datos.Lector["IDUsuarioProfesional"],
                            Nombre = (string)datos.Lector["NombreProfesional"],
                            Apellido = (string)datos.Lector["ApellidoProfesional"]
                        };
                        turno.Servicio = new Servicio()
                        {
                            Nombre = (string)datos.Lector["Servicio"],
                            Precio = (decimal)datos.Lector["PrecioServicio"]
                        };

                        turno.Estado = new EstadoTurno
                        {
                            IDEstado = (int)datos.Lector["IDEstado"],
                            Descripcion = (string)datos.Lector["DescripcionEstado"]
                        };
                        // Cargar pagos del turno 
                        turno.Pago = pagoDatos.ListarPagosDelTurno(turno.IDTurno);
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return turno;
        }
        public List<Turno> ListarTurnosCliente(int idCliente)
        {
            List<Turno> lista = new List<Turno>();

            using (Datos datos = new Datos())
            {
                try
                {
                    datos.SetearProcedimiento("sp_ListarTurnosCliente");
                    datos.SetearParametro("@IDCliente", idCliente);
                    datos.EjecutarLectura();

                    while (datos.Lector.Read())
                    {
                        Turno aux = new Turno();
                        aux.IDTurno = (int)datos.Lector["IDTurno"];
                        aux.Fecha = ((DateTime)datos.Lector["Fecha"]).Date;
                        aux.HoraInicio = (TimeSpan)datos.Lector["HoraInicio"];

                        aux.Profesional = new Profesional()
                        {
                            Nombre = (string)datos.Lector["NombreProfesional"],
                            Apellido = (string)datos.Lector["ApellidoProfesional"]
                        };


                        aux.Servicio = new Servicio()
                        {
                            Nombre = (string)datos.Lector["Servicio"],
                        };

                        aux.Estado = new EstadoTurno
                        {
                            IDEstado = (int)datos.Lector["IDEstado"],
                            Descripcion = (string)datos.Lector["EstadoDescripcion"]
                        };


                        aux.Pago = pagoDatos.ListarPagosDelTurno(aux.IDTurno);


                        lista.Add(aux);
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }

            return lista;
        }



        public bool TieneTurnosPendientesPorProfesional(int idProfesional)
        {
            using (Datos datos = new Datos())
            {
                try
                {

                    string consulta = @"
                        SELECT COUNT(*) 
                        FROM Turno 
                        WHERE IDUsuarioProfesional = @idProf 
                          AND IDEstado IN (1, 2) -- 1=Confirmado, 2=Pendiente
                          AND (CAST(Fecha AS DATETIME) + CAST(HoraInicio AS DATETIME)) > GETDATE()";

                    datos.SetearConsulta(consulta);
                    datos.SetearParametro("@idProf", idProfesional);


                    int cantidad = (int)datos.EjecutarAccionEscalar();

                    return cantidad > 0;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        public bool TieneTurnosPendientesPorServicio(int idServicio)
        {
            using (Datos datos = new Datos())
            {
                try
                {
                    string consulta = @"
                        SELECT COUNT(*) 
                        FROM Turno 
                        WHERE IDServicio = @idServicio 
                          AND IDEstado IN (1, 2) -- 1=Confirmado, 2=Pendiente
                          AND (CAST(Fecha AS DATETIME) + CAST(HoraInicio AS DATETIME)) > GETDATE()";

                    datos.SetearConsulta(consulta);
                    datos.SetearParametro("@idServicio", idServicio);

                    int cantidad = (int)datos.EjecutarAccionEscalar();

                    return cantidad > 0;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        public void CambiarEstado(int idTurno, int idEstado)
        {
            using (Datos datos = new Datos())
            {
                try
                {

                    string consulta = "UPDATE Turno SET IDEstado = @idEstado WHERE IDTurno = @idTurno";
                    datos.SetearConsulta(consulta);
                    datos.SetearParametro("@idEstado", idEstado);
                    datos.SetearParametro("@idTurno", idTurno);
                    datos.EjecutarAccion();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        public List<Turno> ListarTurnosPendientesPorProfesional(int idProfesional)
        {
            List<Turno> lista = new List<Turno>();
            using (Datos datos = new Datos())
            {
                try
                {
                    string consulta = @"SELECT T.IDTurno, T.Fecha,  T.HoraInicio,T.IDEstado, TE.Descripcion AS EstadoNombre,S.Nombre AS ServicioNombre, C.Nombre AS ClienteNombre,  C.Apellido AS ClienteApellido
                FROM Turno T
                INNER JOIN Servicio S ON T.IDServicio = S.IDServicio
                INNER JOIN Usuario C ON T.IDUsuarioCliente = C.IDUsuario
                INNER JOIN EstadoTurno TE ON T.IDEstado = TE.IDEstado
                WHERE T.IDUsuarioProfesional = @idProf 
                    AND T.IDEstado IN (1, 2) -- 1=Confirmado, 2=Pendiente 
                    AND (CAST(T.Fecha AS DATETIME) + CAST(T.HoraInicio AS DATETIME)) > GETDATE()
                ORDER BY T.Fecha, T.HoraInicio ASC";

                    datos.SetearConsulta(consulta);
                    datos.SetearParametro("@idProf", idProfesional);
                    datos.EjecutarLectura();

                    while (datos.Lector.Read())
                    {
                        Turno aux = new Turno();
                        aux.IDTurno = (int)datos.Lector["IDTurno"];

                        DateTime fecha = (DateTime)datos.Lector["Fecha"];
                        TimeSpan hora = (TimeSpan)datos.Lector["HoraInicio"];

                        aux.Fecha = fecha.Add(hora);
                        aux.HoraInicio = hora;

                        aux.Estado = new EstadoTurno
                        {
                            IDEstado = (int)datos.Lector["IDEstado"],
                            Descripcion = (string)datos.Lector["EstadoNombre"]
                        };

                        aux.Servicio = new Servicio
                        {
                            Nombre = (string)datos.Lector["ServicioNombre"]
                        };

                        aux.Cliente = new Cliente
                        {
                            Nombre = (string)datos.Lector["ClienteNombre"],
                            Apellido = (string)datos.Lector["ClienteApellido"]
                        };

                        lista.Add(aux);
                    }

                    return lista;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        public bool TieneTurnosPendientesPorEspecialidad(int idProfesional, int idEspecialidad)
        {
            using (Datos datos = new Datos())
            {
                try
                {

                    string consulta = @"
                     SELECT COUNT(*) 
                     FROM Turno T
                     INNER JOIN Servicio S ON T.IDServicio = S.IDServicio
                     WHERE T.IDUsuarioProfesional = @idProf 
                     AND S.IDEspecialidad = @idEsp
                     AND T.IDEstado IN (1, 2) -- 1=Confirmado, 2=Pendiente
                     AND (CAST(T.Fecha AS DATETIME) + CAST(T.HoraInicio AS DATETIME)) > GETDATE()";

                    datos.SetearConsulta(consulta);
                    datos.SetearParametro("@idProf", idProfesional);
                    datos.SetearParametro("@idEsp", idEspecialidad);

                    int cantidad = (int)datos.EjecutarAccionEscalar();
                    return cantidad > 0;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }
        public int ContarTurnos(DateTime fechaInicio, DateTime fechaFin, int idProfesional)
        {
            int cantidad = 0;
            using (Datos datos = new Datos())
            {

                datos.SetearProcedimiento("sp_contarTurnos");
                datos.SetearParametro("@IDProfesional", idProfesional);
                datos.SetearParametro("@FechaInicio", fechaInicio.Date);
                datos.SetearParametro("@FechaFin", fechaFin.Date);

                cantidad = datos.EjecutarAccionEscalar();



                return cantidad;
            }
        }

        public int ContarTotalPendientes()
        {
            using (Datos datos = new Datos())
            {
                try
                {

                    string consulta = "SELECT COUNT(*) FROM Turno WHERE IDEstado = 2";

                    datos.SetearConsulta(consulta);
                    return (int)datos.EjecutarAccionEscalar();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        public List<EstadoTurno> ListarEstados()
        {
            List<EstadoTurno> lista = new List<EstadoTurno>();
            using (Datos datos = new Datos())
            {
                try
                {
                    datos.SetearConsulta("SELECT * FROM EstadoTurno");
                    datos.EjecutarLectura();
                    while (datos.Lector.Read())
                    {
                        EstadoTurno aux = new EstadoTurno();

                        aux.IDEstado = (int)datos.Lector["IDEstado"];
                        aux.Descripcion = (string)datos.Lector["Descripcion"];
                        lista.Add(aux);
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return lista;
        }

        public List<FormaPago> ListarFormasPago()
        {
            List<FormaPago> lista = new List<FormaPago>();
            using (Datos datos = new Datos())
            {
                try
                {
                    datos.SetearConsulta("SELECT * FROM FormaPago");
                    datos.EjecutarLectura();
                    while (datos.Lector.Read())
                    {
                        FormaPago aux = new FormaPago();
                        aux.IDFormaPago = (int)datos.Lector["IDFormaPago"];
                        aux.Descripcion = (string)datos.Lector["Nombre"];
                        lista.Add(aux);
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return lista;
        }

        public List<TipoPago> ListarTiposPago()
        {
            List<TipoPago> lista = new List<TipoPago>();
            using (Datos datos = new Datos())
            {
                try
                {
                    datos.SetearConsulta("SELECT * FROM TipoPago");
                    datos.EjecutarLectura();
                    while (datos.Lector.Read())
                    {
                        TipoPago aux = new TipoPago();
                        aux.IDTipoPago = (int)datos.Lector["IDTipoPago"];
                        aux.Descripcion = (string)datos.Lector["Nombre"];
                        lista.Add(aux);
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return lista;
        }

        public void Agregar(Turno nuevo, Pago primerPago)
        {
            Datos datosTurno = new Datos();
            Datos datosPago = new Datos();

            try
            {

                datosTurno.SetearConsulta("INSERT INTO Turno (Fecha, HoraInicio, IDUsuarioCliente, IDUsuarioProfesional, IDServicio, IDEstado) OUTPUT INSERTED.IDTurno VALUES (@Fecha, @Hora, @Cliente, @Prof, @Serv, @Estado)");
                datosTurno.SetearParametro("@Fecha", nuevo.Fecha);
                datosTurno.SetearParametro("@Hora", nuevo.HoraInicio);
                datosTurno.SetearParametro("@Cliente", nuevo.Cliente.ID);
                datosTurno.SetearParametro("@Prof", nuevo.Profesional.ID);
                datosTurno.SetearParametro("@Serv", nuevo.Servicio.IDServicio);
                datosTurno.SetearParametro("@Estado", nuevo.Estado.IDEstado);

                int idTurno = (int)datosTurno.EjecutarAccionEscalar();


                datosPago.SetearConsulta("INSERT INTO Pago (IDTurno, Fecha, Monto, EsDevolucion, IDTipoPago, IDFormaPago, CodigoTransaccion) VALUES (@IDTurno, @Fecha, @Monto, 0, @Tipo, @Forma, @Cod)");

                datosPago.SetearParametro("@IDTurno", idTurno);
                datosPago.SetearParametro("@Fecha", primerPago.Fecha);
                datosPago.SetearParametro("@Monto", primerPago.Monto);
                datosPago.SetearParametro("@Tipo", primerPago.Tipo.IDTipoPago);
                datosPago.SetearParametro("@Forma", primerPago.FormaDePago.IDFormaPago);

                if (string.IsNullOrEmpty(primerPago.CodigoTransaccion))
                    datosPago.SetearParametro("@Cod", DBNull.Value);
                else
                    datosPago.SetearParametro("@Cod", primerPago.CodigoTransaccion);

                datosPago.EjecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datosTurno.CerrarConexion();
                datosPago.CerrarConexion();
            }
        }

        public List<Turno> ListarTurnosParaDevolucion()
        {
            List<Turno> lista = new List<Turno>();
            using (Datos datos = new Datos())
            {
                try
                {
                    datos.SetearProcedimiento("sp_ListarTurnosParaDevolucion");
                    datos.EjecutarLectura();

                    while (datos.Lector.Read())
                    {
                        Turno aux = new Turno();
                        aux.IDTurno = (int)datos.Lector["IDTurno"];
                        aux.Fecha = ((DateTime)datos.Lector["Fecha"]).Date;
                        aux.HoraInicio = (TimeSpan)datos.Lector["HoraInicio"];


                        aux.Cliente = new Cliente
                        {
                            ID = (int)datos.Lector["IDUsuarioCliente"],
                            Nombre = (string)datos.Lector["NombreCliente"],
                            Apellido = (string)datos.Lector["ApellidoCliente"],
                            Telefono = (string)datos.Lector["TelefonoCliente"],
                            Mail = (string)datos.Lector["EmailCliente"]
                        };
                        aux.Profesional = new Profesional
                        {
                            ID = (int)datos.Lector["IDUsuarioProfesional"],
                            Nombre = (string)datos.Lector["NombreProfesional"],
                            Apellido = (string)datos.Lector["ApellidoProfesional"]
                        };
                        aux.Servicio = new Servicio
                        {
                            IDServicio = (int)datos.Lector["IDServicio"],
                            Nombre = (string)datos.Lector["Servicio"]
                        };
                        aux.Estado = new EstadoTurno
                        {
                            IDEstado = (int)datos.Lector["IDEstado"],
                            Descripcion = (string)datos.Lector["DescripcionEstado"]
                        };


                        Pago pagoInfo = new Pago();
                        pagoInfo.Monto = (decimal)datos.Lector["TotalPagado"];
                        aux.Pago = new List<Pago> { pagoInfo };

                        lista.Add(aux);
                    }
                    return lista;
                }
                catch (Exception ex) { throw ex; }
            }
        }

        public List<Turno> FiltrarTurnos(int idEstado, int idEspecialidad, int idProfesional, int idServicio)
        {
            List<Turno> lista = new List<Turno>();

            using (Datos datos = new Datos())
            {
                try
                {
                    // Armamos la consulta base
                    string consulta =
                        "SELECT T.IDTurno, T.Fecha, T.HoraInicio, T.IDEstado, T.IDServicio, " +
                        "T.IDUsuarioProfesional, T.IDUsuarioCliente, " +
                        "E.Descripcion AS EstadoDesc, " +
                        "P.Nombre AS ProfNombre, P.Apellido AS ProfApellido, " +
                        "C.Nombre AS CliNombre, C.Apellido AS CliApellido, " +
                        "S.Nombre AS ServNombre, S.IDEspecialidad " +
                        "FROM Turno T " +
                        "INNER JOIN EstadoTurno E ON E.IDEstado = T.IDEstado " +
                        "INNER JOIN Usuario C ON C.IDUsuario = T.IDUsuarioCliente " +
                        "INNER JOIN Usuario P ON P.IDUsuario = T.IDUsuarioProfesional " +
                        "INNER JOIN Servicio S ON S.IDServicio = T.IDServicio " +
                        "WHERE 1 = 1 ";

                    // Lista de condiciones dinámicas
                    List<string> condiciones = new List<string>();

                    if (idEstado != 0)
                        condiciones.Add("T.IDEstado = @IDEstado");

                    if (idEspecialidad != 0)
                        condiciones.Add("S.IDEspecialidad = @IDEspecialidad");

                    if (idProfesional != 0)
                        condiciones.Add("T.IDUsuarioProfesional = @IDProfesional");

                    if (idServicio != 0)
                        condiciones.Add("T.IDServicio = @IDServicio");

                    // Si hay condiciones, las agregamos
                    if (condiciones.Count > 0)
                    {
                        consulta += " AND " + string.Join(" AND ", condiciones);
                    }

                    consulta += " ORDER BY T.Fecha DESC, T.HoraInicio DESC";

                    datos.SetearConsulta(consulta);

                    // Parámetros
                    if (idEstado != 0)
                        datos.SetearParametro("@IDEstado", idEstado);

                    if (idEspecialidad != 0)
                        datos.SetearParametro("@IDEspecialidad", idEspecialidad);

                    if (idProfesional != 0)
                        datos.SetearParametro("@IDProfesional", idProfesional);

                    if (idServicio != 0)
                        datos.SetearParametro("@IDServicio", idServicio);

                    datos.EjecutarLectura();

                    while (datos.Lector.Read())
                    {
                        lista.Add(new Turno
                        {
                            IDTurno = (int)datos.Lector["IDTurno"],
                            Fecha = (DateTime)datos.Lector["Fecha"],
                            HoraInicio = (TimeSpan)datos.Lector["HoraInicio"],

                            Estado = new EstadoTurno
                            {
                                IDEstado = (int)datos.Lector["IDEstado"],
                                Descripcion = (string)datos.Lector["EstadoDesc"]
                            },

                            Servicio = new Servicio
                            {
                                IDServicio = (int)datos.Lector["IDServicio"],
                                Nombre = (string)datos.Lector["ServNombre"]
                            },

                            Cliente = new Cliente
                            {
                                ID = (int)datos.Lector["IDUsuarioCliente"],
                                Nombre = (string)datos.Lector["CliNombre"],
                                Apellido = (string)datos.Lector["CliApellido"]
                            },

                            Profesional = new Profesional
                            {
                                ID = (int)datos.Lector["IDUsuarioProfesional"],
                                Nombre = (string)datos.Lector["ProfNombre"],
                                Apellido = (string)datos.Lector["ProfApellido"]
                            }
                        });
                    }

                    return lista;
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al filtrar turnos en la BBDD: " + ex.Message);
                }
            }
        }


    }

}


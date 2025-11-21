using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;
using Dominio.Enum;

namespace AccesoDatos
{
    public class TurnoDatos
    {
        public List<Turno> ListarTodos()
        {
            List<Turno> lista = new List<Turno>();
            using (Datos datos = new Datos())
            {
                try
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
                        };

                        aux.Pago = new Pago()
                        {
                            Monto = (decimal)datos.Lector["Monto"],
                            FormaDePago = (FormaPago)(int)datos.Lector["IDFormaPago"],
                            Tipo = (TipoPago)(int)datos.Lector["IDTipoPago"],
                            FechaPago = ((DateTime)datos.Lector["FechaPago"]).Date
                        };

                        aux.Estado = (EstadoTurno)(int)datos.Lector["IDEstado"];
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
                        aux.Fecha = ((DateTime)datos.Lector["Fecha"]).Date; // para que no muestra la hora
                        aux.HoraInicio = (TimeSpan)datos.Lector["HoraInicio"];
                        aux.Profesional = new Profesional()
                        {

                            Nombre = (string)datos.Lector["Nombre"],
                            Apellido = (string)datos.Lector["Apellido"]
                        };
                        aux.Servicio = new Servicio()
                        {
                            Nombre = (string)datos.Lector["Servicio"],
                        };

                        aux.Estado = (EstadoTurno)(int)datos.Lector["IDEstado"];


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

                    string consulta = @"
                        SELECT 
                            T.IDTurno, T.Fecha, T.HoraInicio,
                            T.IDEstado, TE.Descripcion AS EstadoNombre,
                            S.Nombre AS ServicioNombre,
                            C.Nombre AS ClienteNombre, C.Apellido AS ClienteApellido
                             FROM Turno T
                             INNER JOIN Servicio S ON T.IDServicio = S.IDServicio
                             INNER JOIN Usuario C ON T.IDUsuarioCliente = C.IDUsuario
                             INNER JOIN EstadoTurno TE ON T.IDEstado = TE.IDEstado
                             WHERE T.IDUsuarioProfesional = @idProf 
                             AND T.IDEstado IN (1, 2) -- 1=Confirmado, 2=Pendiente (según tu script)
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
                        aux.Estado = (EstadoTurno)(int)datos.Lector["IDEstado"];
                        aux.Servicio = new Servicio();
                        aux.Servicio.Nombre = (string)datos.Lector["ServicioNombre"];
                        aux.Cliente = new Cliente();
                        aux.Cliente.Nombre = (string)datos.Lector["ClienteNombre"];
                        aux.Cliente.Apellido = (string)datos.Lector["ClienteApellido"];

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

        public decimal ObtenerIngresos(DateTime fechaInicio, DateTime fechaFin, int idProfesional)
        {
            
            using (Datos datos = new Datos())
            {
            
                datos.SetearProcedimiento("sp_ObtenerIngresos");
                            
                datos.SetearParametro("@IDProfesional", idProfesional);
                datos.SetearParametro("@FechaInicio", fechaInicio.Date); 
                datos.SetearParametro("@FechaFin", fechaFin.Date);       

              
                decimal resultado = datos.EjecutarAccionEscalar();

               
                return resultado;
            }
        }
    }
}

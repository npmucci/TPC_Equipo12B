using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AccesoDatos
{
    public class ServicioDatos
    {
        public List<Servicio> Listar()
        {
            List<Servicio> lista = new List<Servicio>();

            using (Datos datos = new Datos())
            {
                try
                {
                    
                    string consulta = @"
                        SELECT 
                            S.IDServicio, S.Nombre, S.Descripcion, S.Precio, 
                            S.DuracionMinutos, S.Activo,
                            E.IDEspecialidad, E.Nombre AS NombreEspecialidad, E.Activo AS EspecialidadActivo
                        FROM Servicio S
                        INNER JOIN Especialidad E ON S.IDEspecialidad = E.IDEspecialidad";

                    datos.SetearConsulta(consulta);
                    datos.EjecutarLectura();

                    while (datos.Lector.Read())
                    {
                        Servicio aux = new Servicio();
                        aux.IDServicio = (int)datos.Lector["IDServicio"];
                        aux.Nombre = (string)datos.Lector["Nombre"];

                        if (!(datos.Lector["Descripcion"] is DBNull))
                            aux.Descripcion = (string)datos.Lector["Descripcion"];

                        aux.Precio = (decimal)datos.Lector["Precio"];
                        aux.DuracionMinutos = (int)datos.Lector["DuracionMinutos"];
                        aux.Activo = (bool)datos.Lector["Activo"];

                        aux.Especialidad = new Especialidad();
                        aux.Especialidad.IDEspecialidad = (int)datos.Lector["IDEspecialidad"];
                        aux.Especialidad.Nombre = (string)datos.Lector["NombreEspecialidad"];

                        
                        aux.Especialidad.Activo = (bool)datos.Lector["EspecialidadActivo"];

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


        public List<Servicio> ListarPorEspecialidad(int idEspecialidad)
        {
            // (Este es el que usa el Admin, trae activos e inactivos)
            List<Servicio> lista = new List<Servicio>();

            using (Datos datos = new Datos())
            {
                try
                {
                    
                    string consulta = @"
                        SELECT 
                            S.IDServicio, S.Nombre, S.Descripcion, S.Precio, 
                            S.DuracionMinutos, S.Activo,
                            E.IDEspecialidad, E.Nombre AS NombreEspecialidad, E.Activo AS EspecialidadActivo
                        FROM Servicio S
                        INNER JOIN Especialidad E ON S.IDEspecialidad = E.IDEspecialidad
                        WHERE S.IDEspecialidad = @idEspecialidad";

                    datos.SetearConsulta(consulta);
                    datos.SetearParametro("@idEspecialidad", idEspecialidad);
                    datos.EjecutarLectura();

                    while (datos.Lector.Read())
                    {
                        Servicio aux = new Servicio();
                        aux.IDServicio = (int)datos.Lector["IDServicio"];
                        aux.Nombre = (string)datos.Lector["Nombre"];

                        if (!(datos.Lector["Descripcion"] is DBNull))
                            aux.Descripcion = (string)datos.Lector["Descripcion"];

                        aux.Precio = (decimal)datos.Lector["Precio"];
                        aux.DuracionMinutos = (int)datos.Lector["DuracionMinutos"];
                        aux.Activo = (bool)datos.Lector["Activo"];

                        aux.Especialidad = new Especialidad();
                        aux.Especialidad.IDEspecialidad = (int)datos.Lector["IDEspecialidad"];
                        aux.Especialidad.Nombre = (string)datos.Lector["NombreEspecialidad"];

                        
                        aux.Especialidad.Activo = (bool)datos.Lector["EspecialidadActivo"];

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

        public Servicio ObtenerPorId(int id)
        {
            Servicio aux = null;
            using (Datos datos = new Datos())
            {
                try
                {
                    
                    string consulta = @"
                        SELECT S.IDServicio, S.Nombre, S.Descripcion, S.Precio, 
                               S.DuracionMinutos, S.Activo, 
                               E.IDEspecialidad, E.Nombre AS NombreEspecialidad, E.Activo AS EspecialidadActivo
                        FROM Servicio S
                        INNER JOIN Especialidad E ON S.IDEspecialidad = E.IDEspecialidad
                        WHERE S.IDServicio = @id";

                    datos.SetearConsulta(consulta);
                    datos.SetearParametro("@id", id);
                    datos.EjecutarLectura();

                    if (datos.Lector.Read())
                    {
                        aux = new Servicio();
                        aux.IDServicio = (int)datos.Lector["IDServicio"];
                        aux.Nombre = (string)datos.Lector["Nombre"];
                        aux.Descripcion = datos.Lector["Descripcion"] is DBNull ? null : (string)datos.Lector["Descripcion"];
                        aux.Precio = (decimal)datos.Lector["Precio"];
                        aux.DuracionMinutos = (int)datos.Lector["DuracionMinutos"];
                        aux.Activo = (bool)datos.Lector["Activo"];

                        aux.Especialidad = new Especialidad();
                        aux.Especialidad.IDEspecialidad = (int)datos.Lector["IDEspecialidad"];
                        aux.Especialidad.Nombre = (string)datos.Lector["NombreEspecialidad"];
                        aux.Especialidad.Activo = (bool)datos.Lector["EspecialidadActivo"];
                    }
                    return aux;
                }
                catch (Exception ex) { throw ex; }
            }
        }


        
        public void Agregar(Servicio nuevo)
        {
            using (Datos datos = new Datos())
            {
                try
                {
                    datos.SetearProcedimiento("sp_AgregarServicio");
                    datos.SetearParametro("@IDEspecialidad", nuevo.Especialidad.IDEspecialidad);
                    datos.SetearParametro("@Nombre", nuevo.Nombre);
                    datos.SetearParametro("@Descripcion", (object)nuevo.Descripcion ?? DBNull.Value);
                    datos.SetearParametro("@Precio", nuevo.Precio);
                    datos.SetearParametro("@DuracionMinutos", nuevo.DuracionMinutos);
                    datos.EjecutarAccion();
                }
                catch (Exception ex) { throw ex; }
            }
        }

        public void Modificar(Servicio mod)
        {
            using (Datos datos = new Datos())
            {
                try
                {
                    datos.SetearProcedimiento("sp_ModificarServicio");
                    datos.SetearParametro("@IDServicio", mod.IDServicio);
                    datos.SetearParametro("@IDEspecialidad", mod.Especialidad.IDEspecialidad);
                    datos.SetearParametro("@Nombre", mod.Nombre);
                    datos.SetearParametro("@Descripcion", (object)mod.Descripcion ?? DBNull.Value);
                    datos.SetearParametro("@Precio", mod.Precio);
                    datos.SetearParametro("@DuracionMinutos", mod.DuracionMinutos);
                    datos.SetearParametro("@Activo", mod.Activo);
                    datos.EjecutarAccion();
                }
                catch (Exception ex) { throw ex; }
            }
        }

        public void EliminarLogico(int id)
        {
            using (Datos datos = new Datos())
            {
                try
                {
                    datos.SetearProcedimiento("sp_EliminarLogicoServicio");
                    datos.SetearParametro("@IDServicio", id);
                    datos.EjecutarAccion();
                }
                catch (Exception ex) { throw ex; }
            }
        }

        public void ActivarLogico(int id)
        {
            using (Datos datos = new Datos())
            {
                try
                {
                    string consulta = "UPDATE Servicio SET Activo = 1 WHERE IDServicio = @IDServicio";
                    datos.SetearConsulta(consulta);
                    datos.SetearParametro("@IDServicio", id);
                    datos.EjecutarAccion();
                }
                catch (Exception ex) { throw ex; }
            }
        }
    }
}
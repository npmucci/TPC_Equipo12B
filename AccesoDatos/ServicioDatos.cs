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
                            E.IDEspecialidad, E.Nombre AS NombreEspecialidad, E.Descripcion AS DescripcionEspecialidad
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

                        if (!(datos.Lector["DescripcionEspecialidad"] is DBNull))
                            aux.Especialidad.Descripcion = (string)datos.Lector["DescripcionEspecialidad"];

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
    }
}

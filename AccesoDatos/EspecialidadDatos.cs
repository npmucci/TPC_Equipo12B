using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Configuration;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace AccesoDatos
{
    public class EspecialidadDatos
    {
       
        public List<Especialidad> Listar()
        {
            List<Especialidad> lista = new List<Especialidad>();

            
            using (Datos datos = new Datos())
            {
                try
                {
                    string consulta = "SELECT IDEspecialidad, Nombre, Descripcion, Foto FROM Especialidad";
                    datos.SetearConsulta(consulta);
                    datos.EjecutarLectura();

                    while (datos.Lector.Read())
                    {
                        Especialidad aux = new Especialidad();
                        aux.IDEspecialidad = (int)datos.Lector["IDEspecialidad"];
                        aux.Nombre = (string)datos.Lector["Nombre"];

                        if (!(datos.Lector["Descripcion"] is DBNull))
                        {
                            aux.Descripcion = (string)datos.Lector["Descripcion"];
                        }
                        aux.Imagen = (string)datos.Lector["Foto"];
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

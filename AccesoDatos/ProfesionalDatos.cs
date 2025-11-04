using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace AccesoDatos
{
    public class ProfesionalDatos
    {
        public List<Profesional> Listar()
        {
            List<Dominio.Profesional> lista = new List<Profesional>();
            using (Datos datos = new Datos())
            {
                try
                {

                    datos.SetearProcedimiento("ListarProfesionales");
                    datos.EjecutarLectura();
                    while (datos.Lector.Read())
                    {
                        Dominio.Profesional aux = new Profesional();
                        aux.ID = (int)datos.Lector["IDUsuario"];
                        aux.Nombre = (string)datos.Lector["Nombre"];
                        aux.Apellido = (string)datos.Lector["Apellido"];
                        aux.Dni = (string)datos.Lector["Dni"];
                        aux.Mail = (string)datos.Lector["Mail"];
                        aux.Rol = (Rol)datos.Lector["IDRol"];
                        aux.Foto = datos.Lector["Foto"] != DBNull.Value ? (string)datos.Lector["Foto"] : null;
                        aux.Activo = (bool)datos.Lector["Activo"];
                        
                        
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

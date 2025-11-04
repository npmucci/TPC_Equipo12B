using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AccesoDatos;
using Dominio;

namespace Negocio
{
    public class ProfesionalNegocio
    {
        private ProfesionalDatos datos;
        public ProfesionalNegocio()
        {
            datos = new AccesoDatos.ProfesionalDatos();
        }
        public List<Profesional> Listar(int idRol)
        {
            return datos.Listar(idRol);
        }
        
        public List<Profesional> ListarActivos(Rol rol)
        {
            return Listar((int)rol).FindAll(prof => prof.Activo);
        }
    }
}

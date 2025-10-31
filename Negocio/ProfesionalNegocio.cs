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
        public List<Profesional> Listar()
        {
            return datos.Listar();
        }
        
        public List<Profesional> ListarActivos()
        {
            return Listar().FindAll(prof => prof.Activo);
        }
    }
}

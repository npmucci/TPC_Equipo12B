using AccesoDatos;
using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class EspecialidadNegocio
    {
        
        private EspecialidadDatos datos;

        public EspecialidadNegocio()
        {
            datos = new EspecialidadDatos();
        }

        public List<Especialidad> Listar()
        {
            
            return datos.Listar();
        }
    }
}

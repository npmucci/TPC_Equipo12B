using AccesoDatos;
using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class ServicioNegocio
    {
        private ServicioDatos datos;

        public ServicioNegocio()
        {
            datos = new ServicioDatos();
        }

        // Para el Front ⬇️
        public List<Servicio> ListarActivos()
        {
            List<Servicio> listaCompleta = datos.Listar();
  
            List<Servicio> listaFiltrada = listaCompleta.FindAll(s => s.Activo == true);
  
            return listaFiltrada;
        }

        public List<Servicio> listarPorEspecialidad(int idEspecialidad)
        {
            
            List<Servicio> listaCompleta = datos.ListarPorEspecialidad(idEspecialidad);

           
            List<Servicio> listaFiltrada = listaCompleta.FindAll(s => s.Activo == true);

            return listaFiltrada;
        }

        // Para Admin ⬇️
        public List<Servicio> ListarTodos()
        {
            return datos.Listar();
        }
    }
}

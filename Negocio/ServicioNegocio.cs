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

        public List<Servicio> ListarPorEspecialidad(int idEspecialidad)
        {

            List<Servicio> listaCompleta = datos.ListarPorEspecialidad(idEspecialidad);


            List<Servicio> listaFiltrada = listaCompleta.FindAll(s => s.Activo == true);

            return listaFiltrada;
        }

        public List<Servicio> ListarPorEspecialidadTodos(int idEspecialidad)
        {

            List<Servicio> listaCompleta = datos.ListarPorEspecialidad(idEspecialidad);

            return listaCompleta;
        }


        // Para Admin ⬇️
        public List<Servicio> ListarTodos()
        {
            return datos.Listar();
        }

        public Servicio ObtenerPorId(int id)
        {
            
            return datos.ObtenerPorId(id);
        }

        public void Agregar(Servicio nuevo)
        {
            if (nuevo.Precio <= 0)
                throw new Exception("El precio debe ser mayor a cero");
            // + VALIDACIONES
            ServicioDatos datos = new ServicioDatos();
            datos.Agregar(nuevo);
        }

        public void Modificar(Servicio mod)
        {
            TurnoNegocio turnoNegocio = new TurnoNegocio();

            if (turnoNegocio.ServicioTieneTurnosPendientes(mod.IDServicio))
            {
                throw new Exception("No se puede modificar el servicio porque tiene turnos pendientes.");
            }

            if (mod.Precio <= 0)
                throw new Exception("El precio debe ser mayor a cero");

            datos.Modificar(mod);
        }

        public void EliminarLogico(int id)
        {
            
            TurnoNegocio turnoNegocio = new TurnoNegocio();

            
            if (turnoNegocio.ServicioTieneTurnosPendientes(id))
            {
                
                throw new Exception("No se puede dar de baja el servicio porque tiene turnos pendientes.");
            }

            
            datos.EliminarLogico(id);
        }

        public void ActivarLogico(int id)
        {
            
            Servicio servicio = ObtenerPorId(id);

            
            if (servicio.Especialidad == null || !servicio.Especialidad.Activo)
            {
               
                throw new Exception("No se puede activar el servicio. Su especialidad ('" + servicio.Especialidad.Nombre + "') está inactiva. Active la especialidad primero.");
            }

            datos.ActivarLogico(id);
        }

    }
}

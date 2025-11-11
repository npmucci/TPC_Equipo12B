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
        public List<Especialidad> ListarActivos()
        {

            return Listar().FindAll(esp => esp.Activo);
        }

        public Especialidad ObtenerPorId(int id)
        {
            return datos.ObtenerPorId(id);
        }
        public void AsignarEspecialidadAProfesional(int idUsuario, int idEspecialidad)
        {
            
            datos.AsignarEspecialidad(idUsuario, idEspecialidad);
        }

        public void Agregar(Especialidad nueva)
        {
            // VALIDACIONES
            if (string.IsNullOrEmpty(nueva.Nombre))
                throw new Exception("El nombre es obligatorio");

            EspecialidadDatos datos = new EspecialidadDatos();
            datos.Agregar(nueva);
        }

        public void Modificar(Especialidad mod)
        {
            //VALIDACIONES
            EspecialidadDatos datos = new EspecialidadDatos();
            datos.Modificar(mod);
        }

        public void EliminarLogico(int id)
        {
            
            ServicioNegocio servicioNegocio = new ServicioNegocio();
            TurnoNegocio turnoNegocio = new TurnoNegocio();

            List<Servicio> serviciosActivosAsociados = servicioNegocio.ListarPorEspecialidad(id);

            foreach (Servicio servicio in serviciosActivosAsociados)
            {
                if (turnoNegocio.ServicioTieneTurnosPendientes(servicio.IDServicio))
                {
                    
                    throw new Exception($"No se puede dar de baja la especialidad. El servicio '{servicio.Nombre}' tiene turnos pendientes.");
                }
            }

            datos.EliminarLogico(id);

            ServicioDatos servicioDatos = new ServicioDatos();
            foreach (Servicio servicio in serviciosActivosAsociados)
            {
                servicioDatos.EliminarLogico(servicio.IDServicio);
            }
        }

        public void ActivarLogico(int id)
        {
            EspecialidadDatos datos = new EspecialidadDatos();
            datos.ActivarLogico(id);
        }

        public List<Especialidad> ListarPorProfesional(int idProfesional)
        {
            return datos.ListarPorProfesional(idProfesional);
        }
    }
}

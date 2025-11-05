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
            // VALIDACIONES
            EspecialidadDatos datos = new EspecialidadDatos();
            datos.EliminarLogico(id);
        }
    }
}

using AccesoDatos;
using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class HorarioAtencionNegocio
    {
        private HorarioAtencionDatos datos;
        public HorarioAtencionNegocio()
        {
            datos = new HorarioAtencionDatos();
        }

        public List<HorarioAtencion> ListarPorProfesional(int idUsuario)
        {
            return datos.ListarPorProfesional(idUsuario);
        }

        public void Agregar(HorarioAtencion nuevo)
        {
            // VALIDACIONES
            if (nuevo.HorarioInicio >= nuevo.HorarioFin)
                throw new Exception("La hora de inicio debe ser anterior a la hora de fin.");

            datos.Agregar(nuevo);
        }

        public void Modificar(HorarioAtencion mod)
        {
            // VALIDACIONES
            if (mod.HorarioInicio >= mod.HorarioFin)
                throw new Exception("La hora de inicio debe ser anterior a la hora de fin.");

            datos.Modificar(mod);
        }

        public void Eliminar(int id)
        {
            // VALIDACIONES
            datos.Eliminar(id);
        }
    }
}
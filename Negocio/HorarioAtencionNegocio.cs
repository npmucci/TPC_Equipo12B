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
        private TurnoNegocio turnoNegocio = new TurnoNegocio();

        public HorarioAtencionNegocio()
        {
            datos = new HorarioAtencionDatos();
        }

        public List<HorarioAtencion> ListarPorProfesional(int idUsuario)
        {
            return datos.ListarPorProfesional(idUsuario);
        }

        public HorarioAtencion ObtenerPorId(int id)
        {
            return datos.ObtenerPorId(id); 
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

        public void Eliminar(int idHorario)
        {
            
            HorarioAtencion horarioABorrar = ObtenerPorId(idHorario);

            if (horarioABorrar != null)
            {
                ValidarTurnosPendientes(horarioABorrar);
            }

            datos.Eliminar(idHorario);
        }

        private void ValidarTurnosPendientes(HorarioAtencion horario)
        {
            
            List<Turno> turnosFuturos = turnoNegocio.ListarTurnosPendientesPorProfesional(horario.Profesional.ID);

            foreach (Turno t in turnosFuturos)
            {
                
                string diaTurno = TraducirDiaEsp(t.Fecha.DayOfWeek);

                if (diaTurno.Equals(horario.DiaSemana, StringComparison.OrdinalIgnoreCase))
                {
                    
                    if (t.HoraInicio >= horario.HorarioInicio && t.HoraInicio < horario.HorarioFin)
                    {
                        throw new Exception($"No se puede eliminar el horario del {horario.DiaSemana}. Hay turnos pendientes (ej: {t.FechaString} a las {t.HoraInicio}). Cancele los turnos primero.");
                    }
                }
            }
        }

        private string TraducirDiaEsp(DayOfWeek diaIngles)
        {
            switch (diaIngles)
            {
                case DayOfWeek.Monday: return "Lunes";
                case DayOfWeek.Tuesday: return "Martes";
                case DayOfWeek.Wednesday: return "Miércoles";
                case DayOfWeek.Thursday: return "Jueves";
                case DayOfWeek.Friday: return "Viernes";
                case DayOfWeek.Saturday: return "Sábado";
                case DayOfWeek.Sunday: return "Domingo";
                default: return "";
            }
        }
    }
}
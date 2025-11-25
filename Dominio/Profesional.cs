using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Profesional : Usuario
    {
        public List<Especialidad> Especialidades { get; set; }
        public List<HorarioAtencion> Horarios { get; set; }
        public List<Turno> Turnos { get; set; } 

        public Profesional()
        {
            Especialidades = new List<Especialidad>();
            Horarios = new List<HorarioAtencion>();
            Turnos = new List<Turno>();
            Rol = Rol.Profesional; // Se setea el rol por defecto
        }

    }
}

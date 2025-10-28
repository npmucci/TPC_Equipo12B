using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class HorarioAtencion
    {
        public int IDHorarioAtencion { get; set; }
        public string DiaSemana { get; set; } 
        public TimeSpan HorarioInicio { get; set; }
        public TimeSpan HorarioFin { get; set; }
        public bool Activo { get; set; }
        public Profesional Profesional { get; set; }
    }
}

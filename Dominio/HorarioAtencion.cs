using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class HorarioAtencion
    {
        public int ID { get; set; }
        public TimeSpan HoraInicio { get; set; }
        public TimeSpan HoraFin { get; set; }
        public DayOfWeek Dia { get; set; }
        public bool Activo { get; set; }
    }
}

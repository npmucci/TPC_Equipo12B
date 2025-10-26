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
        public List<HorarioAtencion> HorariosAtencion { get; set; }
        public List<Turno> Turnos{ get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Turno
    {
        public int IDTurno { get; set; }
        public DateTime Fecha { get; set; }
        public TimeSpan HoraInicio { get; set; }
        public Profesional Profesional { get; set; }
        public Cliente Cliente { get; set; }
        public Servicio Servicio { get; set; }
        public Pago Pago { get; set; }
        public EstadoTurno Estado { get; set; } 
    }
}

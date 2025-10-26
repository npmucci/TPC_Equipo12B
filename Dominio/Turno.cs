using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Turno
    {
        public int ID { get; set; }
        public DayOfWeek Dia { get; set; }
        public TimeSpan Hora { get; set; }
        public int IdCliente { get; set; }
        public int IdProfesional { get; set; }
        public Servicio Servicio { get; set; }
        public Pago Pago { get; set; }  
        public EstadoTurno Estado { get; set; }
    }
}

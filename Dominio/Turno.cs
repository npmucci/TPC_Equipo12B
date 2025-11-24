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
        public Usuario Profesional { get; set; }
        public Usuario Cliente { get; set; }
        public Servicio Servicio { get; set; }
        public List<Pago> Pago { get; set; } = new List<Pago>();

        public EstadoTurno Estado { get; set; }
        public DateTime? FechaCancelacion { get; set; } 

        //para que me devuela la fecha en formato dd/MM/yyyy
        public string FechaString
        {
            get
            {
                return Fecha.ToString("dd/MM/yyyy");
            }
        }

        public string ClienteNombreCompleto
        {
            get { return Cliente.Nombre + " " + Cliente.Apellido; }
        }

        public string ProfesionalNombreCompleto
        {
            get { return Profesional.Nombre + " " + Profesional.Apellido; }
        }


    }
}

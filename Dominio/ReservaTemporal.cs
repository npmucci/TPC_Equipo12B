using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class ReservaTemporal
    {
        public int IDServicio { get; set; }
        public string NombreServicio { get; set; }
        public int IDProfesional { get; set; }
        public string NombreProfesional { get; set; }
        public DateTime Fecha { get; set; }
        public TimeSpan Hora { get; set; }
        public decimal Precio { get; set; }
        public int IDCliente { get; set; }
    }
}

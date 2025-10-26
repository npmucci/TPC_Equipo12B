using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Pago
    {
        public int ID { get; set; }
        public decimal Monto { get; set; }
        public DateTime Fecha { get; set; }
        public bool EsSenia { get; set; }
        public bool EsPagoCompleto { get; set; }

    }
}

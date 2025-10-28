using Dominio.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    
        public class Pago
        {
            public int IDPago { get; set; }
            public DateTime FechaPago { get; set; }
            public decimal Monto { get; set; }
            public TipoPago Tipo { get; set; } 
        }

    
}

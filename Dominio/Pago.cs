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
        public int IDTurno {get;set; }
        public DateTime Fecha { get; set; }
        public bool EsDevolucion { get; set; }
        public decimal Monto { get; set; }
        public TipoPago Tipo { get; set; }
        public FormaPago FormaDePago { get; set; }
       



        public string FechaString
        {
            get
            {
                return Fecha.ToString("dd/MM/yyyy");
            }
        }
    }
}

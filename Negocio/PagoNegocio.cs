using AccesoDatos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Negocio
{
    public class PagoNegocio
    {
        PagoDatos pagoDatos = new PagoDatos();
        
        public List<Dominio.Pago> ListarPagosDelTurno(int idTurno)
        {
            return pagoDatos.ListarPagosDelTurno(idTurno);
        }

        public void AgregarPago(Pago nuevoPago)
        {
            pagoDatos.AgregarPago(nuevoPago);
        }

    }
}

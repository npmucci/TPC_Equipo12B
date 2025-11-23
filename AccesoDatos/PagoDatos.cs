using System;
using System.Collections.Generic;
using Dominio;
using Dominio.Enum;


namespace AccesoDatos
{
   public class PagoDatos
    {
        public List<Pago> ListarPagosDelTurno(int idTurno)
        {
            List<Pago> pagos = new List<Pago>();

            using (Datos datos = new Datos())
            {
                datos.SetearProcedimiento("sp_ListarPagosPorTurno");
                datos.SetearParametro("@IDTurno", idTurno);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Pago pago = new Pago()
                    {
                        IDPago = (int)datos.Lector["IDPago"],
                        IDTurno = idTurno,
                        Fecha = (DateTime)datos.Lector["Fecha"],
                        EsDevolucion = (bool)datos.Lector["EsDevolucion"],
                        Monto = (decimal)datos.Lector["Monto"],
                        Tipo = (TipoPago)(int)datos.Lector["IDTipoPago"],
                        FormaDePago = (FormaPago)(int)datos.Lector["IDFormaPago"]
                    };

                    pagos.Add(pago);
                }
            }

            return pagos;
        }
    }
}

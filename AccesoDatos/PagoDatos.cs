using System;
using System.Collections.Generic;
using Dominio;



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
                    Pago aux = new Pago();

                    aux.IDPago = (int)datos.Lector["IDPago"];
                    aux.IDTurno = idTurno;
                    aux.Fecha = (DateTime)datos.Lector["Fecha"];
                    aux.EsDevolucion = (bool)datos.Lector["EsDevolucion"];
                    aux.Monto = (decimal)datos.Lector["Monto"];

                    if (!(datos.Lector["CodigoTransaccion"] is DBNull))
                    {
                        aux.CodigoTransaccion = (string)datos.Lector["CodigoTransaccion"];
                    }


                    aux.Tipo = new TipoPago
                    {
                        IDTipoPago = (int)datos.Lector["IDTipoPago"],
                        Descripcion = datos.Lector["TipoPagoDescripcion"] is DBNull ? "" : (string)datos.Lector["TipoPagoDescripcion"]
                    };
                    aux.FormaDePago = new FormaPago
                    {
                        IDFormaPago = (int)datos.Lector["IDFormaPago"],                       
                        Descripcion = datos.Lector["FormaPagoDescripcion"] is DBNull ? "" : (string)datos.Lector["FormaPagoDescripcion"]
                    };


                    pagos.Add(aux);
                }
            }

            return pagos;
        }

        public void AgregarPago(Pago nuevoPago)
        {
            using (Datos datos = new Datos())
            {
                datos.SetearProcedimiento("sp_AgregarPago");
                datos.SetearParametro("@IDTurno", nuevoPago.IDTurno);
                datos.SetearParametro("@Fecha", nuevoPago.Fecha);
                datos.SetearParametro("@EsDevolucion", nuevoPago.EsDevolucion);
                datos.SetearParametro("@Monto", nuevoPago.Monto);
                datos.SetearParametro("@IDTipoPago", nuevoPago.Tipo.IDTipoPago);
                datos.SetearParametro("@IDFormaPago", nuevoPago.FormaDePago.IDFormaPago);
                datos.EjecutarAccion();
            }
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace AccesoDatos
{
    public class TurnoDatos
    {
        public List<Turno> ListarTurnosCliente(int idCliente)
        {
            List<Turno> lista = new List<Turno>();
          
            using (Datos datos = new Datos())
            {
                try
                {
                    datos.SetearProcedimiento("sp_ListarTurnosCliente");
                    datos.SetearParametro("@IDCliente", idCliente);
                    datos.EjecutarLectura();
                    while (datos.Lector.Read())
                    {
                        Turno aux = new Turno();
                        aux.IDTurno = (int)datos.Lector["IDTurno"];
                        aux.Fecha = ((DateTime)datos.Lector["Fecha"]).Date; // para que no muestra la hora
                       aux.HoraInicio = (TimeSpan)datos.Lector["HoraInicio"];
                        aux.Profesional = new Profesional()
                        {

                            Nombre = (string)datos.Lector["Nombre"],
                            Apellido = (string)datos.Lector["Apellido"]
                        };
                        aux.Servicio = new Servicio()
                        {
                            Nombre = (string)datos.Lector["Servicio"],
                        };

                        aux.Estado = (EstadoTurno)(int)datos.Lector["Estado"];


                        lista.Add(aux);
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            
            return lista;
        }
    }
}

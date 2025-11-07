using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;
using AccesoDatos;

namespace Negocio
{
    public class TurnoNegocio
    {
        private TurnoDatos datos = new TurnoDatos();

        public List<Turno> ListarTurnosCliente(int idCliente)
        {
            return datos.ListarTurnosCliente(idCliente);
        }
    }
}

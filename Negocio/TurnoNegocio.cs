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
        public List<Turno> ListarTodos()
        {
            return datos.ListarTodos();
        }
        public List<Turno> ListarTurnosPasados()
        {
            return ListarTodos().FindAll(turnos => turnos.Estado != EstadoTurno.Confirmado && turnos.Estado != EstadoTurno.Pendiente);
        }
        public List<Turno> ListarTurnosActuales()
        {
            return ListarTodos().FindAll(turnos => turnos.Estado == EstadoTurno.Confirmado || turnos.Estado == EstadoTurno.Pendiente);
        }

        public List<Turno> ListarTurnosCliente(int idCliente)
        {
            return datos.ListarTurnosCliente(idCliente);
        }

        public List<Turno> ListarTurnosPasadosCliente(int idCliente)
        {
            return datos.ListarTurnosCliente(idCliente).FindAll(turnos => turnos.Estado != EstadoTurno.Confirmado && turnos.Estado != EstadoTurno.Pendiente);
        }

        public List<Turno> ListarTurnosActualesCliente(int idCliente)
        {
            return datos.ListarTurnosCliente(idCliente).FindAll(turnos => turnos.Estado == EstadoTurno.Confirmado || turnos.Estado == EstadoTurno.Pendiente);
        }
    }
}

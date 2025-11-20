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

        public bool TieneTurnosPendientesPorEspecialidad(int idProfesional, int idEspecialidad)
        {
            return datos.TieneTurnosPendientesPorEspecialidad(idProfesional, idEspecialidad);
        }

        public bool ProfesionalTieneTurnosPendientes(int idProfesional)
        {
            TurnoDatos datos = new TurnoDatos();
            return datos.TieneTurnosPendientesPorProfesional(idProfesional);
        }

        public bool ServicioTieneTurnosPendientes(int idServicio)
        {
            return datos.TieneTurnosPendientesPorServicio(idServicio);
        }
        
        public void CambiarEstado(int idTurno, int idEstado)
        {
            datos.CambiarEstado(idTurno, idEstado);
        }

        public List<Turno> ListarTurnosPendientesPorProfesional(int idProfesional)
        {
            return datos.ListarTurnosPendientesPorProfesional(idProfesional);
        }

        public int ContarTurnos(DateTime fechaInicio, DateTime fechaFin, int idProfesional)
        {
            return datos.ContarTurnos(fechaInicio, fechaFin, idProfesional);
        }

        public decimal ObtenerIngresos(DateTime fechaInicio, DateTime fechaFin, int idProfesional)
        {
            return datos.ObtenerIngresos(fechaInicio, fechaFin, idProfesional);
        }
    }
}

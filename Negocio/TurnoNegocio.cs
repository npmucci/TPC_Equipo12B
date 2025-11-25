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

        
        // LISTADOS GENERALES Y BÚSQUEDA
        
        #region Listados Generales
        public List<Turno> ListarTodos()
        {
            return datos.ListarTodos();
        }

        public Turno BuscarTurnoPorId(int idTurno)
        {
            return datos.BuscarTurnoPorId(idTurno);
        }

        public List<Turno> ListarTurnosPasados()
        {
            return ListarTodos().FindAll(turnos => turnos.Estado.Descripcion != "Confirmado" && turnos.Estado.Descripcion != "Pendiente");
        }

        public List<Turno> ListarTurnosActuales()
        {
            return ListarTodos().FindAll(turnos => turnos.Estado.Descripcion == "Confirmado" || turnos.Estado.Descripcion == "Pendiente");
        }

        public List<Turno> ListarTurnosDelDia(int idProfesional, DateTime fecha)
        {
            return datos.ListarPorProfesionalYFecha(idProfesional, fecha);
        }
        #endregion

       
        // MÉTODOS PARA EL CLIENTE
        
        #region Métodos Cliente
        public List<Turno> ListarTurnosCliente(int idCliente)
        {
            return datos.ListarTurnosCliente(idCliente);
        }

        public List<Turno> ListarTurnosPasadosCliente(int idCliente)
        {
            return datos.ListarTurnosCliente(idCliente).FindAll(turnos => turnos.Estado.Descripcion != "Confirmado" && turnos.Estado.Descripcion != "Pendiente");
        }

        public List<Turno> ListarTurnosActualesCliente(int idCliente)
        {
            return datos.ListarTurnosCliente(idCliente).FindAll(turnos => turnos.Estado.Descripcion == "Confirmado" || turnos.Estado.Descripcion == "Pendiente");
        }
        #endregion

       
        // MÉTODOS PARA PROFESIONALES Y RECEPCIÓN
        
        #region Métodos Profesional y Recepción
        public List<Turno> ListarTurnosPendientesPorProfesional(int idProfesional)
        {
            return datos.ListarTurnosPendientesPorProfesional(idProfesional);
        }

        public List<Turno> ListarTurnosParaDevolucion()
        {
            return datos.ListarTurnosParaDevolucion();
        }
        #endregion

      
        // VALIDACIONES DE NEGOCIO
        
        #region Validaciones
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
        #endregion

        
        //  ACCIONES TRANSACCIONALES (Guardar, Cambiar Estado, Cancelar)
       
        #region Acciones y Cambios de Estado
        public void GuardarTurno(Turno nuevo, Pago pagoInicial)
        {
            datos.Agregar(nuevo, pagoInicial);
        }

        public void CambiarEstado(int idTurno, int idEstado)
        {
            datos.CambiarEstado(idTurno, idEstado);
        }

        public string ProcesarCancelacionCliente(int idTurno)
        {
            Turno turno = datos.BuscarTurnoPorId(idTurno);

            DateTime fechaHoraTurno = turno.Fecha.Add(turno.HoraInicio);
            double horasRestantes = (fechaHoraTurno - DateTime.Now).TotalHours;

            decimal montoPagado = 0;
            if (turno.Pago != null)
            {
                foreach (var p in turno.Pago)
                {
                    if (!p.EsDevolucion) montoPagado += p.Monto;
                }
            }

            // REGLA DE 24 HORAS 

            // CASO A: Cancela con tiempo (>24hs) y hay plata para devolver
            if (horasRestantes >= 24 && montoPagado > 0)
            {
                // Estado 6: Solicitud de Devolución
                datos.CambiarEstado(idTurno, 6);
                return $"Turno cancelado. Al ser con antelación (>24hs), se generó una solicitud de devolución por ${montoPagado:N0}.";
            }
            // CASO B: Cancela sobre la hora (<24hs) 
            else
            {
                // Estado 3: Cancelado por Cliente (Sin devolución)
                datos.CambiarEstado(idTurno, 3);

                if (montoPagado > 0)
                    return "Turno cancelado. Al ser con menos de 24hs de aviso, el pago no es reembolsable.";
                else
                    return "Turno cancelado exitosamente.";
            }
        }
        #endregion

        
        // ESTADÍSTICAS Y REPORTES (KPIs)
       
        #region Estadísticas
        public int ContarTurnos(DateTime fechaInicio, DateTime fechaFin, int idProfesional)
        {
            return datos.ContarTurnos(fechaInicio, fechaFin, idProfesional);
        }

        public int CantidadTurnosPendientesTotal()
        {
            return datos.ContarTotalPendientes();
        }
        #endregion

        
        // CATÁLOGOS AUXILIARES 
        
        #region Catálogos Auxiliares
        public List<EstadoTurno> ListarEstados()
        {
            return datos.ListarEstados();
        }

        public List<FormaPago> ListarFormasPago()
        {
            return datos.ListarFormasPago();
        }

        public List<TipoPago> ListarTiposPago()
        {
            return datos.ListarTiposPago();
        }
        #endregion
    }
}
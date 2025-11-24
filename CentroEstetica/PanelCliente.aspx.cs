using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CentroEstetica
{
    public partial class PanelCliente : System.Web.UI.Page
    {
        TurnoNegocio turnosNegocio = new TurnoNegocio();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Seguridad.EsCliente(Session["usuario"]))
            {
                Response.Redirect("Default.aspx", false);
                return;
            }

            if (!IsPostBack)
            {
                
                if (Request.QueryString["reservaExitosa"] == "true")
                {
                    pnlMensajeExito.Visible = true;
                }

                CargarTurnos();
            }
        }

        private void CargarTurnos()
        {
            Cliente cliente = (Cliente)Session["usuario"];

            
            List<Turno> todosLosTurnos = turnosNegocio.ListarTurnosCliente(cliente.ID);

           
            List<Turno> pendientes = todosLosTurnos.FindAll(t =>
                t.Estado.Descripcion == "Pendiente" &&
                (t.Fecha > DateTime.Today || (t.Fecha == DateTime.Today && t.HoraInicio > DateTime.Now.TimeOfDay))
            );

            List<Turno> confirmados = todosLosTurnos.FindAll(t =>
                t.Estado.Descripcion == "Confirmado" &&
                (t.Fecha > DateTime.Today || (t.Fecha == DateTime.Today && t.HoraInicio > DateTime.Now.TimeOfDay))
            );

            
            List<Turno> pasados = todosLosTurnos.FindAll(t =>
                t.Estado.Descripcion == "Finalizado" ||
                t.Estado.Descripcion == "Cancelado" ||
                t.Fecha < DateTime.Today ||
                (t.Fecha == DateTime.Today && t.HoraInicio <= DateTime.Now.TimeOfDay)
            );

            
            rptPendientes.DataSource = pendientes;
            rptPendientes.DataBind();

            rptConfirmados.DataSource = confirmados;
            rptConfirmados.DataBind();

            rptPasados.DataSource = pasados;
            rptPasados.DataBind();

            
            pnlSinPendientes.Visible = (pendientes.Count == 0);
            pnlSinConfirmados.Visible = (confirmados.Count == 0);
        }

        public string GenerarMensajeConfirmacion(object fechaObj, object horaObj)
        {
            try
            {
                if (fechaObj == null || horaObj == null) return "return confirm('¿Cancelar turno?');";

                DateTime fecha = (DateTime)fechaObj;
                TimeSpan hora = (TimeSpan)horaObj;
                DateTime fechaTurno = fecha.Add(hora);

                double horasRestantes = (fechaTurno - DateTime.Now).TotalHours;

                string mensaje = "";

                if (horasRestantes < 24)
                {
                    
                    mensaje = "⚠️ ATENCIÓN: Faltan menos de 24hs para el turno.\\n\\n" +
                              "Si cancelás ahora, el dinero abonado NO SERÁ REEMBOLSADO según nuestras políticas.\\n\\n" +
                              "¿Estás seguro que querés cancelar?";
                }
                else
                {
                    
                    mensaje = "Estás cancelando con la anticipación requerida (>24hs).\\n\\n" +
                              "Se generará una solicitud de devolución por el monto abonado.\\n\\n" +
                              "¿Confirmar cancelación?";
                }

                return $"return confirm('{mensaje}');";
            }
            catch
            {
                return "return confirm('¿Seguro que querés cancelar este turno?');";
            }
        }

        protected void btnCancelar_Command(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Cancelar")
            {
                try
                {
                    
                    int idTurno = int.Parse(e.CommandArgument.ToString());
                    string mensajeResultado = turnosNegocio.ProcesarCancelacionCliente(idTurno);
                    CargarTurnos();

                    lblMensajeCancelacion.Text = mensajeResultado;
                    pnlMensajeCancelacion.Visible = true;

                  
                    if (mensajeResultado.Contains("no es reembolsable"))
                    {
                        pnlMensajeCancelacion.CssClass = "alert alert-warning alert-dismissible fade show shadow-sm mb-4";
                    }
                    else
                    {
                        pnlMensajeCancelacion.CssClass = "alert alert-info alert-dismissible fade show shadow-sm mb-4";
                    }
                }
                catch (Exception ex)
                {
                   
                    lblMensajeCancelacion.Text = "Hubo un error al intentar cancelar: " + ex.Message;
                    pnlMensajeCancelacion.CssClass = "alert alert-danger alert-dismissible fade show shadow-sm mb-4";
                    pnlMensajeCancelacion.Visible = true;
                }
            }
        }
    }
}
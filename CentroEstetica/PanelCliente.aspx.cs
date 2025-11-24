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

        
        protected void btnCancelar_Command(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Cancelar")
            {
                try
                {
                    int idTurno = int.Parse(e.CommandArgument.ToString());

                    turnosNegocio.CambiarEstado(idTurno, 4);

                    
                    CargarTurnos();
                }
                catch (Exception ex)
                {
                    
                }
            }
        }
    }
}
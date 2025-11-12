using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;

namespace CentroEstetica
{
    public partial class GestionTurnosProfesional : System.Web.UI.Page
    {
        private TurnoNegocio turnoNegocio = new TurnoNegocio();
        private UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
        private int idProfesional = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Seguridad.EsAdmin(Session["usuario"]))
            {
                Response.Redirect("Default.aspx", false);
                return;
            }

            
            if (Request.QueryString["idProf"] == null || !int.TryParse(Request.QueryString["idProf"], out idProfesional))
            {
                Response.Redirect("PanelAdmin.aspx", false);
                return;
            }

            if (!IsPostBack)
            {
                CargarNombreProfesional();
                CargarTurnos();
            }
        }

        private void CargarNombreProfesional()
        {
            try
            {
                
                Usuario prof = usuarioNegocio.ObtenerPorId(idProfesional);
                if (prof != null)
                {
                    litNombreProfesional.Text = $"{prof.Nombre} {prof.Apellido}";
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al cargar datos del profesional: " + ex.Message, "danger");
            }
        }

        private void CargarTurnos()
        {
            try
            {
                
                List<Turno> turnos = turnoNegocio.ListarTurnosPendientesPorProfesional(idProfesional);

                if (turnos.Count > 0)
                {
                    rptTurnos.DataSource = turnos;
                    rptTurnos.DataBind();
                    pnlNoHayTurnos.Visible = false;
                }
                else
                {
                    rptTurnos.DataSource = null;
                    rptTurnos.DataBind();
                    pnlNoHayTurnos.Visible = true;
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al cargar los turnos: " + ex.Message, "danger");
            }
        }

        protected void rptTurnos_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DarDeBaja")
            {
                int idTurno = int.Parse(e.CommandArgument.ToString());
                try
                {
                    
                    turnoNegocio.CambiarEstado(idTurno, 4); // hay que crear este metodo, y reasignar los id de estados por que el 4 esta como cancelado profesional....

                    MostrarMensaje("Turno dado de baja correctamente.", "success");
                    CargarTurnos(); 
                }
                catch (Exception ex)
                {
                    MostrarMensaje("Error al dar de baja el turno: " + ex.Message, "danger");
                }
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("PanelAdmin.aspx", false);
        }

        private void MostrarMensaje(string mensaje, string tipo)
        {
            pnlMensaje.Visible = true;
            pnlMensaje.CssClass = $"alert alert-{tipo}";
            litMensaje.Text = mensaje;
        }
    }
}
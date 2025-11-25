using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CentroEstetica
{
    public partial class PanelRecepcionista : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
           
            Usuario usuario = (Usuario)Session["usuario"];

            if (usuario == null || (!Seguridad.EsRecepcionista(usuario) && !Seguridad.EsAdmin(usuario)))
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

         
                lblNombre.Text = usuario.Nombre.ToString();
                MostrarFechaActual();

                TurnoNegocio negocio = new TurnoNegocio();

                //  Cargar Turnos del Día 
                List<Turno> listaTurnos = negocio.ListarTodos();
                listaTurnos = listaTurnos.FindAll(t => t.Fecha.Date == DateTime.Today.Date);
                dgvTurnos.DataSource = listaTurnos;
                dgvTurnos.DataBind();

                // Cargar Devoluciones Pendientes
                //dgvDevoluciones.DataSource = negocio.ListarTurnosParaDevolucion();
                //dgvDevoluciones.DataBind();
            }
        }

        private void MostrarFechaActual()
        {

            lblFechaHoy.Text = DateTime.Now.ToString("dddd, dd 'de' MMMM",
                System.Globalization.CultureInfo.CreateSpecificCulture("es-ES"));
        }

        protected void dgvTurnos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            dgvTurnos.PageIndex = e.NewPageIndex;

            TurnoNegocio negocio = new TurnoNegocio();
            List<Turno> listaTurnos = negocio.ListarTodos();
            listaTurnos = listaTurnos.FindAll(t => t.Fecha.Date == DateTime.Today.Date);

            dgvTurnos.DataSource = listaTurnos;
            dgvTurnos.DataBind();
        }

        protected void dgvTurnos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "VerPagos")
                {
                    int idTurno = Convert.ToInt32(e.CommandArgument);


                    MostrarDetalleModal(idTurno);
                }
                if (e.CommandName == "Modificar")
                {
                    int idTurno = Convert.ToInt32(e.CommandArgument);
                    Response.Redirect($"ModificarTurno.aspx?IDTurno={idTurno}");
                }
            }

            catch (Exception ex)
            {
                throw (ex);
            }
        }
        private void MostrarDetalleModal(int idTurno)
        {
            PagoNegocio pagoNegocio = new PagoNegocio();
            var lista = pagoNegocio.ListarPagosDelTurno(idTurno);

            dgvPagos.DataSource = lista;
            dgvPagos.DataBind();

            string script = "var modal = new bootstrap.Modal(document.getElementById('pagoModal')); modal.show();";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", script, true);



        }

    }
}

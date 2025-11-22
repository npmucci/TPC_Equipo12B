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
            if (!Seguridad.EsRecepcionista(Session["usuario"]))
            {
                Response.Redirect("Default.aspx", false);
                return;
            }

            if (!IsPostBack)
            {
                Recepcionista recepcionista = (Recepcionista)Session["usuario"];
                lblNombre.Text = recepcionista.Nombre.ToString();
                MostrarFechaActual();
                TurnoNegocio negocio = new TurnoNegocio();
                List<Turno> listaTurnos = negocio.ListarTodos();
                listaTurnos = listaTurnos.FindAll(t => t.Fecha.Date == DateTime.Today.Date);
                dgvTurnos.DataSource = listaTurnos;
                dgvTurnos.DataBind();
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
                if (e.CommandName == "VerDetalle")
                {
                    int idTurno = Convert.ToInt32(e.CommandArgument);

                    TurnoNegocio negocio = new TurnoNegocio();

                    Turno turnoSeleccionado = negocio.BuscarTurnoPorId(idTurno);

                    MostrarDetalleModal(turnoSeleccionado);
                }
            }

            catch (Exception ex)
            {
                throw (ex);
            }
        }
        private void MostrarDetalleModal(Turno turno)
        {
            if (turno == null)
            {
                return;
            }

            lblDetalleFecha.Text = turno.FechaString;
            lblDetalleHora.Text = turno.HoraInicio.ToString("hh\\:mm");
            lblDetalleServicioNombre.Text = turno.Servicio != null ? turno.Servicio.Nombre : "N/A";
            lblDetalleEstado.Text = turno.Estado.ToString();
            lblDetalleClienteNombre.Text = turno.Cliente != null ? turno.ClienteNombreCompleto : "Cliente no disponible";

            if (turno.Pago != null)
            {
                lblDetalleMonto.Text = turno.Pago.Monto.ToString("C");
                lblDetalleTipoPago.Text = turno.Pago.Tipo.ToString();
                lblDetalleFormaPago.Text = turno.Pago.FormaDePago.ToString();
                lblDetalleFechaPago.Text = turno.Pago.FechaPago.ToString("dd/MM/yyyy");
            }
            else
            {
                lblDetalleMonto.Text = "Pendiente / Sin Registrar";
                lblDetalleTipoPago.Text = "N/A";
                lblDetalleFormaPago.Text = "N/A";
                lblDetalleFechaPago.Text = "N/A";
            }

            string script = "var modal = new bootstrap.Modal(document.getElementById('detalleModal')); modal.show();";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", script, true);


        }

    }
}

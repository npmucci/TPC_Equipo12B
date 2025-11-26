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
        private PagoNegocio pagoNegocio = new PagoNegocio();
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
                CargarDatosProfesional();
                CargarTurnos();
            }
        }

        private void CargarDatosProfesional()
        {
            try
            {
                Usuario prof = usuarioNegocio.ObtenerPorId(idProfesional);
                if (prof != null)
                {
                    litNombreProfesional.Text = $"{prof.Nombre} {prof.Apellido}";
                }
            }
            catch (Exception ex) {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx");
            }
        }

        private void CargarTurnos()
        {
            try
            {
                List<Turno> turnos = turnoNegocio.ListarTurnosPendientesPorProfesional(idProfesional);
                dgvTurnos.DataSource = turnos;
                dgvTurnos.DataBind();
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al cargar turnos: " + ex.Message, "danger");
            }
        }

        // LÓGICA DE CANCELACIÓN

        protected void dgvTurnos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "PreCancelar")
            {
                int idTurno = int.Parse(e.CommandArgument.ToString());
                hfIdTurnoCancelar.Value = idTurno.ToString();

                
                decimal montoPagado = CalcularMontoPagado(idTurno);
                lblMontoDevolucion.Text = "$" + montoPagado.ToString("N0");

                
                txtComprobanteDevolucion.Text = "";
                ddlFormaDevolucion.SelectedValue = "Transferencia";

                
                pnlComprobante.Visible = true;
                rfvComprobante.Enabled = true;

                
                pnlProcesoCancelacion.Visible = true;
                pnlMensaje.Visible = false;
            }
        }

        protected void ddlFormaDevolucion_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlFormaDevolucion.SelectedValue == "Efectivo")
            {
                pnlComprobante.Visible = false;
                rfvComprobante.Enabled = false;
            }
            else
            {
                pnlComprobante.Visible = true;
                rfvComprobante.Enabled = true;
            }
        }

        protected void btnConfirmarCancelacion_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            try
            {
                int idTurno = int.Parse(hfIdTurnoCancelar.Value);
               
                decimal montoDevolucion = decimal.Parse(lblMontoDevolucion.Text.Replace("$", "").Replace(".", ""));

                Turno turno = turnoNegocio.BuscarTurnoPorId(idTurno);

                
                if (montoDevolucion > 0)
                {
                    Pago devolucion = new Pago();
                    devolucion.IDTurno = idTurno;
                    devolucion.Fecha = DateTime.Now;
                    devolucion.EsDevolucion = true;
                    devolucion.Monto = montoDevolucion * -1;


                    if (ddlFormaDevolucion.SelectedValue == "Efectivo")
                    {
                        devolucion.FormaDePago = new FormaPago { IDFormaPago = 1 };
                        devolucion.CodigoTransaccion = null;
                    }
                    else
                    {
                        devolucion.FormaDePago = new FormaPago { IDFormaPago = 2 };
                        devolucion.CodigoTransaccion = txtComprobanteDevolucion.Text;
                    }

                    devolucion.Tipo = new TipoPago { IDTipoPago = 2 }; 

                    pagoNegocio.AgregarPago(devolucion);
                }

                
                turnoNegocio.CambiarEstado(idTurno, 4);

                
                try
                {
                    string detallePago = ddlFormaDevolucion.SelectedValue == "Efectivo"
                        ? "Efectivo en sucursal"
                        : $"Transferencia (Op: {txtComprobanteDevolucion.Text})";

                    EmailService.EnviarAvisoCancelacion(
                        turno.Cliente.Mail,
                        turno.Servicio.Nombre,
                        turno.Fecha,
                        $"El turno fue cancelado por motivos administrativos. Se ha registrado la devolución de ${montoDevolucion:N0} mediante {detallePago}."
                    );
                }
                catch (Exception ex)
                {
                    Session.Add("error", ex);
                    Response.Redirect("Error.aspx");
                }

                
                pnlProcesoCancelacion.Visible = false; 
                CargarTurnos(); 
                MostrarMensaje("Turno cancelado y devolución registrada correctamente.", "success");
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx");
            }
        }

        protected void btnCerrarPanel_Click(object sender, EventArgs e)
        {
            pnlProcesoCancelacion.Visible = false;
            hfIdTurnoCancelar.Value = "";
        }

        private decimal CalcularMontoPagado(int idTurno)
        {
            List<Pago> pagos = pagoNegocio.ListarPagosDelTurno(idTurno);
            decimal total = 0;
            foreach (var p in pagos)
            {
                if (!p.EsDevolucion) total += p.Monto;
            }
            return total;
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("PanelAdmin.aspx?view=profesionales", false);
        }

        private void MostrarMensaje(string mensaje, string tipo)
        {
            pnlMensaje.Visible = true;
            pnlMensaje.CssClass = $"alert alert-{tipo} alert-dismissible fade show shadow-sm";
            litMensaje.Text = mensaje;
        }
    }
}
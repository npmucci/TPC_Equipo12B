using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;

namespace CentroEstetica
{
    public partial class PagoTurno : System.Web.UI.Page
    {
        private TurnoNegocio turnoNegocio = new TurnoNegocio();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Seguridad.SesionActiva(Session["usuario"])) { Response.Redirect("Default.aspx"); return; }
            if (Session["ReservaEnCurso"] == null) { Response.Redirect("ReservarTurno.aspx"); return; }

            if (!IsPostBack)
            {
                CargarResumen();
                ConfigurarVistaPorRol();
            }
        }

        private void CargarResumen()
        {
            ReservaTemporal reserva = (ReservaTemporal)Session["ReservaEnCurso"];
            lblServicio.Text = reserva.NombreServicio;
            lblProfesional.Text = reserva.NombreProfesional;
            lblFechaHora.Text = $"{reserva.Fecha:dd/MM/yyyy} - {reserva.Hora:hh\\:mm} hs";

            // Calculamos Seña por defecto
            CalcularMonto();
        }

        private void CalcularMonto()
        {
            ReservaTemporal reserva = (ReservaTemporal)Session["ReservaEnCurso"];
            decimal total = reserva.Precio;

            if (rblTipoMonto.SelectedValue == "Senia")
                lblMontoAPagar.Text = "$" + (total * 0.5m).ToString("N0");
            else
                lblMontoAPagar.Text = "$" + total.ToString("N0");
        }

        protected void rblTipoMonto_SelectedIndexChanged(object sender, EventArgs e)
        {
            CalcularMonto();
        }

        // --- LÓGICA DE ROLES ---
        private void ConfigurarVistaPorRol()
        {
            Usuario usuario = (Usuario)Session["usuario"];

            if (Seguridad.EsAdmin(usuario) || usuario.Rol == Dominio.Rol.Recepcionista)
            {
                // ES ADMIN/RECEPCIONISTA
                pnlOpcionesAdmin.Visible = true;
                pnlOpcionesCliente.Visible = false;

                // Por defecto Transferencia seleccionado
                rblFormaPagoAdmin.SelectedValue = "Transferencia";
                pnlDatosTransferencia.Visible = true;
                rfvCodigo.Enabled = false; // Para ellos el código es opcional
            }
            else
            {
                // ES CLIENTE
                pnlOpcionesAdmin.Visible = false;
                pnlOpcionesCliente.Visible = true; // Solo ve mensaje "Transferencia"

                pnlDatosTransferencia.Visible = true; // Siempre ve datos bancarios
                rfvCodigo.Enabled = true; // OBLIGATORIO para el cliente
            }
        }

        protected void rblFormaPagoAdmin_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Solo admin cambia esto
            if (rblFormaPagoAdmin.SelectedValue == "Efectivo")
            {
                pnlDatosTransferencia.Visible = false;
            }
            else
            {
                pnlDatosTransferencia.Visible = true;
            }
        }

        // --- GUARDADO FINAL ---
        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            try
            {
                ReservaTemporal reservaTemp = (ReservaTemporal)Session["ReservaEnCurso"];
                Usuario usuarioLogueado = (Usuario)Session["usuario"];
                bool esAdmin = Seguridad.EsAdmin(usuarioLogueado) || usuarioLogueado.Rol == Dominio.Rol.Recepcionista;

                // 1. Crear Objeto Turno
                Turno nuevoTurno = new Turno();
                nuevoTurno.Fecha = reservaTemp.Fecha;
                nuevoTurno.HoraInicio = reservaTemp.Hora;

                // Si es Admin/Recepcionista y confirma el pago ahí mismo -> Confirmado (1)
                // Si es Cliente -> Pendiente (2) hasta que revisen la transferencia
                if (esAdmin)
                    nuevoTurno.Estado = new EstadoTurno { IDEstado = 1 };
                else
                    nuevoTurno.Estado = new EstadoTurno { IDEstado = 2 };

                nuevoTurno.Cliente = new Cliente { ID = usuarioLogueado.ID }; // OJO: Si el admin reserva para otro, esto debería venir de otro lado. Asumimos auto-reserva por ahora.
                nuevoTurno.Profesional = new Profesional { ID = reservaTemp.IDProfesional };
                nuevoTurno.Servicio = new Servicio { IDServicio = reservaTemp.IDServicio };

                // 2. Crear Objeto Pago
                Pago nuevoPago = new Pago();
                nuevoPago.Fecha = DateTime.Now;
                nuevoPago.EsDevolucion = false;

                // Monto
                decimal total = reservaTemp.Precio;
                nuevoPago.Monto = (rblTipoMonto.SelectedValue == "Senia") ? (total * 0.5m) : total;

                // Tipo Pago (Seña / Total)
                // Asumo IDs: 1=Seña, 2=Total
                nuevoPago.Tipo = new TipoPago { IDTipoPago = (rblTipoMonto.SelectedValue == "Senia" ? 1 : 2) };

                // Forma de Pago y Código
                if (esAdmin)
                {
                    if (rblFormaPagoAdmin.SelectedValue == "Efectivo")
                    {
                        nuevoPago.FormaDePago = new FormaPago { IDFormaPago = 1 }; // 1=Efectivo
                        nuevoPago.CodigoTransaccion = null;
                    }
                    else
                    {
                        nuevoPago.FormaDePago = new FormaPago { IDFormaPago = 2 }; // 2=Transferencia
                        nuevoPago.CodigoTransaccion = txtCodigoTransaccion.Text; // Opcional
                    }
                }
                else // Cliente
                {
                    nuevoPago.FormaDePago = new FormaPago { IDFormaPago = 2 }; // Siempre transf.
                    nuevoPago.CodigoTransaccion = txtCodigoTransaccion.Text; // Obligatorio
                }

                // 3. Guardar
                turnoNegocio.GuardarTurno(nuevoTurno, nuevoPago);

                // 4. Enviar Mail (Simulado o Real)
                if (!esAdmin)
                {
                    // EmailService.EnviarNotificacionPago(nuevoTurno, nuevoPago);
                }

                // 5. Fin
                Session["ReservaEnCurso"] = null;
                Response.Redirect("PanelPerfil.aspx?reservaExitosa=true");
            }
            catch (Exception ex)
            {
                litMensaje.Text = ex.Message;
                pnlMensaje.Visible = true;
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("ReservarTurno.aspx");
        }
    }
}
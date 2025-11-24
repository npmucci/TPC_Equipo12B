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

            
            CalcularMonto();
        }

        private void CalcularMonto()
        {
            ReservaTemporal reserva = (ReservaTemporal)Session["ReservaEnCurso"];
            decimal total = reserva.Precio;
            decimal precioTotal = reserva.Precio;
            DateTime fechaHoraTurno = reserva.Fecha.Add(reserva.Hora);
            double horasRestantes = (fechaHoraTurno - DateTime.Now).TotalHours;

            if (horasRestantes < 24)
            {
                
                decimal monto = precioTotal;
                lblMontoAPagar.Text = "$" + monto.ToString("N0");

                pnlInfoTotal.Visible = true;
                pnlInfoSenia.Visible = false;

                hfTipoPagoCalculado.Value = "Total";
            }
            else
            {
               
                decimal monto = precioTotal * 0.5m;
                lblMontoAPagar.Text = "$" + monto.ToString("N0");

                pnlInfoTotal.Visible = false;
                pnlInfoSenia.Visible = true;

                hfTipoPagoCalculado.Value = "Senia"; 
            }
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
                pnlOpcionesCliente.Visible = true; 

                pnlDatosTransferencia.Visible = true; 
                rfvCodigo.Enabled = true; 
            }
        }

        protected void rblFormaPagoAdmin_SelectedIndexChanged(object sender, EventArgs e)
        {
            
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

                
                Turno nuevoTurno = new Turno();
                nuevoTurno.Fecha = reservaTemp.Fecha;
                nuevoTurno.HoraInicio = reservaTemp.Hora;

                
                if (esAdmin)
                    nuevoTurno.Estado = new EstadoTurno { IDEstado = 1 };
                else
                    nuevoTurno.Estado = new EstadoTurno { IDEstado = 2 };

                nuevoTurno.Cliente = new Cliente { ID = usuarioLogueado.ID }; 
                nuevoTurno.Profesional = new Profesional { ID = reservaTemp.IDProfesional };
                nuevoTurno.Servicio = new Servicio { IDServicio = reservaTemp.IDServicio };


                Pago nuevoPago = new Pago();
                nuevoPago.Fecha = DateTime.Now;
                nuevoPago.EsDevolucion = false;

                decimal precioTotal = reservaTemp.Precio;
                string tipoPago = hfTipoPagoCalculado.Value; 

                if (tipoPago == "Total")
                {
                    nuevoPago.Monto = precioTotal;
                    nuevoPago.Tipo = new TipoPago { IDTipoPago = 2 }; 
                }
                else
                {
                    nuevoPago.Monto = precioTotal * 0.5m;
                    nuevoPago.Tipo = new TipoPago { IDTipoPago = 1 }; 
                }


                if (esAdmin)
                {
                    if (rblFormaPagoAdmin.SelectedValue == "Efectivo")
                    {
                        nuevoPago.FormaDePago = new FormaPago { IDFormaPago = 1 }; 
                        nuevoPago.CodigoTransaccion = null;
                    }
                    else
                    {
                        nuevoPago.FormaDePago = new FormaPago { IDFormaPago = 2 }; 
                        nuevoPago.CodigoTransaccion = txtCodigoTransaccion.Text; 
                    }
                }
                else 
                {
                    nuevoPago.FormaDePago = new FormaPago { IDFormaPago = 2 }; 
                    nuevoPago.CodigoTransaccion = txtCodigoTransaccion.Text; 
                }

                
                turnoNegocio.GuardarTurno(nuevoTurno, nuevoPago);

                
                if (!esAdmin)
                {
                    // EmailService.EnviarNotificacionPago(nuevoTurno, nuevoPago);
                }

                
                Session["ReservaEnCurso"] = null;
                Usuario usuario = (Usuario)Session["usuario"];
                string urlDestino = "Default.aspx"; 

                switch (usuario.Rol)
                {
                    case Rol.Cliente:
                        urlDestino = "PanelCliente.aspx";
                        break;
                    case Rol.Recepcionista:
                        urlDestino = "PanelRecepcionista.aspx";
                        break;
                    case Rol.Admin:
                    case Rol.ProfesionalUnico:
                        urlDestino = "PanelAdmin.aspx";
                        break;
                    case Rol.Profesional:
                        urlDestino = "PanelProfesional.aspx";
                        break;
                }

                
                Response.Redirect(urlDestino + "?reservaExitosa=true", false);
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
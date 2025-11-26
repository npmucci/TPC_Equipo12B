using System;
using System.Collections.Generic;
using System.Linq; 
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;

namespace CentroEstetica
{
    public partial class PanelRecepcionista : System.Web.UI.Page
    {
        private TurnoNegocio turnoNegocio = new TurnoNegocio();
        private PagoNegocio pagoNegocio = new PagoNegocio();
        private UsuarioNegocio usuarioNegocio = new UsuarioNegocio();

        protected void Page_Load(object sender, EventArgs e)
        {
            pnlMensajeExito.Visible = false;
            pnlMensajeError.Visible = false;
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
                    MostrarExito("La reserva se ha registrado correctamente.");
                }

                
                lblNombre.Text = usuario.Nombre + " " + usuario.Apellido;

                MostrarFechaActual();
                CargarTablas();
            }
        }
       
        private void MostrarFechaActual()
        {
            lblFechaHoy.Text = DateTime.Now.ToString("dddd, dd 'de' MMMM",
                System.Globalization.CultureInfo.CreateSpecificCulture("es-ES"));
        }

     
        public string GetComprobante(object pagoListObj)
        {
            var pagos = pagoListObj as List<Pago>;
            if (pagos != null && pagos.Count > 0)
            {
                
                var pago = pagos.FirstOrDefault(p => !p.EsDevolucion);
                return pago != null ? (pago.CodigoTransaccion ?? "No especificado") : "-";
            }
            return "-";
        }

        private void CargarTablas()
        {
            try
            {
                List<Turno> listaTodos = turnoNegocio.ListarTodos();

                
                var turnosHoy = listaTodos.FindAll(t =>
                    t.Fecha.Date == DateTime.Today.Date &&
                    (t.Estado.IDEstado == 1 || t.Estado.IDEstado == 2));

                
                var agendaCalculada = turnosHoy.Select(t => new
                {
                    t.IDTurno,
                    t.Fecha,
                    t.HoraInicio,
                    ClienteNombreCompleto = t.Cliente.Nombre + " " + t.Cliente.Apellido,
                    ProfesionalNombreCompleto = t.Profesional.Nombre + " " + t.Profesional.Apellido,
                    Servicio = t.Servicio, 
                    Estado = t.Estado,

                    
                    MontoPagado = t.Pago != null ? t.Pago.Where(p => !p.EsDevolucion).Sum(p => p.Monto) : 0,

                   
                    SaldoRestante = t.Servicio.Precio - (t.Pago != null ? t.Pago.Where(p => !p.EsDevolucion).Sum(p => p.Monto) : 0)
                }).ToList();

                
                dgvAgendaPendienteCobro.DataSource = agendaCalculada.Where(x => x.SaldoRestante > 0).ToList();
                dgvAgendaPendienteCobro.DataBind();

                
                dgvAgendaPagada.DataSource = agendaCalculada.Where(x => x.SaldoRestante <= 0).ToList();
                dgvAgendaPagada.DataBind();


                
                List<Turno> pendientes = listaTodos.FindAll(t =>
                    t.Estado.IDEstado == 2 &&
                    t.Fecha.Date >= DateTime.Today);

                dgvPendientesConfirmacion.DataSource = pendientes;
                dgvPendientesConfirmacion.DataBind();


              
                List<Turno> devoluciones = turnoNegocio.ListarTurnosParaDevolucion();
                dgvDevoluciones.DataSource = devoluciones;
                dgvDevoluciones.DataBind();
            }
            catch (Exception ex)
            {
                MostrarError("Error al cargar las tablas: " + ex.Message);
            }
        }

      
        protected void dgvAgendaPendienteCobro_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int idTurno = Convert.ToInt32(e.CommandArgument);

                if (e.CommandName == "VerPagos")
                {
                    MostrarDetalleModal(idTurno);
                }
                else if (e.CommandName == "CobrarResto")
                {
                   
                    Turno t = turnoNegocio.BuscarTurnoPorId(idTurno);

                    decimal pagado = 0;
                    if (t.Pago != null) pagado = t.Pago.Where(p => !p.EsDevolucion).Sum(p => p.Monto);

                    decimal precio = t.Servicio.Precio;
                    decimal resta = precio - pagado;

                   
                    hfIdTurnoCobrar.Value = idTurno.ToString();
                    lblTotalServicio.Text = "$" + precio.ToString("N0");
                    lblYaAbonado.Text = "$" + pagado.ToString("N0");
                    lblRestaPagar.Text = "$" + resta.ToString("N0");

                  
                    txtComprobanteCobro.Text = "";

                
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "AbrirCobro", "new bootstrap.Modal(document.getElementById('cobrarModal')).show();", true);
                }
                else if (e.CommandName == "CancelarTurno")
                {
                    hfIdTurnoCancelar.Value = idTurno.ToString();
                   
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "AbrirCancelar", "new bootstrap.Modal(document.getElementById('cancelarModal')).show();", true);
                }
            }
            catch (Exception ex)
            {
                MostrarError("Error en agenda pendiente: " + ex.Message);
            }
        }

       
        protected void dgvAgendaPagada_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int idTurno = Convert.ToInt32(e.CommandArgument);

                if (e.CommandName == "VerPagos")
                {
                    MostrarDetalleModal(idTurno);
                }
                else if (e.CommandName == "FinalizarTurno")
                {
                    
                    turnoNegocio.CambiarEstado(idTurno, 4);

                    CargarTablas();
                    MostrarExito("¡El turno ha sido marcado como Finalizado!");
                }
            }
            catch (Exception ex)
            {
                MostrarError("Error al finalizar turno: " + ex.Message);
            }
        }

       

        protected void btnConfirmarCobro_Click(object sender, EventArgs e)
        {
            try
            {
               
                if (ddlFormaPagoCobro.SelectedValue == "2" && string.IsNullOrWhiteSpace(txtComprobanteCobro.Text))
                {
                   
                    MostrarError("El comprobante es OBLIGATORIO para pagos con Transferencia.");
                    return;
                }

                int idTurno = int.Parse(hfIdTurnoCobrar.Value);

                
                Turno t = turnoNegocio.BuscarTurnoPorId(idTurno);

                
                decimal pagado = t.Pago != null ? t.Pago.Where(p => !p.EsDevolucion).Sum(p => p.Monto) : 0;

               
                decimal montoACobrar = t.Servicio.Precio - pagado;

                if (montoACobrar <= 0)
                {
                    MostrarError("Este turno ya está pagado en su totalidad.");
                    return;
                }

                
                Pago nuevoPago = new Pago();
                nuevoPago.IDTurno = idTurno;
                nuevoPago.Fecha = DateTime.Now;
                nuevoPago.Monto = montoACobrar;
                nuevoPago.EsDevolucion = false;
                nuevoPago.Tipo = new TipoPago { IDTipoPago = 1 };
                nuevoPago.FormaDePago = new FormaPago { IDFormaPago = int.Parse(ddlFormaPagoCobro.SelectedValue) };

                
                if (string.IsNullOrWhiteSpace(txtComprobanteCobro.Text))
                    nuevoPago.CodigoTransaccion = null;
                else
                    nuevoPago.CodigoTransaccion = txtComprobanteCobro.Text;

                
                pagoNegocio.AgregarPago(nuevoPago);

               
                if (t.Estado.IDEstado == 2)
                {
                    turnoNegocio.CambiarEstado(idTurno, 1);
                }

                
                CargarTablas();
                MostrarExito("Cobro registrado exitosamente. El turno ahora aparece en 'Pagados Completos'.");
            }
            catch (Exception ex)
            {
                MostrarError("Error al procesar el cobro: " + ex.Message);
            }
        }

        protected void btnConfirmarCancelacion_Click(object sender, EventArgs e)
        {
            try
            {
                int idTurno = int.Parse(hfIdTurnoCancelar.Value);

             
                bool esCulpaCliente = rbAusenciaCliente.Checked;

                if (esCulpaCliente)
                {
                    
                    turnoNegocio.CambiarEstado(idTurno, 3);

                    

                    MostrarExito("Turno cancelado por ausencia/tardanza. No corresponde devolución.");
                }
                else
                {
                    turnoNegocio.CambiarEstado(idTurno, 6);

                 
                    hfTabActivo.Value = "#v-pills-devoluciones";

                    MostrarExito("Turno cancelado por el centro. Se ha generado una solicitud de devolución.");
                }

                CargarTablas();
            }
            catch (Exception ex)
            {
                MostrarError("Error al cancelar el turno: " + ex.Message);
            }
        }


     
        protected void dgvPendientesConfirmacion_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ConfirmarTurno")
            {
                try
                {
                    int idTurno = int.Parse(e.CommandArgument.ToString());

                    turnoNegocio.CambiarEstado(idTurno, 1);

                    Turno turnoCompleto = CargarDatosCompletosTurno(idTurno);
                    EmailService.EnviarAvisoPagoAprobado(turnoCompleto.Cliente.Mail, turnoCompleto);

                    CargarTablas();
                    hfTabActivo.Value = "#v-pills-pendientes";
                    MostrarExito("Seña confirmada y cliente notificado.");
                }
                catch (Exception ex)
                {
                    MostrarError("Error al confirmar: " + ex.Message);
                }
            }
            else if (e.CommandName == "RechazarTurno")
            {
                try
                {
                    int idTurno = int.Parse(e.CommandArgument.ToString());

            
                    turnoNegocio.CambiarEstado(idTurno, 3);

                    Turno turnoCompleto = CargarDatosCompletosTurno(idTurno);
                    EmailService.EnviarAvisoPagoRechazado(turnoCompleto.Cliente.Mail, turnoCompleto, "Comprobante inválido o pago no acreditado.");

                    CargarTablas();
                    hfTabActivo.Value = "#v-pills-pendientes";
                    MostrarExito("Turno rechazado y notificación enviada.");
                }
                catch (Exception ex)
                {
                    MostrarError("Error al rechazar: " + ex.Message);
                }
            }
        }


     
        protected void dgvDevoluciones_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "AbrirModalDevolucion")
            {
                try
                {
                    int idTurno = int.Parse(e.CommandArgument.ToString());

                    Turno turno = turnoNegocio.BuscarTurnoPorId(idTurno);

                    
                    decimal totalPagado = 0;
                    if (turno.Pago != null)
                    {
                        totalPagado = turno.Pago.Where(p => !p.EsDevolucion).Sum(p => p.Monto);
                    }

                    hfIdTurnoDevolucion.Value = idTurno.ToString();
                    hfIdClienteDevolucion.Value = turno.Cliente.ID.ToString();

                    txtMontoDevolucion.Text = totalPagado.ToString("N2");
                    txtComprobanteDevolucion.Text = "";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "AbrirDevolucion", "new bootstrap.Modal(document.getElementById('devolucionModal')).show();", true);
                }
                catch (Exception ex)
                {
                    MostrarError("Error al abrir devolución: " + ex.Message);
                }
            }
        }

        protected void btnConfirmarDevolucion_Click(object sender, EventArgs e)
        {
            try
            {
                int idTurno = int.Parse(hfIdTurnoDevolucion.Value);
                int idCliente = int.Parse(hfIdClienteDevolucion.Value);
                decimal montoPositivo = decimal.Parse(txtMontoDevolucion.Text);

            
                if (ddlFormaDevolucion.SelectedValue == "2" && string.IsNullOrWhiteSpace(txtComprobanteDevolucion.Text))
                {
                    MostrarError("El comprobante es obligatorio para transferencias.");
                    return;
                }

              
                Pago devolucion = new Pago();
                devolucion.IDTurno = idTurno;
                devolucion.Fecha = DateTime.Now;
                devolucion.EsDevolucion = true;
                devolucion.Monto = montoPositivo * -1; 
                devolucion.Tipo = new TipoPago { IDTipoPago = 2 }; 
                devolucion.FormaDePago = new FormaPago { IDFormaPago = int.Parse(ddlFormaDevolucion.SelectedValue) };
                devolucion.CodigoTransaccion = txtComprobanteDevolucion.Text;

                pagoNegocio.AgregarPago(devolucion);

                
                turnoNegocio.CambiarEstado(idTurno, 5);

                
                Usuario cliente = usuarioNegocio.ObtenerPorId(idCliente);
                if (cliente != null && !string.IsNullOrEmpty(cliente.Mail))
                {
                    EmailService.EnviarConfirmacionDevolucion(
                        cliente.Mail,
                        cliente.Nombre,
                        devolucion.Monto,
                        ddlFormaDevolucion.SelectedItem.Text,
                        devolucion.CodigoTransaccion
                    );
                }

                CargarTablas();
                hfTabActivo.Value = "#v-pills-devoluciones";
                MostrarExito("Devolución registrada y notificada correctamente.");
            }
            catch (Exception ex)
            {
                MostrarError("Error al procesar la devolución: " + ex.Message);
            }
        }


       

        private Turno CargarDatosCompletosTurno(int idTurno)
        {
            Turno t = turnoNegocio.BuscarTurnoPorId(idTurno);

           
            if (string.IsNullOrEmpty(t.Cliente.Mail))
            {
                Usuario u = usuarioNegocio.ObtenerPorId(t.Cliente.ID);
                t.Cliente.Mail = u.Mail;
                t.Cliente.Nombre = u.Nombre;
            }
            return t;
        }

        private void MostrarDetalleModal(int idTurno)
        {
            try
            {
                var lista = pagoNegocio.ListarPagosDelTurno(idTurno);
                dgvPagos.DataSource = lista;
                dgvPagos.DataBind();

                Turno t = turnoNegocio.BuscarTurnoPorId(idTurno);
                if (t != null)
                {
                    litNombreTurno.Text = $"{t.Servicio.Nombre} - {t.Cliente.Nombre} {t.Cliente.Apellido}";
                }

                string script = "new bootstrap.Modal(document.getElementById('pagoModal')).show();";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", script, true);
            }
            catch (Exception ex)
            {
                MostrarError("No se pudieron cargar los detalles: " + ex.Message);
            }
        }

        private void MostrarExito(string msg)
        {
            lblMensajeExito.Text = msg;
            pnlMensajeExito.Visible = true;
            pnlMensajeError.Visible = false;
        }

        private void MostrarError(string msg)
        {
            lblMensajeError.Text = msg;
            pnlMensajeError.Visible = true;
            pnlMensajeExito.Visible = false;
        }

      
        protected void dgvTurnos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
          
        }
    }
}
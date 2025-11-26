using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CentroEstetica
{
    public partial class PanelRecepcionista : System.Web.UI.Page
    {
        private TurnoNegocio turnoNegocio = new TurnoNegocio();
        private PagoNegocio pagoNegocio = new PagoNegocio();
        private UsuarioNegocio usuarioNegocio = new UsuarioNegocio();

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
                return pagos[0].CodigoTransaccion ?? "No especificado";
            }
            return "-";
        }

        private void CargarTablas()
        {
            try
            {
                List<Turno> listaTodos = turnoNegocio.ListarTodos();

                // AGENDA DEL DÍA (Turnos Confirmados o Pendientes de HOY)
                
                List<Turno> agendaHoy = listaTodos.FindAll(t =>
                    t.Fecha.Date == DateTime.Today.Date &&
                    (t.Estado.IDEstado == 1 || t.Estado.IDEstado == 2));

                dgvTurnos.DataSource = agendaHoy;
                dgvTurnos.DataBind();

                // PENDIENTES DE CONFIRMACIÓN (Para verificar pagos)
                
                List<Turno> pendientes = listaTodos.FindAll(t =>
                    t.Estado.IDEstado == 2 &&
                    t.Fecha.Date >= DateTime.Today);

                dgvPendientesConfirmacion.DataSource = pendientes;
                dgvPendientesConfirmacion.DataBind();

                // PENDIENTES DE DEVOLUCIÓN
                
                List<Turno> devoluciones = turnoNegocio.ListarTurnosParaDevolucion();
                dgvDevoluciones.DataSource = devoluciones;
                dgvDevoluciones.DataBind();
            }
            catch (Exception ex)
            {
                MostrarError("Error al cargar las tablas: " + ex.Message);
            }
        }

        
        // LÓGICA DE LA AGENDA DEL DÍA
        

        protected void dgvTurnos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            dgvTurnos.PageIndex = e.NewPageIndex;
            CargarTablas();
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
                MostrarError("Error en agenda: " + ex.Message);
            }
        }

        
        // LÓGICA DE PENDIENTES DE CONFIRMACIÓN
        

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
                    MostrarExito("Turno confirmado y cliente notificado.");
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

        
        // LÓGICA DE DEVOLUCIONES
        

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
                        foreach (var p in turno.Pago)
                        {
                            if (!p.EsDevolucion) totalPagado += p.Monto;
                        }
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

        
        // MÉTODOS AUXILIARES Y MODALES
       

        
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

                string script = "var modal = new bootstrap.Modal(document.getElementById('pagoModal')); modal.show();";
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
    }
}
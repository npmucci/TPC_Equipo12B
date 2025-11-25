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
    public partial class ModificarTurno : System.Web.UI.Page
    {
        private int idTurno;
        private TurnoNegocio turnoNegocio = new TurnoNegocio();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                if (!int.TryParse(Request.QueryString["IDTurno"], out idTurno))
                {
                    Response.Redirect("PanelRecepcionista.aspx");
                    return;
                }
                PagoNegocio pagoNegocio = new PagoNegocio();

                Turno turno = turnoNegocio.BuscarTurnoPorId(idTurno);
                if (turno.Estado.Descripcion == "CanceladoCliente" || turno.Estado.Descripcion == "CanceladoProfesional")
                {
                    pnlRegistrarPago.Visible = false;
                    pnlRegistrarDevolucion.Visible = true;
                }
                else
                {
                    pnlRegistrarPago.Visible = true;
                    pnlRegistrarDevolucion.Visible = false;
                }

                CargarDatosTurno();
                CargarEstados();
                CargarTipoPago();
                CargarFormaPago();
            }
            else
            {
                if (!int.TryParse(Request.QueryString["IDTurno"], out idTurno))
                {
                    Response.Redirect("PanelRecepcionista.aspx");
                    return;
                }
            }
        }

        private void CargarDatosTurno()
        {

            PagoNegocio pagoNegocio = new PagoNegocio();

            Turno turno = turnoNegocio.BuscarTurnoPorId(idTurno);
            if (turno == null)
            {
                Response.Redirect("PanelRecepcionista.aspx");
                return;
            }



            lblFecha.Text = turno.Fecha.ToString("dd/MM/yyyy");
            lblHora.Text = turno.HoraInicio.ToString(@"hh\:mm");
            lblServicio.Text = turno.Servicio.Nombre;
            lblProfesional.Text = turno.ProfesionalNombreCompleto;
            lblCliente.Text = turno.ClienteNombreCompleto;
            lblEstadoActual.Text = turno.Estado.Descripcion;

            // Repeater pagos
            repPagos.DataSource = turno.Pago;
            repPagos.DataBind();
        }

        private void CargarEstados()
        {

            ddlEstado.DataSource = turnoNegocio.ListarEstados();
            ddlEstado.DataTextField = "Descripcion";
            ddlEstado.DataValueField = "IDEstado";
            ddlEstado.DataBind();

            TurnoNegocio tn = new TurnoNegocio();
            Turno t = tn.BuscarTurnoPorId(idTurno);
            ddlEstado.SelectedValue = ((int)t.Estado.IDEstado).ToString();
        }

        private void CargarTipoPago()
        {

            ddlTipoPago.DataSource = turnoNegocio.ListarTiposPago();
            ddlTipoPago.DataTextField = "Descripcion";
            ddlTipoPago.DataValueField = "IDTipoPago";
            ddlTipoPago.DataBind();
        }

        private void CargarFormaPago()
        {
            ddlFormaPago.DataSource = turnoNegocio.ListarFormasPago();
            ddlFormaPago.DataTextField = "Descripcion";
            ddlFormaPago.DataValueField = "IDFormaPago";
            ddlFormaPago.DataBind();
        }

        protected void btnGuardarEstado_Click(object sender, EventArgs e)
        {

            int nuevoEstado = int.Parse(ddlEstado.SelectedValue);
            turnoNegocio.CambiarEstado(idTurno, nuevoEstado);
            CargarDatosTurno();
        }

        protected void btnAgregarPago_Click(object sender, EventArgs e)
                    {
            Pago pago = new Pago();
            if (decimal.TryParse(txtMonto.Text, out decimal monto))
            {
               


                pago.IDTurno = idTurno;
                pago.Monto = monto;
                pago.EsDevolucion = false;
                pago.Tipo = new TipoPago
                {
                    IDTipoPago = int.Parse(ddlTipoPago.SelectedValue)
                };
                pago.FormaDePago = new FormaPago
                {
                    IDFormaPago = int.Parse(ddlFormaPago.SelectedValue)
                };
               pago.Fecha = DateTime.Now;
                
            }
            ;

            PagoNegocio pagoNeg = new PagoNegocio();
            pagoNeg.AgregarPago(pago);

            // Limpiar textbox
            txtMonto.Text = "";

            // Refrescar pagos
            CargarDatosTurno();
        }
        

        protected void btnRegistrarDevolucion_Click(object sender, EventArgs e)
        {
            if (decimal.TryParse(txtMontoDevolucion.Text, out decimal monto))
            {
                Pago devolucion = new Pago
                {
                    IDTurno = idTurno,
                    Monto = monto,
                    EsDevolucion = true,
                    Fecha = DateTime.Now,
                    Tipo = new TipoPago
                    {
                        IDTipoPago = int.Parse(ddlTipoPago.SelectedValue)
                    },
                    FormaDePago = new FormaPago
                    {
                        IDFormaPago = int.Parse(ddlFormaPago.SelectedValue)
                    }

                };

                PagoNegocio pagoNeg = new PagoNegocio();
                pagoNeg.AgregarPago(devolucion);

                // Limpiar textbox
                txtMontoDevolucion.Text = "";

                // Refrescar pagos
                CargarDatosTurno();
            }
        }
    }
}

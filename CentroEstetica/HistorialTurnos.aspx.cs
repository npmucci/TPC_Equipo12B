using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CentroEstetica
{
    public partial class HistorialTurnos : System.Web.UI.Page
    {
        public bool FiltroAvanzado { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Seguridad.SesionActiva(Session["usuario"]))
            {
                Response.Redirect("Default.aspx", false);
                return;
            }
            int IdUsuario = ((Usuario)Session["usuario"]).ID;
            int rolUsuario = (int) ((Usuario)Session["usuario"]).Rol;
            ConfigurarBotonVolver(rolUsuario);
            if (!IsPostBack)
            {
                MostrarFechaActual();
                CargarFiltrosIniciales();
                TurnoNegocio negocio = new TurnoNegocio();
                List<Turno> listaTurnos= negocio.ListarTodos(); ;
               /*
                if (rolUsuario == 2 || rolUsuario == 3) 
                {

                    listaTurnos = listaTurnos.FindAll(t => (t.Profesional?.ID  == IdUsuario) || (t.Cliente?.ID  == IdUsuario)
);
                }
                */
                Session.Add("listaTurnosHistorial", listaTurnos);
                dgvTurnos.DataSource = Session["listaTurnosHistorial"];
                dgvTurnos.DataBind();
            }
        }

        private void MostrarFechaActual()
        {

            lblFechaHoy.Text = DateTime.Now.ToString("dddd, dd 'de' MMMM",
                System.Globalization.CultureInfo.CreateSpecificCulture("es-ES"));
        }
        private void CargarFiltrosIniciales()
        {
            TurnoNegocio turnoNegocio = new TurnoNegocio();
            EspecialidadNegocio especialidadNegocio = new EspecialidadNegocio();
            ddlEstado.DataSource = turnoNegocio.ListarEstados();
            ddlEstado.DataTextField = "Descripcion";
            ddlEstado.DataValueField = "IDEstado";
            ddlEstado.DataBind();
            ddlEstado.Items.Insert(0, new ListItem("Todos", "0"));
        }

        protected void filtro_TextChanged(object sender, EventArgs e)
        {
            TurnoNegocio negocio = new TurnoNegocio();
            List<Turno> listaBase = negocio.ListarTodos();
            string filtro = txtFiltro.Text.Trim().ToUpper();

            List<Turno> listaFiltrada = listaBase;

            if (!string.IsNullOrWhiteSpace(filtro))
            {
                listaFiltrada = listaBase.FindAll(x => x.ClienteNombreCompleto.ToUpper().Contains(filtro) ||  x.ProfesionalNombreCompleto.ToUpper().Contains(filtro) ||  x.Servicio.Nombre.ToUpper().Contains(filtro));
            }

            Session["listaTurnosHistorial"] = listaFiltrada;
            dgvTurnos.DataSource = listaFiltrada;
            dgvTurnos.DataBind();
        }

        protected void chkAvanzado_CheckedChanged(object sender, EventArgs e)
        {
           

            TurnoNegocio negocio = new TurnoNegocio();

                     Session["listaTurnosHistorial"] = negocio.ListarTodos();

            txtFiltro.Text = "";
            txtFiltro.Enabled = !chkAvanzado.Checked;

            dgvTurnos.DataSource = Session["listaTurnosHistorial"];
            dgvTurnos.DataBind();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                int idEstado = int.Parse(ddlEstado.SelectedValue);
                DateTime fechaDesde = DateTime.MinValue;
                DateTime fechaHasta = DateTime.MaxValue;

                if (!string.IsNullOrEmpty(txtFechaDesde.Text))
                {
                    fechaDesde = Convert.ToDateTime(txtFechaDesde.Text);
                }

                if (!string.IsNullOrEmpty(txtFechaHasta.Text))
                {
                  
                    fechaHasta = Convert.ToDateTime(txtFechaHasta.Text).AddDays(1).AddSeconds(-1);
                }
                TurnoNegocio negocio = new TurnoNegocio();
                List<Turno> listaFiltrada = negocio.FiltrarTurnos(idEstado, fechaDesde,fechaHasta);
                Session["listaTurnosHistorial"] = listaFiltrada;
                dgvTurnos.DataSource = listaFiltrada;
                dgvTurnos.DataBind();
            }
            catch (Exception ex)
            {
                throw (ex);
            }
        }
        protected void dgvTurnos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
         
            if (Session["listaTurnosHistorial"] != null)
            {
                dgvTurnos.DataSource = Session["listaTurnosHistorial"];
                dgvTurnos.PageIndex = e.NewPageIndex;
                dgvTurnos.DataBind();
            }
           
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
        private void ConfigurarBotonVolver(int rolID)
        {
            string urlPanel = "~/Default.aspx";
                switch (rolID)
                {
                    case 1: 
                        urlPanel = "~/PanelAdmin.aspx";
                        break;
                    case 2: 
                        urlPanel = "~/PanelProfesional.aspx";
                        break;
                    case 3: 
                        urlPanel = "~/PanelCliente.aspx";
                        break;
                    case 4:  
                        urlPanel = "~/PanelRecepcionista.aspx";
                        break;
                default:
                       
                        urlPanel = "~/Default.aspx";
                        break;
                }                
                lnkVolver.NavigateUrl = urlPanel;
            }
          
    }
}
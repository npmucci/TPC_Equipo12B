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
    public partial class HistorialTurnos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           /* if (!Seguridad.EsRecepcionista(Session["usuario"]))
            {
                Response.Redirect("Default.aspx", false);
                return;
            }
           */

            if (!IsPostBack)
            {
  
                MostrarFechaActual();
                CargarFiltrosIniciales();
                TurnoNegocio negocio = new TurnoNegocio();
                List<Turno> listaTurnos = negocio.ListarTodos();
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
            ddlEspecialidad.DataSource = especialidadNegocio.ListarActivos();
            ddlEspecialidad.DataTextField = "Nombre";
            ddlEspecialidad.DataValueField = "IDEspecialidad";
            ddlEspecialidad.DataBind();
            ddlEspecialidad.Items.Insert(0, new ListItem("Todas", "0"));
            ddlProfesional.Items.Insert(0, new ListItem("Todos", "0"));
            ddlServicio.Items.Insert(0, new ListItem("Todos", "0"));
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
            pnlAvanzado.Visible = chkAvanzado.Checked;

            TurnoNegocio negocio = new TurnoNegocio();

                     Session["listaTurnosHistorial"] = negocio.ListarTodos();

            txtFiltro.Text = "";
            txtFiltro.Enabled = !chkAvanzado.Checked;

            dgvTurnos.DataSource = Session["listaTurnosHistorial"];
            dgvTurnos.DataBind();
        }


        protected void ddlEspecialidad_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                ddlProfesional.Items.Clear();
                ddlServicio.Items.Clear();
                int idEspecialidad = int.Parse(ddlEspecialidad.SelectedValue);
                ProfesionalNegocio profNeg = new ProfesionalNegocio();
                ddlProfesional.DataSource = profNeg.ListarPorEspecialidad(idEspecialidad);
                ddlProfesional.DataTextField = "NombreCompleto";
                ddlProfesional.DataValueField = "ID";
                ddlProfesional.DataBind();

                ServicioNegocio servNeg = new ServicioNegocio();
                ddlServicio.DataSource = servNeg.ListarPorEspecialidad(idEspecialidad);
                ddlServicio.DataTextField = "Nombre";
                ddlServicio.DataValueField = "IDServicio";
                ddlServicio.DataBind();
            }
            catch (Exception ex)
            {
                throw (ex);
            }

            ddlProfesional.Items.Insert(0, new ListItem("Todos", "0"));
            ddlServicio.Items.Insert(0, new ListItem("Todos", "0"));
        }

        protected void ddlProfesional_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlServicio.Items.Clear();
            int idEspecialidad = int.Parse(ddlEspecialidad.SelectedValue);
       

          if (idEspecialidad != 0)
            {
                ServicioNegocio servNeg = new ServicioNegocio();
                ddlServicio.DataSource = servNeg.ListarPorEspecialidad(idEspecialidad);
                ddlServicio.DataTextField = "Nombre";
                ddlServicio.DataValueField = "IDServicio";
                ddlServicio.DataBind();
            }

            ddlServicio.Items.Insert(0, new ListItem("Todos", "0"));
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                int idEstado = int.Parse(ddlEstado.SelectedValue); 
                int idEspecialidad = int.Parse(ddlEspecialidad.SelectedValue); 
                int idProfesional = int.Parse(ddlProfesional.SelectedValue);
                int idServicio = 0; 
                           
                if (ddlServicio.SelectedValue != "0" && !string.IsNullOrEmpty(ddlServicio.SelectedValue))
                {
                    idServicio = int.Parse(ddlServicio.SelectedValue);
                }

                TurnoNegocio negocio = new TurnoNegocio();
                List<Turno> listaFiltrada = negocio.FiltrarTurnos(idEstado, idEspecialidad, idProfesional,  idServicio);
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
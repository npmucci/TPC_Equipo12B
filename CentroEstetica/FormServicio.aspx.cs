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
    public partial class FormServicio : System.Web.UI.Page
    {
        private ServicioNegocio servNegocio = new ServicioNegocio();
        private EspecialidadNegocio espNegocio = new EspecialidadNegocio();
        private bool esModoEdicion = false;
        private int idEdicion = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Seguridad.EsAdmin(Session["usuario"]))
            {
                Response.Redirect("Default.aspx", false);
                return;
            }

            if (Request.QueryString["id"] != null)
            {
                esModoEdicion = true;
                int.TryParse(Request.QueryString["id"], out idEdicion);
            }

            if (!IsPostBack)
            {
                CargarEspecialidades();

                if (esModoEdicion && idEdicion > 0)
                {
                    // MODO EDICIÓN
                    CargarDatosServicio();
                }
                else
                {
                    // MODO CREACIÓN
                    tituloPagina.InnerText = "Nuevo Servicio";
                    btnGuardar.Text = "Crear Servicio";
                    pnlControlesEdicion.Visible = false;


                    if (Request.QueryString["idEspecialidad"] != null)
                    {
                        ddlEspecialidad.SelectedValue = Request.QueryString["idEspecialidad"];
                        ddlEspecialidad.Enabled = false;
                    }
                }
            }
        }

        private void CargarEspecialidades()
        {
            try
            {
                
                ddlEspecialidad.DataSource = espNegocio.ListarActivos();
                ddlEspecialidad.DataValueField = "IDEspecialidad";
                ddlEspecialidad.DataTextField = "Nombre";
                ddlEspecialidad.DataBind();
                ddlEspecialidad.Items.Insert(0, new ListItem("Seleccione una Especialidad", "0"));
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al cargar especialidades: " + ex.Message, "danger");
            }
        }

        private void CargarDatosServicio()
        {
            try
            {
                Servicio servicio = servNegocio.ObtenerPorId(idEdicion);
                if (servicio != null)
                {

                    txtNombre.Text = servicio.Nombre;
                    txtDescripcion.Text = servicio.Descripcion;
                    txtPrecio.Text = servicio.Precio.ToString("N0");
                    txtDuracion.Text = servicio.DuracionMinutos.ToString();
                    chkActivo.Checked = servicio.Activo;


                    if (ddlEspecialidad.Items.FindByValue(servicio.Especialidad.IDEspecialidad.ToString()) != null)
                    {
                        ddlEspecialidad.SelectedValue = servicio.Especialidad.IDEspecialidad.ToString();
                    }


                    tituloPagina.InnerText = "Editar Servicio";
                    btnGuardar.Text = "Guardar Cambios";
                    pnlControlesEdicion.Visible = true;
                }
                else
                {
                    MostrarMensaje("Error: No se encontró el servicio solicitado.", "danger");
                    btnGuardar.Enabled = false;
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al cargar datos: " + ex.Message, "danger");
                btnGuardar.Enabled = false;
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                Servicio serv = new Servicio();
                serv.Nombre = txtNombre.Text.Trim();
                serv.Descripcion = txtDescripcion.Text.Trim();
                serv.Precio = decimal.Parse(txtPrecio.Text);
                serv.DuracionMinutos = int.Parse(txtDuracion.Text);

                serv.Especialidad = new Especialidad();
                serv.Especialidad.IDEspecialidad = int.Parse(ddlEspecialidad.SelectedValue);

                if (esModoEdicion)
                {
                    serv.IDServicio = idEdicion;
                    serv.Activo = chkActivo.Checked;
                    servNegocio.Modificar(serv);
                }
                else
                {
                    servNegocio.Agregar(serv);
                }

                
                MostrarMensaje("¡Servicio guardado correctamente!", "success");

                btnGuardar.Visible = false;
                btnVolver.Text = "Volver al Panel";
                btnVolver.CssClass = "btn btn-success";

                BloquearFormulario();

                
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al guardar: " + ex.Message, "danger");
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("PanelAdmin.aspx", false);
        }

        private void MostrarMensaje(string mensaje, string tipo)
        {
            pnlMensaje.Visible = true;
            pnlMensaje.CssClass = $"alert alert-{tipo}";
            litMensaje.Text = mensaje;
        }

        private void BloquearFormulario()
        {
            ddlEspecialidad.Enabled = false;
            txtNombre.Enabled = false;
            txtDescripcion.Enabled = false;
            txtPrecio.Enabled = false;
            txtDuracion.Enabled = false;
            chkActivo.Disabled = true;
        }
    }
}
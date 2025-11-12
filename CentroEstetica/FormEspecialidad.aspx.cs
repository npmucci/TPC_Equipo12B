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
    public partial class FormEspecialidad : System.Web.UI.Page
    {
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
                if (esModoEdicion && idEdicion > 0)
                {
                    // MODO EDICIÓN
                    CargarDatosEspecialidad();
                }
                else
                {
                    // MODO CREACIÓN
                    tituloPagina.InnerText = "Nueva Especialidad";
                    btnGuardar.Text = "Crear Especialidad";
                    pnlControlesEdicion.Visible = false;
                }
            }
        }

        private void CargarDatosEspecialidad()
        {
            try
            {
                Especialidad especialidad = espNegocio.ObtenerPorId(idEdicion);
                if (especialidad != null)
                {
                    
                    txtNombre.Text = especialidad.Nombre;
                    txtDescripcion.Text = especialidad.Descripcion;
                    txtFoto.Text = especialidad.Foto;
                    chkActivo.Checked = especialidad.Activo;

                    
                    tituloPagina.InnerText = "Editar Especialidad";
                    btnGuardar.Text = "Guardar Cambios";
                    pnlControlesEdicion.Visible = true;
                }
                else
                {
                    MostrarMensaje("Error: No se encontró la especialidad solicitada.", "danger");
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
                Especialidad esp = new Especialidad();
                esp.Nombre = txtNombre.Text.Trim();
                esp.Descripcion = txtDescripcion.Text.Trim();
                esp.Foto = txtFoto.Text.Trim();

                if (esModoEdicion)
                {
                    // LÓGICA DE MODIFICACIÓN
                    esp.IDEspecialidad = idEdicion;
                    esp.Activo = chkActivo.Checked;
                    espNegocio.Modificar(esp);
                }
                else
                {
                    // LÓGICA DE CREACIÓN              
                    espNegocio.Agregar(esp);
                }

                
                Response.Redirect("PanelAdmin.aspx", false);
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
    }
}
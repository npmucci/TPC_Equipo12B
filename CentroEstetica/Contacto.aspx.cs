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
    public partial class Contacto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["usuario"] != null)
                {
                    Usuario user = (Usuario)Session["usuario"];
                    if (user.Rol == Rol.Cliente)
                    {
                        txtNombre.Text = user.Nombre + " " + user.Apellido;
                        txtEmail.Text = user.Mail;
                        txtEmail.ReadOnly = true;
                        txtNombre.ReadOnly = true;
                        txtEmail.CssClass += " bg-light";
                    }
                }
            }
        }

        protected void btnEnviar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    
                    EmailService.EnviarConsultaWeb(
                        txtNombre.Text,
                        txtEmail.Text,
                        txtAsunto.Text,
                        txtMensaje.Text
                    );

                    MostrarMensaje("¡Gracias! El correo se ha enviado exitosamente.", "success");
                    LimpiarFormularioParcial();
                }
                catch (Exception ex)
                {
                    Session.Add("error", ex);
                    Response.Redirect("Error.aspx");
                }
            }
        }

        private void MostrarMensaje(string mensaje, string tipo)
        {
            pnlMensaje.Visible = true;
            pnlMensaje.CssClass = $"alert alert-{tipo} alert-dismissible fade show mb-4";
            litMensaje.Text = mensaje;
        }

        private void LimpiarFormularioParcial()
        {
            if (Session["usuario"] == null)
            {
                txtNombre.Text = string.Empty;
                txtEmail.Text = string.Empty;
            }
            txtAsunto.Text = string.Empty;
            txtMensaje.Text = string.Empty;
        }
    }
}
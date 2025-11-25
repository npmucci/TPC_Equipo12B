using System;
using Negocio;

namespace CentroEstetica
{
    public partial class RecuperarPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRecuperar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            try
            {
                UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
                usuarioNegocio.RecuperarAcceso(txtEmail.Text.Trim());

                // Éxito
                pnlMensaje.Visible = true;
                pnlMensaje.CssClass = "alert alert-success text-center";
                litMensaje.Text = "<i class='bi bi-check-circle-fill me-2'></i>¡Listo! Te enviamos la nueva contraseña a tu correo.";

                // Bloquear botón para evitar reenvíos
                btnRecuperar.Enabled = false;
                btnRecuperar.CssClass += " disabled";
            }
            catch (Exception ex)
            {
                pnlMensaje.Visible = true;
                pnlMensaje.CssClass = "alert alert-danger text-center";
                litMensaje.Text = ex.Message;
            }
        }
    }
}
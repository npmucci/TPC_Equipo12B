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
    public partial class CambiarContrasenia : System.Web.UI.Page
    {
        private UsuarioNegocio negocio = new UsuarioNegocio();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Seguridad.SesionActiva(Session["usuario"]))
            {
                Response.Redirect("Default.aspx", false);
                return;
            }
            if (IsPostBack)
            {
                lblErrorPass.Visible = false;
                lblErrorPass.Text = "";
                lblExitoPass.Visible = false;
                lblExitoPass.Text = "";
            }

        }


        protected void btnGuardarContrasenia_Click(object sender, EventArgs e)
        {
            lblErrorPass.Text = string.Empty;
            lblExitoPass.Text = string.Empty;
            lblErrorPass.Visible = false; 
            lblExitoPass.Visible = false;

            Page.Validate("PassGroup");


            if (!Page.IsValid)
                return;


            


            try
            {
                Usuario usuarioActual = (Usuario)Session["usuario"];
                string passActualIngresada = txtPassActual.Text;
                string passNueva = txtPassNueva.Text;

                Usuario usuarioVerificado = negocio.Login(usuarioActual.Mail, passActualIngresada);

                if (usuarioVerificado == null)
                {

                    // Error: Contraseña actual incorrecta
                    lblErrorPass.Text = "La Contraseña Actual es incorrecta.";
                    lblErrorPass.Visible = true;

                    return;
                }

                negocio.ActualizarPassword(usuarioVerificado.ID, passNueva);


                // exito
                lblExitoPass.Text = "Contraseña actualizada con éxito.";
                lblExitoPass.Visible = true;
                
                // Limpiar campos
                txtPassActual.Text = string.Empty;
                txtPassNueva.Text = string.Empty;
                txtPassConfirmar.Text = string.Empty;

            }
            catch (Exception ex)
            {
                lblErrorPass.Text = "Ocurrió un error inesperado al actualizar: " + ex.Message;
                lblErrorPass.Visible = true;


            }
        }
    }
}

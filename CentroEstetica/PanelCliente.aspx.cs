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
    public partial class PanelCliente : System.Web.UI.Page
    {

        ClienteNegocio negocio = new ClienteNegocio();
        TurnoNegocio turnosNegocio = new TurnoNegocio();

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Seguridad.EsCliente(Session["usuario"]))
            {
                Response.Redirect("Default.aspx", false);
                return;
            }
            if (!IsPostBack)
            {
                Cliente cliente = (Cliente)Session["usuario"];
             

                rptTurnosPasados.DataSource = turnosNegocio.ListarTurnosPasadosCliente((int)cliente.ID);
                rptTurnosPasados.DataBind();

                rptTurnosActuales.DataSource = turnosNegocio.ListarTurnosActualesCliente((int)cliente.ID);
                rptTurnosActuales.DataBind();
            }
        }
        /*
        protected void btnCambiarPass_Click(object sender, EventArgs e)
        {


            txtPassActual.Text = string.Empty;
            txtPassNueva.Text = string.Empty;
            txtPassConfirmar.Text = string.Empty;

            lblErrorPass.Visible = false;
            lblExitoPass.Visible = false;
            lblErrorPass.Text = string.Empty;
            lblExitoPass.Text = string.Empty;

            updCambiarPass.Update();
            ScriptManager.RegisterStartupScript(this, GetType(), "MostrarModalCambiarPass", "abrirModalCambiarPass();", true);

        }
        protected void btnGuardarContrasenia_Click(object sender, EventArgs e)
        {
            //escondemos los mensajes y ponemos el texto en vacio
            lblErrorPass.Visible = false;
            lblExitoPass.Visible = false;
            lblErrorPass.Text = string.Empty;
            lblExitoPass.Text = string.Empty;

            Page.Validate("PassGroup");
            if (!Page.IsValid)
            {
                updCambiarPass.Update();
                ScriptManager.RegisterStartupScript(this, GetType(), "ReabrirModal", "abrirModalCambiarPass();", true);
                return;
            }

            try
            {
                Usuario usuario = (Usuario)Session["usuario"];
                string passActualIngresada = txtPassActual.Text;
                UsuarioNegocio negocio = new UsuarioNegocio();

                Usuario usuarioVerificado = negocio.Login(usuario.Mail, passActualIngresada);

                if (usuarioVerificado == null)
                {

                    // Error: Contraseña actual incorrecta
                    lblErrorPass.Text = "La **Contraseña Actual** es incorrecta.";
                    lblErrorPass.Visible = true;

                    ScriptManager.RegisterStartupScript(this, GetType(), "ReabrirModal", "abrirModalCambiarPass();", true);
                    updCambiarPass.Update();

                    return;
                }


                string passNueva = txtPassNueva.Text;
                negocio.ActualizarPassword(usuarioVerificado.ID, passNueva);


                // exito
                lblExitoPass.Text = "Contraseña actualizada con éxito.";
                lblExitoPass.Visible = true;
                ScriptManager.RegisterStartupScript(this, GetType(), "CerrarModalCambiarPass", "setTimeout(function() { cerrarModalCambiarPass(); }, 1500);", true);

                // Limpiar campos
                txtPassActual.Text = string.Empty;
                txtPassNueva.Text = string.Empty;
                txtPassConfirmar.Text = string.Empty;
                updCambiarPass.Update();
                btnCambiarPass.Visible = false;
            }
            catch (Exception ex)
            {
                lblErrorPass.Text = "Ocurrió un error inesperado al actualizar: " + ex.Message;
                lblErrorPass.Visible = true;


            }
        */
        


    }
}





using Dominio;
using Negocio;
using System;
using System.Web.UI;


namespace CentroEstetica
{
    public partial class PanelPerfil : System.Web.UI.Page
    {
        UsuarioNegocio negocio = new UsuarioNegocio();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Seguridad.SesionActiva(Session["usuario"]))
            {
                Response.Redirect("Default.aspx", false);
                return;
            }

            if (!IsPostBack)
            {
                Usuario usuario = (Usuario)Session["usuario"];
                txtMail.ReadOnly = true;
                CargarDatos(usuario);
                ModoLectura();
            }

        }


        private void CargarDatos(Usuario usuario)
        {
            if (usuario != null)
            {
                txtNombre.Text = usuario.Nombre;
                txtApellido.Text = usuario.Apellido;
                txtMail.Text = usuario.Mail;
                txtTelefono.Text = usuario.Telefono;
                txtDomicilio.Text = usuario.Domicilio;
            }

        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            divMensaje.Visible = false;
            ModoEdicion();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                Usuario UsuarioActual = (Usuario)Session["usuario"];

                UsuarioActual.Nombre = txtNombre.Text;
                UsuarioActual.Apellido = txtApellido.Text;
                UsuarioActual.Telefono = txtTelefono.Text;
                UsuarioActual.Domicilio = txtDomicilio.Text;
             

                negocio.Modificar(UsuarioActual);
                Session["usuario"] = UsuarioActual;


                divMensaje.Visible = true;
                lblMensaje.Text = "Datos guardados correctamente.";
                lblMensaje.CssClass = "alert alert-success d-block mt-3";

                ModoLectura(false);
            }
            catch (Exception ex) {
                throw ex;

            }
        }


        protected void btnCancelar_Click(object sender, EventArgs e)
        {

            Usuario UsuarioOriginal = (Usuario)Session["usuario"];
            CargarDatos(UsuarioOriginal);
            ModoLectura();

        }

        private void ModoLectura(bool ocultarMensaje = true)
        {
            txtNombre.ReadOnly = txtApellido.ReadOnly = txtMail.ReadOnly =
            txtTelefono.ReadOnly = txtDomicilio.ReadOnly = true;

            btnEditar.Visible = true;
            btnGuardar.Visible = false;
            btnCancelar.Visible = false;

            if (ocultarMensaje)
                divMensaje.Visible = false;

            rfvNombre.Enabled = false;
            rfvApellido.Enabled = false;
            rfvMail.Enabled = false;
            revMail.Enabled = false;
            rfvTelefono.Enabled = false;
            revTelefono.Enabled = false;
        }

        private void ModoEdicion()
        {
            txtNombre.ReadOnly = txtApellido.ReadOnly = txtMail.ReadOnly =
            txtTelefono.ReadOnly = txtDomicilio.ReadOnly = false;

            btnEditar.Visible = false;
            btnGuardar.Visible = true;
            btnCancelar.Visible = true;

            rfvNombre.Enabled = true;
            rfvApellido.Enabled = true;
            rfvMail.Enabled = true;
            revMail.Enabled = true;
            rfvTelefono.Enabled = true;
            revTelefono.Enabled = true;
        }


    }
}

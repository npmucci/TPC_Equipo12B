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
            if (Session["usuario"] == null)
            {
                Response.Redirect("Default.aspx", false);
                return;
            }

            if (!IsPostBack)
            {
                Usuario usuarioLogueado = (Usuario)Session["usuario"];
                string idQuery = Request.QueryString["id"];
                string adminMode = Request.QueryString["adminMode"];

                // DETECTAR SI ES ADMIN EDITANDO A OTRO
                if (!string.IsNullOrEmpty(idQuery) && adminMode == "true" && Seguridad.EsAdmin(usuarioLogueado))
                {
                    int idUsuarioAEditar = int.Parse(idQuery);
                    Usuario usuarioAEditar = negocio.ObtenerPorId(idUsuarioAEditar);

                    if (usuarioAEditar != null)
                    {
                        hfIdUsuario.Value = usuarioAEditar.ID.ToString();
                        lblTituloPerfil.Text = "Modificar Datos de Usuario";

                        // MOSTRAR BOTONES DE ADMIN
                        btnVolverAdmin.Visible = true;
                        btnBlanquearPass.Visible = true; // Habilitamos blanquear pass

                        CargarDatos(usuarioAEditar);
                        ModoLectura();
                    }
                }
                else
                {
                    // MI PERFIL (Usuario normal o Admin editandose a si mismo)
                    hfIdUsuario.Value = usuarioLogueado.ID.ToString();
                    lblTituloPerfil.Text = "Mi Perfil";

                    btnVolverAdmin.Visible = false;
                    btnBlanquearPass.Visible = false;

                    CargarDatos(usuarioLogueado);
                    ModoLectura();
                }
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

                int idUsuario = int.Parse(hfIdUsuario.Value);


                Usuario usuarioAActualizar = negocio.ObtenerPorId(idUsuario);


                usuarioAActualizar.Mail = usuarioAActualizar.Mail; //  restaurar mail por si intentan mandar el post con un campo oculto


                // Actualizamos con los datos del formulario
                usuarioAActualizar.Nombre = txtNombre.Text;
                usuarioAActualizar.Apellido = txtApellido.Text;
                usuarioAActualizar.Telefono = txtTelefono.Text;
                usuarioAActualizar.Domicilio = txtDomicilio.Text;


                negocio.Modificar(usuarioAActualizar);


                Usuario usuarioLogueado = (Usuario)Session["usuario"];
                if (usuarioLogueado.ID == idUsuario)
                {
                    Session["usuario"] = usuarioAActualizar;
                }


                divMensaje.Visible = true;
                lblMensaje.Text = "Datos guardados correctamente.";
                lblMensaje.CssClass = "alert alert-success d-block mt-3";

                ModoLectura(false);


            }
            catch (Exception ex)
            {

                divMensaje.Visible = true;
                lblMensaje.Text = "Error al guardar: " + ex.Message;
                lblMensaje.CssClass = "alert alert-danger d-block mt-3";
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {

            int idUsuario = int.Parse(hfIdUsuario.Value);
            Usuario u = negocio.ObtenerPorId(idUsuario);
            CargarDatos(u);
            ModoLectura();
        }


        private void ModoLectura(bool ocultarMensaje = true)
        {
            txtNombre.ReadOnly = txtApellido.ReadOnly = txtMail.ReadOnly =
            txtTelefono.ReadOnly = txtDomicilio.ReadOnly = true;

            btnEditar.Visible = true;
            btnGuardar.Visible = false;
            btnCancelar.Visible = false;

            if (ocultarMensaje) divMensaje.Visible = false;

            rfvNombre.Enabled = false;
            rfvApellido.Enabled = false;
            rfvMail.Enabled = false;
            revMail.Enabled = false;
            rfvTelefono.Enabled = false;
            revTelefono.Enabled = false;
        }

        private void ModoEdicion()
        {
            txtNombre.ReadOnly = txtApellido.ReadOnly =
            txtTelefono.ReadOnly = txtDomicilio.ReadOnly = false;

            txtMail.ReadOnly = true;
            btnEditar.Visible = false;
            btnGuardar.Visible = true;
            btnCancelar.Visible = true;

            rfvNombre.Enabled = true;
            rfvApellido.Enabled = true;
            rfvTelefono.Enabled = true;
            revTelefono.Enabled = true;
        }

        protected void btnBlanquearPass_Click(object sender, EventArgs e)
        {
            try
            {
                int idUsuario = int.Parse(hfIdUsuario.Value);

                //  contraseña por defecto
                string passDefault = "1234";


                negocio.ActualizarPassword(idUsuario, passDefault);

                divMensaje.Visible = true;
                lblMensaje.Text = $"Contraseña restablecida a '{passDefault}' correctamente.";
                lblMensaje.CssClass = "alert alert-warning d-block mt-3 fw-bold text-dark";
            }
            catch (Exception ex)
            {
                divMensaje.Visible = true;
                lblMensaje.Text = "Error al blanquear contraseña: " + ex.Message;
                lblMensaje.CssClass = "alert alert-danger d-block mt-3";
            }
        }

        protected void btnVolverAdmin_Click(object sender, EventArgs e)
        {

            Response.Redirect("PanelAdmin.aspx?view=clientes", false);
        }
    }
}
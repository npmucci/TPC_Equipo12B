using Dominio;
using Negocio;
using System;
using System.Text.RegularExpressions;
using System.Web.UI;

namespace CentroEstetica
{
    public partial class RegistroPage : System.Web.UI.Page
    {
        private UsuarioNegocio negocio = new UsuarioNegocio();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlCredenciales.Visible = true; // Panel con email + contraseñas
                pnlDatos.Visible = false;       // Panel con el resto de datos
                lblMensaje.Text = "";
            }
        }

        protected void btnValidar_Click(object sender, EventArgs e)
        {
            try
            {
                string email = txtMail.Text.Trim();
                string pass = txtContraseña.Text.Trim();
                string pass2 = txtRepetirContraseña.Text.Trim();

                // Validaciones 
                if (!Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
                {
                    lblMensaje.Text = "Formato de email inválido.";
                    return;
                }

                if (pass.Length < 8)
                {
                    lblMensaje.Text = "La contraseña debe tener al menos 8 caracteres.";
                    return;
                }

                if (pass != pass2)
                {
                    lblMensaje.Text = "Las contraseñas no coinciden.";
                    return;
                }

                // Verificar email 
                if (negocio.VerificarEmail(email))
                {
                    lblMensaje.Text = "Este email ya está registrado.";
                    return;
                }

                
                lblMensaje.Text = "";
                pnlCredenciales.Visible = false;
                pnlDatos.Visible = true;

                
                ViewState["Email"] = email;
                ViewState["Password"] = pass;
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Ocurrió un error al validar el email: " + ex.Message;
            }
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            try
            {
                string email = ViewState["Email"] as string;
                string passwordPlano = ViewState["Password"] as string;

                if (email == null || passwordPlano == null)
                {
                    lblMensaje.Text = "Error: faltan las credenciales iniciales.";
                    return;
                }

               
                Usuario nuevo = new Cliente
                {
                    Nombre = txtNombre.Text.Trim(),
                    Apellido = txtApellido.Text.Trim(),
                    Dni = txtDni.Text.Trim(),
                    Telefono = txtTelefono.Text.Trim(),
                    Domicilio = string.IsNullOrWhiteSpace(txtDomicilio.Text) ? null : txtDomicilio.Text.Trim(),
                    Mail = email,
                    Rol = Rol.Cliente,
                    Activo = true
                };

               
                int id = negocio.RegistrarUsuario(nuevo, passwordPlano);

                lblMensaje.CssClass = "text-success";
                lblMensaje.Text = $"Usuario registrado correctamente 🎉 (ID: {id})";

                pnlDatos.Visible = false;
            }
            catch (Exception ex)
            {
                lblMensaje.CssClass = "text-danger";
                lblMensaje.Text = "Error al registrar usuario: " + ex.Message;
            }
        }
    }
}
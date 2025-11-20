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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack && Session["usuario"] != null)
            {
                Usuario logueado = (Usuario)Session["usuario"];

                // Admin y ProfesionalUnico van al Panel Admin
                if (logueado.Rol == Rol.Admin || logueado.Rol == Rol.ProfesionalUnico)
                {
                    Response.Redirect("PanelAdmin.aspx", false);
                }
                else if (logueado.Rol == Rol.Recepcionista)
                {
                    Response.Redirect("PanelRecepcionista.aspx", false);
                }
                else if (logueado.Rol == Rol.Profesional)
                {
                    Response.Redirect("PanelProfesional.aspx", false);
                }
                else
                {
                    Response.Redirect("PanelCliente.aspx", false);
                }
            }
        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtUsuario.Text) || string.IsNullOrEmpty(txtPassword.Text))
            {
                lblError.Text = "Por favor, complete ambos campos.";
                lblError.Visible = true;
                return;
            }

            try
            {
                UsuarioNegocio negocio = new UsuarioNegocio();

                string email = txtUsuario.Text;
                string pass = txtPassword.Text;

                Usuario usuarioLogueado = negocio.Login(email, pass);

                if (usuarioLogueado != null)
                {
                    
                    Session["usuario"] = usuarioLogueado;  // Login exitoso

                    
                    switch (usuarioLogueado.Rol)
                    {
                        case Rol.Admin:
                        case Rol.ProfesionalUnico: 
                            Response.Redirect("PanelAdmin.aspx", false);
                            break;

                        case Rol.Recepcionista:
                            Response.Redirect("PanelRecepcionista.aspx", false);
                            break;

                        case Rol.Profesional:
                            Response.Redirect("PanelProfesional.aspx", false);
                            break;

                        case Rol.Cliente:
                        default:
                            Response.Redirect("PanelCliente.aspx", false);
                            break;
                    }
                }
                else
                {
                    lblError.Text = "Usuario o contraseña incorrectos.";
                    lblError.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Ocurrió un error inesperado.";
                lblError.Visible = true;
                
            }
        }
    }
}
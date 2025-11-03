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
         
            if (!IsPostBack)
            {
                if (Session["admin"] != null)
                {
                    Response.Redirect("PanelAdmin.aspx");
                }
                else if (Session["profesional"] != null)
                {
                    Response.Redirect("PanelProfesional.aspx");
                }
                else if (Session["cliente"] != null)
                {
                    Response.Redirect("PanelCliente.aspx");
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

                List<Rol> rolesLogueados = negocio.Login(email, pass);

                if (rolesLogueados != null && rolesLogueados.Count > 0)
                {
                    foreach (var rol in rolesLogueados)
                    {
                        Usuario usuario = negocio.CargarPerfil(email, rol);
                        if (rol == Rol.Admin)
                            Session["admin"] = usuario;

                        if (rol == Rol.Cliente)
                            Session["cliente"] = usuario;

                        if (rol == Rol.Profesional)
                            Session["profesional"] = usuario;
                    }

                    if (rolesLogueados.Contains(Rol.Admin))
                    {
                        Response.Redirect("PanelAdmin.aspx", false);
                    }
                    else if (rolesLogueados.Contains(Rol.Profesional))
                    {
                        Response.Redirect("PanelProfesional.aspx", false);
                    }
                    else if (rolesLogueados.Contains(Rol.Cliente))
                    {
                        Response.Redirect("PanelCliente.aspx", false);
                    }
                    else
                    {
                        lblError.Text = "Usuario autenticado pero sin roles.";
                        lblError.Visible = true;
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
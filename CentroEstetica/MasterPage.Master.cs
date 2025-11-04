using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CentroEstetica
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                if (Session["usuario"] == null) //USUARIO INVITADO
                {

                    hlIniciarSesion.Visible = true;
                    hlPerfil.Visible = false;
                    btnCerrarSesion.Visible = false;
                }
                else
                {
                    //USUARIO LOGUEADO

                    hlIniciarSesion.Visible = false;
                    hlPerfil.Visible = true;
                    btnCerrarSesion.Visible = true;

                    Usuario logueado = (Usuario)Session["usuario"];

                    switch (logueado.Rol)
                    {
                        case Rol.Admin:
                            hlPerfil.NavigateUrl = "~/PanelAdmin.aspx";
                            break;
                        case Rol.Profesional:
                            hlPerfil.NavigateUrl = "~/PanelProfesional.aspx";
                            break;
                        case Rol.Cliente:
                        default:
                            hlPerfil.NavigateUrl = "~/PanelCliente.aspx";
                            break;
                    }
                }
            }
        }


        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            Session.Clear(); // Limpiamos la sesión
            Response.Redirect("~/Default.aspx"); // Lo mandamos al inicio
        }
    }
}
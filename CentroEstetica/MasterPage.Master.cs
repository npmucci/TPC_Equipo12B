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
                string paginaActual = Request.Url.AbsolutePath.ToLower();// para saber en que pagina estoy y ver que boton muestro
                if (Session["usuario"] == null) //USUARIO INVITADO
                {
                    menuUsuario.Visible = false;
                    menuLogin.Visible = true;
                }
                else
                {
                    //USUARIO LOGUEADO
                                      

                    Usuario logueado = (Usuario)Session["usuario"];
                    menuUsuario.Visible = true;
                    menuLogin.Visible = false;

                    usuarioTexto.InnerText = logueado.Nombre;
                    Rol idRol = logueado.Rol;
              

                    //LÓGICA DE LA BARRA DE NAVEGACIÓN)
                    hlEspecialidades.Visible = true;
                    hlContacto.Visible = true;

                    if (idRol == Rol.Cliente)
                    {
                        if (paginaActual.Contains("/panelcliente.aspx"))
                        {

                            hlEspecialidades.Visible = false;
                        }
                    }

                    else if (idRol == Dominio.Rol.Admin ||
                             idRol == Dominio.Rol.Profesional ||
                             idRol == Dominio.Rol.Recepcionista ||
                             idRol == Dominio.Rol.ProfesionalUnico)
                    {

                        if (paginaActual.Contains("/default.aspx") || paginaActual.Contains("/paneladmin.aspx") | paginaActual.Contains("/panelprofesional.aspx") || paginaActual.Contains("/panelrecepcionista.aspx") || paginaActual.Contains("/panelperfil.aspx") || paginaActual.Contains("/cambiarcontrasenia.aspx"))
                        {
                            hlContacto.Visible = false;
                            hlEspecialidades.Visible = false;
                        }
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
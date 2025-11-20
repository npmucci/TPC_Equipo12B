using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;

namespace CentroEstetica
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Lógica de Especialidades (Solo visible en Default.aspx)
            string paginaActual = System.IO.Path.GetFileName(Request.Url.AbsolutePath).ToLower();

            // Si estamos en la raíz o en default.aspx mostramos las especialidades...
            if (paginaActual == "default.aspx" || paginaActual == "")
            {
                liEspecialidades.Visible = true;
            }
            else
            {
                liEspecialidades.Visible = false;
            }

            // Lógica de Sesión
            if (Seguridad.SesionActiva(Session["usuario"]))
            {
                // USUARIO LOGUEADO
                Usuario user = (Usuario)Session["usuario"];

                menuLogin.Visible = false;
                menuUsuario.Visible = true;
                usuarioTexto.InnerText = user.Nombre + " " + user.Apellido;

                // Reiniciar visibilidad por defecto para logueados
                liReservarTurno.Visible = false;
                liMisTurnos.Visible = false;
                liAdministracion.Visible = false;
                liContacto.Visible = true; // Visible por defecto (útil para Cliente), se oculta abajo si es staff (recep, admin, profUnico o profesional)

                switch (user.Rol)
                {
                    case Rol.Cliente:

                        liReservarTurno.Visible = true;
                        liMisTurnos.Visible = true;
                        liAdministracion.Visible = false;
                        li1MiAgenda.Visible = false;
                        liContacto.Visible = true;
                        break;

                    case Rol.Profesional:

                        liReservarTurno.Visible = true;
                        liMisTurnos.Visible = false;
                        liAdministracion.Visible = false;
                        li1MiAgenda.Visible = true;
                        hlMiAgenda.NavigateUrl = "~/PanelProfesional.aspx";
                        liContacto.Visible = false;
                        break;

                    case Rol.Recepcionista:

                        liReservarTurno.Visible = true;
                        liMisTurnos.Visible = false;
                        li1MiAgenda.Visible = false;
                        liAdministracion.Visible = true;
                        hlAdministracion.NavigateUrl = "~/PanelRecepcionista.aspx";
                        liContacto.Visible = false;
                        break;

                    case Rol.Admin:
                    case Rol.ProfesionalUnico:

                        liReservarTurno.Visible = true;
                        liMisTurnos.Visible = false;
                        li1MiAgenda.Visible = false;
                        liAdministracion.Visible = true;
                        hlAdministracion.NavigateUrl = "~/PanelAdmin.aspx";
                        liContacto.Visible = false;
                        break;
                }
            }
            else
            {
                // USUARIO NO LOGUEADO (Invitado)
                menuLogin.Visible = true;
                menuUsuario.Visible = false;

                // Ocultar opciones de usuario registrado
                liReservarTurno.Visible = false;
                liMisTurnos.Visible = false;
                liAdministracion.Visible = false;

                // Mostrar contacto para invitados
                liContacto.Visible = true;
            }
        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Default.aspx");
        }
    }
}
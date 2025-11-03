using Dominio;
using Dominio.Enum; 
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
                
                if (Session["admin"] == null &&
                    Session["profesional"] == null &&
                    Session["cliente"] == null)
                {
                    // Es un invitado
                    hlIniciarSesion.Visible = true;
                    hlPerfil.Visible = false;
                    btnCerrarSesion.Visible = false;
                }
                else
                {
                    
                    hlIniciarSesion.Visible = false;
                    hlPerfil.Visible = true;
                    btnCerrarSesion.Visible = true;



                    if (Session["admin"] != null)
                    {
                        hlPerfil.NavigateUrl = "~/PanelAdmin.aspx";


                    }
                    else if (Session["profesional"] != null)
                    {
                        hlPerfil.NavigateUrl = "~/PanelProfesional.aspx";
                    }

                    else if (Session["cliente"] != null)
                    {
                        hlPerfil.NavigateUrl = "~/PanelCliente.aspx";

                    }
                }
            }
        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
           
            Session.Remove("admin");
            Session.Remove("profesional");
            Session.Remove("cliente");

            Response.Redirect("~/Default.aspx"); // Lo mandamos al inicio
        }
    }
}
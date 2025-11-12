using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CentroEstetica
{
    public partial class PanelRecepcionista : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

            /*
            if (!Seguridad.EsRecepcionista(Session["usuario"]))
            {
                Response.Redirect("Default.aspx", false);
                return;
            }

            */
            if (!IsPostBack)
            {
                rptTurnosPasados.DataSource = new TurnoNegocio().ListarTurnosPasados();
                rptTurnosPasados.DataBind();

                rptTurnosActuales.DataSource = new TurnoNegocio().ListarTurnosActuales();
                rptTurnosActuales.DataBind();
            }

        }
        protected void lnk_Click(object sender, EventArgs e)
        {
            LinkButton clickedLink = (LinkButton)sender;

    
            lnkHoy.CssClass = "nav-link";
            lnkProximos.CssClass = "nav-link";
            lnkPasados.CssClass = "nav-link";

            clickedLink.CssClass = "nav-link active";


            switch (clickedLink.ID)
            {
                case "lnkHoy":
                    mvTurnos.ActiveViewIndex = 0; 
                    break;
                case "lnkProximos":
                    mvTurnos.ActiveViewIndex = 1; 
                    break;
                case "lnkPasados":
                    mvTurnos.ActiveViewIndex = 2; 
                    break;
            }
        }
    }
}
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
            
          if (!Seguridad.EsRecepcionista(Session["usuario"]))
          {
              Response.Redirect("Default.aspx", false);
              return;
          }
          
            if (!IsPostBack)
            {
                rptTurnosPasados.DataSource = new TurnoNegocio().ListarTurnosPasados();
                rptTurnosPasados.DataBind();

                rptTurnosActuales.DataSource = new TurnoNegocio().ListarTurnosActuales();
                rptTurnosActuales.DataBind();
            }

        }
    }
}
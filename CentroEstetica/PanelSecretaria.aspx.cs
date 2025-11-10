using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;

namespace CentroEstetica
{
    public partial class PanelSecretaria : System.Web.UI.Page
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
                rptTurnosActuales.DataSource = new TurnoNegocio().ListarTodos();
                rptTurnosActuales.DataBind();
            }
            
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;

namespace CentroEstetica
{
    public partial class PanelAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            if (!Seguridad.EsAdmin(Session["admin"]))
            {
                
                Response.Redirect("Default.aspx", false);
            }

            if (!IsPostBack)
            {
                
            }
        }
    }
}
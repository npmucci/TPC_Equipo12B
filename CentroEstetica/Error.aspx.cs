using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CentroEstetica
{
    public partial class Error : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["error"] != null)
            {
                 string mensajeError = Session["error"].ToString();

                lblError.Text = mensajeError;
                Session.Remove("error");
            }
            else
            {
                
                lblError.Text = "Ocurrió un error inesperado, pero no pudimos obtener los detalles. Inténtalo de nuevo.";
            }

        }
    }
}
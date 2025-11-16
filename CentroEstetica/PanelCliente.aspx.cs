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
    public partial class PanelCliente : System.Web.UI.Page
    {

        ClienteNegocio negocio = new ClienteNegocio();
        TurnoNegocio turnosNegocio = new TurnoNegocio();

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Seguridad.EsCliente(Session["usuario"]))
            {
                Response.Redirect("Default.aspx", false);
                return;
            }
            if (!IsPostBack)
            {
                Cliente cliente = (Cliente)Session["usuario"];
             

                rptTurnosPasados.DataSource = turnosNegocio.ListarTurnosPasadosCliente((int)cliente.ID);
                rptTurnosPasados.DataBind();

                rptTurnosActuales.DataSource = turnosNegocio.ListarTurnosActualesCliente((int)cliente.ID);
                rptTurnosActuales.DataBind();
            }
        }

    }
}





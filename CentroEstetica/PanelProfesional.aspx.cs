using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;
using Dominio;

namespace CentroEstetica
{
    public partial class PanelProfesional : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["usuario"] == null || !Seguridad.EsProfesional(Session["usuario"]))
            {

                Response.Redirect("Default.aspx", false);
                return;
            }

            if (!IsPostBack)
            {

                Profesional profesional = (Profesional)Session["usuario"];
                lblNombre.Text = "Bienvenida/o " + profesional.Nombre.ToString();
                MostrarFechaActual();
                CargarEstadisticas(profesional.ID);


            }
        }
        private void MostrarFechaActual()
        {

            lblFechaHoy.Text = DateTime.Now.ToString("dddd, dd 'de' MMMM",
                System.Globalization.CultureInfo.CreateSpecificCulture("es-ES"));
        }
        protected void lnk_Click(object sender, EventArgs e)
        {

            lnkHoy.CssClass = "nav-link";
            lnkProximos.CssClass = "nav-link";
            lnkPasados.CssClass = "nav-link";

            // btener el LinkButton que fue presionado
            LinkButton clickedLink = (LinkButton)sender;

            // Establecer la clase 'active' para el botón presionado
            clickedLink.CssClass = "nav-link active";

            //  Cambiar la vista del MultiView
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
        protected void CargarEstadisticas(int idProfesional)
        {
            TurnoNegocio negocio = new TurnoNegocio();
            DateTime hoy = DateTime.Now.Date;

            DateTime inicioSemana = hoy.AddDays(1); // asi se muestran los turnos a partir del dia siguiente;
            DateTime finSemana = hoy.AddDays(7);

            int turnosProximos = negocio.ContarTurnos(inicioSemana, finSemana, idProfesional);
            int turnosHoy = negocio.ContarTurnos(hoy, hoy, idProfesional);


            lblTurnosHoy.Text = turnosHoy.ToString();

            lblTurnosProximos.Text = turnosProximos.ToString();
        }
    }
}
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

            if (!Seguridad.EsProfesional(Session["usuario"]))
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
                CargarTurnos();
            }
        }

        private void MostrarFechaActual()
        {

            lblFechaHoy.Text = DateTime.Now.ToString("dddd, dd 'de' MMMM",
            System.Globalization.CultureInfo.CreateSpecificCulture("es-ES"));
        }

        
        protected void CargarEstadisticas(int idProfesional)
        {
            TurnoNegocio negocio = new TurnoNegocio();
            DateTime hoy = DateTime.Now.Date;

            DateTime inicioSemana = hoy.AddDays(1); 
            DateTime finSemana = hoy.AddDays(7);
            int turnosProximos = negocio.ContarTurnos(inicioSemana, finSemana, idProfesional);
            int turnosHoy = negocio.ContarTurnos(hoy, hoy, idProfesional);      

            lblTurnosHoy.Text = turnosHoy.ToString();
            lblTurnosProximos.Text = turnosProximos.ToString();
      
        }

        protected void CargarTurnos()
        {
            string filtro = hfTabActivo.Value; 
            TurnoNegocio negocio = new TurnoNegocio();
            Profesional profesional = (Profesional)Session["usuario"];
            List<Turno> lista;
            DateTime hoy = DateTime.Now.Date;
         
            lblTituloPrincipal.Text =TituloPrincipal(filtro);
            lblSubTituloGrid.Text =SubTituloGrid(filtro);
            pnlEstadisticas.Visible = (filtro == "Hoy");

            switch (filtro)
            {
                case "Hoy":
                    lista = negocio.ListarTurnosDelDia(profesional.ID, hoy, hoy);
                    break;

                case "Semana":
                    DateTime inicioSemana = hoy.AddDays(1);
                    DateTime finSemana = hoy.AddDays(7);
                    lista = negocio.ListarTurnosDelDia(profesional.ID, inicioSemana, finSemana);
                    break;

                default:                
                    lista = negocio.ListarTurnosDelDia(profesional.ID, hoy, hoy);
                    hfTabActivo.Value = "Hoy"; 
                    break;
            }

            Session["ListaTurnosProfesional"] = lista;
            dgvTurnos.DataSource = lista;
            dgvTurnos.DataBind();
        }

        protected void dgvTurnos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {           
            dgvTurnos.PageIndex = e.NewPageIndex;          
            dgvTurnos.DataSource = (List<Turno>)Session["ListaTurnosProfesional"];
            dgvTurnos.DataBind();
           
        }

        protected void lnkMenu_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string filtro = btn.CommandArgument;
           hfTabActivo.Value = filtro;
            CargarTurnos();   
        
        }

       
        private string TituloPrincipal(string filtro)
        {
            switch (filtro)
            {
                case "Hoy": return "Agenda del Día";
                case "Semana": return "Próximos Turnos (7 días)";         
                default: return "Panel Profesional";
            }
        }

        private string SubTituloGrid(string filtro)
        {
            switch (filtro)
            {
                case "Hoy": return "Turnos Programados para Hoy";
                case "Semana": return "Turnos de la semana";               
                default: return "Turnos";
            }
        }
    }
}

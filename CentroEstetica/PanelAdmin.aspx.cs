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
    public partial class PanelAdmin : System.Web.UI.Page
    {
        // Instanciamos los negocios que vamos a usar
        private UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
        private EspecialidadNegocio espNegocio = new EspecialidadNegocio();
        private ServicioNegocio servNegocio = new ServicioNegocio();
        private TurnoNegocio turnoNegocio = new TurnoNegocio(); // <-- AGREGADO

        protected void Page_Load(object sender, EventArgs e)
        {
            // Ocultamos el panel de mensajes en CADA carga
            pnlMensajes.Visible = false;

            if (!Seguridad.EsAdmin(Session["usuario"]))
            {
                Response.Redirect("Default.aspx", false);
            }

            if (!IsPostBack)
            {
                CargarProfesionales(true);
                CargarEspecialidadesConServicios();
            }
        }

        // --- MÉTODOS DE CARGA DE DATOS ---

        private void CargarProfesionales(bool activos)
        {
            rptProfesionales.DataSource = usuarioNegocio.ListarPorRol((int)Rol.Profesional)
                            .Where(u => u.Activo == activos)
                            .ToList();
            rptProfesionales.DataBind();

            if (activos)
            {
                lnkVerActivos.CssClass = "btn btn-link fw-bold p-0";
                lnkVerInactivos.CssClass = "btn btn-link p-0";
            }
            else
            {
                lnkVerActivos.CssClass = "btn btn-link p-0";
                lnkVerInactivos.CssClass = "btn btn-link fw-bold p-0";
            }
        }

        private void CargarEspecialidadesConServicios()
        {
            rptEspecialidadesLista.DataSource = espNegocio.Listar();
            rptEspecialidadesLista.DataBind();
        }

        // --- EVENTOS DE BOTONES ---

        protected void btnAgregarProfesional_Click(object sender, EventArgs e)
        {
            int idRolProfesional = (int)Dominio.Rol.Profesional;
            Response.Redirect($"RegistroPage.aspx?rol={idRolProfesional}", false);
        }

        protected void lnkVerActivos_Click(object sender, EventArgs e)
        {
            CargarProfesionales(true);
        }

        protected void lnkVerInactivos_Click(object sender, EventArgs e)
        {
            CargarProfesionales(false);
        }

        // --- EVENTOS DE REPEATERS ---

        protected void rptProfesionales_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            
            pnlMensajes.Visible = false;

            int idUsuario = int.Parse(e.CommandArgument.ToString());

            
            switch (e.CommandName)
            {
                case "DarDeBaja":
                    
                    if (turnoNegocio.ProfesionalTieneTurnosPendientes(idUsuario))
                    {
                        // No se puede dar de baja, mostramos error
                        pnlMensajes.Visible = true;
                        pnlMensajes.CssClass = "alert alert-danger";
                        litMensaje.Text = "<strong>Error:</strong> No se puede dar de baja al profesional porque tiene turnos pendientes.";
                    }
                    else
                    {
                        // No tiene turnos, procedemos con la baja
                        usuarioNegocio.CambiarEstado(idUsuario, false);
                        CargarProfesionales(true); // Recargamos la lista de activos
                    }
                    break;

                case "DarDeAlta":
                    
                    usuarioNegocio.CambiarEstado(idUsuario, true);
                    CargarProfesionales(false); 
                    break;

                case "VerTurnos":
                    
                    Response.Redirect($"GestionTurnosProfesional.aspx?idProf={idUsuario}", false);
                    break;
            }
        }

        protected void rptProfesionales_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Usuario profesional = (Usuario)e.Item.DataItem;
                Repeater rptEspecialidadesProf = (Repeater)e.Item.FindControl("rptEspecialidadesProf");

                
                rptEspecialidadesProf.DataSource = espNegocio.ListarPorProfesional(profesional.ID);
                rptEspecialidadesProf.DataBind();
            }
        }

        protected void rptEspecialidadesLista_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Especialidad especialidad = (Especialidad)e.Item.DataItem;
                Repeater rptServicios = (Repeater)e.Item.FindControl("rptServicios");

               
                rptServicios.DataSource = servNegocio.ListarPorEspecialidad(especialidad.IDEspecialidad);
                rptServicios.DataBind();
            }
        }
    }
}
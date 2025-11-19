using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;
using Dominio;

namespace CentroEstetica
{
    public partial class PanelAdmin : System.Web.UI.Page
    {
        private UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
        private EspecialidadNegocio espNegocio = new EspecialidadNegocio();
        private ServicioNegocio servNegocio = new ServicioNegocio();
        private TurnoNegocio turnoNegocio = new TurnoNegocio();

        protected void Page_Load(object sender, EventArgs e)
        {
            pnlMensajes.Visible = false;

            if (!Seguridad.EsAdmin(Session["usuario"]))
            {
                Response.Redirect("Default.aspx", false);
                return;
            }

            if (!IsPostBack)
            {
                CargarDashboardCompleto();
            }
        }

        // --- METODO PRINCIPAL DE CARGA ---

        private void CargarDashboardCompleto()
        {
            // Carga Profesionales (Activos e Inactivos)
            CargarProfesionales();

            // Carga Servicios y Especialidades
            CargarEspecialidadesConServicios();

            // Actualiza KPIs (Contadores)
            ActualizarKPIs();
        }

        private void CargarProfesionales()
        {

            ProfesionalNegocio negocio = new ProfesionalNegocio();
            List<Usuario> todosLosProfesionales = negocio.ListarProfesionales();


            // Lista Activos
            rptProfesionalesActivos.DataSource = todosLosProfesionales.FindAll(x => x.Activo == true);
            rptProfesionalesActivos.DataBind();

            // Lista Inactivos
            rptProfesionalesInactivos.DataSource = todosLosProfesionales.FindAll(x => x.Activo == false);
            rptProfesionalesInactivos.DataBind();
        }

        private void CargarEspecialidadesConServicios()
        {
            List<Especialidad> listaEspecialidades = espNegocio.Listar();
            rptEspecialidadesLista.DataSource = listaEspecialidades;
            rptEspecialidadesLista.DataBind();
        }

        private void ActualizarKPIs()
        {
            // KPI Profesionales Activos
            List<Usuario> profs = usuarioNegocio.ListarPorRol((int)Rol.Profesional);
            litCantProfesionales.Text = profs.Count(p => p.Activo).ToString();

            // KPI Servicios Activos
            List<Servicio> servs = servNegocio.ListarActivos();
            litCantServicios.Text = servs.Count.ToString();
        }

        private void MostrarMensaje(string mensaje, string tipo)
        {
            pnlMensajes.Visible = true;
            pnlMensajes.CssClass = $"alert alert-{tipo} alert-dismissible fade show mb-4 shadow-sm";
            litMensaje.Text = mensaje;
        }


        // --- SECCIÓN PROFESIONALES ---

        protected void btnAgregarProfesional_Click(object sender, EventArgs e)
        {
            int idRolProfesional = (int)Dominio.Rol.Profesional;
            Response.Redirect($"RegistroPage.aspx?rol={idRolProfesional}", false);
        }

        protected void rptProfesionales_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            pnlMensajes.Visible = false;
            int idUsuario = int.Parse(e.CommandArgument.ToString());

            switch (e.CommandName)
            {
                case "DarDeBaja":

                    if (turnoNegocio.ProfesionalTieneTurnosPendientes(idUsuario))
                    {
                        MostrarMensaje("<strong>Error:</strong> No se puede dar de baja al profesional porque tiene turnos pendientes.", "danger");
                    }
                    else
                    {
                        usuarioNegocio.CambiarEstado(idUsuario, false);
                        CargarProfesionales();
                        MostrarMensaje("Profesional dado de baja correctamente.", "success");
                    }
                    break;

                case "DarDeAlta":
                    usuarioNegocio.CambiarEstado(idUsuario, true);
                    CargarProfesionales();
                    MostrarMensaje("Profesional reactivado correctamente.", "success");
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
                if (rptEspecialidadesProf != null)
                {
                    rptEspecialidadesProf.DataSource = espNegocio.ListarPorProfesional(profesional.ID);
                    rptEspecialidadesProf.DataBind();
                }
            }
        }


        // --- SECCIÓN ESPECIALIDADES ---

        protected void btnAgregarEspecialidad_Click(object sender, EventArgs e)
        {
            Response.Redirect("FormEspecialidad.aspx", false);
        }

        protected void rptEspecialidadesLista_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Especialidad especialidad = (Especialidad)e.Item.DataItem;
                bool activo = especialidad.Activo;


                Repeater rptServicios = (Repeater)e.Item.FindControl("rptServicios");
                Button btnAgregarServicio = (Button)e.Item.FindControl("btnAgregarServicio");
                Button btnEditarEspecialidad = (Button)e.Item.FindControl("btnEditarEspecialidad");
                Button btnCambiarEstadoEspecialidad = (Button)e.Item.FindControl("btnCambiarEstadoEspecialidad");


                rptServicios.DataSource = servNegocio.ListarPorEspecialidadTodos(especialidad.IDEspecialidad);
                rptServicios.DataBind();


                btnAgregarServicio.CommandArgument = especialidad.IDEspecialidad.ToString();
                btnEditarEspecialidad.CommandArgument = especialidad.IDEspecialidad.ToString();
                btnCambiarEstadoEspecialidad.CommandArgument = especialidad.IDEspecialidad.ToString();


                if (activo)
                {
                    btnCambiarEstadoEspecialidad.Text = "Desactivar";
                    btnCambiarEstadoEspecialidad.CssClass = "btn btn-sm btn-outline-danger bg-white";
                    btnCambiarEstadoEspecialidad.CommandName = "DarDeBajaEspecialidad";
                    btnCambiarEstadoEspecialidad.OnClientClick = "return confirm('¿Seguro que desea desactivar esta especialidad?');";
                }
                else
                {
                    btnCambiarEstadoEspecialidad.Text = "Activar";
                    btnCambiarEstadoEspecialidad.CssClass = "btn btn-sm btn-outline-success bg-white";
                    btnCambiarEstadoEspecialidad.CommandName = "DarDeAltaEspecialidad";
                    btnCambiarEstadoEspecialidad.OnClientClick = "";
                }
            }
        }

        protected void rptEspecialidadesLista_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());

            switch (e.CommandName)
            {
                case "AgregarServicio":
                    Response.Redirect($"FormServicio.aspx?idEspecialidad={id}", false);
                    break;

                case "EditarEspecialidad":
                    Response.Redirect($"FormEspecialidad.aspx?id={id}", false);
                    break;

                case "DarDeBajaEspecialidad":
                    try
                    {
                        espNegocio.EliminarLogico(id);
                        MostrarMensaje("Especialidad desactivada.", "success");
                    }
                    catch (Exception ex)
                    {
                        MostrarMensaje("Error: " + ex.Message, "danger");
                    }
                    break;

                case "DarDeAltaEspecialidad":
                    try
                    {
                        espNegocio.ActivarLogico(id);
                        MostrarMensaje("Especialidad activada.", "success");
                    }
                    catch (Exception ex)
                    {
                        MostrarMensaje("Error: " + ex.Message, "danger");
                    }
                    break;
            }

            CargarDashboardCompleto();
        }


        // --- SECCIÓN SERVICIOS ---

        protected void rptServicios_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Servicio servicio = (Servicio)e.Item.DataItem;
                bool activo = servicio.Activo;

                Button btnEditarServicio = (Button)e.Item.FindControl("btnEditarServicio");
                Button btnCambiarEstadoServicio = (Button)e.Item.FindControl("btnCambiarEstadoServicio");

                btnEditarServicio.CommandArgument = servicio.IDServicio.ToString();
                btnCambiarEstadoServicio.CommandArgument = servicio.IDServicio.ToString();

                if (activo)
                {
                    btnCambiarEstadoServicio.Text = "🔒";
                    btnCambiarEstadoServicio.ToolTip = "Desactivar Servicio";
                    btnCambiarEstadoServicio.CssClass = "btn btn-light btn-sm border text-danger";
                    btnCambiarEstadoServicio.CommandName = "DarDeBajaServicio";
                    btnCambiarEstadoServicio.OnClientClick = "return confirm('¿Desactivar servicio?');";
                }
                else
                {
                    btnCambiarEstadoServicio.Text = "🔓";
                    btnCambiarEstadoServicio.ToolTip = "Activar Servicio";
                    btnCambiarEstadoServicio.CssClass = "btn btn-light btn-sm border text-success";
                    btnCambiarEstadoServicio.CommandName = "DarDeAltaServicio";
                    btnCambiarEstadoServicio.OnClientClick = "";
                }
            }
        }

        protected void rptServicios_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());

            switch (e.CommandName)
            {
                case "EditarServicio":
                    Response.Redirect($"FormServicio.aspx?id={id}", false);
                    break;

                case "DarDeBajaServicio":
                    try
                    {
                        servNegocio.EliminarLogico(id);
                        MostrarMensaje("Servicio desactivado.", "success");
                    }
                    catch (Exception ex)
                    {
                        MostrarMensaje("Error: " + ex.Message, "danger");
                    }
                    break;

                case "DarDeAltaServicio":
                    try
                    {
                        servNegocio.ActivarLogico(id);
                        MostrarMensaje("Servicio activado.", "success");
                    }
                    catch (Exception ex)
                    {
                        MostrarMensaje("Error: " + ex.Message, "danger");
                    }
                    break;
            }

            CargarDashboardCompleto();
        }
    }
}
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
        // Negocias a utilizar
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
            }

            if (!IsPostBack)
            {
                CargarProfesionales(true);
                CargarEspecialidadesConServicios();
            }
        }

        // --- MÉTODOS DE CARGA Y AUXILIARES ---

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

        private void MostrarMensaje(string mensaje, string tipo) // tipo = "success" o "danger"
        {
            pnlMensajes.Visible = true;
            pnlMensajes.CssClass = $"alert alert-{tipo}";
            litMensaje.Text = mensaje;
        }


        // --- SECCIÓN PROFESIONALES ---

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
                        CargarProfesionales(true); 
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

                
                Button btnCambiarEstado = (Button)e.Item.FindControl("btnCambiarEstado");
                if (btnCambiarEstado != null)
                {
                    bool activo = profesional.Activo;
                    btnCambiarEstado.Text = activo ? "Dar de Baja" : "Dar de Alta";
                    btnCambiarEstado.CssClass = activo ? "btn btn-outline-danger btn-sm" : "btn btn-outline-success btn-sm";
                    btnCambiarEstado.CommandName = activo ? "DarDeBaja" : "DarDeAlta";
                    btnCambiarEstado.CommandArgument = profesional.ID.ToString();

                    if (activo)
                        btnCambiarEstado.OnClientClick = "return confirm('¿Está seguro que desea dar de baja a este profesional?');";
                }

                
                Button btnGestionarTurnos = (Button)e.Item.FindControl("btnGestionarTurnos");
                if (btnGestionarTurnos != null)
                {
                    btnGestionarTurnos.CommandArgument = profesional.ID.ToString();
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
                    btnCambiarEstadoEspecialidad.Text = "Dar de Baja";
                    btnCambiarEstadoEspecialidad.CssClass = "btn btn-outline-danger btn-sm mt-2 ms-1";
                    btnCambiarEstadoEspecialidad.CommandName = "DarDeBajaEspecialidad";
                    btnCambiarEstadoEspecialidad.OnClientClick = "return confirm('¿Está seguro que desea dar de baja esta especialidad? Esto dará de baja TODOS sus servicios asociados.');";
                }
                else
                {
                    btnCambiarEstadoEspecialidad.Text = "Dar de Alta";
                    btnCambiarEstadoEspecialidad.CssClass = "btn btn-outline-success btn-sm mt-2 ms-1";
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
                        MostrarMensaje("Especialidad (y sus servicios) dada de baja.", "success");
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
            
            CargarEspecialidadesConServicios();
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
                    btnCambiarEstadoServicio.Text = "Dar de Baja";
                    btnCambiarEstadoServicio.CssClass = "btn btn-outline-danger";
                    btnCambiarEstadoServicio.CommandName = "DarDeBajaServicio";
                    btnCambiarEstadoServicio.OnClientClick = "return confirm('¿Está seguro que desea dar de baja este servicio?');";
                }
                else
                {
                    btnCambiarEstadoServicio.Text = "Dar de Alta";
                    btnCambiarEstadoServicio.CssClass = "btn btn-outline-success";
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
                        MostrarMensaje("Servicio dado de baja.", "success");
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
            
            CargarEspecialidadesConServicios();
        }
    }
}
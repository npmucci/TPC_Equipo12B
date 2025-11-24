using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;

namespace CentroEstetica
{
    public partial class PanelAdmin : System.Web.UI.Page
    {

        private UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
        private ClienteNegocio clienteNegocio = new ClienteNegocio();
        private EspecialidadNegocio espNegocio = new EspecialidadNegocio();
        private ServicioNegocio servNegocio = new ServicioNegocio();
        private TurnoNegocio turnoNegocio = new TurnoNegocio();
        private ProfesionalNegocio profesionalNegocio = new ProfesionalNegocio();

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
                string view = Request.QueryString["view"];

                
                switch (view)
                {
                    case "profesionales":
                        hfTabActivo.Value = "#v-pills-profesionales";
                        break;
                    case "servicios":
                        hfTabActivo.Value = "#v-pills-servicios";
                        break;
                    case "clientes":
                        hfTabActivo.Value = "#v-pills-clientes";
                        break;
                    case "settings":
                        hfTabActivo.Value = "#v-pills-settings";
                        break;
                    case "agenda":
                        hfTabActivo.Value = "#v-pills-agenda";
                        break;
                    case "recepcionistas":
                        hfTabActivo.Value = "#v-pills-recepcionistas";
                        break;
                    default:
                        hfTabActivo.Value = "#v-pills-dashboard";
                        break;
                }

                CargarDashboardCompleto();
            }
        }

        private void CargarDashboardCompleto()
        {

            CargarProfesionales();
            CargarEspecialidadesConServicios();
            ActualizarKPIsAdmin();
            CargarClientes();
            CargarRecepcionistas();
            CargarAgendaPersonal();
        }




        private void CargarClientes()
        {

            List<Usuario> listaClientes = clienteNegocio.ListarClientes();

            
            rptClientesActivos.DataSource = listaClientes.FindAll(x => x.Activo);
            rptClientesActivos.DataBind();

            
            rptClientesInactivos.DataSource = listaClientes.FindAll(x => !x.Activo);
            rptClientesInactivos.DataBind();
        }

        protected void rptClientes_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());

            switch (e.CommandName)
            {
                case "EditarCliente":

                    Response.Redirect($"PanelPerfil.aspx?id={id}&adminMode=true", false);
                    break;

                case "VerTurnosCliente":
                    CargarTurnosEnModal(id);
                    break;

                case "DarDeBajaCliente":

                    usuarioNegocio.CambiarEstado(id, false);
                    MostrarMensaje("Cliente dado de baja correctamente.", "success");
                    break;

                case "DarDeAltaCliente":
                    usuarioNegocio.CambiarEstado(id, true);
                    MostrarMensaje("Cliente reactivado correctamente.", "success");
                    break;
            }

            
            CargarClientes();
            hfTabActivo.Value = "#v-pills-clientes";
        }

        private void CargarTurnosEnModal(int idCliente)
        {

            Usuario cliente = usuarioNegocio.ObtenerPorId(idCliente); 
            litNombreClienteModal.Text = cliente != null ? $"{cliente.Nombre} {cliente.Apellido}" : "Cliente";


            List<Turno> turnos = turnoNegocio.ListarTurnosCliente(idCliente);


            List<Turno> pendientes = turnos.FindAll(t => t.Estado.Descripcion == "Pendiente");

            if (pendientes.Count > 0)
            {
                rptTurnosModal.DataSource = pendientes;
                rptTurnosModal.DataBind();
                pnlSinTurnos.Visible = false;
                rptTurnosModal.Visible = true;
            }
            else
            {
                pnlSinTurnos.Visible = true;
                rptTurnosModal.Visible = false;
            }


            upModalTurnos.Update();

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "abrirModalTurnos", "new bootstrap.Modal(document.getElementById('modalTurnosCliente')).show();", true);
        }




        private void CargarAgendaPersonal()
        {
            if (Session["usuario"] != null)
            {
                Usuario u = (Usuario)Session["usuario"];
                if (u.Rol == Rol.ProfesionalUnico)
                {
                    btnTabAgenda.Visible = true;
                    lblNombre.Text = "Bienvenida/o, " + u.Nombre;
                    lblFechaHoy.Text = DateTime.Now.ToString("dddd, dd 'de' MMMM", System.Globalization.CultureInfo.CreateSpecificCulture("es-ES"));
                    CalcularEstadisticasPersonales(u.ID);
                }
                else
                {
                    btnTabAgenda.Visible = false;
                }
            }
        }

        private void CalcularEstadisticasPersonales(int idProfesional)
        {
            DateTime hoy = DateTime.Now.Date;
            DateTime inicioSemana = hoy.AddDays(1);
            DateTime finSemana = hoy.AddDays(7);
            DateTime primerDiaMes = new DateTime(hoy.Year, hoy.Month, 1);
            DateTime ultimoDiaMes = primerDiaMes.AddMonths(1).AddDays(-1);

            int hoyCount = turnoNegocio.ContarTurnos(hoy, hoy, idProfesional);
            int proxCount = turnoNegocio.ContarTurnos(inicioSemana, finSemana, idProfesional);
            decimal ingresos = turnoNegocio.ObtenerIngresos(primerDiaMes, ultimoDiaMes, idProfesional);

            lblTurnosHoy.Text = hoyCount.ToString();
            lblTurnosProximos.Text = proxCount.ToString();
            lblIngresosMes.Text = ingresos.ToString("N0");
        }

        protected void lnkAgenda_Click(object sender, EventArgs e)
        {
            lnkHoy.CssClass = "nav-link";
            lnkProximos.CssClass = "nav-link";
            lnkPasados.CssClass = "nav-link";

            LinkButton clickedLink = (LinkButton)sender;
            clickedLink.CssClass = "nav-link active";

            switch (clickedLink.ID)
            {
                case "lnkHoy": mvTurnos.ActiveViewIndex = 0; break;
                case "lnkProximos": mvTurnos.ActiveViewIndex = 1; break;
                case "lnkPasados": mvTurnos.ActiveViewIndex = 2; break;
            }
            hfTabActivo.Value = "#v-pills-agenda";
        }

        protected void btnNuevoAdmin_Click(object sender, EventArgs e)
        {

            Response.Redirect($"RegistroPage.aspx?rol={(int)Rol.Admin}", false);
        }

        private void ActualizarKPIsAdmin()
        {
            List<Usuario> profs = usuarioNegocio.ListarPorRol((int)Rol.Profesional);
            litCantProfesionales.Text = profs.Count(p => p.Activo).ToString();
            
            List<Servicio> servs = servNegocio.ListarActivos();
            litCantServicios.Text = servs.Count.ToString();

            litCantTurnos.Text = turnoNegocio.CantidadTurnosPendientesTotal().ToString();
        }

        private void CargarProfesionales()
        {
            List<Usuario> todos = profesionalNegocio.ListarProfesionales();
            rptProfesionalesActivos.DataSource = todos.FindAll(x => x.Activo);
            rptProfesionalesActivos.DataBind();

            rptProfesionalesInactivos.DataSource = todos.FindAll(x => !x.Activo);
            rptProfesionalesInactivos.DataBind();
        }

        private void CargarEspecialidadesConServicios()
        {
            rptEspecialidadesLista.DataSource = espNegocio.Listar();
            rptEspecialidadesLista.DataBind();
        }

        private void MostrarMensaje(string mensaje, string tipo)
        {
            pnlMensajes.Visible = true;
            pnlMensajes.CssClass = $"alert alert-{tipo} alert-dismissible fade show mb-4 shadow-sm";
            litMensaje.Text = mensaje;
        }

        // Eventos ABM Profesionales
        protected void btnAgregarProfesional_Click(object sender, EventArgs e)
        {
            Response.Redirect($"RegistroPage.aspx?rol={(int)Rol.Profesional}", false);
        }

        protected void rptProfesionales_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());
            switch (e.CommandName)
            {
                case "DarDeBaja":
                    if (turnoNegocio.ProfesionalTieneTurnosPendientes(id))
                        MostrarMensaje("Error: El profesional tiene turnos pendientes.", "danger");
                    else
                    {
                        usuarioNegocio.CambiarEstado(id, false);
                        CargarProfesionales();
                        MostrarMensaje("Profesional dado de baja.", "success");
                    }
                    break;
                case "DarDeAlta":
                    usuarioNegocio.CambiarEstado(id, true);
                    CargarProfesionales();
                    MostrarMensaje("Profesional reactivado.", "success");
                    break;
                case "VerTurnos":
                    Response.Redirect($"GestionTurnosProfesional.aspx?idProf={id}", false);
                    break;
            }
            hfTabActivo.Value = "#v-pills-profesionales";
        }

        protected void rptProfesionales_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Usuario p = (Usuario)e.Item.DataItem;
                Repeater rpt = (Repeater)e.Item.FindControl("rptEspecialidadesProf");
                if (rpt != null)
                {
                    rpt.DataSource = espNegocio.ListarPorProfesional(p.ID);
                    rpt.DataBind();
                }
            }
        }

        // Eventos ABM Especialidades
        protected void btnAgregarEspecialidad_Click(object sender, EventArgs e)
        {
            Response.Redirect("FormEspecialidad.aspx", false);
        }

        protected void rptEspecialidadesLista_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Especialidad esp = (Especialidad)e.Item.DataItem;


                Repeater rptS = (Repeater)e.Item.FindControl("rptServicios");


                System.Web.UI.HtmlControls.HtmlGenericControl pnlMensaje =
                    (System.Web.UI.HtmlControls.HtmlGenericControl)e.Item.FindControl("pnlSinServicios");

                Button btnAdd = (Button)e.Item.FindControl("btnAgregarServicio");
                LinkButton btnEdit = (LinkButton)e.Item.FindControl("btnEditarEspecialidad");
                LinkButton btnState = (LinkButton)e.Item.FindControl("btnCambiarEstadoEspecialidad");


                List<Servicio> listaServicios = servNegocio.ListarPorEspecialidadTodos(esp.IDEspecialidad);


                rptS.DataSource = listaServicios;
                rptS.DataBind();


                if (listaServicios.Count == 0)
                {
                    pnlMensaje.Visible = true;
                }
                else
                {
                    pnlMensaje.Visible = false;
                }


                btnAdd.CommandArgument = esp.IDEspecialidad.ToString();
                btnEdit.CommandArgument = esp.IDEspecialidad.ToString();
                btnState.CommandArgument = esp.IDEspecialidad.ToString();

                if (esp.Activo)
                {
                    btnState.Text = "<i class='bi bi-unlock-fill'></i>";
                    btnState.ToolTip = "Desactivar Especialidad";
                    btnState.CssClass = "btn btn-link p-0 text-success border-0 fs-5";
                    btnState.CommandName = "DarDeBajaEspecialidad";
                    btnState.OnClientClick = "return confirm('¿Desactivar especialidad?');";
                }
                else
                {
                    btnState.Text = "<i class='bi bi-lock-fill'></i>";
                    btnState.ToolTip = "Activar Especialidad";
                    btnState.CssClass = "btn btn-link p-0 text-danger border-0 fs-5";
                    btnState.CommandName = "DarDeAltaEspecialidad";
                    btnState.OnClientClick = "";
                }
            }
        }

        protected void rptEspecialidadesLista_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());
            switch (e.CommandName)
            {
                case "AgregarServicio": Response.Redirect($"FormServicio.aspx?idEspecialidad={id}", false); break;
                case "EditarEspecialidad": Response.Redirect($"FormEspecialidad.aspx?id={id}", false); break;
                case "DarDeBajaEspecialidad":
                    try { espNegocio.EliminarLogico(id); MostrarMensaje("Especialidad desactivada.", "success"); }
                    catch (Exception ex) { MostrarMensaje("Error: " + ex.Message, "danger"); }
                    break;
                case "DarDeAltaEspecialidad":
                    try { espNegocio.ActivarLogico(id); MostrarMensaje("Especialidad activada.", "success"); }
                    catch (Exception ex) { MostrarMensaje("Error: " + ex.Message, "danger"); }
                    break;
            }
            CargarDashboardCompleto();
            hfTabActivo.Value = "#v-pills-servicios";
        }

        protected void rptServicios_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Servicio s = (Servicio)e.Item.DataItem;
                Button btnEdit = (Button)e.Item.FindControl("btnEditarServicio");
                Button btnState = (Button)e.Item.FindControl("btnCambiarEstadoServicio");

                btnEdit.CommandArgument = s.IDServicio.ToString();
                btnState.CommandArgument = s.IDServicio.ToString();

                if (s.Activo)
                {
                    btnState.Text = "🔒";
                    btnState.ToolTip = "Desactivar";
                    btnState.CssClass = "btn btn-light btn-sm border text-danger";
                    btnState.CommandName = "DarDeBajaServicio";
                    btnState.OnClientClick = "return confirm('¿Desactivar servicio?');";
                }
                else
                {
                    btnState.Text = "🔓";
                    btnState.ToolTip = "Activar";
                    btnState.CssClass = "btn btn-light btn-sm border text-success";
                    btnState.CommandName = "DarDeAltaServicio";
                    btnState.OnClientClick = "";
                }
            }
        }

        protected void rptServicios_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());
            switch (e.CommandName)
            {
                case "EditarServicio": Response.Redirect($"FormServicio.aspx?id={id}", false); break;
                case "DarDeBajaServicio":
                    try { servNegocio.EliminarLogico(id); MostrarMensaje("Servicio desactivado.", "success"); }
                    catch (Exception ex) { MostrarMensaje("Error: " + ex.Message, "danger"); }
                    break;
                case "DarDeAltaServicio":
                    try { servNegocio.ActivarLogico(id); MostrarMensaje("Servicio activado.", "success"); }
                    catch (Exception ex) { MostrarMensaje("Error: " + ex.Message, "danger"); }
                    break;
            }
            CargarDashboardCompleto();
            hfTabActivo.Value = "#v-pills-servicios";
        }

        // LÓGICA DE RECEPCIONISTAS 

        private void CargarRecepcionistas()
        {

            List<Usuario> lista = usuarioNegocio.ListarPorRol((int)Rol.Recepcionista);

            rptRecepcionistasActivos.DataSource = lista.FindAll(x => x.Activo);
            rptRecepcionistasActivos.DataBind();

            rptRecepcionistasInactivos.DataSource = lista.FindAll(x => !x.Activo);
            rptRecepcionistasInactivos.DataBind();
        }

        protected void btnAgregarRecepcionista_Click(object sender, EventArgs e)
        {

            Response.Redirect($"RegistroPage.aspx?rol={(int)Rol.Recepcionista}", false);
        }

        protected void rptRecepcionistas_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());

            switch (e.CommandName)
            {
                case "EditarRecepcionista":

                    Response.Redirect($"PanelPerfil.aspx?id={id}&adminMode=true", false);
                    break;

                case "DarDeBajaRecepcionista":
                    usuarioNegocio.CambiarEstado(id, false);
                    MostrarMensaje("Recepcionista dada/o de baja.", "success");
                    break;

                case "DarDeAltaRecepcionista":
                    usuarioNegocio.CambiarEstado(id, true);
                    MostrarMensaje("Recepcionista reactivada/o.", "success");
                    break;
            }

            CargarRecepcionistas();
            hfTabActivo.Value = "#v-pills-recepcionistas";
        }
    }
}
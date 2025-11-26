using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;

namespace CentroEstetica
{
    public partial class GestionProfesional : System.Web.UI.Page
    {

        private UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
        private EspecialidadNegocio espNegocio = new EspecialidadNegocio();
        private HorarioAtencionNegocio horarioNegocio = new HorarioAtencionNegocio();
        private TurnoNegocio turnoNegocio = new TurnoNegocio();


        private int IDProfesional
        {
            get { return ViewState["IDProfesional"] != null ? (int)ViewState["IDProfesional"] : 0; }
            set { ViewState["IDProfesional"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Seguridad.EsAdmin(Session["usuario"]))
            {
                Response.Redirect("Default.aspx");
                return;
            }

            if (!IsPostBack)
            {

                txtEmail.ReadOnly = true;
                txtEmail.CssClass += " bg-light";


                if (Request.QueryString["id"] != null)
                {
                    IDProfesional = int.Parse(Request.QueryString["id"]);
                    CargarTodo();
                }
                else
                {
                    Response.Redirect("PanelAdmin.aspx");
                }
            }
        }

        private void CargarTodo()
        {
            Usuario prof = usuarioNegocio.ObtenerPorId(IDProfesional);
            if (prof != null)
            {

                txtNombre.Text = prof.Nombre;
                txtApellido.Text = prof.Apellido;
                txtEmail.Text = prof.Mail;
                txtTelefono.Text = prof.Telefono;


                CargarEspecialidades();


                CargarHorarios();
            }
        }


        // LÓGICA DATOS PERSONALES

        protected void btnGuardarDatos_Click(object sender, EventArgs e)
        {
            try
            {
                Usuario prof = usuarioNegocio.ObtenerPorId(IDProfesional);
                prof.Nombre = txtNombre.Text;
                prof.Apellido = txtApellido.Text;
                prof.Mail = txtEmail.Text;
                prof.Telefono = txtTelefono.Text;

                usuarioNegocio.Modificar(prof);

                MostrarMensaje("Datos personales actualizados correctamente.");
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx");
            }
        }


        // LÓGICA ESPECIALIDADES

        private void CargarEspecialidades()
        {

            List<Especialidad> todas = espNegocio.ListarActivos();


            List<Especialidad> asignadas = espNegocio.ListarPorProfesional(IDProfesional);


            cblEspecialidades.DataSource = todas;
            cblEspecialidades.DataTextField = "Nombre";
            cblEspecialidades.DataValueField = "IDEspecialidad";
            cblEspecialidades.DataBind();


            foreach (ListItem item in cblEspecialidades.Items)
            {

                if (asignadas.Any(x => x.IDEspecialidad.ToString() == item.Value))
                {
                    item.Selected = true;
                }
            }
        }

        protected void btnGuardarEspecialidades_Click(object sender, EventArgs e)
        {
            try
            {

                List<Especialidad> asignadasActualmente = espNegocio.ListarPorProfesional(IDProfesional);

                bool huboCambios = false;
                string erroresValidacion = "";

                foreach (ListItem item in cblEspecialidades.Items)
                {
                    int idEsp = int.Parse(item.Value);
                    bool estaMarcadoEnUI = item.Selected;
                    bool estaEnBD = asignadasActualmente.Any(x => x.IDEspecialidad == idEsp);


                    if (estaMarcadoEnUI && !estaEnBD)
                    {
                        espNegocio.AsignarEspecialidadAProfesional(IDProfesional, idEsp);
                        huboCambios = true;
                    }

                    else if (!estaMarcadoEnUI && estaEnBD)
                    {

                        if (turnoNegocio.TieneTurnosPendientesPorEspecialidad(IDProfesional, idEsp))
                        {

                            erroresValidacion += $"No se puede quitar '{item.Text}' porque tiene turnos pendientes.<br/>";
                            item.Selected = true;
                        }
                        else
                        {

                            espNegocio.DesasignarEspecialidadAProfesional(IDProfesional, idEsp);
                            huboCambios = true;
                        }
                    }

                }

                if (!string.IsNullOrEmpty(erroresValidacion))
                {

                    pnlMensaje.Visible = true;
                    pnlMensaje.CssClass = "alert alert-warning alert-dismissible fade show";
                    lblMensaje.Text = "Algunos cambios no se aplicaron:<br/>" + erroresValidacion;
                }
                else if (huboCambios)
                {
                    msgEspecialidades.Visible = true;


                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx");
            }
        }


        //LÓGICA HORARIOS

        private void CargarHorarios()
        {
            List<HorarioAtencion> lista = horarioNegocio.ListarPorProfesional(IDProfesional);
            rptHorarios.DataSource = lista;
            rptHorarios.DataBind();
        }

        protected void btnAgregarHorario_Click(object sender, EventArgs e)
        {
            try
            {
                lblErrorHorario.Visible = false;


                if (string.IsNullOrEmpty(txtHoraInicio.Text) || string.IsNullOrEmpty(txtHoraFin.Text))
                {
                    lblErrorHorario.Text = "Complete los horarios.";
                    lblErrorHorario.Visible = true;
                    return;
                }

                HorarioAtencion nuevo = new HorarioAtencion();
                nuevo.Profesional = new Profesional { ID = IDProfesional };
                nuevo.DiaSemana = ddlDia.SelectedValue;
                nuevo.HorarioInicio = TimeSpan.Parse(txtHoraInicio.Text);
                nuevo.HorarioFin = TimeSpan.Parse(txtHoraFin.Text);
                nuevo.Activo = true;

                horarioNegocio.Agregar(nuevo);

                
                txtHoraInicio.Text = "";
                txtHoraFin.Text = "";
                CargarHorarios();
            }
            catch (Exception ex)
            {
                lblErrorHorario.Text = ex.Message;
                lblErrorHorario.Visible = true;
            }
        }

        protected void rptHorarios_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                try
                {
                    
                    int idHorario = int.Parse(e.CommandArgument.ToString());

                    
                    horarioNegocio.Eliminar(idHorario);

                   
                    CargarHorarios();

                    
                }
                catch (Exception ex)
                {
                    
                    pnlMensaje.Visible = true;
                    pnlMensaje.CssClass = "alert alert-danger alert-dismissible fade show shadow-sm";
                    lblMensaje.Text = "Error al eliminar el horario: " + ex.Message;
                }
            }
        }


        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("PanelAdmin.aspx?view=profesionales");
        }

        private void MostrarMensaje(string texto)
        {
            pnlMensaje.Visible = true;
            lblMensaje.Text = texto;
        }
    }
}
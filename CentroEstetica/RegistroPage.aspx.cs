using Dominio;
using Negocio;
using System;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CentroEstetica
{
    public partial class RegistroPage : System.Web.UI.Page
    {
        private UsuarioNegocio negocio = new UsuarioNegocio();
        private EspecialidadNegocio espNegocio = new EspecialidadNegocio();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlCredenciales.Visible = true;
                pnlDatos.Visible = false;

               
                pnlMensaje.Visible = false;
               

                if (Seguridad.EsAdmin(Session["usuario"]))
                {
                    pnlAdminControls.Visible = true;
                    CargarRoles();
                    CargarEspecialidades();
                }
                else
                {
                    pnlAdminControls.Visible = false;
                }
            }
        }

        protected void btnValidar_Click(object sender, EventArgs e)
        {
           
            pnlMensaje.Visible = false;

            Page.Validate();
            if (!Page.IsValid)
            {
                return;
            }

            try
            {
                
                string email = txtMail.Text.Trim();
                if (negocio.VerificarEmail(email))
                {
                    
                    pnlMensaje.Visible = true;
                    pnlMensaje.CssClass = "alert alert-danger";
                    litMensaje.Text = "<strong>Error de Validación:</strong> Este email ya está registrado.";
                    return;
                }

               
                pnlCredenciales.Visible = false;
                pnlDatos.Visible = true;

                
                Session["RegistroEmail"] = email;
                Session["RegistroPassword"] = txtContraseña.Text;
            }
            catch (Exception ex)
            {
                pnlMensaje.Visible = true;
                pnlMensaje.CssClass = "alert alert-danger";
                litMensaje.Text = "<strong>¡Ups! Hubo un error al validar:</strong> " + ex.Message;
            }
        }


        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            try
            {
                string email = Session["RegistroEmail"] as string;
                string passwordPlano = Session["RegistroPassword"] as string;

               
                if (email == null || passwordPlano == null)
                {

                    pnlMensaje.Visible = true;
                    pnlMensaje.CssClass = "alert alert-danger";
                    litMensaje.Text = "<strong>Error de Sesión:</strong> La sesión expiró. Por favor, vuelva a empezar el registro.";
                    return;
                }
                
                Rol rolACrear = Rol.Cliente;

                if (pnlAdminControls.Visible)
                {
                    rolACrear = (Rol)Enum.Parse(typeof(Rol), ddlRoles.SelectedValue);
                }

                // CREAMOS EL OBJETO BASE 
                Usuario nuevo;
                switch (rolACrear)
                {
                    case Rol.Admin:
                        nuevo = new Administrador();
                        break;
                    case Rol.Profesional:
                        nuevo = new Profesional();
                        break;
                    case Rol.Recepcionista:
                        nuevo = new Recepcionista();
                        break;
                    case Rol.Cliente:
                    default:
                        nuevo = new Cliente();
                        break;
                }

                // SETEAMOS PROPIEDADES COMUNES
                nuevo.Nombre = txtNombre.Text.Trim();
                nuevo.Apellido = txtApellido.Text.Trim();
                nuevo.Dni = txtDni.Text.Trim();
                nuevo.Telefono = txtTelefono.Text.Trim();
                nuevo.Domicilio = string.IsNullOrWhiteSpace(txtDomicilio.Text) ? null : txtDomicilio.Text.Trim();
                nuevo.Mail = email;
                nuevo.Rol = rolACrear;
                nuevo.Activo = true;

                // REGISTRO EN LA BD
                int id = negocio.RegistrarUsuario(nuevo, passwordPlano);

                // SI ES PROF. SE INGRESA LA/LAS ESPECIALIDADES 
                if (rolACrear == Rol.Profesional && id > 0)
                {

                    foreach (ListItem item in cblEspecialidades.Items)
                    {

                        if (item.Selected)
                        {
                            int idEspecialidad = int.Parse(item.Value);
                            espNegocio.AsignarEspecialidadAProfesional(id, idEspecialidad);
                        }
                    }
                }

                
                pnlMensaje.Visible = true;
                pnlMensaje.CssClass = "alert alert-success h4";
                litMensaje.Text = $"<strong>¡Registro Exitoso!</strong> El usuario ({rolACrear}) fue creado correctamente. 🎉";

                pnlDatos.Visible = false;
                pnlAdminControls.Visible = false;
                pnlCredenciales.Visible = false;

                Session["RegistroEmail"] = null;
                Session["RegistroPassword"] = null;
            }
            catch (Exception ex)
            {

                pnlMensaje.Visible = true;
                pnlMensaje.CssClass = "alert alert-danger";
                litMensaje.Text = "<strong>¡Ups! Hubo un error:</strong> No se pudo completar el registro. (" + ex.Message + ")";
            }
        }

        private void CargarRoles()
        {
            
            ddlRoles.Items.Clear();
            ddlRoles.Items.Add(new ListItem("Cliente", ((int)Rol.Cliente).ToString()));
            ddlRoles.Items.Add(new ListItem("Profesional", ((int)Rol.Profesional).ToString()));
            ddlRoles.Items.Add(new ListItem("Recepcionista", ((int)Rol.Recepcionista).ToString()));
            ddlRoles.Items.Add(new ListItem("Administrador", ((int)Rol.Admin).ToString()));
            

            ddlRoles.SelectedValue = ((int)Rol.Cliente).ToString(); // Default
        }

        private void CargarEspecialidades()
        {
            
            cblEspecialidades.DataSource = espNegocio.ListarActivos(); 
            cblEspecialidades.DataTextField = "Nombre";
            cblEspecialidades.DataValueField = "IDEspecialidad";
            cblEspecialidades.DataBind();
        }

        protected void ddlRoles_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            Rol rolSeleccionado = (Rol)Enum.Parse(typeof(Rol), ddlRoles.SelectedValue);

            
            if (rolSeleccionado == Rol.Profesional)
            {
                pnlEspecialidad.Visible = true;
            }
            else
            {
                pnlEspecialidad.Visible = false;
            }
        }
    }
}
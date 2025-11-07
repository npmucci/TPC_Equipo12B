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
            if (!IsPostBack)
            {
                if (!Seguridad.EsCliente(Session["usuario"]))
                {
                    Response.Redirect("Default.aspx", false);
                    return; 
                }

                Cliente cliente = (Cliente)Session["usuario"];
                CargarDatosCliente(cliente);
                
                rptTurnos.DataSource = turnosNegocio.ListarTurnosCliente((int) cliente.ID);
                rptTurnos.DataBind();
            }
        }

        private void CargarDatosCliente(Usuario cliente)
        {
            txtNombre.Text = cliente.Nombre;
            txtApellido.Text = cliente.Apellido;
            txtMail.Text = cliente.Mail;
            txtTelefono.Text = cliente.Telefono;
            txtDomicilio.Text = cliente.Domicilio;
            txtDni.Text = cliente.Dni;

           

        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            // Habilitar edición

            txtNombre.ReadOnly = false;
            txtApellido.ReadOnly = false;
            // txtMail.ReadOnly = false; 
            txtTelefono.ReadOnly = false;
            txtDomicilio.ReadOnly = false;
            txtDni.ReadOnly = false;

            btnGuardar.Visible = true;
            btnCancelar.Visible = true;
            btnEditar.Visible = false;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
               
                Cliente clienteActual = (Cliente)Session["usuario"];

               
                clienteActual.Nombre = txtNombre.Text;
                clienteActual.Apellido = txtApellido.Text;
                //clienteActual.Mail = txtMail.Text;
                clienteActual.Telefono = txtTelefono.Text;
                clienteActual.Domicilio = txtDomicilio.Text;
                clienteActual.Dni = txtDni.Text;

                negocio.Modificar(clienteActual);

                
                Session["usuario"] = clienteActual;

                
                ResetearControles();

                // Mostrar un mensaje de exito....
            }
            catch (Exception ex)
            {
                // Mostrar un mensaje de error....
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
           
            Cliente clienteOriginal = (Cliente)Session["usuario"];

            
            CargarDatosCliente(clienteOriginal);

            
            ResetearControles();
        }

        private void ResetearControles()
        {
            txtNombre.ReadOnly = true;
            txtApellido.ReadOnly = true;
            txtMail.ReadOnly = true;
            txtTelefono.ReadOnly = true;
            txtDomicilio.ReadOnly = true;

            btnGuardar.Visible = false;
            btnCancelar.Visible = false;
            btnEditar.Visible = true;
        }

        protected void btnGuardarContrasenia_Click(object sender, EventArgs e)
        {
         
            lblModalError.Text = "";
            lblModalError.Style["display"] = "none";
            lblModalExito.Text = "";
            lblModalExito.Style["display"] = "none";

            Page.Validate("PassGroup");
            if (!Page.IsValid)
                return;

            try
            {
                Usuario usuario = (Usuario)Session["usuario"];
                string passActualIngresada = txtPassActual.Text;
                UsuarioNegocio negocio = new UsuarioNegocio();

                Usuario usuarioVerificado = negocio.Login(usuario.Mail, passActualIngresada);

                if (usuarioVerificado == null)
                {
                   
                    lblModalError.Text = "La contraseña actual es incorrecta.";
                    lblModalError.Style["display"] = "block";
                    return;
                }

               
                string passNueva = txtPassNueva.Text;
                negocio.ActualizarPassword(usuario.ID, passNueva);

                
                lblModalExito.Text = "¡Contraseña actualizada con éxito!";
                lblModalExito.Style["display"] = "block";

                
                divPassActual.Style["display"] = "none";
                divPassNueva.Style["display"] = "none";
                divPassConfirmar.Style["display"] = "none";

                
                modalFooter.Style["display"] = "none";
            }
            catch (Exception ex)
            {
                lblModalError.Text = "Ocurrió un error inesperado: " + ex.Message;
                lblModalError.Style["display"] = "block";
            }
        }
    }
}
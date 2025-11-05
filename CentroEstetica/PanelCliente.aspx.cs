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
        
        protected void Page_Load(object sender, EventArgs e)
        {
          

            if (!IsPostBack)
            {

                if (!Seguridad.EsCliente(Session["usuario"]))
                {

                    Response.Redirect("Default.aspx", false);
                }
                

                Usuario usuarioSesion = (Usuario)Session["usuario"];

                Usuario cliente = negocio.ObtenerClientePorId(usuarioSesion.ID);
                CargarDatosCliente(cliente);

            }
        }
        private void CargarDatosCliente(Usuario cliente)
        {
            txtNombre.Text = cliente.Nombre;
            txtApellido.Text = cliente.Apellido;
            txtMail.Text = cliente.Mail;
            txtTelefono.Text = cliente.Telefono;
            txtDomicilio.Text = cliente.Domicilio;
        }
        protected void btnEditar_Click(object sender, EventArgs e)
        {
            // Habilitar edición
            txtNombre.ReadOnly = false;
            txtApellido.ReadOnly = false;
            txtMail.ReadOnly = false;
            txtTelefono.ReadOnly = false;
            txtDomicilio.ReadOnly = false;

            btnGuardar.Visible = true;
            btnCancelar.Visible = true;
            btnEditar.Visible = false;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                Usuario usuarioSesion = (Usuario)Session["usuario"];

                Usuario cliente = new Cliente();

                cliente.Nombre = txtNombre.Text;
                cliente.Apellido = txtApellido.Text;
                cliente.Mail = txtMail.Text;
                cliente.Telefono = txtTelefono.Text;
                cliente.Domicilio = txtDomicilio.Text;

                //clienteNegocio.Actualizar(cliente);

                // Bloquear nuevamente
                txtNombre.ReadOnly = true;
                txtApellido.ReadOnly = true;
                txtMail.ReadOnly = true;
                txtTelefono.ReadOnly = true;
                txtDomicilio.ReadOnly = true;

                btnGuardar.Visible = false;
                btnCancelar.Visible = false;
                btnEditar.Visible = true;
            }
            catch (Exception ex)
            {
                
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Usuario usuarioSesion = (Usuario)Session["usuario"];

            Usuario cliente = negocio.ObtenerClientePorId(usuarioSesion.ID);
            CargarDatosCliente(cliente);

            txtNombre.ReadOnly = true;
            txtApellido.ReadOnly = true;
            txtMail.ReadOnly = true;
            txtTelefono.ReadOnly = true;
            txtDomicilio.ReadOnly = true;

            btnGuardar.Visible = false;
            btnCancelar.Visible = false;
            btnEditar.Visible = true;
        }
    }


}
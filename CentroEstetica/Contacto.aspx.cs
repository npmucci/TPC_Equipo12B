using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio; 

namespace CentroEstetica
{
    public partial class Contacto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Verificar si el usuario está logueado
                if (Session["usuario"] != null)
                {
                    Usuario user = (Usuario)Session["usuario"];

                    // Si es Cliente, pre-cargamos sus datos
                    if (user.Rol == Rol.Cliente)
                    {
                        txtNombre.Text = user.Nombre + " " + user.Apellido;

                        txtEmail.Text = user.Mail;
                        txtEmail.ReadOnly = true; 
                        txtNombre.ReadOnly = true;
                        txtEmail.CssClass += " bg-light"; 
                    }
                }
            }
        }

        protected void btnEnviar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    string emailEmisor = "lucasberlingeri4@gmail.com";
                    string passwordEmisor = "lbqz sexw ymrh sidn";

                    
                    MailMessage mail = new MailMessage();
                    mail.From = new MailAddress(emailEmisor, "Web Centro Estética");

                    mail.To.Add("natalia.mucci@alumnos.frgp.utn.edu.ar");
                    mail.To.Add("lucas.berlingeri@alumnos.frgp.utn.edu.ar");

                    mail.Subject = "Nueva Consulta Web: " + txtAsunto.Text;
                    mail.Body = $"Hola,\n\nHan recibido una nueva consulta desde el formulario de contacto.\n\n" +
                                $"--------------------------------------------\n" +
                                $"👤 Nombre: {txtNombre.Text}\n" +
                                $"📧 Email Cliente: {txtEmail.Text}\n" +
                                $"📝 Asunto: {txtAsunto.Text}\n" +
                                $"--------------------------------------------\n\n" +
                                $"Mensaje:\n{txtMensaje.Text}";
                    mail.IsBodyHtml = false;

                   
                    SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
                    smtp.Credentials = new NetworkCredential(emailEmisor, passwordEmisor);
                    smtp.EnableSsl = true;

                   
                    smtp.Send(mail);

                    
                    MostrarMensaje("¡Gracias! El correo se ha enviado exitosamente.", "success"); 
                    LimpiarFormularioParcial();
                }
                catch (Exception ex)
                {
                    MostrarMensaje("Error al enviar: " + ex.Message, "danger");
                }
            }
        }

        private void MostrarMensaje(string mensaje, string tipo)
        {
            pnlMensaje.Visible = true;
            pnlMensaje.CssClass = $"alert alert-{tipo} alert-dismissible fade show mb-4";
            litMensaje.Text = mensaje;
        }

        private void LimpiarFormularioParcial()
        {
            
            if (Session["usuario"] == null)
            {
                txtNombre.Text = string.Empty;
                txtEmail.Text = string.Empty;
            }
            
            txtAsunto.Text = string.Empty;
            txtMensaje.Text = string.Empty;
        }
    }
}
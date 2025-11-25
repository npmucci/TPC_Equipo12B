using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net;
using System.Net.Mail;
using Dominio;

namespace Negocio
{
    public static class EmailService
    {
        
        private const string EMAIL_EMISOR = "lucasberlingeri4@gmail.com";
        private const string PASS_EMISOR = "lbqz sexw ymrh sidn";

        
        private static void EnviarEmail(MailMessage email)
        {
            SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
            smtp.Credentials = new NetworkCredential(EMAIL_EMISOR, PASS_EMISOR);
            smtp.EnableSsl = true;

            try
            {
                smtp.Send(email);
            }
            catch (Exception ex)
            {
                
                throw new Exception("No se pudo enviar el correo: " + ex.Message);
            }
        }

        //  CONFIRMACIÓN DE RESERVA 
        public static void EnviarConfirmacionReserva(Turno turno, Pago pago, string emailCliente)
        {
            MailMessage email = new MailMessage();
            email.From = new MailAddress(EMAIL_EMISOR, "Centro Estética - Reservas");
            email.To.Add(emailCliente);
            email.Subject = "✅ Confirmación de Reserva - Centro Estética";
            email.IsBodyHtml = true;

            
            StringBuilder cuerpo = new StringBuilder();
            cuerpo.Append("<div style='font-family: Arial, sans-serif; padding: 20px; border: 1px solid #ddd; max-width: 600px;'>");
            cuerpo.Append("<h2 style='color: #0d6efd;'>¡Tu turno ha sido reservado!</h2>");
            cuerpo.Append("<p>Hola,</p>");
            cuerpo.Append("<p>Te confirmamos que tu reserva ha sido registrada exitosamente en nuestro sistema.</p>");

            cuerpo.Append("<hr>");
            cuerpo.Append("<h3>Detalles del Turno:</h3>");
            cuerpo.Append($"<p><strong>📅 Fecha:</strong> {turno.FechaString}</p>");
            cuerpo.Append($"<p><strong>⏰ Hora:</strong> {turno.HoraInicio:hh\\:mm} hs</p>");
            cuerpo.Append($"<p><strong>💆 Servicio:</strong> {turno.Servicio.Nombre}</p>");

            
            string nombreProf = turno.Profesional != null ? turno.ProfesionalNombreCompleto : "Profesional asignado";
            cuerpo.Append($"<p><strong>👤 Profesional:</strong> {nombreProf}</p>");

            cuerpo.Append("<hr>");
            cuerpo.Append("<h3>Detalles del Pago:</h3>");
            cuerpo.Append($"<p><strong>Monto Abonado:</strong> ${pago.Monto:N0}</p>");
            cuerpo.Append($"<p><strong>Estado del Turno:</strong> {turno.Estado.Descripcion}</p>");

           
            if (!string.IsNullOrEmpty(pago.CodigoTransaccion))
            {
                cuerpo.Append("<div style='background-color: #f8f9fa; padding: 10px; border-left: 4px solid #198754; margin-top: 10px;'>");
                cuerpo.Append($"<p style='margin:0;'><strong>🔐 Código de Operación Recibido:</strong> {pago.CodigoTransaccion}</p>");
                cuerpo.Append("<small>Tu comprobante está sujeto a verificación por administración.</small>");
                cuerpo.Append("</div>");
            }
            else if (pago.FormaDePago != null && pago.FormaDePago.Descripcion.ToLower().Contains("efectivo"))
            {
                cuerpo.Append("<p><em>Pago registrado en efectivo en el local.</em></p>");
            }

            cuerpo.Append("<br>");
            cuerpo.Append("<p style='color: #6c757d; font-size: 12px;'>Si necesitas cancelar, recuerda hacerlo con 24hs de anticipación.</p>");
            cuerpo.Append("</div>");

            email.Body = cuerpo.ToString();

            EnviarEmail(email);
        }

        // AVISO DE CANCELACIÓN 
        public static void EnviarAvisoCancelacion(string emailCliente, string servicio, DateTime fecha, string motivo)
        {
            MailMessage email = new MailMessage();
            email.From = new MailAddress(EMAIL_EMISOR, "Centro Estética - Cancelaciones");
            email.To.Add(emailCliente);
            email.Subject = "❌ Cancelación de Turno";
            email.IsBodyHtml = true;

            string cuerpo = $"<h3>Tu turno para {servicio} el {fecha:dd/MM/yyyy} ha sido cancelado.</h3>";
            cuerpo += $"<p><strong>Detalle:</strong> {motivo}</p>";
            cuerpo += "<p>Si corresponde una devolución, serás contactado/a a la brevedad.</p>";

            email.Body = cuerpo;
            EnviarEmail(email);
        }

        // CONSULTA DESDE LA WEB 
        public static void EnviarConsultaWeb(string nombre, string emailCliente, string asunto, string mensaje)
        {
            MailMessage email = new MailMessage();
            email.From = new MailAddress(EMAIL_EMISOR, "Web Centro Estética - Consultas");

            // Destinatarios del negocio
            email.To.Add("natalia.mucci@alumnos.frgp.utn.edu.ar");
            email.To.Add("lucas.berlingeri@alumnos.frgp.utn.edu.ar");

            email.Subject = "Nueva Consulta Web: " + asunto;

            StringBuilder cuerpo = new StringBuilder();
            cuerpo.Append("Hola,\n\nHan recibido una nueva consulta desde el formulario de contacto.\n\n");
            cuerpo.Append("--------------------------------------------\n");
            cuerpo.Append($"👤 Nombre: {nombre}\n");
            cuerpo.Append($"📧 Email Cliente: {emailCliente}\n");
            cuerpo.Append($"📝 Asunto: {asunto}\n");
            cuerpo.Append("--------------------------------------------\n\n");
            cuerpo.Append($"Mensaje:\n{mensaje}");

            email.Body = cuerpo.ToString();
            email.IsBodyHtml = false; 

            EnviarEmail(email);
        }

        // AVISO DE PAGO ACEPTADO (Cuando la recepcionista valida la transferencia)
        public static void EnviarAvisoPagoAprobado(string emailCliente, Turno turno)
        {
            MailMessage email = new MailMessage();
            email.From = new MailAddress(EMAIL_EMISOR, "Centro Estética - Pagos");
            email.To.Add(emailCliente);
            email.Subject = "✅ ¡Pago Aprobado! Tu turno está confirmado";
            email.IsBodyHtml = true;

            string cuerpo = "<div style='font-family: Arial, sans-serif; padding: 20px; border: 1px solid #28a745; max-width: 600px;'>";
            cuerpo += "<h2 style='color: #28a745;'>¡Pago Verificado!</h2>";
            cuerpo += $"<p>Hola <strong>{turno.Cliente.Nombre}</strong>,</p>";
            cuerpo += "<p>Te informamos que hemos verificado tu comprobante de pago correctamente.</p>";
            cuerpo += "<p><strong>Tu turno ha pasado a estado: CONFIRMADO.</strong></p>";
            cuerpo += "<hr>";
            cuerpo += $"<p>📅 <strong>Fecha:</strong> {turno.FechaString}</p>";
            cuerpo += $"<p>⏰ <strong>Hora:</strong> {turno.HoraInicio:hh\\:mm} hs</p>";
            cuerpo += "<p>¡Te esperamos!</p>";
            cuerpo += "</div>";

            email.Body = cuerpo;
            EnviarEmail(email);
        }

        //  AVISO A RECEPCIÓN (Nuevo Pago entrante por Transferencia)
        public static void EnviarAvisoPagoRecepcionista(Turno turno, Pago pago)
        {
            MailMessage email = new MailMessage();
            email.From = new MailAddress(EMAIL_EMISOR, "Sistema de Pagos");
            
            email.To.Add("lucas.berlingeri@alumnos.frgp.utn.edu.ar");

            email.Subject = $"💸 Nuevo Pago a Verificar - Op: {pago.CodigoTransaccion}";
            email.IsBodyHtml = true;

            StringBuilder cuerpo = new StringBuilder();
            cuerpo.Append("<div style='font-family: Arial, sans-serif; padding: 20px; border: 1px solid #ffc107; max-width: 600px;'>");
            cuerpo.Append("<h3 style='color: #333;'>⚠️ Nuevo Comprobante de Pago Cargado</h3>");

            cuerpo.Append($"<p>El cliente <strong>{turno.Cliente.Nombre} {turno.Cliente.Apellido}</strong> ha registrado una transferencia.</p>");

            cuerpo.Append("<div style='background-color: #fff3cd; padding: 15px; border-radius: 5px; margin: 15px 0;'>");
            cuerpo.Append($"<p style='margin: 5px 0;'><strong>🔑 Código Operación:</strong> {pago.CodigoTransaccion}</p>");
            cuerpo.Append($"<p style='margin: 5px 0;'><strong>💰 Monto Declarado:</strong> ${pago.Monto:N0}</p>");
            cuerpo.Append($"<p style='margin: 5px 0;'><strong>🏦 Banco/Entidad:</strong> (Verificar en Home Banking)</p>");
            cuerpo.Append("</div>");

            cuerpo.Append("<hr>");
            cuerpo.Append("<p><strong>Detalles del Turno asociado:</strong></p>");
            cuerpo.Append($"<ul>");
            cuerpo.Append($"<li>Fecha: {turno.FechaString} - {turno.HoraInicio:hh\\:mm} hs</li>");
            cuerpo.Append($"<li>Servicio: {turno.Servicio.Nombre}</li>");
            cuerpo.Append($"<li>Estado Actual: <strong>PENDIENTE</strong></li>");
            cuerpo.Append($"</ul>");

            cuerpo.Append("<p><em>Por favor, verificá la acreditación y confirmá el turno en el Panel de Recepción.</em></p>");
            cuerpo.Append("</div>");

            email.Body = cuerpo.ToString();

            EnviarEmail(email);
        }

        // RECUPERO DE CONTRASEÑA
        public static void EnviarNuevaContrasenia(string emailDestino, string nuevaPass)
        {
            MailMessage email = new MailMessage();
            email.From = new MailAddress(EMAIL_EMISOR, "Centro Estética - Seguridad");
            email.To.Add(emailDestino);
            email.Subject = "🔐 Recuperación de Contraseña";
            email.IsBodyHtml = true;

            string cuerpo = "<div style='font-family: Arial, sans-serif; padding: 20px; border: 1px solid #ddd; max-width: 600px;'>";
            cuerpo += "<h3>Restablecimiento de Contraseña</h3>";
            cuerpo += "<p>Hola,</p>";
            cuerpo += "<p>Recibimos una solicitud para restablecer tu contraseña.</p>";
            cuerpo += "<div style='background-color: #f8f9fa; padding: 15px; text-align: center; border-radius: 5px; margin: 20px 0;'>";
            cuerpo += "<p style='margin:0; color: #666;'>Tu nueva contraseña temporal es:</p>";
            cuerpo += $"<h2 style='margin: 10px 0; color: #0d6efd; letter-spacing: 2px;'>{nuevaPass}</h2>";
            cuerpo += "</div>";
            cuerpo += "<p>Te recomendamos ingresar al sistema y cambiarla por una de tu preferencia desde la sección 'Mi Perfil'.</p>";
            cuerpo += "<hr>";
            cuerpo += "<small>Si no solicitaste este cambio, por favor contáctanos de inmediato.</small>";
            cuerpo += "</div>";

            email.Body = cuerpo;
            EnviarEmail(email);
        }
    }
}
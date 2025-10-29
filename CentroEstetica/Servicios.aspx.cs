using Dominio; // Asegúrate de tener tus using
using Negocio; // Asegúrate de tener tus using
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CentroEstetica
{
    public partial class Servicios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                if (Request.QueryString["id"] != null)
                {
                    int idEspecialidad;
                    
                    if (int.TryParse(Request.QueryString["id"], out idEspecialidad))
                    {
                        
                        CargarPagina(idEspecialidad);
                    }
                    else
                    {
                        // Si el ID no es un número, redirigir
                        Response.Redirect("Default.aspx", false);
                    }
                }
                else
                {
                    // Si no hay ID en la URL, redirigir
                    Response.Redirect("Default.aspx", false);
                }
            }
        }

        private void CargarPagina(int idEspecialidad)
        {
            try
            {
                // servicios filtrados...

                ServicioNegocio negocioServicio = new ServicioNegocio();
                List<Servicio> listaFiltrada = negocioServicio.listarPorEspecialidad(idEspecialidad);

                if (listaFiltrada.Count > 0)
                {
                    rptServicios.DataSource = listaFiltrada;
                    rptServicios.DataBind();
                }
                else
                {
                    // especialidad sin servicios...
                    divServicios.InnerHtml = "<p class='alert alert-warning'>No hay servicios disponibles para esta especialidad.</p>";
                }


                // título dinamico
                EspecialidadNegocio negocioEspecialidad = new EspecialidadNegocio();
                Especialidad especialidad = negocioEspecialidad.ObtenerPorId(idEspecialidad); 

                if (especialidad != null)
                {
                    h2Titulo.InnerText = "Servicios de " + especialidad.Nombre;
                    
                    // Page.Title = "Servicios de " + especialidad.Nombre;
                }
            }
            catch (Exception ex)
            {
                
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }
    }
}
﻿using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CentroEstetica
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
            if (!IsPostBack)
            {
                try
                {
                   
                    EspecialidadNegocio negocio = new EspecialidadNegocio();

                    List<Especialidad> listaEspecialidades = negocio.ListarActivos();
                    rptEspecialidades.DataSource = listaEspecialidades;

                    rptEspecialidades.DataBind();

                    ProfesionalNegocio profesionalNegocio = new ProfesionalNegocio();
                    List<Profesional> listaProfesionales = profesionalNegocio.ListarActivos();
                    rptProfesionales.DataSource = listaProfesionales;

                    rptProfesionales.DataBind();
                }
                catch (Exception ex)
                {
                    
                    throw ex;
                }
            }
        }
    }
}
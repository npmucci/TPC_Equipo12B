using AccesoDatos;
using Dominio;
using Dominio.Enum; 
using System;
using System.Collections.Generic;
using System.Linq;

namespace Negocio
{
    public class ProfesionalNegocio
    {
        private UsuarioDatos datos;

        public ProfesionalNegocio()
        {
            datos = new UsuarioDatos();
        }
        public List<Usuario> ListarProfesionales()
        {
            
            return datos.ListarPorRol((int)Rol.Profesional);
        }

        
        public List<Usuario> ListarProfesionalesActivos()
        {
           
            return ListarProfesionales().FindAll(prof => prof.Activo);
        }
    }
}
using AccesoDatos;
using Dominio;
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

        
        public List<Usuario> ListarPorEspecialidad(int idEspecialidad)
        {
            
            List<Usuario> todos = ListarProfesionalesActivos();
            List<Usuario> filtrados = new List<Usuario>();

            
            EspecialidadNegocio espNegocio = new EspecialidadNegocio();

            foreach (Usuario prof in todos)
            {
                
                List<Especialidad> especialidadesDelProf = espNegocio.ListarPorProfesional(prof.ID);

                
                if (especialidadesDelProf.Any(e => e.IDEspecialidad == idEspecialidad))
                {
                    filtrados.Add(prof);
                }
            }

            return filtrados;
        }
    }
}
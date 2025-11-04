using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public static class Seguridad
    {
        
        public static bool SesionActiva(object sesionUsuario)
        {
            return sesionUsuario != null;
        }

        
        public static bool EsCliente(object sesionUsuario)
        {
            Usuario usuario = sesionUsuario as Usuario;
            return usuario != null && usuario.Rol == Rol.Cliente;
        }

        public static bool EsAdmin(object sesionUsuario)
        {
            Usuario usuario = sesionUsuario as Usuario;
            
            return usuario != null && (usuario.Rol == Rol.Admin || usuario.Rol == Rol.ProfesionalUnico);
        }

        public static bool EsProfesional(object sesionUsuario)
        {
            Usuario usuario = sesionUsuario as Usuario;
            
            return usuario != null && (usuario.Rol == Rol.Profesional || usuario.Rol == Rol.ProfesionalUnico);
        }

        public static bool EsRecepcionista(object sesionUsuario)
        {
            Usuario usuario = sesionUsuario as Usuario;
            return usuario != null && usuario.Rol == Rol.Recepcionista;
        }
    }
}

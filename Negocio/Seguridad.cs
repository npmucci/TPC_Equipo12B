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
        // Chequea si hay una sesión activa
        public static bool SesionActiva(object sesionUsuario)
        {
            return sesionUsuario != null;
        }

        // Chequea si el usuario es Admin
        public static bool EsAdmin(object sesionUsuario)
        {
            Usuario usuario = sesionUsuario as Usuario;
            return usuario != null && usuario.Rol == Rol.Admin;
        }

        // Chequea si es Cliente
        public static bool EsCliente(object sesionUsuario)
        {
            Usuario usuario = sesionUsuario as Usuario;
            return usuario != null && usuario.Rol == Rol.Cliente;
        }

        // Chequea si es Profesional
        public static bool EsProfesional(object sesionUsuario)
        {
            Usuario usuario = sesionUsuario as Usuario;
            return usuario != null && usuario.Rol == Rol.Profesional;
        }
    }
}

using AccesoDatos;
using Dominio;
using Dominio.Enum; 
using System;
using System.Collections.Generic;
using BCrypt.Net; 


namespace Negocio
{
    public class UsuarioNegocio
    {
        private UsuarioDatos datos;

        public UsuarioNegocio()
        {
            datos = new UsuarioDatos();
        }

        
        public List<Rol> Login(string email, string passwordPlano)
        {
            try
            {
                
                var credenciales = datos.ObtenerCredenciales(email);

                
                if (credenciales.Hash == null || credenciales.Roles.Count == 0)
                {
                    return null; 
                }

                
                bool esValido = BCrypt.Net.BCrypt.Verify(passwordPlano, credenciales.Hash);

                if (!esValido)
                {
                    return null; 
                }

                
                return credenciales.Roles;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        
        public Usuario CargarPerfil(string email, Rol rolElegido)
        {
            try
            {
                
                Usuario usuario = datos.CargarPerfil(email, rolElegido);

                

                return usuario;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        
        public int RegistrarCliente(Cliente nuevo, string passwordPlano)
        {
            try
            {
                
                string hash = BCrypt.Net.BCrypt.HashPassword(passwordPlano);

               
                return datos.RegistrarCliente(nuevo, hash);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
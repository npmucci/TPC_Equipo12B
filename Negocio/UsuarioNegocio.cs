using AccesoDatos;
using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
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


        public Usuario Login(string email, string passwordPlano)
        {
            try
            {
                var credenciales = datos.ObtenerCredenciales(email);

                if (credenciales.Hash == null)   // Si el hash es null, el email no existe o está inactivo
                {
                    return null;
                }

                // bool esValido = credenciales.Hash == passwordPlano; // solo para probar con las contraseñas de la bbdd que no estan encriptadas

                bool esValido = BCrypt.Net.BCrypt.Verify(passwordPlano, credenciales.Hash);


                if (!esValido)  // si no es válido, devolvemos null
                {
                    return null;
                }


                Usuario usuario = datos.ObtenerUsuarioPorEmail(email); // Login exitoso, se guarda usuario para usar en sesión
                return usuario;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public Usuario ObtenerPorId(int id)
        {
            return datos.ObtenerPorId(id);
        }

        public void ActualizarPassword(int idUsuario, string passwordPlano)
        {
            try
            {

                string nuevoHash = BCrypt.Net.BCrypt.HashPassword(passwordPlano);


                datos.ActualizarPassword(idUsuario, nuevoHash);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public int RegistrarUsuario(Usuario nuevo, string passwordPlano)
        {
            try
            {
                // if (datos.ExisteEmail(nuevo.Mail))
                //     throw new Exception("El email ya está en uso.");

                string hash = BCrypt.Net.BCrypt.HashPassword(passwordPlano); // Hasheamos la contraseña

                // Se llama al nuevo método genérico en la capa de datos
                return datos.RegistrarUsuario(nuevo, hash);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool VerificarEmail(string email)
        {

            return datos.ExisteEmail(email);
        }

        public List<Usuario> ListarPorRol(int idRol)
        {
            return datos.ListarPorRol(idRol);
        }

        public void CambiarEstado(int idUsuario, bool estado)
        {
            datos.CambiarEstado(idUsuario, estado);
        }
    }
}

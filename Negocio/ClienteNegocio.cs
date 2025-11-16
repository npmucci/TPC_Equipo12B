using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;
using AccesoDatos;

namespace Negocio
{
    public class ClienteNegocio
    {
        private UsuarioDatos datos;

        public ClienteNegocio()
        {
            datos = new UsuarioDatos();
        }
        public List<Usuario> ListarClientes()
        {

            return datos.ListarPorRol((int)Rol.Cliente);
        }


        public Usuario ObtenerClientePorId(int id)
        {

            return ListarClientes().Find(cli=> cli.ID == id);
        }
        
      


    }
}

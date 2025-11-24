
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Dominio
{
    public class Administrador : Usuario
    {
        public Administrador()
        {
            Rol = Rol.Admin; // Se setea el rol por defecto
            
        }
    }
}

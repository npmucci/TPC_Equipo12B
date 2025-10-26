using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    
    public class Usuario
    {
        public int ID{ get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string DNI { get; set; }
        public string Mail { get; set; }
        public string Contrasenia {get; set; }
        public Rol rol { get; set; }
        public bool Activo { get; set; }

    }
}

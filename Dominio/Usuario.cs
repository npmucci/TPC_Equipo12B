using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{

    public abstract class Usuario
    {
        public int ID { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string Dni { get; set; }
        public string Telefono { get; set; }
        public string Domicilio{ get; set; }
        public string Foto{ get; set; }
        public string Mail { get; set; }

        // propiedad ContraseniaHash eliminada por seguridad

        public Rol Rol { get; set; } 
        public bool Activo { get; set; }

        public string NombreCompleto
        {
            get { return Nombre + " " + Apellido; }
        }
    }
}

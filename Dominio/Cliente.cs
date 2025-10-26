using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Cliente : Usuario
    {
        public string Domicilio { get; set; }
        public string Telefono { get; set; }
        public List<Turno> Turnos { get; set; } 
    }
}

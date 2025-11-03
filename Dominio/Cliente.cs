using Dominio.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Cliente : Usuario
    {
        // Propiedades específicas de Cliente
        public List<Turno> Turnos { get; set; }

        public Cliente()
        {
            Turnos = new List<Turno>();
            Rol = Rol.Cliente;
        }
    }
}
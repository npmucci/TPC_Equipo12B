using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Servicio
    {
        public int ID { get; set; }
        public string Descripcion { get; set; }
        public int Duracion { get; set; }
        public decimal Precio { get; set; }
        public int IdEspecialidad { get; set; }
        public bool Activo { get; set; }
    }
}

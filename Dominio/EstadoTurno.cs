using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public enum EstadoTurno
    {
        Confirmado = 1,
        Pendiente = 2,
        CanceladoCliente = 3,
        CanceladoProfesional = 4,
        Finalizado = 5
    }
}

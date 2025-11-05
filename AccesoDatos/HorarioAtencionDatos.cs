using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AccesoDatos
{
    public class HorarioAtencionDatos
    {
        public List<HorarioAtencion> ListarPorProfesional(int idUsuario)
        {
            List<HorarioAtencion> lista = new List<HorarioAtencion>();
            using (Datos datos = new Datos())
            {
                try
                {
                    string consulta = "SELECT IDHorarioAtencion, DiaSemana, HorarioInicio, HorarioFin, Activo " +
                                      "FROM HorarioAtencion WHERE IDUsuario = @idUsuario";
                    datos.SetearConsulta(consulta);
                    datos.SetearParametro("@idUsuario", idUsuario);
                    datos.EjecutarLectura();

                    while (datos.Lector.Read())
                    {
                        HorarioAtencion aux = new HorarioAtencion();
                        aux.IDHorarioAtencion = (int)datos.Lector["IDHorarioAtencion"];
                        aux.DiaSemana = (string)datos.Lector["DiaSemana"];
                        aux.HorarioInicio = (TimeSpan)datos.Lector["HorarioInicio"];
                        aux.HorarioFin = (TimeSpan)datos.Lector["HorarioFin"];
                        aux.Activo = (bool)datos.Lector["Activo"];

                        // no es necesario rellenar el objeto 'Profesional' porque ya estamos en el contexto de ese profesional

                        lista.Add(aux);
                    }
                    return lista;
                }
                catch (Exception ex) { throw ex; }
            }
        }
        public void Agregar(HorarioAtencion nuevo)
        {
            using (Datos datos = new Datos())
            {
                try
                {
                    datos.SetearProcedimiento("sp_AgregarHorario");
                    datos.SetearParametro("@IDUsuario", nuevo.Profesional.ID);
                    datos.SetearParametro("@DiaSemana", nuevo.DiaSemana);
                    datos.SetearParametro("@HorarioInicio", nuevo.HorarioInicio);
                    datos.SetearParametro("@HorarioFin", nuevo.HorarioFin);
                    datos.EjecutarAccion();
                }
                catch (Exception ex) { throw ex; }
            }
        }

        public void Modificar(HorarioAtencion mod)
        {
            using (Datos datos = new Datos())
            {
                try
                {
                    datos.SetearProcedimiento("sp_ModificarHorario");
                    datos.SetearParametro("@IDHorarioAtencion", mod.IDHorarioAtencion);
                    datos.SetearParametro("@DiaSemana", mod.DiaSemana);
                    datos.SetearParametro("@HorarioInicio", mod.HorarioInicio);
                    datos.SetearParametro("@HorarioFin", mod.HorarioFin);
                    datos.SetearParametro("@Activo", mod.Activo);
                    datos.EjecutarAccion();
                }
                catch (Exception ex) { throw ex; }
            }
        }

        public void Eliminar(int id)
        {
            using (Datos datos = new Datos())
            {
                try
                {
                    datos.SetearProcedimiento("sp_EliminarHorario");
                    datos.SetearParametro("@IDHorarioAtencion", id);
                    datos.EjecutarAccion();
                }
                catch (Exception ex) { throw ex; }
            }
        }
    }
}

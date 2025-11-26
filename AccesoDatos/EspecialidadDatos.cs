using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Configuration;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace AccesoDatos
{
    public class EspecialidadDatos
    {

        public List<Especialidad> Listar()
        {
            List<Especialidad> lista = new List<Especialidad>();


            using (Datos datos = new Datos())
            {
                try
                {
                    datos.SetearProcedimiento("ListarEspecialidades");
                    datos.EjecutarLectura();

                    while (datos.Lector.Read())
                    {
                        Especialidad aux = new Especialidad();
                        aux.IDEspecialidad = (int)datos.Lector["IDEspecialidad"];
                        aux.Nombre = (string)datos.Lector["Nombre"];

                        if (!(datos.Lector["Descripcion"] is DBNull))
                        {
                            aux.Descripcion = (string)datos.Lector["Descripcion"];
                        }
                        aux.Foto = (string)datos.Lector["Foto"];

                        aux.Activo = (bool)datos.Lector["Activo"];

                        lista.Add(aux);
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al listar las especialidades: " + ex.Message);
                }

            }

            return lista;
        }


        public Especialidad ObtenerPorId(int id)
        {
            Especialidad aux = null;
            using (Datos datos = new Datos())
            {
                try
                {
                    string consulta = "SELECT IDEspecialidad, Nombre, Descripcion, Foto FROM Especialidad WHERE IDEspecialidad = @id";
                    datos.SetearConsulta(consulta);
                    datos.SetearParametro("@id", id);
                    datos.EjecutarLectura();

                    if (datos.Lector.Read())
                    {
                        aux = new Especialidad();
                        aux.IDEspecialidad = (int)datos.Lector["IDEspecialidad"];
                        aux.Nombre = (string)datos.Lector["Nombre"];

                        if (!(datos.Lector["Descripcion"] is DBNull))
                        {
                            aux.Descripcion = (string)datos.Lector["Descripcion"];
                        }
                        aux.Foto = (string)datos.Lector["Foto"];
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al obtener la especialidad por ID: " + ex.Message);
                }
            }
            return aux;
        }


        public void Agregar(Especialidad nueva)
        {
            using (Datos datos = new Datos())
            {
                try
                {

                    datos.SetearProcedimiento("sp_AgregarEspecialidad");


                    datos.SetearParametro("@Nombre", nueva.Nombre);
                    datos.SetearParametro("@Descripcion", (object)nueva.Descripcion ?? DBNull.Value);
                    datos.SetearParametro("@Foto", (object)nueva.Foto ?? DBNull.Value);

                    datos.EjecutarAccion();
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al agregar la especialidad: " + ex.Message);
                }
            }
        }

        public void Modificar(Especialidad mod)
        {
            using (Datos datos = new Datos())
            {
                try
                {
                    datos.SetearProcedimiento("sp_ModificarEspecialidad");
                    datos.SetearParametro("@ID", mod.IDEspecialidad);
                    datos.SetearParametro("@Nombre", mod.Nombre);
                    datos.SetearParametro("@Descripcion", (object)mod.Descripcion ?? DBNull.Value);
                    datos.SetearParametro("@Foto", (object)mod.Foto ?? DBNull.Value);
                    datos.SetearParametro("@Activo", mod.Activo);

                    datos.EjecutarAccion();
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al modificar la especialidad: " + ex.Message);
                }
            }
        }

        public void EliminarLogico(int id)
        {
            using (Datos datos = new Datos())
            {
                try
                {
                    datos.SetearProcedimiento("sp_EliminarLogicoEspecialidad");
                    datos.SetearParametro("@ID", id);
                    datos.EjecutarAccion();
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al eliminar la especialidad: " + ex.Message);
                }
            }
        }

        public void ActivarLogico(int id)
        {
            using (Datos datos = new Datos())
            {
                try
                {

                    string consulta = "UPDATE Especialidad SET Activo = 1 WHERE IDEspecialidad = @ID";
                    datos.SetearConsulta(consulta);
                    datos.SetearParametro("@ID", id);
                    datos.EjecutarAccion();
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al activar la especialidad: " + ex.Message);
                }
            }
        }

        public void AsignarEspecialidad(int idUsuario, int idEspecialidad)
        {
            using (Datos datos = new Datos())
            {
                try
                {
                    string consulta = "INSERT INTO ProfesionalEspecialidad (IDUsuario, IDEspecialidad) VALUES (@idUsuario, @idEspecialidad)";
                    datos.SetearConsulta(consulta);
                    datos.SetearParametro("@idUsuario", idUsuario);
                    datos.SetearParametro("@idEspecialidad", idEspecialidad);
                    datos.EjecutarAccion();
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al asignar la especialidad al profesional: " + ex.Message);
                }
            }
        }

        public void EliminarEspecialidadDeProfesional(int idUsuario, int idEspecialidad)
        {
            using (Datos datos = new Datos())
            {
                try
                {

                    string consulta = "DELETE FROM ProfesionalEspecialidad WHERE IDUsuario = @idUsuario AND IDEspecialidad = @idEsp";

                    datos.SetearConsulta(consulta);
                    datos.SetearParametro("@idUsuario", idUsuario);
                    datos.SetearParametro("@idEsp", idEspecialidad);

                    datos.EjecutarAccion();
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al eliminar la especialidad del profesional: " + ex.Message);
                }

            }
        }

        public List<Especialidad> ListarPorProfesional(int idProfesional)
        {
            List<Especialidad> lista = new List<Especialidad>();
            using (Datos datos = new Datos())
            {
                try
                {
                    string consulta = @"
                    SELECT E.IDEspecialidad, E.Nombre
                    FROM Especialidad E
                    INNER JOIN ProfesionalEspecialidad PE ON E.IDEspecialidad = PE.IDEspecialidad
                    WHERE PE.IDUsuario = @idProfesional AND E.Activo = 1";

                    datos.SetearConsulta(consulta);
                    datos.SetearParametro("@idProfesional", idProfesional);
                    datos.EjecutarLectura();

                    while (datos.Lector.Read())
                    {
                        Especialidad aux = new Especialidad();
                        aux.IDEspecialidad = (int)datos.Lector["IDEspecialidad"];
                        aux.Nombre = (string)datos.Lector["Nombre"];
                        lista.Add(aux);
                    }
                    return lista;
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al listar las especialidades del profesional: " + ex.Message);
                }
            }
        }

    }
}

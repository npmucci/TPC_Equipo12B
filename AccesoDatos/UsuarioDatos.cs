using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AccesoDatos
{
    public class UsuarioDatos
    {

        public (string Hash, Rol Rol) ObtenerCredenciales(string email)  // Trae solo el hash y el rol para validar el login
        {
            using (Datos datos = new Datos())
            {
                try
                {
                    string consulta = "SELECT IDRol, ContraseniaHash FROM Usuario WHERE Mail = @mail AND Activo = 1";
                    datos.SetearConsulta(consulta);
                    datos.SetearParametro("@mail", email);
                    datos.EjecutarLectura();

                    if (datos.Lector.Read())
                    {
                        string hash = (string)datos.Lector["ContraseniaHash"];
                        Rol rol = (Rol)datos.Lector["IDRol"];
                        return (hash, rol);  // Devuelve un "Tuple" (un objeto temporal) con el hash y el rol.
                    }

                    return (null, 0);  // Si no encuentra usuario, devuelve null
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }


        public Usuario ObtenerUsuarioPorEmail(string email)
        {
            using (Datos datos = new Datos())
            {
                try
                {

                    string consulta = "SELECT * FROM Usuario WHERE Mail = @mail AND Activo = 1";
                    datos.SetearConsulta(consulta);
                    datos.SetearParametro("@mail", email);
                    datos.EjecutarLectura();

                    if (datos.Lector.Read())
                    {
                        Usuario aux;
                        Rol rol = (Rol)datos.Lector["IDRol"];


                        switch (rol)
                        {
                            case Rol.Admin:
                                aux = new Administrador();
                                break;
                            case Rol.Profesional:
                                aux = new Profesional();
                                // 
                                break;
                            case Rol.Recepcionista:
                                aux = new Recepcionista();
                                break;
                            case Rol.ProfesionalUnico:
                                aux = new ProfesionalUnico();
                                // 
                                break;
                            case Rol.Cliente:
                            default:
                                aux = new Cliente();
                                // 
                                break;
                        }


                        aux.ID = (int)datos.Lector["IDUsuario"];
                        aux.Nombre = (string)datos.Lector["Nombre"];
                        aux.Apellido = (string)datos.Lector["Apellido"];
                        aux.Dni = (string)datos.Lector["Dni"];
                        aux.Mail = (string)datos.Lector["Mail"];
                        aux.Activo = (bool)datos.Lector["Activo"];
                        aux.Telefono = (string)datos.Lector["Telefono"];
                        aux.Domicilio = datos.Lector["Domicilio"] is DBNull ? null : (string)datos.Lector["Domicilio"];
                        aux.Foto = datos.Lector["Foto"] is DBNull ? null : (string)datos.Lector["Foto"];
                        aux.Rol = rol;

                        return aux;
                    }
                    return null;
                }
                catch (Exception ex) { throw ex; }
            }
        }

        public Usuario ObtenerPorId(int id)
        {
            Usuario aux = null;
            using (Datos datos = new Datos())
            {
                try
                {
                    string consulta = "SELECT IDUsuario, Mail, ContraseniaHash, Nombre, Apellido, Dni, Telefono, Domicilio, IDRol, Activo, Foto FROM Usuario WHERE IDUsuario = @id";
                    datos.SetearConsulta(consulta);
                    datos.SetearParametro("@id", id);
                    datos.EjecutarLectura();

                    if (datos.Lector.Read())
                    {
                       
                        Rol rol = (Rol)datos.Lector["IDRol"];

                        switch (rol)
                        {
                            case Rol.Admin:
                                aux = new Administrador();
                                break;
                            case Rol.Profesional:
                                aux = new Profesional();
                                break;
                            case Rol.Recepcionista:
                                aux = new Recepcionista();
                                break;
                            case Rol.ProfesionalUnico:
                                aux = new ProfesionalUnico();
                                break;
                            case Rol.Cliente:
                            default:
                                aux = new Cliente();
                                break;
                        }
                     
                        aux.ID = (int)datos.Lector["IDUsuario"];
                        aux.Mail = (string)datos.Lector["Mail"];
                        aux.Nombre = (string)datos.Lector["Nombre"];
                        aux.Apellido = (string)datos.Lector["Apellido"];
                        aux.Dni = (string)datos.Lector["Dni"];
                        aux.Telefono = (string)datos.Lector["Telefono"];
                        aux.Domicilio = datos.Lector["Domicilio"] is DBNull ? null : (string)datos.Lector["Domicilio"];
                        aux.Foto = datos.Lector["Foto"] is DBNull ? null : (string)datos.Lector["Foto"];
                        aux.Rol = rol;
                        aux.Activo = (bool)datos.Lector["Activo"];
                    }
                    return aux;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        public void ActualizarPassword(int idUsuario, string nuevoHash)
        {
            using (Datos datos = new Datos())
            {
                try
                {
                    
                    string consulta = "UPDATE Usuario SET ContraseniaHash = @hash WHERE IDUsuario = @id";

                    datos.SetearConsulta(consulta);
                    datos.SetearParametro("@hash", nuevoHash);
                    datos.SetearParametro("@id", idUsuario);

                    
                    datos.EjecutarAccion();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        public int RegistrarUsuario(Usuario nuevo, string hash)
        {
            using (Datos datos = new Datos())
            {
                try
                {
                    datos.SetearProcedimiento("sp_RegistrarUsuario");
                    datos.SetearParametro("@Nombre", nuevo.Nombre);
                    datos.SetearParametro("@Apellido", nuevo.Apellido);
                    datos.SetearParametro("@Dni", nuevo.Dni);
                    datos.SetearParametro("@Telefono", nuevo.Telefono);
                    datos.SetearParametro("@Domicilio", (object)nuevo.Domicilio ?? DBNull.Value);
                    datos.SetearParametro("@Mail", nuevo.Mail);
                    datos.SetearParametro("@Hash", hash);
                    datos.SetearParametro("@Foto", (object)nuevo.Foto ?? DBNull.Value);


                    datos.SetearParametro("@IDRol", (int)nuevo.Rol);


                    return datos.EjecutarAccionEscalar();
                }
                catch (Exception ex) { throw ex; }
            }
        }

        public List<Usuario> ListarPorRol(int idRol)
        {
            List<Usuario> lista = new List<Usuario>();
            using (Datos datos = new Datos())
            {
                try
                {
                    datos.SetearProcedimiento("ListarUsuariosPorRol");
                    datos.SetearParametro("@IDRol", idRol);
                    datos.EjecutarLectura();

                    while (datos.Lector.Read())
                    {
                        Usuario aux;
                        Rol rol = (Rol)datos.Lector["IDRol"];


                        switch (rol)
                        {
                            case Rol.Admin: aux = new Administrador(); break;
                            case Rol.Profesional: aux = new Profesional(); break;
                            case Rol.Recepcionista: aux = new Recepcionista(); break;
                            case Rol.ProfesionalUnico: aux = new ProfesionalUnico(); break;
                            case Rol.Cliente:
                            default: aux = new Cliente(); break;
                        }


                        aux.ID = (int)datos.Lector["IDUsuario"];
                        aux.Nombre = (string)datos.Lector["Nombre"];
                        aux.Apellido = (string)datos.Lector["Apellido"];
                        aux.Dni = (string)datos.Lector["Dni"];
                        aux.Mail = (string)datos.Lector["Mail"];
                        aux.Telefono = (string)datos.Lector["Telefono"];
                        aux.Domicilio = datos.Lector["Domicilio"] == DBNull.Value ? string.Empty : datos.Lector["Domicilio"].ToString();
                        aux.Foto = datos.Lector["Foto"] != DBNull.Value ? (string)datos.Lector["Foto"] : null;
                        aux.Activo = (bool)datos.Lector["Activo"];
                        aux.Rol = rol;

                        lista.Add(aux);
                    }
                }
                catch (Exception ex) { throw ex; }
            }
            return lista;
        }

        public void Modificar(Usuario usuario)
        {
            using (Datos datos = new Datos())
            {
                try
                {
                    
                    datos.SetearProcedimiento("sp_ModificarUsuario");
                    datos.SetearParametro("@IDUsuario", usuario.ID);
                    datos.SetearParametro("@Nombre", usuario.Nombre);
                    datos.SetearParametro("@Apellido", usuario.Apellido);
                    datos.SetearParametro("@Dni", usuario.Dni);
                    datos.SetearParametro("@Telefono", usuario.Telefono);
                    datos.SetearParametro("@Domicilio", (object)usuario.Domicilio ?? DBNull.Value);
                    datos.SetearParametro("@Mail", usuario.Mail);
                    datos.SetearParametro("@Foto", (object)usuario.Foto ?? DBNull.Value);
                    datos.SetearParametro("@Activo", usuario.Activo);
                    datos.EjecutarAccion();
                    
                }
                catch (Exception ex) { throw ex; }
            }
        }

        public bool ExisteEmail(string email)
        {
            using (Datos datos = new Datos())
            {
                datos.SetearConsulta("SELECT COUNT(*) FROM Usuario WHERE Mail = @Mail");
                datos.SetearParametro("@Mail", email);
                datos.EjecutarLectura();

                if (datos.Lector.Read())
                {
                    int count = (int)datos.Lector[0];
                    return count > 0;
                }
                return false;
            }
        }

        public bool ExisteDNI(string dni)
        {
            using (Datos datos = new Datos())
            {
                try
                {
                    datos.SetearConsulta("SELECT COUNT(*) FROM Usuario WHERE Dni = @Dni");
                    datos.SetearParametro("@Dni", dni);
                    datos.EjecutarLectura();

                    if (datos.Lector.Read())
                    {
                        int count = (int)datos.Lector[0];
                        return count > 0;
                    }
                    return false;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        public void CambiarEstado(int idUsuario, bool activo)
        {
            using (Datos datos = new Datos())
            {
                try
                {
                    
                    string consulta = "UPDATE Usuario SET Activo = @activo WHERE IDUsuario = @idUsuario";
                    datos.SetearConsulta(consulta);
                    datos.SetearParametro("@activo", activo);
                    datos.SetearParametro("@idUsuario", idUsuario);
                    datos.EjecutarAccion();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }
    }
}
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



        public int RegistrarCliente(Cliente nuevo, string hash)
        {
            using (Datos datos = new Datos())
            {
                try
                {
                    
                    string consultaUsuario = @"
                        INSERT INTO Usuario (Nombre, Apellido, Dni, Telefono, Domicilio, Mail, ContraseniaHash, Foto, Activo, IDRol) 
                        VALUES (@Nombre, @Apellido, @Dni, @Telefono, @Domicilio, @Mail, @Hash, @Foto, 1, @IDRol);
                        SELECT CAST(SCOPE_IDENTITY() AS INT);";

                    datos.SetearConsulta(consultaUsuario);
                    datos.SetearParametro("@Nombre", nuevo.Nombre);
                    datos.SetearParametro("@Apellido", nuevo.Apellido);
                    datos.SetearParametro("@Dni", nuevo.Dni);
                    datos.SetearParametro("@Telefono", nuevo.Telefono);
                    datos.SetearParametro("@Domicilio", (object)nuevo.Domicilio ?? DBNull.Value);
                    datos.SetearParametro("@Mail", nuevo.Mail);
                    datos.SetearParametro("@Hash", hash);
                    datos.SetearParametro("@Foto", (object)nuevo.Foto ?? DBNull.Value);
                    datos.SetearParametro("@IDRol", (int)Rol.Cliente); 

                    

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
    }
}
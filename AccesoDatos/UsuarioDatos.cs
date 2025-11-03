using Dominio;
using Dominio.Enum;
using System;
using System.Collections.Generic;

namespace AccesoDatos
{
    public class UsuarioDatos
    {
        
        public (string Hash, List<Rol> Roles) ObtenerCredenciales(string email) // Trae el Hash y la LISTA de roles
        {
            using (Datos datos = new Datos())
            {
                try
                {
                    
                    string consulta = @"
                        SELECT U.ContraseniaHash, UR.IDRol 
                        FROM Usuario U
                        INNER JOIN UsuarioRol UR ON U.IDUsuario = UR.IDUsuario
                        WHERE U.Mail = @mail AND U.Activo = 1";

                    datos.SetearConsulta(consulta);
                    datos.SetearParametro("@mail", email);
                    datos.EjecutarLectura();

                    string hash = null;
                    List<Rol> roles = new List<Rol>();

                    while (datos.Lector.Read())
                    {
                        if (hash == null)
                            hash = (string)datos.Lector["ContraseniaHash"];

                        roles.Add((Rol)datos.Lector["IDRol"]);
                    }

                    return (hash, roles); // Devuelve el hash y la lista de roles
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }



        public Usuario CargarPerfil(string email, Rol rolElegido)
        {
            using (Datos datos = new Datos())
            {
                try
                {
                    
                    string consulta = @"
                SELECT IDUsuario, Nombre, Apellido, Dni, Telefono, Domicilio, Foto, Mail, Activo 
                FROM Usuario 
                WHERE Mail = @mail AND Activo = 1";

                    datos.SetearConsulta(consulta);
                    datos.SetearParametro("@mail", email);
                    datos.EjecutarLectura();

                    if (datos.Lector.Read())
                    {
                        Usuario aux; 

                        
                        switch (rolElegido)
                        {
                            case Rol.Admin:
                                aux = new Administrador();
                                break;
                            case Rol.Profesional:
                                aux = new Profesional();
                                break;
                            case Rol.Cliente:
                            default:
                                aux = new Cliente();
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
                        aux.Rol = rolElegido;

                        
                        return aux;
                    }
                    return null;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }


        public int RegistrarCliente(Cliente nuevo, string hash)
        {
            using (Datos datos = new Datos())
            {
                try
                {
                    
                    string consultaUsuario = @"
                        INSERT INTO Usuario (Nombre, Apellido, Dni, Telefono, Domicilio, Mail, ContraseniaHash, Foto, Activo) 
                        VALUES (@Nombre, @Apellido, @Dni, @Telefono, @Domicilio, @Mail, @Hash, @Foto, 1);
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

                    int idNuevoUsuario = datos.EjecutarAccionEscalar();

                    // Inserta en UsuarioRol
                    string consultaRol = "INSERT INTO UsuarioRol (IDUsuario, IDRol) VALUES (@IDUsuario, @IDRol)";
                    datos.SetearConsulta(consultaRol);
                    datos.SetearParametro("@IDUsuario", idNuevoUsuario);
                    datos.SetearParametro("@IDRol", (int)Rol.Cliente);
                    datos.EjecutarAccion();

                    return idNuevoUsuario;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }
    }
}
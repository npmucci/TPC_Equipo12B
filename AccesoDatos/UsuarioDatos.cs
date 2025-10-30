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

                    string consulta = @"
                    SELECT 
                        U.ID, U.Nombre, U.Apellido, U.Dni, U.Mail, U.IDRol, U.Activo, C.Domicilio, C.Telefono FROM Usuario U
                    LEFT JOIN 
                        Cliente C ON U.ID = C.IDUsuario
                    LEFT JOIN 
                        Profesional P ON U.ID = P.IDUsuario
                    WHERE 
                        U.Mail = @mail AND U.Activo = 1";

                    datos.SetearConsulta(consulta);
                    datos.SetearParametro("@mail", email);
                    datos.EjecutarLectura();

                    if (datos.Lector.Read())
                    {
                        Usuario aux;            // Clase Usuario declarada como clase abstracta...
                        Rol rol = (Rol)datos.Lector["IDRol"];


                        switch (rol)
                        {
                            case Rol.Admin:
                                aux = new Administrador();

                                break;

                            case Rol.Profesional:
                                aux = new Profesional();

                                break;

                            case Rol.Cliente:
                            default:
                                // Instanciamos Y casteamos para rellenar campos específicos para cliente...
                                Cliente cliente = new Cliente();
                                cliente.Domicilio = datos.Lector["Domicilio"] is DBNull ? null : (string)datos.Lector["Domicilio"];
                                cliente.Telefono = datos.Lector["Telefono"] is DBNull ? null : (string)datos.Lector["Telefono"];
                                aux = cliente;
                                break;
                        }


                        aux.ID = (int)datos.Lector["ID"];
                        aux.Nombre = (string)datos.Lector["Nombre"];
                        aux.Apellido = (string)datos.Lector["Apellido"];
                        aux.Dni = (string)datos.Lector["Dni"];
                        aux.Mail = (string)datos.Lector["Mail"];
                        aux.Activo = (bool)datos.Lector["Activo"];
                        aux.Rol = rol;

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

                    string consultaUsuario = "INSERT INTO Usuario (Nombre, Apellido, Dni, Mail, ContraseniaHash, IDRol, Activo) " +
                                             "VALUES (@Nombre, @Apellido, @Dni, @Mail, @Hash, @IDRol, 1); " +
                                             "SELECT CAST(SCOPE_IDENTITY() AS INT);";

                    datos.SetearConsulta(consultaUsuario);
                    datos.SetearParametro("@Nombre", nuevo.Nombre);
                    datos.SetearParametro("@Apellido", nuevo.Apellido);
                    datos.SetearParametro("@Dni", nuevo.Dni);
                    datos.SetearParametro("@Mail", nuevo.Mail);
                    datos.SetearParametro("@Hash", hash);
                    datos.SetearParametro("@IDRol", (int)Rol.Cliente); // Se registra como Cliente

                    int idNuevoUsuario = datos.EjecutarAccionEscalar();

                    // Inserta en la tabla Cliente usando el ID obtenido
                    string consultaCliente = "INSERT INTO Cliente (IDUsuario, Domicilio, Telefono) " +
                                             "VALUES (@IDUsuario, @Domicilio, @Telefono)";


                    datos.SetearConsulta(consultaCliente);
                    datos.SetearParametro("@IDUsuario", idNuevoUsuario);
                    datos.SetearParametro("@Domicilio", (object)nuevo.Domicilio ?? DBNull.Value);
                    datos.SetearParametro("@Telefono", (object)nuevo.Telefono ?? DBNull.Value);

                    datos.EjecutarAccion(); // Esta vez no devuelve nada

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
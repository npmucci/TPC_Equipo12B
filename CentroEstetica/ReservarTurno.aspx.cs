using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;

namespace CentroEstetica
{
    public partial class ReservarTurno : System.Web.UI.Page
    {
        private EspecialidadNegocio espNegocio = new EspecialidadNegocio();
        private ServicioNegocio servNegocio = new ServicioNegocio();
        private ProfesionalNegocio profNegocio = new ProfesionalNegocio();
        private HorarioAtencionNegocio horarioNegocio = new HorarioAtencionNegocio();
        private TurnoNegocio turnoNegocio = new TurnoNegocio();
        private ClienteNegocio clienteNegocio = new ClienteNegocio();
        private UsuarioNegocio usuarioNegocio = new UsuarioNegocio();

        private HashSet<DateTime> FechasDisponiblesCache
        {
            get { return (HashSet<DateTime>)ViewState["FechasDisponibles"] ?? new HashSet<DateTime>(); }
            set { ViewState["FechasDisponibles"] = value; }
        }

        // Inicializacion y Carga
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Seguridad.SesionActiva(Session["usuario"]))
            {
                Response.Redirect("Default.aspx", false);
                return;
            }

            if (!IsPostBack)
            {
                CargarEspecialidades();
                calFecha.SelectedDate = DateTime.Today;

                Usuario usuario = (Usuario)Session["usuario"];

                if (Seguridad.EsAdmin(usuario) || Seguridad.EsRecepcionista(usuario))
                {
                    pnlPaso1_Cliente.Visible = true;
                    pnlPaso2_Servicio.Visible = false;
                }
                else
                {
                    hfIdClienteSeleccionado.Value = usuario.ID.ToString();
                    pnlPaso1_Cliente.Visible = false;
                    pnlPaso2_Servicio.Visible = true;
                }
            }
        }

        private void CargarEspecialidades()
        {
            try
            {
                ddlEspecialidad.DataSource = espNegocio.ListarActivos();
                ddlEspecialidad.DataTextField = "Nombre";
                ddlEspecialidad.DataValueField = "IDEspecialidad";
                ddlEspecialidad.DataBind();
                ddlEspecialidad.Items.Insert(0, new ListItem("Seleccione...", "0"));
            }
            catch (Exception) { }
        }


        // Paso 1: Seleccion Cliente (recepcion)
        protected void btnBuscarCliente_Click(object sender, EventArgs e)
        {
            string termino = txtBuscarCliente.Text.Trim().ToLower();
            if (string.IsNullOrEmpty(termino)) return;

            try
            {
                
                List<Usuario> todos = usuarioNegocio.ListarTodos();

                List<Usuario> resultados = todos.FindAll(x =>
                    x.Nombre.ToLower().Contains(termino) ||
                    x.Apellido.ToLower().Contains(termino) ||
                    x.Dni.Contains(termino)
                );

                gvClientes.DataSource = resultados;
                gvClientes.DataBind();
                gvClientes.Visible = true;
            }
            catch (Exception) { }
        }

        protected void gvClientes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Seleccionar")
            {
                int idCliente = int.Parse(e.CommandArgument.ToString());
                hfIdClienteSeleccionado.Value = idCliente.ToString();

                UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
                Usuario cliente = usuarioNegocio.ObtenerPorId(idCliente);
             
                if (cliente != null)
                {
                    lblClienteNombre.Text = $"{cliente.Nombre} {cliente.Apellido} ({cliente.Dni})";

                    txtBuscarCliente.Visible = false;
                    btnBuscarCliente.Visible = false;
                    gvClientes.Visible = false;
                    pnlClienteSeleccionado.Visible = true;

                    pnlPaso2_Servicio.Visible = true;
                    upReserva.Update();
                }
            }
        }

        protected void btnCambiarCliente_Click(object sender, EventArgs e)
        {
            hfIdClienteSeleccionado.Value = "";
            pnlClienteSeleccionado.Visible = false;
            txtBuscarCliente.Visible = true;
            btnBuscarCliente.Visible = true;
            gvClientes.Visible = false;

            ReiniciarPasos(2);
            pnlPaso2_Servicio.Visible = false;
        }

        protected void btnNuevoCliente_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistroPage.aspx?rol=" + (int)Dominio.Rol.Cliente);
        }
        

        // Paso 2: Especialidad y Servicio
        protected void ddlEspecialidad_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idEsp = int.Parse(ddlEspecialidad.SelectedValue);
            if (idEsp > 0)
            {
                List<Servicio> servicios = servNegocio.ListarPorEspecialidad(idEsp);
                servicios = servicios.FindAll(s => s.Activo);

                ddlServicio.DataSource = servicios;
                ddlServicio.DataTextField = "Nombre";
                ddlServicio.DataValueField = "IDServicio";
                ddlServicio.DataBind();
                ddlServicio.Items.Insert(0, new ListItem("Seleccione...", "0"));
                ddlServicio.Enabled = true;
            }
            else
            {
                ddlServicio.Items.Clear();
                ddlServicio.Enabled = false;
            }

            ReiniciarPasos(3);
            upReserva.Update();
            upResumen.Update();
        }

        protected void ddlServicio_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idServ = int.Parse(ddlServicio.SelectedValue);
            ReiniciarPasos(3);

            if (idServ > 0)
            {
                Servicio seleccionado = servNegocio.ObtenerPorId(idServ);
                lblResumenServicio.Text = seleccionado.Nombre;
                lblResumenPrecio.Text = "$" + seleccionado.Precio.ToString("N0");
                ViewState["DuracionServicio"] = seleccionado.DuracionMinutos;

                int idEsp = int.Parse(ddlEspecialidad.SelectedValue);
                List<Usuario> profs = profNegocio.ListarPorEspecialidad(idEsp);
                profs = profs.FindAll(p => p.Activo);

                if (profs.Count > 0)
                {
                    ddlProfesional.DataSource = profs;
                    ddlProfesional.DataTextField = "NombreCompleto";
                    ddlProfesional.DataValueField = "ID";
                    ddlProfesional.DataBind();
                    ddlProfesional.Items.Insert(0, new ListItem("Seleccione...", "0"));

                    pnlPaso3_Profesional.Visible = true;
                    ddlProfesional.Visible = true;
                    msgProfesional.Visible = false;
                }
                else
                {
                    pnlPaso3_Profesional.Visible = true;
                    ddlProfesional.Visible = false;
                    msgProfesional.Visible = true;
                }
            }
            else
            {
                lblResumenServicio.Text = "-";
                lblResumenPrecio.Text = "$0";
                pnlPaso3_Profesional.Visible = false;
            }

            upReserva.Update();
            upResumen.Update();
        }
        

        // Paso 3: Profesional
        protected void ddlProfesional_SelectedIndexChanged(object sender, EventArgs e)
        {
            ReiniciarPasos(4);
            int idProf = int.Parse(ddlProfesional.SelectedValue);

            if (idProf > 0)
            {
                lblResumenProfesional.Text = ddlProfesional.SelectedItem.Text;
                pnlPaso4_FechaHora.Visible = true;

                msgSeleccionarFecha.Visible = true;
                msgSinHorarios.Visible = false;

                PreCalcularDisponibilidadMes(DateTime.Today.Month, DateTime.Today.Year);
            }
            else
            {
                lblResumenProfesional.Text = "-";
                pnlPaso4_FechaHora.Visible = false;
            }

            upReserva.Update();
            upResumen.Update();
        }
        

        // Paso 4: Calendario y Horarios
        protected void calFecha_DayRender(object sender, DayRenderEventArgs e)
        {
            if (e.Day.Date < DateTime.Today)
            {
                e.Day.IsSelectable = false;
                e.Cell.ForeColor = System.Drawing.Color.Silver;
                return;
            }

            if (FechasDisponiblesCache.Contains(e.Day.Date))
            {
                e.Cell.CssClass = "day-available";
                e.Cell.ToolTip = "Horarios disponibles";
            }
        }

        protected void calFecha_VisibleMonthChanged(object sender, MonthChangedEventArgs e)
        {
            if (ddlProfesional.SelectedValue != "0")
            {
                PreCalcularDisponibilidadMes(e.NewDate.Month, e.NewDate.Year);
                upReserva.Update();
            }
        }

        protected void calFecha_SelectionChanged(object sender, EventArgs e)
        {
            DateTime fecha = calFecha.SelectedDate;
            lblResumenFecha.Text = fecha.ToString("dd/MM/yyyy");

            msgSeleccionarFecha.Visible = false;
            ActualizarGrillaHorarios(fecha);

            upReserva.Update();
            upResumen.Update();
        }

        protected void rptHorarios_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string hora = e.CommandArgument.ToString();
            hfHoraSeleccionada.Value = hora;
            lblResumenHora.Text = hora + " hs";
            btnContinuarReserva.Enabled = true;

            ActualizarGrillaHorarios(calFecha.SelectedDate);

            upReserva.Update();
            upResumen.Update();
        }
        

        // Logica de Negocio (Calculo Disponibilidad)
        private List<string> CalcularSlotsParaFecha(DateTime fecha, int idProf, int duracionServicio)
        {
            List<string> slotsLibres = new List<string>();

            string diaSemana = TraducirDia(fecha.DayOfWeek);
            List<HorarioAtencion> horariosProf = horarioNegocio.ListarPorProfesional(idProf);
            HorarioAtencion horarioDia = horariosProf.Find(h => h.DiaSemana == diaSemana && h.Activo);

            if (horarioDia == null) return slotsLibres;

            List<Turno> turnosDelDia = turnoNegocio.ListarTurnosDelDia(idProf, fecha, fecha);

            TimeSpan inicioJornada = horarioDia.HorarioInicio;
            TimeSpan finJornada = horarioDia.HorarioFin;

            if (fecha.Date == DateTime.Today)
            {
                TimeSpan horaActual = DateTime.Now.TimeOfDay;
                int minutos = horaActual.Minutes >= 30 ? 60 : 30;
                TimeSpan proximaMediaHora = new TimeSpan(horaActual.Hours, 0, 0).Add(TimeSpan.FromMinutes(minutos));
                if (inicioJornada < proximaMediaHora) inicioJornada = proximaMediaHora;
            }

            TimeSpan cursor = inicioJornada;
            while (cursor.Add(TimeSpan.FromMinutes(duracionServicio)) <= finJornada)
            {
                TimeSpan nuevoInicio = cursor;
                TimeSpan nuevoFin = cursor.Add(TimeSpan.FromMinutes(duracionServicio));
                bool colisiona = false;

                foreach (Turno t in turnosDelDia)
                {
                    int duracionTurnoOcupado = (t.Servicio != null && t.Servicio.DuracionMinutos > 0) ? t.Servicio.DuracionMinutos : 60;

                    TimeSpan ocupadoInicio = t.HoraInicio;
                    TimeSpan ocupadoFin = t.HoraInicio.Add(TimeSpan.FromMinutes(duracionTurnoOcupado));

                    if (nuevoInicio < ocupadoFin && nuevoFin > ocupadoInicio)
                    {
                        colisiona = true;
                        break;
                    }
                }

                if (!colisiona)
                {
                    slotsLibres.Add(cursor.ToString(@"hh\:mm"));
                }
                cursor = cursor.Add(TimeSpan.FromMinutes(30));
            }

            return slotsLibres;
        }

        private void ActualizarGrillaHorarios(DateTime fecha)
        {
            int idProf = int.Parse(ddlProfesional.SelectedValue);
            int duracionServicio = (int)ViewState["DuracionServicio"];

            List<string> slots = CalcularSlotsParaFecha(fecha, idProf, duracionServicio);

            if (slots.Count > 0)
            {
                rptHorarios.DataSource = slots;
                rptHorarios.DataBind();
                msgSinHorarios.Visible = false;
            }
            else
            {
                rptHorarios.DataSource = null;
                rptHorarios.DataBind();
                msgSinHorarios.Visible = true;
            }
        }

        private void PreCalcularDisponibilidadMes(int mes, int anio)
        {
            int idProf = int.Parse(ddlProfesional.SelectedValue);
            if (ViewState["DuracionServicio"] == null) return;
            int duracionServicio = (int)ViewState["DuracionServicio"];

            HashSet<DateTime> fechasConLugar = new HashSet<DateTime>();
            int diasEnMes = DateTime.DaysInMonth(anio, mes);

            for (int dia = 1; dia <= diasEnMes; dia++)
            {
                DateTime fechaIteracion = new DateTime(anio, mes, dia);

                if (fechaIteracion < DateTime.Today) continue;

                List<string> slots = CalcularSlotsParaFecha(fechaIteracion, idProf, duracionServicio);

                if (slots.Count > 0)
                {
                    fechasConLugar.Add(fechaIteracion);
                }
            }
            FechasDisponiblesCache = fechasConLugar;
        }
        

        // Finalizacion y Helpers
        protected void btnContinuarReserva_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(hfIdClienteSeleccionado.Value)) return;

            ReservaTemporal reserva = new ReservaTemporal();
            reserva.IDCliente = int.Parse(hfIdClienteSeleccionado.Value);
            reserva.IDServicio = int.Parse(ddlServicio.SelectedValue);
            reserva.NombreServicio = lblResumenServicio.Text;
            reserva.IDProfesional = int.Parse(ddlProfesional.SelectedValue);
            reserva.NombreProfesional = lblResumenProfesional.Text;
            reserva.Fecha = calFecha.SelectedDate;
            reserva.Hora = TimeSpan.Parse(hfHoraSeleccionada.Value);

            string precioLimpio = lblResumenPrecio.Text.Replace("$", "").Replace(".", "").Trim();
            if (decimal.TryParse(precioLimpio, out decimal p)) reserva.Precio = p;

            Session["ReservaEnCurso"] = reserva;
            Response.Redirect("PagoTurno.aspx");
        }

        private void ReiniciarPasos(int desdePaso)
        {
            if (desdePaso <= 4)
            {
                pnlPaso4_FechaHora.Visible = false;
                calFecha.SelectedDate = DateTime.MinValue;
                rptHorarios.DataSource = null;
                rptHorarios.DataBind();
                lblResumenFecha.Text = "-";
                lblResumenHora.Text = "-";
                hfHoraSeleccionada.Value = "";
                btnContinuarReserva.Enabled = false;
            }

            if (desdePaso <= 3)
            {
                pnlPaso3_Profesional.Visible = false;
                ddlProfesional.Items.Clear();
                lblResumenProfesional.Text = "-";
            }
        }

        private string TraducirDia(DayOfWeek dia)
        {
            switch (dia) { case DayOfWeek.Monday: return "Lunes"; case DayOfWeek.Tuesday: return "Martes"; case DayOfWeek.Wednesday: return "Miércoles"; case DayOfWeek.Thursday: return "Jueves"; case DayOfWeek.Friday: return "Viernes"; case DayOfWeek.Saturday: return "Sábado"; case DayOfWeek.Sunday: return "Domingo"; default: return ""; }
        }
        
    }
}
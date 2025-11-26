<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PanelRecepcionista.aspx.cs" Inherits="CentroEstetica.PanelRecepcionista" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        function validarDevolucion() {
            var ddl = document.getElementById('<%= ddlFormaDevolucion.ClientID %>');
            var txt = document.getElementById('<%= txtComprobanteDevolucion.ClientID %>');

            // Si es Transferencia (valor 2) y está vacío
            if (ddl.value == "2" && txt.value.trim() == "") {
                alert("⚠️ Para devoluciones por Transferencia, el comprobante es OBLIGATORIO.");
                return false;
            }
            return confirm('¿Confirmar la devolución y notificar al cliente?');
        }

        function validarCobro() {
            var ddl = document.getElementById('<%= ddlFormaPagoCobro.ClientID %>');
            var txt = document.getElementById('<%= txtComprobanteCobro.ClientID %>');

            // Si es Transferencia (valor 2) y está vacío
            if (ddl.value == "2" && txt.value.trim() === "") {
                alert("⚠️ Atención: Para cobrar con Transferencia, el número de comprobante es OBLIGATORIO.");
                return false;
            }
            return true;
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <asp:HiddenField ID="hfTabActivo" runat="server" Value="#v-pills-agenda" />
    <asp:HiddenField ID="hfTabAgendaActivo" runat="server" Value="#tab-pendiente" />

    <div class="container mt-3">
        <asp:Panel ID="pnlMensajeExito" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i> 
            <asp:Label ID="lblMensajeExito" runat="server" Text="Operación realizada con éxito."></asp:Label>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </asp:Panel>
        
        <asp:Panel ID="pnlMensajeError" runat="server" Visible="false" CssClass="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> 
            <asp:Label ID="lblMensajeError" runat="server"></asp:Label>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </asp:Panel>
    </div>

    <div class="container-fluid dashboard-container">
        <div class="row">

            <div class="col-lg-3 col-xl-2 mb-4">
                <div class="sticky-top" style="top: 90px; z-index: 1;">
                    <h5 class="text-muted text-uppercase mb-3 ms-2 small fw-bold">Menú Recepción</h5>

                    <div class="nav flex-column nav-pills me-3" id="v-pills-tab-recepcionista" role="tablist" aria-orientation="vertical">
                        <button class="nav-link active" id="v-pills-agenda-tab" data-bs-toggle="pill" data-bs-target="#v-pills-agenda" type="button" role="tab"> Agenda del Día </button>
                        <button class="nav-link" id="v-pills-pendientes-tab" data-bs-toggle="pill" data-bs-target="#v-pills-pendientes" type="button" role="tab"> Pendientes de Confirmación </button>
                        <button class="nav-link" id="v-pills-devoluciones-tab" data-bs-toggle="pill" data-bs-target="#v-pills-devoluciones" type="button" role="tab"> Pendientes de Devolución </button>
                         <asp:HyperLink  ID="lnkHistorial"  runat="server"   NavigateUrl="~/HistorialTurnos.aspx" CssClass="nav-link" ToolTip="Ir a la página de historial de de turnos"> Historial Turnos</asp:HyperLink>
                        <asp:HyperLink  ID="lnkReservarTurnos"  runat="server"   NavigateUrl="~/ReservarTurno.aspx" CssClass="nav-link" ToolTip="Ir a la página de registro de turnos"> Reservar Turnos</asp:HyperLink>
                    </div>
                </div>
            </div>

            <div class="col-lg-9 col-xl-10">
                <div class="content-area tab-content" id="v-pills-tabContent-recepcionista">
                    
                    <div class="tab-pane fade show active" id="v-pills-agenda" role="tabpanel" tabindex="0">
                        
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div>
                                <h2 class="fw-bold mb-1 text-dark"><asp:Label ID="lblBienvenida" runat="server" Text="Gestión Diaria"></asp:Label></h2>
                                <h5 class="text-muted fw-normal"><asp:Label ID="lblNombre" runat="server"></asp:Label></h5>
                            </div>
                            <div class="text-end">
                                <span class="lblfecha border px-3 py-2 fs-6">                                
                                    <asp:Label ID="lblFechaHoy" runat="server"></asp:Label>
                                </span>
                            </div>
                        </div>
                    
                        <ul class="nav nav-tabs mb-3" id="agendaTabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active fw-bold text-dark" id="pendiente-tab" data-bs-toggle="tab" data-bs-target="#tab-pendiente" type="button" role="tab">
                                    <i class="bi bi-cash-coin me-2"></i>Falta Cobrar / En Curso
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link fw-bold text-success" id="listo-tab" data-bs-toggle="tab" data-bs-target="#tab-listo" type="button" role="tab">
                                    <i class="bi bi-check-circle-fill me-2"></i>Pagados Completos
                                </button>
                            </li>
                        </ul>
                    
                        <div class="tab-content" id="agendaTabsContent">
                            
                            <div class="tab-pane fade show active" id="tab-pendiente" role="tabpanel">
                                <div class="card shadow-sm border-0 rounded-4">
                                    <div class="card-body p-4">
                                        <h5 class="mb-3 text-secondary">Turnos con saldo pendiente</h5>
                                        <div class="table-responsive">
                                            <asp:GridView ID="dgvAgendaPendienteCobro" runat="server" DataKeyNames="IDTurno" 
                                                CssClass="table table-hover align-middle mb-0" AutoGenerateColumns="false" 
                                                OnRowCommand="dgvAgendaPendienteCobro_RowCommand" EmptyDataText="No hay turnos pendientes de cobro para hoy.">
                                                <Columns>
                                                    <asp:BoundField HeaderText="Hora" DataField="HoraInicio" />
                                                    <asp:BoundField HeaderText="Paciente" DataField="ClienteNombreCompleto" />
                                                    <asp:BoundField HeaderText="Servicio" DataField="Servicio.Nombre" />
                                                    <asp:BoundField HeaderText="Profesional" DataField="ProfesionalNombreCompleto" />
                                                    
                                                    <asp:TemplateField HeaderText="Total">
                                                        <ItemTemplate>$<%# Eval("Servicio.Precio", "{0:N0}") %></ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Pagado">
                                                        <ItemTemplate>$<%# Eval("MontoPagado", "{0:N0}") %></ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Resta">
                                                        <ItemTemplate>
                                                            <span class="text-danger fw-bold">$<%# Eval("SaldoRestante", "{0:N0}") %></span>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    
                                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Acciones" ItemStyle-Width="380px">
                                                        <ItemTemplate>
                                                            <div class="d-flex justify-content-center gap-2">
                                                                <asp:LinkButton ID="btnVerPagos" runat="server" CommandName="VerPagos" CommandArgument='<%# Eval("IDTurno") %>' 
                                                                    CssClass="btn btn-outline-secondary btn-sm d-flex align-items-center">
                                                                    <i class="bi bi-eye me-1"></i> Ver Pagos
                                                                </asp:LinkButton>
                                                                
                                                                <asp:LinkButton ID="btnCobrar" runat="server" CommandName="CobrarResto" CommandArgument='<%# Eval("IDTurno") %>' 
                                                                    CssClass="btn btn-primary btn-sm fw-bold d-flex align-items-center shadow-sm">
                                                                    <i class="bi bi-currency-dollar me-1"></i> Cobrar
                                                                </asp:LinkButton>
                                                                
                                                                <asp:LinkButton ID="btnCancelar" runat="server" CommandName="CancelarTurno" CommandArgument='<%# Eval("IDTurno") %>' 
                                                                    CssClass="btn btn-outline-danger btn-sm d-flex align-items-center">
                                                                    <i class="bi bi-x-circle me-1"></i> Cancelar
                                                                </asp:LinkButton>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <HeaderStyle CssClass="bg-light text-muted small text-uppercase" />
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    
                            <div class="tab-pane fade" id="tab-listo" role="tabpanel">
                                <div class="card shadow-sm border-0 rounded-4 border-start border-success border-4">
                                    <div class="card-body p-4">
                                        <h5 class="mb-3 text-success">Turnos Pagados (Listos para Finalizar)</h5>
                                        <div class="table-responsive">
                                            <asp:GridView ID="dgvAgendaPagada" runat="server" DataKeyNames="IDTurno" 
                                                CssClass="table table-hover align-middle mb-0" AutoGenerateColumns="false" 
                                                OnRowCommand="dgvAgendaPagada_RowCommand" EmptyDataText="No hay turnos listos para finalizar.">
                                                <Columns>
                                                    <asp:BoundField HeaderText="Hora" DataField="HoraInicio" />
                                                    <asp:BoundField HeaderText="Paciente" DataField="ClienteNombreCompleto" />
                                                    <asp:BoundField HeaderText="Servicio" DataField="Servicio.Nombre" />
                                                    <asp:BoundField HeaderText="Profesional" DataField="ProfesionalNombreCompleto" />
                                                    <asp:TemplateField HeaderText="Estado Pago">
                                                        <ItemTemplate><span class="badge bg-success">Completo</span></ItemTemplate>
                                                    </asp:TemplateField>
                                                    
                                                    <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderText="Acciones">
                                                        <ItemTemplate>
                                                            <div class="d-flex justify-content-center gap-2">
                                                                <asp:LinkButton ID="btnVerPagos" runat="server" CommandName="VerPagos" CommandArgument='<%# Eval("IDTurno") %>' 
                                                                    CssClass="btn btn-outline-secondary btn-sm"> <i class="bi bi-eye"></i> Ver Pagos </asp:LinkButton>
                                                    
                                                                <asp:LinkButton ID="btnFinalizar" runat="server" CommandName="FinalizarTurno" CommandArgument='<%# Eval("IDTurno") %>' 
                                                                    CssClass="btn btn-success btn-sm fw-bold"
                                                                    OnClientClick="return confirm('¿Confirmar que el servicio fue realizado y finalizar el turno?');"> 
                                                                    <i class="bi bi-check-lg"></i> Finalizar 
                                                                </asp:LinkButton>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <HeaderStyle CssClass="bg-light text-muted small text-uppercase" />
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    
                        </div>
                    </div>
                    
                    <div class="tab-pane fade" id="v-pills-pendientes" role="tabpanel">
                        <h3 class="mb-4 fw-bold text-warning-emphasis">Turnos Pendientes de Confirmación</h3>
                        
                        <asp:GridView ID="dgvPendientesConfirmacion" runat="server" DataKeyNames="IDTurno" 
                            CssClass="table table-hover align-middle mb-0" AutoGenerateColumns="false"
                            OnRowCommand="dgvPendientesConfirmacion_RowCommand" EmptyDataText="No hay turnos pendientes.">
                            <Columns>
                                <asp:BoundField HeaderText="Fecha" DataField="FechaString" />
                                <asp:BoundField HeaderText="Hora" DataField="HoraInicio" />
                                <asp:TemplateField HeaderText="Cliente">
                                    <ItemTemplate>
                                        <%# Eval("Cliente.Nombre") + " " + Eval("Cliente.Apellido") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Servicio" DataField="Servicio.Nombre" />
                                
                                <asp:TemplateField HeaderText="Comprobante">
                                    <ItemTemplate>
                                        <span class="fw-bold text-dark">
                                            <%# GetComprobante(Eval("Pago")) %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Acción">
                                    <ItemTemplate>
                                        <div class="d-flex gap-2">
                                            <asp:Button ID="btnConfirmar" runat="server" Text="✅ Aprobar" 
                                                CommandName="ConfirmarTurno" CommandArgument='<%# Eval("IDTurno") %>'
                                                CssClass="btn btn-success btn-sm fw-bold" 
                                                OnClientClick="return confirm('¿El dinero se acreditó correctamente?');"/>
                                            
                                            <asp:Button ID="btnRechazar" runat="server" Text="❌ Rechazar" 
                                                CommandName="RechazarTurno" CommandArgument='<%# Eval("IDTurno") %>'
                                                CssClass="btn btn-danger btn-sm fw-bold" 
                                                OnClientClick="return confirm('¿Rechazar el comprobante y cancelar el turno? Se notificará al cliente.');"/>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="bg-light text-muted small text-uppercase" />
                        </asp:GridView>
                    </div>

                    <div class="tab-pane fade" id="v-pills-devoluciones" role="tabpanel">
                        <h3 class="mb-4 fw-bold text-danger">Solicitudes de Devolución</h3>
                        
                        <asp:GridView ID="dgvDevoluciones" runat="server" DataKeyNames="IDTurno" 
                            CssClass="table table-hover align-middle mb-0" AutoGenerateColumns="false" 
                            OnRowCommand="dgvDevoluciones_RowCommand" EmptyDataText="No hay devoluciones pendientes.">
                            <Columns>
                                <asp:BoundField HeaderText="Fecha Turno" DataField="FechaString" />
                                
                                <asp:TemplateField HeaderText="Cliente">
                                    <ItemTemplate>
                                        <%# Eval("Cliente.Nombre") + " " + Eval("Cliente.Apellido") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Contacto">
                                    <ItemTemplate>
                                        <div class="d-flex flex-column small">
                                            <span><i class="bi bi-whatsapp text-success me-1"></i><%# Eval("Cliente.Telefono") %></span>
                                            <span><i class="bi bi-envelope text-primary me-1"></i><%# Eval("Cliente.Mail") %></span>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:BoundField HeaderText="Servicio" DataField="Servicio.Nombre" />
                                
                                <asp:TemplateField HeaderText="Monto a Devolver">
                                    <ItemTemplate>
                                        <span class="fw-bold text-danger">$<%# Eval("Pago[0].Monto", "{0:N0}") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Acción" ItemStyle-Width="120px">
                                    <ItemTemplate>
                                        <asp:Button ID="btnProcesarDevolucion" runat="server" Text="💸 Procesar" 
                                            CommandName="AbrirModalDevolucion" CommandArgument='<%# Eval("IDTurno") %>'
                                            CssClass="btn btn-outline-danger btn-sm fw-bold w-100"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="bg-light text-muted small text-uppercase" />
                        </asp:GridView>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="pagoModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg"> 
            <div class="modal-content">
                <div class="modal-header" style="background-color: var(--colorPrincipalHover); color: white;">
                    <h5 class="modal-title">Detalle de Pagos del Turno</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body p-4">
                    <h6 class="fw-bold mb-3">Turno para: <asp:Literal ID="litNombreTurno" runat="server"></asp:Literal></h6> 
                    <div class="table-responsive">
                        <asp:GridView ID="dgvPagos" runat="server" AutoGenerateColumns="false" CssClass="table table-hover align-middle mb-0" ShowHeaderWhenEmpty="true">
                            <Columns>                                
                                <asp:TemplateField HeaderText="Tipo de Transacción" ItemStyle-Width="150px">
                                    <ItemTemplate>
                                        <span class='badge fw-bold <%# (bool)Eval("EsDevolucion") ? "bg-danger" : "bg-success" %>'>
                                            <%# (bool)Eval("EsDevolucion") ? "Devolución" : "Pago" %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Monto" DataField="Monto"  DataFormatString="{0:C}" ItemStyle-CssClass="fw-bold" />                                
                                <asp:BoundField HeaderText="Forma de Pago" DataField="FormaDePago.Descripcion" />
                                <asp:BoundField HeaderText="Fecha" DataField="Fecha" DataFormatString="{0:dd/MM/yyyy}" />
                                <asp:BoundField HeaderText="Concepto" DataField="Tipo.Descripcion" />
                            </Columns>
                             <HeaderStyle CssClass="bg-light text-muted small text-uppercase" />                
                        </asp:GridView>
                    </div>
                </div>            
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="cobrarModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">Cobrar Saldo Restante</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hfIdTurnoCobrar" runat="server" />
                    
                    <div class="alert alert-info">
                        <div class="d-flex justify-content-between">
                            <span>Total Servicio:</span>
                            <asp:Label ID="lblTotalServicio" runat="server" Font-Bold="true"></asp:Label>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span>Ya abonado:</span>
                            <asp:Label ID="lblYaAbonado" runat="server" Font-Bold="true"></asp:Label>
                        </div>
                        <hr />
                        <div class="d-flex justify-content-between fs-5">
                            <span>Restan Pagar:</span>
                            <asp:Label ID="lblRestaPagar" runat="server" CssClass="fw-bold text-danger"></asp:Label>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Forma de Pago</label>
                        <asp:DropDownList ID="ddlFormaPagoCobro" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Efectivo" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Transferencia Bancaria" Value="2"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Comprobante / Transacción</label>
                        <asp:TextBox ID="txtComprobanteCobro" runat="server" CssClass="form-control" placeholder="Obligatorio si elige Transferencia"></asp:TextBox>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <asp:Button ID="btnConfirmarCobro" runat="server" Text="Confirmar Cobro" 
                        CssClass="btn btn-primary fw-bold" OnClick="btnConfirmarCobro_Click" OnClientClick="return validarCobro();" />
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="cancelarModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title">Cancelar Turno</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hfIdTurnoCancelar" runat="server" />
                    <p>Seleccione el motivo de la cancelación. Esto definirá si el dinero debe devolverse o no.</p>
                    
                    <div class="form-check mb-2">
                        <input class="form-check-input" type="radio" name="motivoCancelacion" id="rbAusenciaCliente" value="cliente" runat="server" checked>
                        <label class="form-check-label fw-bold" for="rbAusenciaCliente">
                            Ausencia del Cliente / Cancelación tardía
                        </label>
                        <div class="form-text text-muted small ms-2">
                            El turno pasa a "Cancelado". El dinero NO se devuelve (seña perdida).
                        </div>
                    </div>
                    
                    <div class="form-check mt-3">
                        <input class="form-check-input" type="radio" name="motivoCancelacion" id="rbAusenciaProfesional" value="profesional" runat="server">
                        <label class="form-check-label fw-bold" for="rbAusenciaProfesional">
                            Ausencia del Profesional / Problema del Centro
                        </label>
                        <div class="form-text text-muted small ms-2">
                            El turno pasa a "Solicitud de Devolución". El monto pagado aparecerá en la pestaña de devoluciones.
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Atrás</button>
                    <asp:Button ID="btnConfirmarCancelacion" runat="server" Text="Procesar Cancelación" 
                        CssClass="btn btn-danger fw-bold" OnClick="btnConfirmarCancelacion_Click" />
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="devolucionModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title">Registrar Devolución</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body p-4">
                    <asp:HiddenField ID="hfIdTurnoDevolucion" runat="server" />
                    <asp:HiddenField ID="hfIdClienteDevolucion" runat="server" />
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">Monto a Devolver</label>
                        <asp:TextBox ID="txtMontoDevolucion" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Medio de Devolución</label>
                        <asp:DropDownList ID="ddlFormaDevolucion" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Transferencia Bancaria" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Efectivo" Value="1"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">N° Comprobante / Transacción</label>
                        <asp:TextBox ID="txtComprobanteDevolucion" runat="server" CssClass="form-control" placeholder="Obligatorio si es transferencia"></asp:TextBox>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <asp:Button ID="btnConfirmarDevolucion" runat="server" Text="Confirmar Devolución" 
                        CssClass="btn btn-danger fw-bold" OnClick="btnConfirmarDevolucion_Click" OnClientClick="return validarDevolucion();" />
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            
            var hfSidebar = document.getElementById('<%= hfTabActivo.ClientID %>');
            if (hfSidebar && hfSidebar.value) {
                var tabSidebar = document.querySelector('button[data-bs-target="' + hfSidebar.value + '"]');
                if (tabSidebar) {
                    new bootstrap.Tab(tabSidebar).show();
                }
            }

            var sidebarBtns = document.querySelectorAll('#v-pills-tab-recepcionista button[data-bs-toggle="pill"]');
            sidebarBtns.forEach(function (btn) {
                btn.addEventListener('shown.bs.tab', function (event) {
                    hfSidebar.value = event.target.getAttribute('data-bs-target');
                });
            });

            var hfAgenda = document.getElementById('<%= hfTabAgendaActivo.ClientID %>');
            if (hfAgenda && hfAgenda.value) {
                var tabAgenda = document.querySelector('#agendaTabs button[data-bs-target="' + hfAgenda.value + '"]');
                if (tabAgenda) {
                    new bootstrap.Tab(tabAgenda).show();
                }
            }

            
            var agendaBtns = document.querySelectorAll('#agendaTabs button[data-bs-toggle="tab"]');
            agendaBtns.forEach(function (btn) {
                btn.addEventListener('shown.bs.tab', function (event) {
                    hfAgenda.value = event.target.getAttribute('data-bs-target');
                });
            });
        });
    </script>

</asp:Content>
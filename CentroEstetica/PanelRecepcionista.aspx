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
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hfTabActivo" runat="server" Value="#v-pills-agenda" />

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
                        <button class="nav-link" id="v-pills-historial-tab" data-bs-toggle="pill" data-bs-target="#v-pills-agenda" type="button" role="tab"> Historial de Turnos </button>
                        <asp:HyperLink  ID="lnkReservarTurnos"  runat="server"   NavigateUrl="~/ReservarTurno.aspx" CssClass="nav-link" ToolTip="Ir a la página de registro de turnos"> Reservar Turnos</asp:HyperLink>
                    </div>
                </div>
            </div>

            <div class="col-lg-9 col-xl-10">
                <div class="content-area tab-content" id="v-pills-tabContent-recepcionista">
                    
                    <div class="tab-pane fade show active" id="v-pills-agenda" role="tabpanel" tabindex="0">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div>
                                <h2 class="fw-bold mb-1 text-dark">
                                    <asp:Label ID="lblBienvenida" runat="server" Text="¡Bienvenido/a!"></asp:Label></h2>
                                <h5 class="text-muted fw-normal">
                                    <asp:Label ID="lblNombre" runat="server" Text="[Nombre Recepcionista]"></asp:Label></h5>
                            </div>
                            <div class="text-end">
                                <span class="lblfecha border px-3 py-2 fs-6">                                
                                    <asp:Label ID="lblFechaHoy" runat="server"></asp:Label>
                                </span>
                            </div>
                        </div>
                        <div class="card shadow-sm border-0 rounded-4">
                            <div class="card-header bg-custom-accent text-white pt-4 px-4 rounded-top-4">
                                <h5 class="mb-0 fw-bold"><i class="bi bi-list-task me-2"></i>Turnos Programados para Hoy</h5>
                            </div>
                            <div class="card-body p-4">
                                <div class="table-responsive">
                                    <asp:GridView ID="dgvTurnos" runat="server" DataKeyNames="IDTurno" CssClass="table table-hover align-middle mb-0"
                                        AutoGenerateColumns="false" AllowPaging="True" PageSize="10" OnRowCommand="dgvTurnos_RowCommand" OnPageIndexChanging="dgvTurnos_PageIndexChanging">
                                        <Columns>
                                            <asp:BoundField HeaderText="Hora" DataField="HoraInicio" />
                                            <asp:BoundField HeaderText="Paciente" DataField="ClienteNombreCompleto" />
                                            <asp:BoundField HeaderText="Servicio" DataField="Servicio.Nombre" />
                                            <asp:BoundField HeaderText="Profesional" DataField="ProfesionalNombreCompleto" />
                                            <asp:BoundField HeaderText="Estado" DataField="Estado.Descripcion" />
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <div class="btn-group btn-group-sm">
                                                        <asp:LinkButton ID="btnVerPagos" runat="server" CommandName="VerPagos" CommandArgument='<%# Eval("IDTurno") %>'
                                                            ToolTip="Ver Pagos" CssClass="btn-custom btn-sm me-2"> Pagos </asp:LinkButton>
                                                        <asp:LinkButton ID="btnModificar" runat="server" CommandName="Modificar" CommandArgument='<%# Eval("IDTurno") %>'
                                                            ToolTip="Modificar" CssClass="btn-custom btn-sm"> Modificar </asp:LinkButton>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle CssClass="bg-light text-muted small text-uppercase" />
                                        <PagerStyle CssClass="p-2 border-top bg-light" HorizontalAlign="Center" />
                                    </asp:GridView>
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
                                <asp:BoundField HeaderText="Cliente" DataField="ClienteNombreCompleto" />
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
                                <asp:BoundField HeaderText="Cliente" DataField="ClienteNombreCompleto" />
                                <asp:BoundField HeaderText="Servicio" DataField="Servicio.Nombre" />
                                <asp:TemplateField HeaderText="Monto a Devolver">
                                    <ItemTemplate>
                                        <span class="fw-bold text-danger">$<%# Eval("Pago[0].Monto", "{0:N0}") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Acción">
                                    <ItemTemplate>
                                        <asp:Button ID="btnProcesarDevolucion" runat="server" Text="💸 Procesar" 
                                            CommandName="AbrirModalDevolucion" CommandArgument='<%# Eval("IDTurno") %>'
                                            CssClass="btn btn-outline-danger btn-sm fw-bold"/>
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
            var hiddenField = document.getElementById('<%= hfTabActivo.ClientID %>');
            if (hiddenField && hiddenField.value) {
                var tabToActivate = document.querySelector('button[data-bs-target="' + hiddenField.value + '"]');
                if (tabToActivate) {
                    var tab = new bootstrap.Tab(tabToActivate);
                    tab.show();
                }
            }
            var tabButtons = document.querySelectorAll('button[data-bs-toggle="pill"]');
            tabButtons.forEach(function (btn) {
                btn.addEventListener('shown.bs.tab', function (event) {
                    hiddenField.value = event.target.getAttribute('data-bs-target');
                });
            });
        });
    </script>

</asp:Content>
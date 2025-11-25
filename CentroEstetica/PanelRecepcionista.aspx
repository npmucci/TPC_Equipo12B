<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PanelRecepcionista.aspx.cs" Inherits="CentroEstetica.PanelRecepcionista" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hfTabActivo" runat="server" Value="#v-pills-agenda" />

    <div class="container mt-3">
        <asp:Panel ID="pnlMensajeExito" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i> 
            <strong>¡Listo!</strong> La reserva se ha registrado y confirmado correctamente.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </asp:Panel>
    </div>
    <div class="container-fluid dashboard-container">
        <div class="row">

            <div class="col-lg-3 col-xl-2 mb-4">
                <div class="sticky-top" style="top: 90px; z-index: 1;">
                    <h5 class="text-muted text-uppercase mb-3 ms-2 small fw-bold">Menú Recepción</h5>

                    <div class="nav flex-column nav-pills me-3" id="v-pills-tab-recepcionista" role="tablist" aria-orientation="vertical">
                        <button class="nav-link active" id="v-pills-agenda-tab" data-bs-toggle="pill" data-bs-target="#v-pills-agenda" type="button" role="tab" aria-controls="v-pills-agenda" aria-selected="true"> Agenda del Día </button>
                        <button class="nav-link" id="v-pills-pendientes-tab" data-bs-toggle="pill" data-bs-target="#v-pills-agenda" type="button" role="tab" aria-controls="v-pills-agenda" aria-selected="true"> Pendientes de Confirmación </button>
                        <button class="nav-link" id="v-pills-historial-tab" data-bs-toggle="pill" data-bs-target="#v-pills-agenda" type="button" role="tab" aria-controls="v-pills-agenda" aria-selected="true"> Historial de Turnos  </button>
                        <asp:HyperLink  ID="lnkReservarTurnos"  runat="server"   NavigateUrl="~/ReservarTurno.aspx" CssClass="nav-link" ToolTip="Ir a la página de registro de turnos"> Reservar Turnos</asp:HyperLink>
                    </div>
                </div>
            </div>

            <div class="col-lg-9 col-xl-10">
                <div class="content-area tab-content" id="v-pills-tabContent-recepcionista">
                    <div class="tab-pane fade show active" id="v-pills-agenda" role="tabpanel" aria-labelledby="v-pills-agenda-tab" tabindex="0">
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
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="">
                                                <ItemTemplate>
                                                    <div class="btn-group btn-group-sm" role="group">
                                                        <asp:LinkButton ID="btnVerPagos" runat="server" CommandName="VerPagos" CommandArgument='<%# Eval("IDTurno") %>'
                                                            ToolTip="Ver Pagos del turno" CssClass="btn-custom btn-sm me-3">  Pagos
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnModificar" runat="server" CommandName="Modificar" CommandArgument='<%# Eval("IDTurno") %>'
                                                            ToolTip="Modificar Turno" CssClass="btn-custom btn-sm"> Modificar
                                                        </asp:LinkButton>
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
                </div>
            </div>
        </div>
    </div>
 <div class="modal fade" id="pagoModal" tabindex="-1" aria-labelledby="pagoModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg"> <div class="modal-content">

            <div class="modal-header" style="background-color: var(--colorPrincipalHover); color: white;">
                <h5 class="modal-title" id="pagoModalLabel">Detalle de Pagos del Turno</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>

            <div class="modal-body p-4">
                
                <h6 class="fw-bold mb-3">Turno para: <asp:Literal ID="litNombreTurno" runat="server"></asp:Literal></h6> 

                <div class="table-responsive">
                    <asp:GridView ID="dgvPagos" runat="server" AutoGenerateColumns="false"   CssClass="table table-hover align-middle mb-0" ShowHeaderWhenEmpty="true">
                        <Columns>                            
                            <asp:TemplateField HeaderText="Tipo de Transacción" ItemStyle-Width="150px">
                                <ItemTemplate>
                                    <span class='badge fw-bold 
                                        <%# (bool)Eval("EsDevolucion") ? "bg-danger" : "bg-success" %>'>
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

</asp:Content>

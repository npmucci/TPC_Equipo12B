<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PanelCliente.aspx.cs" Inherits="CentroEstetica.PanelCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid py-5 px-4">
        
        <asp:Panel ID="pnlMensajeExito" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show shadow-sm mb-4" role="alert">
            <div class="d-flex align-items-center">
                <i class="bi bi-check-circle-fill fs-4 me-3"></i>
                <div>
                    <strong>¡Reserva exitosa!</strong><br />
                    Tu turno quedó registrado como <b>Pendiente</b>. Esperá la confirmación del centro. Gracias!
                </div>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </asp:Panel>

        <div class="row">
            
            <div class="col-lg-3 col-xl-2 mb-4">
                <div class="card border-0 shadow-sm rounded-4 sticky-top" style="top: 100px; z-index: 1;">
                    <div class="card-body p-3">
                        <h5 class="text-muted text-uppercase mb-3 ms-2 small fw-bold">Mis Turnos</h5>
                        
                        <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                            
                            <button class="nav-link active d-flex justify-content-between align-items-center mb-2" id="v-pills-pendientes-tab" data-bs-toggle="pill" data-bs-target="#v-pills-pendientes" type="button" role="tab">
                                <span><i class="bi bi-hourglass-split me-2"></i> Pendientes</span>
                            </button>

                            <button class="nav-link d-flex justify-content-between align-items-center mb-2" id="v-pills-confirmados-tab" data-bs-toggle="pill" data-bs-target="#v-pills-confirmados" type="button" role="tab">
                                <span><i class="bi bi-calendar-check me-2"></i> Confirmados</span>
                            </button>

                            <button class="nav-link d-flex justify-content-between align-items-center mb-2" id="v-pills-pasados-tab" data-bs-toggle="pill" data-bs-target="#v-pills-pasados" type="button" role="tab">
                                <span><i class="bi bi-clock-history me-2"></i> Historial</span>
                            </button>

                            <hr class="text-muted my-2" />

                            <a class="nav-link text-secondary" href="PanelPerfil.aspx">
                                <i class="bi bi-person-gear me-2"></i> Mis Datos
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-9 col-xl-10">
                <div class="tab-content" id="v-pills-tabContent">

                    <div class="tab-pane fade show active" id="v-pills-pendientes" role="tabpanel">
                        
                        <h4 class="fw-bold mb-4 text-dark"><i class="bi bi-hourglass-split"></i> Turnos Pendientes de Confirmación</h4>
                        
                        <asp:Panel ID="pnlSinPendientes" runat="server" Visible="false" CssClass="alert alert-light border text-center py-5">
                            <i class="bi bi-calendar2-check fs-1 text-muted mb-3 d-block"></i>
                            No tenés turnos pendientes en este momento.
                        </asp:Panel>

                        <asp:Repeater ID="rptPendientes" runat="server" OnItemCommand="btnCancelar_Command">
                            <ItemTemplate>
                                <div class="card shadow-sm border-0 mb-3 border-start border-4 border-info">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                                            <div>
                                                <h5 class="card-title fw-bold mb-1"><%# Eval("Servicio.Nombre") %></h5>
                                                <p class="card-text mb-1 text-muted">
                                                    <i class="bi bi-person me-1"></i> <%# Eval("ProfesionalNombreCompleto") %>
                                                </p>
                                                <p class="card-text mb-0 fw-bold text-dark">
                                                    <i class="bi bi-calendar-event me-1"></i> <%# Eval("FechaString") %> - <%# Eval("HoraInicio", "{0:hh\\:mm}") %> hs
                                                </p>
                                            </div>
                                            <div class="text-end">
                                                <span class="badge bg-info text-white mb-2 d-block">Solicitud Pendiente</span>
                                                
                                                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar Solicitud" 
                                                    CssClass="btn btn-outline-secondary btn-sm" 
                                                    CommandName="Cancelar" CommandArgument='<%# Eval("IDTurno") %>'
                                                    OnClientClick="return confirm('¿Seguro que querés cancelar esta solicitud?');" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <div class="tab-pane fade" id="v-pills-confirmados" role="tabpanel">
                        <h4 class="fw-bold mb-4 text-success"><i class="bi bi-check-circle"></i> Turnos Confirmados</h4>

                        <asp:Panel ID="pnlSinConfirmados" runat="server" Visible="false" CssClass="alert alert-light border text-center py-5">
                            <i class="bi bi-calendar-x fs-1 text-muted mb-3 d-block"></i>
                            No tenés turnos confirmados próximos.
                        </asp:Panel>

                        <asp:Repeater ID="rptConfirmados" runat="server" OnItemCommand="btnCancelar_Command">
                            <ItemTemplate>
                                <div class="card shadow-sm border-0 mb-3 border-start border-4 border-success">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                                            <div>
                                                <h5 class="card-title fw-bold mb-1 text-success"><%# Eval("Servicio.Nombre") %></h5>
                                                <p class="card-text mb-1 text-muted">
                                                    <i class="bi bi-person-badge me-1"></i> <%# Eval("ProfesionalNombreCompleto") %>
                                                </p>
                                                <p class="card-text mb-0 fw-bold fs-5">
                                                    <i class="bi bi-clock me-1"></i> <%# Eval("FechaString") %> - <%# Eval("HoraInicio", "{0:hh\\:mm}") %> hs
                                                </p>
                                            </div>
                                            <div class="text-end">
                                                <span class="badge bg-success mb-2 d-block">Confirmado</span>
                                                <asp:Button ID="btnCancelarConf" runat="server" Text="Cancelar Turno" 
                                                    CssClass="btn btn-danger btn-sm" 
                                                    CommandName="Cancelar" CommandArgument='<%# Eval("IDTurno") %>'
                                                    OnClientClick="return confirm('ATENCIÓN: Estás cancelando un turno confirmado. ¿Continuar?');" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <div class="tab-pane fade" id="v-pills-pasados" role="tabpanel">
                        <h4 class="fw-bold mb-4 text-secondary"><i class="bi bi-archive"></i> Historial de Turnos</h4>

                        <asp:Repeater ID="rptPasados" runat="server">
                            <ItemTemplate>
                                <div class="card border-0 bg-light mb-2 opacity-75">
                                    <div class="card-body py-3">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <h6 class="fw-bold mb-0 text-secondary"><%# Eval("Servicio.Nombre") %></h6>
                                                <small class="text-muted"><%# Eval("FechaString") %> - <%# Eval("HoraInicio", "{0:hh\\:mm}") %> hs</small>
                                            </div>
                                            <span class='badge rounded-pill <%# (string)Eval("Estado.Descripcion") == "Cancelado" ? "bg-danger" : "bg-secondary" %>'>
                                                <%# Eval("Estado.Descripcion") %>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                        
                        <% if (rptPasados.Items.Count == 0) { %>
                            <div class="text-muted fst-italic mt-3">No hay historial disponible.</div>
                        <% } %>
                    </div>

                </div>
            </div>
        </div>
    </div>

</asp:Content>
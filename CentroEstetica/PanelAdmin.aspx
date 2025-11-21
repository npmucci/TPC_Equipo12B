<%@ Page Title="Administración" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PanelAdmin.aspx.cs" Inherits="CentroEstetica.PanelAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <!-- Campo oculto para mantener la pestaña activa tras PostBack -->
    <asp:HiddenField ID="hfTabActivo" runat="server" Value="#v-pills-dashboard" />

    <div class="container-fluid dashboard-container">
        <div class="row">
            
            <!-- COLUMNA IZQUIERDA: MENÚ LATERAL -->
            <div class="col-lg-3 col-xl-2 mb-4">
                <div class="sticky-top" style="top: 90px; z-index: 1;">
                    <h5 class="text-muted text-uppercase mb-3 ms-2 small fw-bold">Menú Principal</h5>
                    
                    <div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                        <button class="nav-link active" id="v-pills-dashboard-tab" data-bs-toggle="pill" data-bs-target="#v-pills-dashboard" type="button" role="tab">
                            <i class="bi bi-speedometer2"></i> Resumen
                        </button>
                        
                        
                        <button class="nav-link" id="btnTabAgenda" runat="server" visible="false" data-bs-toggle="pill" data-bs-target="#v-pills-agenda" type="button" role="tab">
                            <i class="bi bi-calendar-heart"></i> Mi Agenda
                        </button>

                        <button class="nav-link" id="v-pills-profesionales-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profesionales" type="button" role="tab">
                            <i class="bi bi-people"></i> Profesionales
                        </button>

                        <button class="nav-link" id="v-pills-clientes-tab" data-bs-toggle="pill" data-bs-target="#v-pills-clientes" type="button" role="tab">
                            <i class="bi bi-person-hearts"></i> Clientes
                        </button>

                        <button class="nav-link" id="v-pills-recepcionistas-tab" data-bs-toggle="pill" data-bs-target="#v-pills-recepcionistas" type="button" role="tab">
                            <i class="bi bi-headset"></i> Recepción
                        </button>

                        <button class="nav-link" id="v-pills-servicios-tab" data-bs-toggle="pill" data-bs-target="#v-pills-servicios" type="button" role="tab">
                            <i class="bi bi-grid"></i> Catálogo
                        </button>
                        <button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab">
                            <i class="bi bi-gear"></i> Configuración
                        </button>
                    </div>
                </div>
            </div>

            <!-- COLUMNA DERECHA: ÁREA DE CONTENIDO -->
            <div class="col-lg-9 col-xl-10">
                
                <!-- Mensajes de Alerta -->
                <asp:Panel ID="pnlMensajes" runat="server" Visible="false" CssClass="alert alert-warning alert-dismissible fade show mb-4 shadow-sm" role="alert">
                    <i class="bi bi-info-circle-fill me-2"></i>
                    <asp:Literal ID="litMensaje" runat="server"></asp:Literal>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </asp:Panel>

                <div class="content-area tab-content" id="v-pills-tabContent">
                    
                    <!-- 1. DASHBOARD (HOME) -->
                    <div class="tab-pane fade show active" id="v-pills-dashboard" role="tabpanel">
                        <h3 class="fw-bold mb-4">Panel de Control</h3>
                        
                        <!-- KPI Cards -->
                        <div class="row g-4 mb-5">
                            <div class="col-md-4">
                                <div class="kpi-card bg-gradient-primary">
                                    <h5>Profesionales Activos</h5>
                                    <h2><asp:Literal ID="litCantProfesionales" runat="server" Text="--"></asp:Literal></h2>
                                    <i class="bi bi-person-badge"></i>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="kpi-card bg-gradient-success">
                                    <h5>Turnos Pendientes</h5>
                                    <h2><asp:Literal ID="litCantTurnos" runat="server" Text="0"></asp:Literal></h2>
                                    <i class="bi bi-calendar-check"></i>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="kpi-card bg-gradient-info">
                                    <h5>Servicios Activos</h5>
                                    <h2><asp:Literal ID="litCantServicios" runat="server" Text="--"></asp:Literal></h2>
                                    <i class="bi bi-stars"></i>
                                </div>
                            </div>
                        </div>

                        <!-- Accesos Rápidos -->
                        <h5 class="text-muted mb-3">Accesos Directos</h5>
                        <div class="row g-3">
                            
                            <!-- Acceso Agenda (Solo visible si es ProfesionalUnico) -->
                            <asp:PlaceHolder ID="phAccesoAgenda" runat="server" Visible="false">
                                <div class="col-md-4">
                                    <div class="p-4 border rounded-3 bg-light d-flex align-items-center cursor-pointer border-primary" style="cursor:pointer;" onclick="document.getElementById('<%= btnTabAgenda.ClientID %>').click()">
                                        <div class="bg-white p-3 rounded-circle shadow-sm me-3 text-primary"><i class="bi bi-calendar-heart fs-4"></i></div>
                                        <div>
                                            <h6 class="fw-bold mb-1">Mi Agenda</h6>
                                            <small class="text-muted">Gestionar mis turnos</small>
                                        </div>
                                    </div>
                                </div>
                            </asp:PlaceHolder>

                            <div class="col-md-4">
                                <div class="p-4 border rounded-3 bg-light d-flex align-items-center" style="cursor:pointer;" onclick="document.getElementById('v-pills-profesionales-tab').click()">
                                    <div class="bg-white p-3 rounded-circle shadow-sm me-3 text-secondary"><i class="bi bi-person-plus fs-4"></i></div>
                                    <div>
                                        <h6 class="fw-bold mb-1">Gestionar Equipo</h6>
                                        <small class="text-muted">Altas y bajas de profesionales</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="p-4 border rounded-3 bg-light d-flex align-items-center" style="cursor:pointer;" onclick="document.getElementById('v-pills-servicios-tab').click()">
                                    <div class="bg-white p-3 rounded-circle shadow-sm me-3 text-success"><i class="bi bi-bag-plus fs-4"></i></div>
                                    <div>
                                        <h6 class="fw-bold mb-1">Catálogo</h6>
                                        <small class="text-muted">Administrar servicios</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 2. MI AGENDA  -->
                    <div class="tab-pane fade" id="v-pills-agenda" role="tabpanel">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div>
                                <h2 class="fw-bold mb-1 text-dark">Mi Agenda</h2>
                                <h5 class="text-muted fw-normal"><asp:Label ID="lblNombre" runat="server"></asp:Label></h5>
                            </div>
                            <div class="text-end">
                                <span class="badge bg-light text-secondary border px-3 py-2 fs-6">
                                    <i class="bi bi-calendar-day me-2"></i><asp:Label ID="lblFechaHoy" runat="server"></asp:Label>
                                </span>
                            </div>
                        </div>

                        <!-- ESTADÍSTICAS AGENDA -->
                        <div class="row mb-5">
                            <div class="col-md-4 mb-3">
                                <div class="stat-card border-left-primary h-100">
                                    <div class="d-flex align-items-center justify-content-between">
                                        <div>
                                            <p class="stat-label text-primary">Turnos Hoy</p>
                                            <div class="stat-value"><asp:Label ID="lblTurnosHoy" runat="server" Text="0"></asp:Label></div>
                                        </div>
                                        <i class="bi bi-calendar-check fs-1 text-gray-300 opacity-25"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="stat-card border-left-success h-100">
                                    <div class="d-flex align-items-center justify-content-between">
                                        <div>
                                            <p class="stat-label text-success">Próximos 7 Días</p>
                                            <div class="stat-value"><asp:Label ID="lblTurnosProximos" runat="server" Text="0"></asp:Label></div>
                                        </div>
                                        <i class="bi bi-graph-up-arrow fs-1 text-gray-300 opacity-25"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="stat-card border-left-info h-100">
                                    <div class="d-flex align-items-center justify-content-between">
                                        <div>
                                            <p class="stat-label text-info">Ingresos del Mes</p>
                                            <div class="stat-value text-success">$<asp:Label ID="lblIngresosMes" runat="server" Text="0"></asp:Label></div>
                                        </div>
                                        <i class="bi bi-currency-dollar fs-1 text-gray-300 opacity-25"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- CONTENEDOR DE TURNOS AGENDA -->
                        <div class="card shadow-sm border-0 rounded-4">
                            <div class="card-header bg-white border-0 pt-4 px-4">
                                <ul class="nav nav-tabs card-header-tabs" id="tabTurnos">
                                    <li class="nav-item">
                                        <asp:LinkButton ID="lnkHoy" runat="server" CssClass="nav-link active" OnClick="lnkAgenda_Click">
                                            <i class="bi bi-clock me-2"></i>Hoy
                                        </asp:LinkButton>
                                    </li>
                                    <li class="nav-item">
                                        <asp:LinkButton ID="lnkProximos" runat="server" CssClass="nav-link" OnClick="lnkAgenda_Click">
                                            <i class="bi bi-calendar-week me-2"></i>Próximos
                                        </asp:LinkButton>
                                    </li>
                                    <li class="nav-item">
                                        <asp:LinkButton ID="lnkPasados" runat="server" CssClass="nav-link" OnClick="lnkAgenda_Click">
                                            <i class="bi bi-archive me-2"></i>Pasados
                                        </asp:LinkButton>
                                    </li>
                                </ul>
                            </div>
                            
                            <div class="card-body p-4">
                                <asp:MultiView ID="mvTurnos" runat="server" ActiveViewIndex="0">

                                    <asp:View ID="viewHoy" runat="server">
                                        <h5 class="mb-3 fw-bold text-secondary">Turnos del Día</h5>
                                        <div class="alert alert-light border text-center py-5">
                                            <i class="bi bi-inbox fs-1 text-muted d-block mb-2"></i>
                                            <p class="mb-0 text-muted">Aquí se mostrará el listado de turnos del día.</p>
                                        </div>
                                    </asp:View>

                                    <asp:View ID="viewProximos" runat="server">
                                        <h5 class="mb-3 fw-bold text-secondary">Próximos Turnos</h5>
                                        <div class="alert alert-light border text-center py-5">
                                            <i class="bi bi-calendar3 fs-1 text-muted d-block mb-2"></i>
                                            <p class="mb-0 text-muted">Aquí se mostrará el listado de turnos futuros.</p>
                                        </div>
                                    </asp:View>

                                    <asp:View ID="viewPasados" runat="server">
                                        <h5 class="mb-3 fw-bold text-secondary">Historial de Turnos</h5>
                                        <div class="alert alert-light border text-center py-5">
                                            <i class="bi bi-clock-history fs-1 text-muted d-block mb-2"></i>
                                            <p class="mb-0 text-muted">Aquí se mostrará el historial de turnos pasados.</p>
                                        </div>
                                    </asp:View>

                                </asp:MultiView>
                            </div>
                        </div>
                    </div>

                    <!-- 3. PROFESIONALES (ADMIN) -->
                    <div class="tab-pane fade" id="v-pills-profesionales" role="tabpanel">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h4 class="fw-bold mb-0">Equipo Profesional</h4>
                            <asp:Button ID="btnAgregarProfesional" runat="server" Text="+ Nuevo Profesional" 
                                CssClass="btn btn-primary rounded-pill px-4" OnClick="btnAgregarProfesional_Click" />
                        </div>

                        <ul class="nav nav-tabs mb-4" id="profesionalesTabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="pills-activos-tab" data-bs-toggle="pill" data-bs-target="#pills-activos" type="button" role="tab">Activos</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="pills-inactivos-tab" data-bs-toggle="pill" data-bs-target="#pills-inactivos" type="button" role="tab">Inactivos</button>
                            </li>
                        </ul>

                        <div class="tab-content" id="profesionalesTabsContent">
                            <div class="tab-pane fade show active" id="pills-activos" role="tabpanel">
                                <div class="row g-3">
                                    <asp:Repeater ID="rptProfesionalesActivos" runat="server" OnItemDataBound="rptProfesionales_ItemDataBound" OnItemCommand="rptProfesionales_ItemCommand">
                                        <ItemTemplate>
                                            <div class="col-md-6 col-lg-4 col-xl-3">
                                                <div class="card prof-card h-100 p-3 border-success-subtle">
                                                    <div class="d-flex align-items-start">
                                                        <div class="avatar-initials me-3 bg-success-subtle text-success">
                                                            <%# Eval("Nombre").ToString().Substring(0,1) + Eval("Apellido").ToString().Substring(0,1) %>
                                                        </div>
                                                        <div class="flex-grow-1">
                                                            <h6 class="fw-bold mb-0"><%# Eval("Nombre") %> <%# Eval("Apellido") %></h6>
                                                            <small class="text-muted d-block mb-2"><%# Eval("Mail") %></small>
                                                            <span class="badge bg-success-subtle text-success">Activo</span>
                                                        </div>
                                                        <div class="dropdown">
                                                            <button class="btn btn-light btn-sm rounded-circle" type="button" data-bs-toggle="dropdown">
                                                                <i class="bi bi-three-dots-vertical"></i>
                                                            </button>
                                                            <ul class="dropdown-menu">
                                                                <li>
                                                                    <asp:Button ID="btnGestionarTurnos" runat="server" Text="Ver Agenda" 
                                                                        CssClass="dropdown-item" CommandName="VerTurnos" CommandArgument='<%# Eval("ID") %>' />
                                                                </li>
                                                                <li>
                                                                      <a class="dropdown-item" href='GestionProfesional.aspx?id=<%# Eval("ID") %>'>
                                                                          Gestionar Profesional
                                                                      </a>
                                                                </li>
                                                                <li><hr class="dropdown-divider"></li>
                                                                <li>
                                                                    <asp:Button ID="btnBaja" runat="server" Text="Dar de Baja" 
                                                                        CssClass="dropdown-item text-danger" 
                                                                        CommandName="DarDeBaja" 
                                                                        CommandArgument='<%# Eval("ID") %>'
                                                                        OnClientClick="return confirm('¿Está seguro que desea dar de baja a este profesional?');" />
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="mt-3 pt-3 border-top">
                                                        <small class="text-muted text-uppercase" style="font-size: 0.7rem;">Especialidades</small>
                                                        <div class="mt-1">
                                                            <asp:Repeater ID="rptEspecialidadesProf" runat="server">
                                                                <ItemTemplate>
                                                                    <span class="badge bg-light text-secondary border fw-normal"><%# Eval("Nombre") %></span>
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>

                            <div class="tab-pane fade" id="pills-inactivos" role="tabpanel">
                                <div class="row g-3">
                                    <asp:Repeater ID="rptProfesionalesInactivos" runat="server" OnItemDataBound="rptProfesionales_ItemDataBound" OnItemCommand="rptProfesionales_ItemCommand">
                                        <ItemTemplate>
                                            <div class="col-md-6 col-lg-4 col-xl-3">
                                                <div class="card prof-card h-100 p-3 bg-light opacity-75">
                                                    <div class="d-flex align-items-start">
                                                        <div class="avatar-initials me-3 bg-secondary text-white">
                                                            <%# Eval("Nombre").ToString().Substring(0,1) + Eval("Apellido").ToString().Substring(0,1) %>
                                                        </div>
                                                        <div class="flex-grow-1">
                                                            <h6 class="fw-bold mb-0 text-muted"><%# Eval("Nombre") %> <%# Eval("Apellido") %></h6>
                                                            <small class="text-muted d-block mb-2"><%# Eval("Mail") %></small>
                                                            <span class="badge bg-secondary">Inactivo</span>
                                                        </div>
                                                        <div class="dropdown">
                                                            <button class="btn btn-light btn-sm rounded-circle" type="button" data-bs-toggle="dropdown">
                                                                <i class="bi bi-three-dots-vertical"></i>
                                                            </button>
                                                            <ul class="dropdown-menu">
                                                                <li><asp:Button ID="btnAlta" runat="server" Text="Reactivar" CssClass="dropdown-item text-success" CommandName="DarDeAlta" CommandArgument='<%# Eval("ID") %>'/></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="mt-3 pt-3 border-top">
                                                        <small class="text-muted text-uppercase" style="font-size: 0.7rem;">Especialidades</small>
                                                        <div class="mt-1">
                                                            <asp:Repeater ID="Repeater1" runat="server">
                                                                <ItemTemplate>
                                                                    <span class="badge bg-light text-secondary border fw-normal"><%# Eval("Nombre") %></span>
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 3. CLIENTES -->

                    <div class="tab-pane fade" id="v-pills-clientes" role="tabpanel">
    
                      <asp:UpdatePanel ID="upClientes" runat="server" UpdateMode="Conditional">
                          <ContentTemplate>

                              <div class="d-flex justify-content-between align-items-center mb-4">
                                  <h4 class="fw-bold mb-0">Gestión de Clientes</h4>
                                  <asp:Button ID="btnNuevoCliente" runat="server" Text="+ Nuevo Cliente" 
                                      CssClass="btn btn-outline-primary rounded-pill px-4" PostBackUrl="~/RegistroPage.aspx?rol=Cliente" />
                              </div>

                              <ul class="nav nav-tabs mb-3" id="clientesTabs" role="tablist">
                                  <li class="nav-item" role="presentation">
                                      <button class="nav-link active" id="cli-activos-tab" data-bs-toggle="pill" data-bs-target="#cli-activos" type="button" role="tab">Clientes Activos</button>
                                  </li>
                                  <li class="nav-item" role="presentation">
                                      <button class="nav-link" id="cli-inactivos-tab" data-bs-toggle="pill" data-bs-target="#cli-inactivos" type="button" role="tab">Inactivos / Baja</button>
                                  </li>
                              </ul>

                              <div class="tab-content" id="clientesTabsContent">
                                  
                                  <div class="tab-pane fade show active" id="cli-activos" role="tabpanel">
                                      <div class="card border-0 shadow-sm">
                                          <div class="card-body p-0">
                                              <div class="table-responsive">
                                                  <table class="table table-hover align-middle mb-0">
                                                      <thead class="bg-light">
                                                          <tr>
                                                              <th class="ps-4">Nombre Completo</th>
                                                              <th>Email / Contacto</th>
                                                              <th>Estado</th>
                                                              <th class="text-end pe-4">Acciones</th>
                                                          </tr>
                                                      </thead>
                                                      <tbody>
                                                          <asp:Repeater ID="rptClientesActivos" runat="server" OnItemCommand="rptClientes_ItemCommand">
                                                              <ItemTemplate>
                                                                  <tr>
                                                                      <td class="ps-4">
                                                                          <div class="d-flex align-items-center">
                                                                              <div class="avatar-initials-sm me-3 bg-primary-subtle text-primary rounded-circle d-flex justify-content-center align-items-center" style="width:35px; height:35px; font-size:0.9rem; font-weight:bold;">
                                                                                  <%# Eval("Nombre").ToString().Substring(0,1) + Eval("Apellido").ToString().Substring(0,1) %>
                                                                              </div>
                                                                              <div>
                                                                                  <h6 class="mb-0 fw-semibold"><%# Eval("Nombre") %> <%# Eval("Apellido") %></h6>
                                                                              </div>
                                                                          </div>
                                                                      </td>
                                                                      <td>
                                                                          <span class="text-muted small"><i class="bi bi-envelope me-1"></i><%# Eval("Mail") %></span>
                                                                      </td>
                                                                      <td>
                                                                          <span class="badge bg-success-subtle text-success rounded-pill">Activo</span>
                                                                      </td>
                                                                      <td class="text-end pe-4">
                                                                          <div class="btn-group" role="group">
                                                                              
                                                                              <asp:Button ID="btnEditar" runat="server" Text="✏️" ToolTip="Modificar Datos"
                                                                                  CssClass="btn btn-sm btn-light border" CommandName="EditarCliente" CommandArgument='<%# Eval("ID") %>' />

                                                                              <asp:Button ID="btnVerTurnos" runat="server" Text="📅" ToolTip="Ver Turnos Pendientes"
                                                                                  CssClass="btn btn-sm btn-light border text-primary" 
                                                                                  CommandName="VerTurnosCliente" CommandArgument='<%# Eval("ID") %>' />

                                                                              <asp:Button ID="Button1" runat="server" Text="🗑️" ToolTip="Dar de Baja"
                                                                                  CssClass="btn btn-sm btn-light border text-danger" 
                                                                                  CommandName="DarDeBajaCliente" CommandArgument='<%# Eval("ID") %>'
                                                                                  OnClientClick="return confirm('¿Seguro que desea dar de baja a este cliente?');" />
                                                                          </div>
                                                                      </td>
                                                                  </tr>
                                                              </ItemTemplate>
                                                          </asp:Repeater>
                                                      </tbody>
                                                  </table>
                                                  <% if (rptClientesActivos.Items.Count == 0) { %>
                                                      <div class="p-4 text-center text-muted">No hay clientes activos registrados.</div>
                                                  <% } %>
                                              </div>
                                          </div>
                                      </div>
                                  </div>

                                  <div class="tab-pane fade" id="cli-inactivos" role="tabpanel">
                                       <div class="card border-0 shadow-sm">
                                          <div class="card-body p-0">
                                              <div class="table-responsive">
                                                  <table class="table table-hover align-middle mb-0">
                                                      <thead class="bg-light">
                                                          <tr>
                                                              <th class="ps-4">Nombre Completo</th>
                                                              <th>Email</th>
                                                              <th>Estado</th>
                                                              <th class="text-end pe-4">Acciones</th>
                                                          </tr>
                                                      </thead>
                                                      <tbody>
                                                          <asp:Repeater ID="rptClientesInactivos" runat="server" OnItemCommand="rptClientes_ItemCommand">
                                                              <ItemTemplate>
                                                                  <tr class="opacity-75">
                                                                      <td class="ps-4">
                                                                          <div class="d-flex align-items-center">
                                                                              <div class="avatar-initials-sm me-3 bg-secondary text-white rounded-circle d-flex justify-content-center align-items-center" style="width:35px; height:35px; font-size:0.9rem;">
                                                                                  <%# Eval("Nombre").ToString().Substring(0,1) + Eval("Apellido").ToString().Substring(0,1) %>
                                                                              </div>
                                                                              <div>
                                                                                  <h6 class="mb-0 text-muted"><%# Eval("Nombre") %> <%# Eval("Apellido") %></h6>
                                                                              </div>
                                                                          </div>
                                                                      </td>
                                                                      <td><%# Eval("Mail") %></td>
                                                                      <td><span class="badge bg-secondary rounded-pill">Inactivo</span></td>
                                                                      <td class="text-end pe-4">
                                                                          <asp:Button ID="Button2" runat="server" Text="Reactivar" 
                                                                              CssClass="btn btn-sm btn-outline-success" 
                                                                              CommandName="DarDeAltaCliente" CommandArgument='<%# Eval("ID") %>' />
                                                                      </td>
                                                                  </tr>
                                                              </ItemTemplate>
                                                          </asp:Repeater>
                                                      </tbody>
                                                  </table>
                                                  <% if (rptClientesInactivos.Items.Count == 0) { %>
                                                      <div class="p-4 text-center text-muted">No hay clientes inactivos.</div>
                                                  <% } %>
                                              </div>
                                          </div>
                                      </div>
                                  </div>

                              </div>
                          
                          </ContentTemplate>
                      </asp:UpdatePanel>
                      </div>

                    <!-- 4. CATÁLOGO -->
                    <div class="tab-pane fade" id="v-pills-servicios" role="tabpanel">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h4 class="fw-bold mb-0">Catálogo de Servicios</h4>
                            <asp:Button ID="btnAgregarEspecialidad" runat="server" Text="+ Nueva Especialidad" 
                                CssClass="btn btn-primary rounded-pill px-4" OnClick="btnAgregarEspecialidad_Click" />
                        </div>

                        <div class="accordion custom-accordion" id="especialidadesAccordion">
                            <asp:Repeater ID="rptEspecialidadesLista" runat="server" 
                                OnItemDataBound="rptEspecialidadesLista_ItemDataBound"
                                OnItemCommand="rptEspecialidadesLista_ItemCommand">
                                <ItemTemplate>
                                    <div class="accordion-item border rounded mb-3 overflow-hidden shadow-sm">
                                        
                                        <h2 class="accordion-header" id='heading<%# Eval("IDEspecialidad") %>'>
                                            <button class="accordion-button collapsed bg-white py-3" type="button" data-bs-toggle="collapse" 
                                                data-bs-target='#collapse<%# Eval("IDEspecialidad") %>' aria-expanded="false">
                                                
                                                <div class="d-flex align-items-center w-100 pe-3">
                                                    
                                                    <div class="d-flex align-items-center me-auto">
                                                        <i class="bi bi-tag-fill me-2 text-secondary fs-5"></i>
                                                        <span class="fw-bold fs-6 text-dark me-3"><%# Eval("Nombre") %></span>
                                                        <span class='badge rounded-pill <%# (bool)Eval("Activo") ? "bg-success-subtle text-success" : "bg-secondary text-white" %>'>
                                                            <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                                                        </span>
                                                    </div>
                        
                                                    <div class="d-flex align-items-center gap-3" onclick="event.stopPropagation();">
                                                        
                                                        <asp:LinkButton ID="btnEditarEspecialidad" runat="server" 
                                                            CssClass="btn btn-link p-0 text-secondary border-0 fs-5" 
                                                            ToolTip="Editar" CommandName="EditarEspecialidad">
                                                            <i class="bi bi-pencil-square"></i>
                                                        </asp:LinkButton>
                        
                                                        <asp:LinkButton ID="btnCambiarEstadoEspecialidad" runat="server" />
                        
                                                        <div class="vr text-muted mx-1" style="height: 20px;"></div>
                        
                                                        <asp:Button ID="btnAgregarServicio" runat="server" Text="+ Servicio" 
                                                            CssClass="btn btn-sm btn-outline-primary py-0 fw-bold" 
                                                            style="font-size: 0.8rem;" CommandName="AgregarServicio" />
                        
                                                    </div>
                                                </div>
                                            </button>
                                        </h2>
                        
                                        <div id='collapse<%# Eval("IDEspecialidad") %>' class="accordion-collapse collapse" 
                                            data-bs-parent="#especialidadesAccordion">
                                            <div class="accordion-body bg-light pt-0">
                                                
                                                <div class="list-group list-group-flush mt-2 rounded border-0">
                                                    <asp:Repeater ID="rptServicios" runat="server" 
                                                        OnItemDataBound="rptServicios_ItemDataBound"
                                                        OnItemCommand="rptServicios_ItemCommand">
                                                        <ItemTemplate>
                                                            <div class="list-group-item d-flex justify-content-between align-items-center bg-white border-bottom">
                                                                <div class="d-flex flex-column">
                                                                    <span class="fw-semibold text-dark"><%# Eval("Nombre") %></span>
                                                                    <div class="d-flex align-items-center small text-muted gap-2">
                                                                        <span><i class="bi bi-clock me-1"></i><%# Eval("DuracionMinutos") %> min</span>
                                                                        <span>•</span>
                                                                        <span><%# !(bool)Eval("Activo") ? "<span class='text-danger fw-bold'>Inactivo</span>" : "<span class='text-success'>Activo</span>" %></span>
                                                                    </div>
                                                                </div>
                                                                <div class="d-flex align-items-center gap-3">
                                                                    <span class="fw-bold text-primary fs-6">$<%# Eval("Precio", "{0:N0}") %></span>
                                                                    <div class="btn-group">
                                                                        <asp:Button ID="btnEditarServicio" runat="server" Text="✏️" ToolTip="Editar"
                                                                            CssClass="btn btn-light btn-sm border shadow-sm" CommandName="EditarServicio" />
                                                                        <asp:Button ID="btnCambiarEstadoServicio" runat="server" Text="👁️" ToolTip="Activar/Desactivar"
                                                                            CssClass="btn btn-light btn-sm border shadow-sm" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                     <div id="pnlSinServicios" runat="server" visible="false" class="p-3 text-center text-muted small">
                                                        <i class="bi bi-info-circle me-1"></i> No hay servicios cargados en esta especialidad.
                                                      </div>
                                                     
                                                </div>
                        
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>

                    <!-- 5. CONFIGURACIÓN -->
                    <div class="tab-pane fade" id="v-pills-settings" role="tabpanel">
    
                        <h4 class="fw-bold mb-4">Configuración del Sistema</h4>
                        
                        <div class="card border-0 shadow-sm rounded-4 mb-4">
                            <div class="card-header bg-white border-0 pt-4 px-4">
                                 <h5 class="fw-bold text-secondary"><i class="bi bi-shop me-2"></i>Datos del Centro</h5>
                            </div>
                            <div class="card-body p-4">
                                <div class="row g-3">
                                    <div class="col-12">
                                        <label class="form-label fw-bold text-muted small">Nombre del Centro</label>
                                        <input type="text" class="form-control" value="Centro de Estética" disabled>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold text-muted small">Email de Notificaciones</label>
                                        <input type="email" class="form-control" value="admin@sistema.com" disabled>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold text-muted small">Porcentaje de Seña (%)</label>
                                        <input type="number" class="form-control" value="50" disabled>
                                    </div>
                                </div>
                            </div>
                        </div>
                    
                        <div class="card border-0 shadow-sm rounded-4 border-start border-4 border-dark">
                            <div class="card-body p-4">
                                <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
                                    <div>
                                        <h5 class="fw-bold text-dark mb-1"><i class="bi bi-shield-lock-fill me-2"></i>Gestión de Administradores</h5>
                                        <p class="text-muted small mb-0">Registrar nuevos usuarios con acceso total al sistema.</p>
                                    </div>
                                    
                                    <asp:Button ID="btnNuevoAdmin" runat="server" Text="+ Nuevo Administrador" 
                                        CssClass="btn btn-dark px-4 rounded-pill fw-bold" OnClick="btnNuevoAdmin_Click" />
                                </div>
                            </div>
                        </div>
                    
                    </div>
                    <!-- 6. RECEPCIONISTAS (NUEVA SECCIÓN) -->
                    <div class="tab-pane fade" id="v-pills-recepcionistas" role="tabpanel">
                        
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h4 class="fw-bold mb-0">Equipo de Recepción</h4>
                            <asp:Button ID="btnAgregarRecepcionista" runat="server" Text="+ Nueva/o" 
                                CssClass="btn btn-primary rounded-pill px-4" OnClick="btnAgregarRecepcionista_Click" />
                        </div>
                    
                        <!-- Pestañas Activos/Inactivos -->
                        <ul class="nav nav-tabs mb-4" id="recepcionistasTabs" role="tablist">
                            <li class="nav-item">
                                <button class="nav-link active" id="recep-activos-tab" data-bs-toggle="pill" data-bs-target="#recep-activos" type="button" role="tab">Personal Activo</button>
                            </li>
                            <li class="nav-item">
                                <button class="nav-link" id="recep-inactivos-tab" data-bs-toggle="pill" data-bs-target="#recep-inactivos" type="button" role="tab">Inactivos</button>
                            </li>
                        </ul>
                    
                        <div class="tab-content">
                            
                            <!-- RECEPCIONISTAS ACTIVOS -->
                            <div class="tab-pane fade show active" id="recep-activos" role="tabpanel">
                                <div class="row g-3">
                                    <asp:Repeater ID="rptRecepcionistasActivos" runat="server" OnItemCommand="rptRecepcionistas_ItemCommand">
                                        <ItemTemplate>
                                            <div class="col-md-6 col-lg-4 col-xl-3">
                                                <div class="card h-100 border-0 shadow-sm rounded-3 position-relative">
                                                    
                                                    <div class="position-absolute top-0 start-0 w-100 bg-info rounded-top-3" style="height: 4px;"></div>
                                                    
                                                    <div class="card-body p-3">
                                                        <div class="d-flex align-items-center justify-content-between mb-3">
                                                            <div class="d-flex align-items-center">
                                                                <div class="rounded-circle bg-info-subtle text-info d-flex align-items-center justify-content-center fw-bold me-3" 
                                                                    style="width: 45px; height: 45px; font-size: 1rem;">
                                                                    <%# Eval("Nombre").ToString().Substring(0,1) + Eval("Apellido").ToString().Substring(0,1) %>
                                                                </div>
                                                                <div>
                                                                    <h6 class="fw-bold mb-0 text-dark"><%# Eval("Nombre") %></h6>
                                                                    <h6 class="fw-bold mb-0 text-dark"><%# Eval("Apellido") %></h6>
                                                                </div>
                                                            </div>
                                                            
                                                            <div class="dropdown">
                                                                <button class="btn btn-light btn-sm rounded-circle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                                    <i class="bi bi-three-dots-vertical text-muted"></i>
                                                                </button>
                                                                <ul class="dropdown-menu dropdown-menu-end shadow border-0">
                                                                    <li>
                                                                        <asp:LinkButton ID="lnkEditar" runat="server" CssClass="dropdown-item small" 
                                                                            CommandName="EditarRecepcionista" CommandArgument='<%# Eval("ID") %>'>
                                                                            <i class="bi bi-pencil me-2"></i>Modificar
                                                                        </asp:LinkButton>
                                                                    </li>
                                                                    <li><hr class="dropdown-divider"></li>
                                                                    <li>
                                                                        <asp:LinkButton ID="lnkBaja" runat="server" CssClass="dropdown-item small text-danger" 
                                                                            CommandName="DarDeBajaRecepcionista" CommandArgument='<%# Eval("ID") %>'
                                                                            OnClientClick="return confirm('¿Dar de baja?');">
                                                                            <i class="bi bi-trash me-2"></i>Baja
                                                                        </asp:LinkButton>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                        
                                                        <div class="small text-muted">
                                                            <div class="mb-1 text-truncate" title='<%# Eval("Mail") %>'><i class="bi bi-envelope me-2"></i><%# Eval("Mail") %></div>
                                                            <div><i class="bi bi-telephone me-2"></i><%# Eval("Telefono") %></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    
                                    <% if (rptRecepcionistasActivos.Items.Count == 0) { %>
                                       <div class="col-12 text-center text-muted py-5">No hay recepcionistas activos.</div>
                                    <% } %>
                                </div>
                            </div>
                    
                            <!-- RECEPCIONISTAS INACTIVOS -->
                            <div class="tab-pane fade" id="recep-inactivos" role="tabpanel">
                                <div class="row g-3">
                                    <asp:Repeater ID="rptRecepcionistasInactivos" runat="server" OnItemCommand="rptRecepcionistas_ItemCommand">
                                        <ItemTemplate>
                                            <div class="col-md-6 col-lg-4 col-xl-3">
                                                <div class="card h-100 border rounded-3 bg-light opacity-75">
                                                    <div class="card-body p-3">
                                                        <div class="d-flex align-items-center justify-content-between mb-3">
                                                            <div class="d-flex align-items-center">
                                                                <div class="rounded-circle bg-secondary text-white d-flex align-items-center justify-content-center fw-bold me-3" 
                                                                    style="width: 45px; height: 45px;">
                                                                    <%# Eval("Nombre").ToString().Substring(0,1) + Eval("Apellido").ToString().Substring(0,1) %>
                                                                </div>
                                                                <div>
                                                                    <h6 class="fw-bold mb-0 text-muted"><%# Eval("Nombre") %> <%# Eval("Apellido") %></h6>
                                                                    <span class="badge bg-secondary mt-1">Inactivo</span>
                                                                </div>
                                                            </div>
                                                            
                                                            <div class="dropdown">
                                                                <button class="btn btn-light btn-sm rounded-circle" type="button" data-bs-toggle="dropdown">
                                                                    <i class="bi bi-three-dots-vertical"></i>
                                                                </button>
                                                                <ul class="dropdown-menu dropdown-menu-end">
                                                                    <li>
                                                                        <asp:LinkButton ID="lnkAlta" runat="server" CssClass="dropdown-item text-success fw-bold" 
                                                                            CommandName="DarDeAltaRecepcionista" CommandArgument='<%# Eval("ID") %>'>
                                                                            <i class="bi bi-check-circle me-2"></i>Reactivar
                                                                        </asp:LinkButton>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                    
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- Script para mantener la pestaña activa -->
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

    <div class="modal fade" id="modalTurnosCliente" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">Turnos Pendientes</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="upModalTurnos" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            
                            <h6 class="mb-3 fw-bold"><asp:Literal ID="litNombreClienteModal" runat="server"></asp:Literal></h6>

                            <asp:Repeater ID="rptTurnosModal" runat="server">
                                <HeaderTemplate>
                                    <ul class="list-group list-group-flush">
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        <div>
                                            <span class="fw-bold d-block"><%# Eval("Servicio.Nombre") %></span>
                                            <small class="text-muted"><%# ((DateTime)Eval("Fecha")).ToString("dd/MM/yyyy") %> - <%# Eval("HoraInicio") %> hs</small>
                                        </div>
                                        <span class="badge bg-warning text-dark">Pendiente</span>
                                    </li>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </ul>
                                </FooterTemplate>
                            </asp:Repeater>

                            <asp:Panel ID="pnlSinTurnos" runat="server" Visible="false" CssClass="text-center py-3">
                                <i class="bi bi-calendar-x text-muted fs-1"></i>
                                <p class="text-muted mt-2">El cliente no tiene turnos pendientes.</p>
                            </asp:Panel>

                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function openModalTurnos() {
            var myModal = new bootstrap.Modal(document.getElementById('modalTurnosCliente'));
            myModal.show();
        }
    </script>

</asp:Content>
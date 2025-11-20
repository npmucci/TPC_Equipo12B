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
                        
                        <!-- BOTÓN MI AGENDA (Oculto por defecto, se activa en el CodeBehind si es ProfesionalUnico) -->
                        <button class="nav-link" id="btnTabAgenda" runat="server" visible="false" data-bs-toggle="pill" data-bs-target="#v-pills-agenda" type="button" role="tab">
                            <i class="bi bi-calendar-heart"></i> Mi Agenda
                        </button>

                        <button class="nav-link" id="v-pills-profesionales-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profesionales" type="button" role="tab">
                            <i class="bi bi-people"></i> Profesionales
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
                                    <h2>--</h2>
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
                                            <div class="col-md-6 col-xl-4">
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
                                            <div class="col-md-6 col-xl-4">
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
                        </div>
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
                                            <button class="accordion-button collapsed bg-white" type="button" data-bs-toggle="collapse" 
                                                data-bs-target='#collapse<%# Eval("IDEspecialidad") %>' aria-expanded="false">
                                                <div class="d-flex align-items-center w-100 me-3">
                                                    <i class="bi bi-tag-fill me-2 text-secondary"></i>
                                                    <span class="fw-semibold me-auto"><%# Eval("Nombre") %></span>
                                                    <span class='badge me-3 <%# (bool)Eval("Activo") ? "bg-success-subtle text-success" : "bg-danger-subtle text-danger" %>'>
                                                        <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                                                    </span>
                                                </div>
                                            </button>
                                        </h2>
                                        <div id='collapse<%# Eval("IDEspecialidad") %>' class="accordion-collapse collapse" 
                                            data-bs-parent="#especialidadesAccordion">
                                            <div class="accordion-body bg-light">
                                                
                                                <div class="d-flex gap-2 mb-3 justify-content-end">
                                                    <asp:Button ID="btnEditarEspecialidad" runat="server" Text="Editar Especialidad" 
                                                        CssClass="btn btn-sm btn-outline-secondary bg-white" CommandName="EditarEspecialidad" />
                                                    <asp:Button ID="btnCambiarEstadoEspecialidad" runat="server" 
                                                        CssClass="btn btn-sm btn-outline-danger bg-white" />
                                                    <div class="vr mx-2"></div>
                                                    <asp:Button ID="btnAgregarServicio" runat="server" Text="+ Servicio" 
                                                        CssClass="btn btn-sm btn-success text-white" CommandName="AgregarServicio" />
                                                </div>

                                                <div class="list-group">
                                                    <asp:Repeater ID="rptServicios" runat="server" 
                                                        OnItemDataBound="rptServicios_ItemDataBound"
                                                        OnItemCommand="rptServicios_ItemCommand">
                                                        <ItemTemplate>
                                                            <div class="list-group-item d-flex justify-content-between align-items-center">
                                                                <div>
                                                                    <h6 class="mb-0"><%# Eval("Nombre") %></h6>
                                                                    <small class="text-muted"><%# Eval("DuracionMinutos") %> min • <%# !(bool)Eval("Activo") ? "<span class='text-danger'>Inactivo</span>" : "<span class='text-success'>Activo</span>" %></small>
                                                                </div>
                                                                <div class="d-flex align-items-center gap-3">
                                                                    <span class="fw-bold">$<%# Eval("Precio", "{0:N0}") %></span>
                                                                    <div class="btn-group">
                                                                        <asp:Button ID="btnEditarServicio" runat="server" Text="✏️" ToolTip="Editar"
                                                                            CssClass="btn btn-light btn-sm border" CommandName="EditarServicio" />
                                                                        <asp:Button ID="btnCambiarEstadoServicio" runat="server" Text="👁️" ToolTip="Activar/Desactivar"
                                                                            CssClass="btn btn-light btn-sm border" />
                                                                    </div>
                                                                </div>
                                                            </div>
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

                    <!-- 5. CONFIGURACIÓN -->
                    <div class="tab-pane fade" id="v-pills-settings" role="tabpanel">
                        <h4 class="fw-bold mb-4">Configuración</h4>
                        <div class="card border-0 bg-light rounded-3">
                            <div class="card-body">
                                <div class="row g-3">
                                    <div class="col-12">
                                        <label class="form-label fw-bold">Nombre del Centro</label>
                                        <input type="text" class="form-control" value="Centro de Estética" disabled>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Email de Notificaciones</label>
                                        <input type="email" class="form-control" value="admin@sistema.com" disabled>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Porcentaje de Seña (%)</label>
                                        <input type="number" class="form-control" value="50" disabled>
                                    </div>
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

</asp:Content>
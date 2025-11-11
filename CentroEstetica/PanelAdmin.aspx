<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PanelAdmin.aspx.cs" Inherits="CentroEstetica.PanelAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <h1 class="display-6 mb-4">Panel de Administración</h1>

        <asp:Panel ID="pnlMensajes" runat="server" Visible="false" role="alert">
            <asp:Literal ID="litMensaje" runat="server"></asp:Literal>
        </asp:Panel>

        <div class="card mb-4">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h2 class="h5 mb-0">Gestión de Profesionales</h2>
                    <asp:Button ID="btnAgregarProfesional" runat="server" Text="+ Agregar Profesional" 
                        CssClass="btn btn-primary btn-sm" OnClick="btnAgregarProfesional_Click" />
                </div>

                <div class="mb-3">
                    <asp:LinkButton ID="lnkVerActivos" runat="server" OnClick="lnkVerActivos_Click" CssClass="btn btn-link fw-bold p-0">Ver Activos</asp:LinkButton>
                    <span class="text-muted mx-2">|</span>
                    <asp:LinkButton ID="lnkVerInactivos" runat="server" OnClick="lnkVerInactivos_Click" CssClass="btn btn-link p-0">Ver Inactivos</asp:LinkButton>
                </div>

                <div class="row g-3">
                    <asp:Repeater ID="rptProfesionales" runat="server" 
                        OnItemDataBound="rptProfesionales_ItemDataBound" 
                        OnItemCommand="rptProfesionales_ItemCommand">
                        <ItemTemplate>
                            <div class="col-md-6 col-lg-4">
                                <div class="card h-100">
                                    <div class="card-body d-flex flex-column">
                                        
                                        <div class="d-flex align-items-center mb-3">
                                            <div>
                                                <h6 class="mb-0"><%# Eval("Nombre") %> <%# Eval("Apellido") %></h6>
                                                <small class="text-muted"><%# Eval("Mail") %></small>
                                            </div>
                                        </div>

                                        <p class="mb-2"><strong>DNI:</strong> <%# Eval("Dni") %></p>
                                        <p class="mb-2"><strong>Tel:</strong> <%# Eval("Telefono") %></p>
                                        
                                        <div class="mb-3">
                                            <strong>Especialidades:</strong>
                                            <asp:Repeater ID="rptEspecialidadesProf" runat="server">
                                                <ItemTemplate>
                                                    <span class="badge bg-secondary me-1"><%# Eval("Nombre") %></span>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                        
                                        <span class='badge <%# (bool)Eval("Activo") ? "bg-success" : "bg-danger" %> mb-3'>
                                            <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                                        </span>

                                        <div class="d-flex gap-2 mt-auto">
                                            <asp:Button ID="btnModificar" runat="server" Text="Editar" CssClass="btn btn-outline-secondary btn-sm" Enabled="false" />
                                            
                                            <asp:Button ID="btnCambiarEstado" runat="server" 
                                                Text='<%# (bool)Eval("Activo") ? "Dar de Baja" : "Dar de Alta" %>'
                                                CssClass='<%# (bool)Eval("Activo") ? "btn btn-outline-danger btn-sm" : "btn btn-outline-success btn-sm" %>'
                                                CommandName='<%# (bool)Eval("Activo") ? "DarDeBaja" : "DarDeAlta" %>'
                                                CommandArgument='<%# Eval("ID") %>' />

                                            <asp:Button ID="btnGestionarTurnos" runat="server" 
                                                Text="Ver Turnos" 
                                                CssClass="btn btn-outline-info btn-sm"
                                                CommandName="VerTurnos"
                                                CommandArgument='<%# Eval("ID") %>' />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>

        <div class="card mb-4">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h2 class="h5 mb-0">Especialidades y Servicios</h2>
                    <asp:Button ID="btnAgregarEspecialidad" runat="server" Text="+ Agregar Especialidad" CssClass="btn btn-primary btn-sm" Enabled="false" />
                </div>
                
                <div class="accordion" id="especialidadesAccordion">
                    <asp:Repeater ID="rptEspecialidadesLista" runat="server" OnItemDataBound="rptEspecialidadesLista_ItemDataBound">
                        <ItemTemplate>
                            <div class="accordion-item">
                                <h2 class="accordion-header" id='heading<%# Eval("IDEspecialidad") %>'>
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" 
                                        data-bs-target='#collapse<%# Eval("IDEspecialidad") %>' aria-expanded="false" 
                                        aria-controls='collapse<%# Eval("IDEspecialidad") %>'>
                                        <span class="me-2"><%# Eval("Nombre") %></span>
                                        <span class='badge <%# (bool)Eval("Activo") ? "bg-success" : "bg-danger" %>'>
                                            <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                                        </span>
                                    </button>
                                </h2>
                                <div id='collapse<%# Eval("IDEspecialidad") %>' class="accordion-collapse collapse" 
                                    aria-labelledby='heading<%# Eval("IDEspecialidad") %>' data-bs-parent="#especialidadesAccordion">
                                    <div class="accordion-body">
                                        <ul class="list-group mb-2">
                                            <asp:Repeater ID="rptServicios" runat="server">
                                                <ItemTemplate>
                                                    <li class="list-group-item d-flex justify-content-between align-items-start">
                                                        <div>
                                                            <h6 class="mb-1"><%# Eval("Nombre") %></h6>
                                                            <small class="text-muted">Duración: <%# Eval("DuracionMinutos") %> min</small>
                                                        </div>
                                                        <div class="text-end">
                                                            <div class="fw-bold text-primary mb-1">$<%# Eval("Precio", "{0:N0}") %></div>
                                                            <div class="btn-group btn-group-sm">
                                                                <asp:Button ID="btnEditarServicio" runat="server" Text="Editar" CssClass="btn btn-outline-secondary" Enabled="false" />
                                                                <asp:Button ID="btnEliminarServicio" runat="server" Text="Eliminar" CssClass="btn btn-outline-danger" Enabled="false" />
                                                            </div>
                                                        </div>
                                                    </li>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </ul>
                                        <asp:Button ID="btnAgregarServicio" runat="server" Text="+ Agregar Servicio" CssClass="btn btn-outline-primary btn-sm" Enabled="false" />
                                        <asp:Button ID="btnEliminarEspecialidad" runat="server" Text="Eliminar Especialidad" CssClass="btn btn-outline-danger btn-sm mt-2" Enabled="false" />
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
        
        <div class="card mb-4">
                <div class="card-body">
                    <h2 class="h5 mb-3">Configuración General</h2>
                    <div>
                        <div class="mb-3">
                            <label class="form-label">Nombre del Centro</label>
                            <input type="text" class="form-control" value="Centro de Estética">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Porcentaje de Seña</label>
                            <input type="number" class="form-control" value="50">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email de Notificaciones</label>
                            <input type="email" class="form-control" value="admin@esteticapremium.com">
                        </div>
                        <button type="submit" class="btn btn-primary w-100" disabled>Guardar Cambios</button>
                    </div>
                </div>
        </div>

    </div>
</asp:Content>
<%@ Page Title="Gestión Profesional" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="GestionProfesional.aspx.cs" Inherits="CentroEstetica.GestionProfesional" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        
        .gestion-card {
            background-color: #f8f9fa; 
            border: 1px solid #ced4da; 
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        .gestion-card-header {
            background-color: #343a40; 
            color: #ffffff;
            border-bottom: 3px solid #0d6efd; 
            padding: 15px 20px;
            border-radius: calc(0.375rem - 1px) calc(0.375rem - 1px) 0 0;
        }

        .gestion-title {
            font-size: 1.1rem;
            font-weight: 600;
            margin: 0;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
        }

        .gestion-title i {
            margin-right: 10px;
            font-size: 1.2rem;
            opacity: 0.8;
        }
        
        
        .gestion-card .form-control, 
        .gestion-card .form-select {
            background-color: #ffffff; 
            border: 1px solid #ced4da;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-4 mb-5">
        
        <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
            <h2 class="fw-bold text-dark">Gestionar Profesional</h2>
            <asp:Button ID="btnVolver" runat="server" Text="← Volver al Panel" 
                CssClass="btn btn-outline-secondary btn-sm fw-bold" OnClick="btnVolver_Click" />
        </div>

        <asp:UpdatePanel ID="upMensajes" runat="server" UpdateMode="Always">
            <ContentTemplate>
                
                <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <asp:Label ID="lblMensaje" runat="server"></asp:Label>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </asp:Panel>
        
            </ContentTemplate>
        </asp:UpdatePanel>

        <div class="card gestion-card rounded-3 mb-5">
            <div class="gestion-card-header">
                <h5 class="gestion-title"><i class="bi bi-person-vcard"></i>Datos Personales</h5>
            </div>
            <div class="card-body p-4">
                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label fw-bold text-secondary small">Nombre</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-bold text-secondary small">Apellido</label>
                        <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-bold text-secondary small">Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-bold text-secondary small">Teléfono</label>
                        <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-12 text-end mt-3">
                        <asp:Button ID="btnGuardarDatos" runat="server" Text="Guardar Cambios Personales" 
                            CssClass="btn btn-primary px-4" OnClick="btnGuardarDatos_Click" />
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            
            <div class="col-lg-5 mb-4">
                <div class="card gestion-card rounded-3 h-100">
                    <div class="gestion-card-header">
                        <h5 class="gestion-title"><i class="bi bi-stars"></i>Especialidades</h5>
                    </div>
                    <div class="card-body p-4">
                        <p class="text-muted small mb-3">Seleccione las áreas en las que se desempeña el profesional:</p>
                        
                        <asp:UpdatePanel ID="upEspecialidades" runat="server">
                            <ContentTemplate>
                                <div class="bg-white p-3 rounded border mb-3" style="max-height: 300px; overflow-y: auto;">
                                    <asp:CheckBoxList ID="cblEspecialidades" runat="server" 
                                        CssClass="form-check" RepeatLayout="Flow">
                                    </asp:CheckBoxList>
                                </div>
                                
                                <div class="d-grid">
                                    <asp:Button ID="btnGuardarEspecialidades" runat="server" Text="Actualizar Especialidades" 
                                        CssClass="btn btn-success" OnClick="btnGuardarEspecialidades_Click" />
                                </div>
                                
                                <div id="msgEspecialidades" runat="server" visible="false" class="mt-2 text-center bg-success-subtle text-success p-2 rounded small fw-bold">
                                    <i class="bi bi-check-circle me-1"></i> ¡Especialidades actualizadas!
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>

            
            <div class="col-lg-7 mb-4">
                <div class="card gestion-card rounded-3 h-100">
                    <div class="gestion-card-header">
                        <h5 class="gestion-title"><i class="bi bi-calendar-week"></i>Horarios de Atención</h5>
                    </div>
                    <div class="card-body p-4">
                        
                        <asp:UpdatePanel ID="upHorarios" runat="server">
                            <ContentTemplate>
                                
                                <div class="card border-0 shadow-none bg-white mb-4">
                                    <div class="card-body border rounded">
                                        <h6 class="small fw-bold text-uppercase text-primary mb-3">Agregar Nuevo Turno</h6>
                                        <div class="row g-2 align-items-end">
                                            <div class="col-md-4">
                                                <label class="small mb-1 fw-bold text-muted">Día</label>
                                                <asp:DropDownList ID="ddlDia" runat="server" CssClass="form-select form-select-sm">
                                                    <asp:ListItem Text="Lunes" Value="Lunes" />
                                                    <asp:ListItem Text="Martes" Value="Martes" />
                                                    <asp:ListItem Text="Miércoles" Value="Miércoles" />
                                                    <asp:ListItem Text="Jueves" Value="Jueves" />
                                                    <asp:ListItem Text="Viernes" Value="Viernes" />
                                                    <asp:ListItem Text="Sábado" Value="Sábado" />
                                                    <asp:ListItem Text="Domingo" Value="Domingo" />
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-6 col-md-3">
                                                <label class="small mb-1 fw-bold text-muted">Desde</label>
                                                <asp:TextBox ID="txtHoraInicio" runat="server" TextMode="Time" CssClass="form-control form-control-sm"></asp:TextBox>
                                            </div>
                                            <div class="col-6 col-md-3">
                                                <label class="small mb-1 fw-bold text-muted">Hasta</label>
                                                <asp:TextBox ID="txtHoraFin" runat="server" TextMode="Time" CssClass="form-control form-control-sm"></asp:TextBox>
                                            </div>
                                            <div class="col-md-2">
                                                <asp:Button ID="btnAgregarHorario" runat="server" Text="Añadir" CssClass="btn btn-dark btn-sm w-100 fw-bold" OnClick="btnAgregarHorario_Click" />
                                            </div>
                                        </div>
                                        <asp:Label ID="lblErrorHorario" runat="server" CssClass="text-danger small d-block mt-2" Visible="false"></asp:Label>
                                    </div>
                                </div>

                                <h6 class="small fw-bold text-secondary mb-2 ps-1">Grilla Actual:</h6>
                                <div class="table-responsive border rounded bg-white">
                                    <table class="table table-sm table-hover align-middle mb-0">
                                        <thead class="table-light">
                                            <tr>
                                                <th class="ps-3">Día</th>
                                                <th>Horario</th>
                                                <th class="text-end pe-3">Acción</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <asp:Repeater ID="rptHorarios" runat="server" OnItemCommand="rptHorarios_ItemCommand">
                                                <ItemTemplate>
                                                    <tr>
                                                        <td class="ps-3"><span class="badge bg-info text-dark fw-normal border border-info-subtle"><%# Eval("DiaSemana") %></span></td>
                                                        <td class="text-secondary"><%# Eval("HorarioInicio") %> hs - <%# Eval("HorarioFin") %> hs</td>
                                                        <td class="text-end pe-3">
                                                            <asp:LinkButton ID="btnEliminarHorario" runat="server" 
                                                                CommandName="Eliminar" CommandArgument='<%# Eval("IDHorarioAtencion") %>'
                                                                CssClass="btn btn-link text-danger p-0" ToolTip="Eliminar Horario"
                                                                OnClientClick="return confirm('¿Eliminar este rango horario?');">
                                                                Eliminar
                                                            </asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </tbody>
                                    </table>
                                    <% if (rptHorarios.Items.Count == 0) { %>
                                        <div class="text-center text-muted small py-4">
                                            <i class="bi bi-calendar-x d-block fs-4 mb-2 opacity-50"></i>
                                            No hay horarios asignados.
                                        </div>
                                    <% } %>
                                </div>

                            </ContentTemplate>
                        </asp:UpdatePanel>

                    </div>
                </div>
            </div>

        </div>
    </div>

</asp:Content>
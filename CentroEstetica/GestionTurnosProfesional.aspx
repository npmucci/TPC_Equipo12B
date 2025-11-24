<%@ Page Title="Gestión de Turnos" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="GestionTurnosProfesional.aspx.cs" Inherits="CentroEstetica.GestionTurnosProfesional" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5">

        
        <asp:Panel ID="pnlMensaje" runat="server" Visible="false" role="alert">
            <asp:Literal ID="litMensaje" runat="server"></asp:Literal>
        </asp:Panel>

        <div class="card shadow-sm mb-4">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h2 class="h4 mb-0">
                        Turnos de: 
                        <asp:Literal ID="litNombreProfesional" runat="server" Text="Profesional..." />
                    </h2>
                    <asp:Button ID="btnVolver" runat="server" Text="Volver al Panel" 
                        CssClass="btn btn-secondary btn-sm" OnClick="btnVolver_Click" />
                </div>

                <hr />

                <asp:Repeater ID="rptTurnos" runat="server" OnItemCommand="rptTurnos_ItemCommand">
                    <HeaderTemplate>
                        <div class="list-group">
                    </HeaderTemplate>
                <ItemTemplate>
                    <div class="list-group-item list-group-item-action flex-column align-items-start">
                        <div class="d-flex w-100 justify-content-between">
                            <h5 class="mb-1">
                                <strong><%# Eval("FechaString") %> a las <%# Eval("HoraInicio", "{0:hh\\:mm}") %> hs</strong>
                            </h5>
                            
                            <span class="badge bg-primary rounded-pill"><%# Eval("Estado.Descripcion") %></span>
                
                        </div>
                        <p class="mb-1">
                            <strong>Servicio:</strong> <%# Eval("Servicio.Nombre") %> <br />
                            <strong>Cliente:</strong> <%# Eval("Cliente.Nombre") %> <%# Eval("Cliente.Apellido") %>
                        </p>
                        <div class="mt-2">
                            
                            <asp:Button ID="btnDarDeBaja" runat="server" Text="Dar de Baja Turno"
                                CssClass="btn btn-danger btn-sm"
                                CommandName="DarDeBaja" CommandArgument='<%# Eval("IDTurno") %>'
                                OnClientClick="return confirm('¿Está seguro que desea dar de baja este turno? Esta acción no se puede deshacer.');"
                                Visible='<%# (int)Eval("Estado.IDEstado") == 1 || (int)Eval("Estado.IDEstado") == 2 %>' 
                                />
                                </div>
                    </div>
                </ItemTemplate>
                    <FooterTemplate>
                        </div>
                    </FooterTemplate>
                </asp:Repeater>

               
                <asp:Panel ID="pnlNoHayTurnos" runat="server" Visible="false" CssClass="text-center text-muted p-4">
                    <p class="mb-0">Este profesional no tiene turnos pendientes o confirmados.</p>
                </asp:Panel>

            </div>
        </div>

    </div>
</asp:Content>
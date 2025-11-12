<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PanelRecepcionista.aspx.cs" Inherits="CentroEstetica.PanelRecepcionista" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-4">

  
        <ul class="nav nav-tabs" id="tabTurnos" role="tablist">
            <li class="nav-item" role="presentation">
                <asp:LinkButton ID="lnkHoy" runat="server" CssClass="nav-link active" OnClick="lnk_Click">Hoy</asp:LinkButton>
            </li>
            <li class="nav-item" role="presentation">
                <asp:LinkButton ID="lnkProximos" runat="server" CssClass="nav-link" OnClick="lnk_Click">Próximos</asp:LinkButton>
            </li>
            <li class="nav-item" role="presentation">
                <asp:LinkButton ID="lnkPasados" runat="server" CssClass="nav-link" OnClick="lnk_Click">Pasados</asp:LinkButton>
            </li>
        </ul>

        <asp:MultiView ID="mvTurnos" runat="server" ActiveViewIndex="0">

          
            <asp:View ID="viewHoy" runat="server">
                <h2 class="mt-4 mb-3">Turnos de Hoy
                    <small class="text-muted float-end">
                        <asp:Label ID="lblFechaHoy" runat="server" Text=""></asp:Label>
                    </small>
                </h2>
              
                <div class="row">
                    <asp:Repeater ID="rptTurnosActuales" runat="server">
                        <ItemTemplate>
                            <div class="col-12 col-sm-6 col-md-4 col-lg-3 mb-4">
                                <div class="card shadow-sm h-100">
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <div>
                                            <p class="mb-1"><strong>Servicio:</strong> <%# Eval("Servicio.Nombre") %></p>
                                            <p class="mb-1"><strong>Profesional:</strong> <%# Eval("Profesional.Nombre") + " " + Eval("Profesional.Apellido") %></p>
                                            <p class="mb-1"><strong>Paciente:</strong> <%# Eval("Cliente.Nombre") + " " + Eval("Cliente.Apellido") %></p>
                                            <p class="mb-0"><strong>Fecha:</strong> <%# Eval("FechaString") %></p>
                                            <p class="mb-0"><strong>Hora:</strong> <%# Eval("HoraInicio") %></p>
                                            <p class="mb-0"><strong>Estado:</strong> <%# Eval("Estado") %></p>
                                            <p class="mb-0"><strong>Monto:</strong> $<%# Eval("Pago.Monto") %></p>
                                            <p class="mb-0"><strong>Tipo de Pago:</strong> <%# Eval("Pago.Tipo") %></p>
                                            <p class="mb-0"><strong>Forma de Pago:</strong> <%# Eval("Pago.FormaDePago") %></p>
                                            <p class="mb-0"><strong>Fecha de Pago:</strong> <%# Eval("Pago.FechaPago") %></p>
                                        </div>
                                        <div class="d-flex flex-column gap-1 mt-3">
                                            <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-danger btn-sm" CommandArgument='<%# Eval("IDTurno") %>' CommandName="Cancelar" />
                                            <asp:Button ID="btnModificar" runat="server" Text="Modificar" CssClass="btn btn-outline-primary btn-sm" CommandArgument='<%# Eval("IDTurno") %>' CommandName="Modificar" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </asp:View>

        
            <asp:View ID="viewProximos" runat="server">
                <h2 class="mt-4 mb-3">Próximos Turnos</h2>
                <div class="row">
                    
                    <asp:Repeater ID="rptTurnosProximos" runat="server">
                        <ItemTemplate>
                      
                            <div class="col-12 col-sm-6 col-md-4 col-lg-3 mb-4">
                                <div class="card shadow-sm h-100 border-primary">
                                    <div class="card-body">
                                         <p class="text-primary">Próximo: <%# Eval("FechaString") %></p>
                                        <p class="mb-1"><strong>Servicio:</strong> <%# Eval("Servicio.Nombre") %></p>
                                        <p class="mb-1"><strong>Profesional:</strong> <%# Eval("Profesional.Nombre") + " " + Eval("Profesional.Apellido") %></p>
                                        <p class="mb-1"><strong>Paciente:</strong> <%# Eval("Cliente.Nombre") + " " + Eval("Cliente.Apellido") %></p>
                                 
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </asp:View>

      
            <asp:View ID="viewPasados" runat="server">
                <h2 class="mt-4 mb-3">Turnos Pasados</h2>
                <div class="row">
                    <asp:Repeater ID="rptTurnosPasados" runat="server">
                        <ItemTemplate>
                            <div class="col-12 col-sm-6 col-md-4 col-lg-3 mb-4">
                                <div class="card shadow-sm h-100 bg-light">
                                    <div class="card-body">
                                        <p class="mb-1"><strong>Servicio:</strong> <%# Eval("Servicio.Nombre") %></p>
                                        <p class="mb-1"><strong>Profesional:</strong> <%# Eval("Profesional.Nombre") + " " + Eval("Profesional.Apellido") %></p>
                                        <p class="mb-1"><strong>Paciente:</strong> <%# Eval("Cliente.Nombre") + " " + Eval("Cliente.Apellido") %></p>
                                        <p class="mb-0"><strong>Fecha:</strong> <%# Eval("FechaString") %></p>
                                        <p class="mb-0"><strong>Estado:</strong> <%# Eval("Estado") %></p>
                                        <p class="mb-0 text-success"><strong>Monto:</strong> $<%# Eval("Pago.Monto") %></p>
                                     
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </asp:View>

        </asp:MultiView>
    
        
        <!-- SECCIÓN SACAR NUEVO TURNO (Fuera de las pestañas) -->
        <h3 class="mt-5 border-top pt-4">Sacar Nuevo Turno</h3>
        <div class="row row-cols-md-3 row-cols-1 g-3">
            <div class="col">
                <label>Paciente:</label>
                <asp:DropDownList ID="ddlPacientes" runat="server" CssClass="form-select"></asp:DropDownList>
            </div>
            <div class="col">
                <label>Profesional:</label>
                <asp:DropDownList ID="ddlProfesionales" runat="server" CssClass="form-select"></asp:DropDownList>
            </div>
            <div class="col">
                <label>Servicio:</label>
                <asp:DropDownList ID="ddlServicios" runat="server" CssClass="form-select"></asp:DropDownList>
            </div>
            <div class="col">
                <label>Fecha:</label>
                <asp:TextBox ID="txtFecha" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col">
                <label>Hora:</label>
                <asp:TextBox ID="txtHoraInicio" runat="server" TextMode="Time" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col">
                <label>Forma Pago:</label>
                <asp:DropDownList ID="ddlFormaPago" runat="server" CssClass="form-select"></asp:DropDownList>
            </div>
            <div class="col-12 mt-4">
                <asp:Button ID="btnConfirmarTurno" runat="server" Text="Confirmar Turno" CssClass="btn btn-success w-100" />
            </div>
        </div>

    </div>

</asp:Content>

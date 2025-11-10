<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PanelSecretaria.aspx.cs" Inherits="CentroEstetica.PanelSecretaria" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <h3>Turnos Pasados</h3>
<asp:Repeater ID="rptTurnosPasados" runat="server">
    <ItemTemplate>
        <div class="mb-5">
            <div class="d-flex flex-column gap-3">
                <div class="card shadow-sm">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <p class="mb-1"><strong>Servicio:</strong> <%# Eval("Servicio") %></p>
                            <p class="mb-1"><strong>Profesional:</strong> <%# Eval("Profesional") %></p>
                            <p class="mb-1"><strong>Paciente:</strong> <%# Eval("Paciente") %></p>
                            <p class="mb-0"><strong>Fecha:</strong> <%# Eval("FechaString") %></p>
                            <p class="mb-0"><strong>Hora:</strong> <%# Eval("HoraInicio") %></p>
                            <p class="mb-0"><strong>Estado:</strong> <%# Eval("Estado") %></p>
                            <p class="mb-0"><strong>Monto:</strong> $<%# Eval("Monto") %></p>
                            <p class="mb-0"><strong>Tipo de Pago:</strong> <%# Eval("TipoPago") %></p>
                            <p class="mb-0"><strong>Forma de Pago:</strong> <%# Eval("FormaPago") %></p>
                            <p class="mb-0"><strong>Forma de Pago:</strong> <%# Eval("FechaPago") %></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>

<h3>Turnos Actuales</h3>
<asp:Repeater ID="rptTurnosActuales" runat="server">
    <ItemTemplate>
        <div class="mb-5">
            <div class="d-flex flex-column gap-3">
                <div class="card shadow-sm">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <p class="mb-1"><strong>Servicio:</strong> <%# Eval("Servicio") %></p>
                            <p class="mb-1"><strong>Profesional:</strong>  <%# Eval("NombreProfesional") + " " + Eval("ApellidoProfesional") %></p>
                            <p class="mb-1"><strong>Paciente:</strong> <%# Eval("NombreCliente") + " " + Eval("ApellidoCliente") %></p>
                            <p class="mb-0"><strong>Fecha:</strong> <%# Eval("FechaString") %></p>
                            <p class="mb-0"><strong>Hora:</strong> <%# Eval("HoraInicio") %></p>
                            <p class="mb-0"><strong>Estado:</strong> <%# Eval("Estado") %></p>
                            <p class="mb-0"><strong>Monto:</strong> $<%# Eval("Monto") %></p>
                            <p class="mb-0"><strong>Tipo de Pago:</strong> <%# Eval("TipoPago") %></p>
                            <p class="mb-0"><strong>Forma de Pago:</strong> <%# Eval("FormaPago") %></p>
                             <p class="mb-0"><strong>Forma de Pago:</strong> <%# Eval("FechaPago") %></p>
                        </div>
                        <div class="d-flex flex-column gap-1">
                            <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-danger btn-sm"/>
                            <asp:Button ID="btnModificar" runat="server" Text="Modificar" CssClass="btn btn-warning btn-sm"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>

    <h3 class="mt-4">Sacar nuevo turno</h3>
<div class="mb-2">
    <label>Paciente:</label>
    <asp:DropDownList ID="ddlPacientes" runat="server" CssClass="form-select"></asp:DropDownList>
</div>
<div class="mb-2">
    <label>Profesional:</label>
    <asp:DropDownList ID="ddlProfesionales" runat="server" CssClass="form-select"></asp:DropDownList>
</div>
<div class="mb-2">
    <label>Servicio:</label>
    <asp:DropDownList ID="ddlServicios" runat="server" CssClass="form-select"></asp:DropDownList>
</div>
<div class="mb-2">
    <label>Fecha:</label>
    <asp:TextBox ID="txtFecha" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
</div>
<div class="mb-2">
    <label>Hora:</label>
    <asp:TextBox ID="txtHoraInicio" runat="server" TextMode="Time" CssClass="form-control"></asp:TextBox>
</div>
<div class="mb-2">
    <label>Forma Pago:</label>
    <asp:DropDownList ID="ddlFormaPago" runat="server" CssClass="form-select"></asp:DropDownList>
</div>
<div class="mb-3">
    <asp:Button ID="btnConfirmarTurno" runat="server" Text="Confirmar turno"  CssClass="btn btn-success"/>
</div>


</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PanelRecepcionista.aspx.cs" Inherits="CentroEstetica.PanelRecepcionista" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- TURNOS PASADOS -->
     <div class="accordion mb-4" id="accordionTurnosPasados">
        <div class="accordion-item">
            <h3 class="accordion-header" id="headingPasados">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapsePasados" aria-expanded="false" aria-controls="collapsePasados">
                    Turnos Pasados
                </button>
            </h3>
            <div id="collapsePasados" class="accordion-collapse collapse" aria-labelledby="headingPasados" data-bs-parent="#accordionTurnosPasados">
                <div class="accordion-body">
                    <div class="row">
                        <asp:Repeater ID="rptTurnosPasados" runat="server">
                            <ItemTemplate>
                                <div class="col-12 col-sm-6 col-md-3 col-lg-3 mb-4">
                                    <div class="card shadow-sm h-100">
                                        <div class="card-body">
                                            <p class="mb-1"><strong>Servicio:</strong> <%# Eval("Servicio.Nombre") %></p>
                                            <p class="mb-1"><strong>Profesional:</strong> <%# Eval("Profesional.Nombre") + " " + Eval("Profesional.Apellido") %></p>
                                            <p class="mb-1"><strong>Paciente:</strong> <%# Eval("Cliente.Nombre") + " " + Eval("Cliente.Apellido") %></p>
                                            <p class="mb-0"><strong>Fecha:</strong> <%# Eval("FechaString") %></p>
                                            <p class="mb-0"><strong>Hora:</strong> <%# Eval("HoraInicio") %></p>
                                            <p class="mb-0"><strong>Estado:</strong> <%# Eval("Estado") %></p>
                                            <p class="mb-0"><strong>Monto:</strong> $<%# Eval("Pago.Monto") %></p>
                                            <p class="mb-0"><strong>Tipo de Pago:</strong> <%# Eval("Pago.Tipo") %></p>
                                            <p class="mb-0"><strong>Forma de Pago:</strong> <%# Eval("Pago.FormaDePago") %></p>
                                            <p class="mb-0"><strong>Fecha Pago:</strong> <%# Eval("Pago.FechaPago") %></p>
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

    <!-- TURNOS ACTUALES -->
    <h3>Turnos Actuales</h3>
    <div class="row">
        <asp:Repeater ID="rptTurnosActuales" runat="server">
            <ItemTemplate>
                <div class="col-12 col-sm-6 col-md-3 col-lg-3 mb-4">
                    <div class="card shadow-sm h-100">
                        <div class="card-body d-flex flex-column justify-content-between">
                            <div>
                                <p class="mb-1"><strong>Servicio:</strong> <%# Eval("Servicio.Nombre") %></p>
                                <p class="mb-1"><strong>Profesional:</strong> <%# Eval("Profesional.Nombre") + " " + Eval("Profesional.Apellido") %></p>
                                <p class="mb-1"><strong>Paciente:</strong> <%# Eval("Cliente.Nombre") + " " + Eval("Cliente.Apellido")  %></p>
                                <p class="mb-0"><strong>Fecha:</strong> <%# Eval("FechaString") %></p>
                                <p class="mb-0"><strong>Hora:</strong> <%# Eval("HoraInicio") %></p>
                                <p class="mb-0"><strong>Estado:</strong> <%# Eval("Estado") %></p>
                                <p class="mb-0"><strong>Monto:</strong> $<%# Eval("Pago.Monto") %></p>
                                <p class="mb-0"><strong>Tipo de Pago:</strong> <%# Eval("Pago.Tipo") %></p>
                                <p class="mb-0"><strong>Forma de Pago:</strong> <%# Eval("Pago.FormaDePago") %></p>
                                <p class="mb-0"><strong>Fecha de Pago:</strong> <%# Eval("Pago.FechaPago") %></p>
                            </div>
                            <div class="d-flex flex-column gap-1 mt-3">
                                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn-custom btn-sm " />
                                <asp:Button ID="btnModificar" runat="server" Text="Modificar" CssClass="btn-custom  btn-sm" />
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <!-- NUEVO TURNO -->
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
        <asp:Button ID="btnConfirmarTurno" runat="server" Text="Confirmar turno" CssClass="btn btn-success" />
    </div>

</asp:Content>

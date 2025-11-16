<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PanelCliente.aspx.cs" Inherits="CentroEstetica.PanelCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container py-5">

        <!-- PERFIL DEL CLIENTE -->

        <h2 class="h4 mb-3">Mi Perfil</h2>


        <!-- TURNOS Pasados-->
        <h3>Turnos Pasados</h3>
        <asp:Repeater ID="rptTurnosPasados" runat="server">
            <ItemTemplate>

                <div class="mb-5">
                    <div class="d-flex flex-column gap-3">
                        <div class="card shadow-sm">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <p class="mb-1"><strong>Servicio:</strong> <%# Eval("Servicio.Nombre") %></p>
                                    <p class="mb-1"><strong>Profesional:</strong> <%# Eval("Profesional.Nombre") + " " + Eval("Profesional.Apellido") %></p>
                                    <p class="mb-0"><strong>Fecha y Hora:</strong> <%# Eval("FechaString") + " " + Eval("HoraInicio") %></p>
                                    <p class="mb-0"><strong>Estado</strong> <%# Eval("Estado") %></p>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <!-- TURNOS Actuales-->
        <h3>Turnos Actuales</h3>
        <asp:Repeater ID="rptTurnosActuales" runat="server">
            <ItemTemplate>

                <div class="mb-5">
                    <div class="d-flex flex-column gap-3">
                        <div class="card shadow-sm">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <p class="mb-1"><strong>Servicio:</strong> <%# Eval("Servicio.Nombre") %></p>
                                    <p class="mb-1"><strong>Profesional:</strong> <%# Eval("Profesional.Nombre") + " " + Eval("Profesional.Apellido") %></p>
                                    <p class="mb-0"><strong>Fecha y Hora:</strong> <%# Eval("FechaString") + " " + Eval("HoraInicio") %></p>
                                    <p class="mb-0"><strong>Estado</strong> <%# Eval("Estado") %></p>
                                </div>
                                <button class="btn btn-danger btn-sm">Cancelar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>

        </asp:Repeater>

    </div>


</asp:Content>

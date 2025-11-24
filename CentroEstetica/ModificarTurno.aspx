<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ModificarTurno.aspx.cs" Inherits="CentroEstetica.ModificarTurno" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">

    <h3 class="mb-4">Modificar Turno</h3>

    <!-- DATOS DEL TURNO (SOLO LECTURA) -->
    <div class="card mb-4">
        <div class="card-header bg-info text-white">
            Datos del Turno
        </div>
        <div class="card-body">

            <p><strong>Fecha:</strong> <asp:Label ID="lblFecha" runat="server" /></p>
            <p><strong>Hora:</strong> <asp:Label ID="lblHora" runat="server" /></p>
            <p><strong>Servicio:</strong> <asp:Label ID="lblServicio" runat="server" /></p>

            <p><strong>Profesional:</strong> <asp:Label ID="lblProfesional" runat="server" /></p>
            <p><strong>Cliente:</strong> <asp:Label ID="lblCliente" runat="server" /></p>

            <p><strong>Estado actual:</strong> <asp:Label ID="lblEstadoActual" runat="server" /></p>

        </div>
    </div>


    <!-- MODIFICAR ESTADO -->
    <div class="card mb-4">
        <div class="card-header bg-warning text-white">
            Modificar Estado
        </div>
        <div class="card-body">

            <asp:DropDownList ID="ddlEstado" CssClass="form-select" runat="server"></asp:DropDownList>

            <asp:Button ID="btnGuardarEstado" runat="server" CssClass="btn btn-primary mt-3"
                Text="Guardar Estado" OnClick="btnGuardarEstado_Click" />

        </div>
    </div>


    <!-- PAGOS DEL TURNO -->
    <div class="card mb-4">
        <div class="card-header bg-success text-white">
            Pagos Registrados
        </div>
        <div class="card-body">

            <asp:Repeater ID="repPagos" runat="server">
                <ItemTemplate>
                    <div class="border rounded p-2 mb-2">
                        <p><strong>Monto:</strong> <%# Eval("Monto", "{0:C}") %></p>
                        <p><strong>Tipo:</strong> <%# Eval("Tipo") %></p>
                        <p><strong>Forma:</strong> <%# Eval("FormaDePago") %></p>
                        <p><strong>Fecha:</strong> <%# Convert.ToDateTime(Eval("Fecha")).ToString("dd/MM/yyyy") %></p>
                        <p><strong>Es devolución:</strong> <%# (bool)Eval("EsDevolucion") ? "Sí" : "No" %></p>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

        </div>
    </div>


    <!-- AGREGAR PAGO -->
    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            Registrar Pago
        </div>
        <div class="card-body">

            <label>Monto</label>
            <asp:TextBox ID="txtMonto" runat="server" CssClass="form-control"></asp:TextBox>

            <label class="mt-2">Tipo de Pago</label>
            <asp:DropDownList ID="ddlTipoPago" runat="server" CssClass="form-select"></asp:DropDownList>

            <label class="mt-2">Forma de Pago</label>
            <asp:DropDownList ID="ddlFormaPago" runat="server" CssClass="form-select"></asp:DropDownList>

            <asp:Button ID="btnAgregarPago" runat="server" Text="Agregar Pago" CssClass="btn btn-success mt-3"
                OnClick="btnAgregarPago_Click" />

        </div>
    </div>


    <!-- DEVOLUCIÓN -->
    <div class="card mb-4">
        <div class="card-header bg-danger text-white">
            Registrar Devolución
        </div>
        <div class="card-body">

            <label>Monto a devolver</label>
            <asp:TextBox ID="txtMontoDevolucion" runat="server" CssClass="form-control"></asp:TextBox>

            <asp:Button ID="btnRegistrarDevolucion" runat="server" Text="Registrar Devolución"
                CssClass="btn btn-danger mt-3" OnClick="btnRegistrarDevolucion_Click" />

        </div>
    </div>

    <a href="PanelRecepcionista.aspx" class="btn btn-secondary">Volver</a>

</div>
</asp:Content>

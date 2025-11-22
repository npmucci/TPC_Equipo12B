<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PanelRecepcionista.aspx.cs" Inherits="CentroEstetica.PanelRecepcionista" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="container mt-4 mb-3">
        <h2><asp:Label ID="lblBienvenida" runat="server" Text="¡Bienvenido/a!"></asp:Label></h2>
    </div>

    <div class="container d-flex justify-content-between align-items-baseline mb-5">
        <div class="p-2">
            <h4><asp:Label ID="lblNombre" runat="server" Text="JUAN"></asp:Label></h4>
        </div>
        <div class="p-2">
            <h4><asp:Label ID="lblFechaHoy" runat="server" Text=""></asp:Label></h4>
        </div>
    </div>

   
<asp:GridView ID="dgvTurnos" runat="server" DataKeyNames="IDTurno" CssClass="table table-striped table-hover" AutoGenerateColumns="false" 
    AllowPaging="True" PageSize="5" OnRowCommand="dgvTurnos_RowCommand" OnPageIndexChanging="dgvTurnos_PageIndexChanging">
        <Columns>
            <asp:BoundField HeaderText="Hora" DataField="HoraInicio" />
            <asp:BoundField HeaderText="Paciente" DataField="ClienteNombreCompleto" />
            <asp:BoundField HeaderText="Servicio" DataField="Servicio.Nombre" />
            <asp:BoundField HeaderText="Profesional" DataField="ProfesionalNombreCompleto" />
            <asp:BoundField HeaderText="Estado" DataField="Estado" />
            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="">
                <ItemTemplate>
                    <asp:LinkButton ID="btnVerDetalle" runat="server" CommandName="VerDetalle" CommandArgument='<%# Eval("IDTurno") %>' ToolTip="Ver detalles del turno" CssClass="text-primary"> Ver Detalle </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="">
                <ItemTemplate>
                    <asp:LinkButton ID="btnModificar" runat="server" CommandName="Modificar" CommandArgument='<%# Eval("IDTurno") %>' ToolTip="Modificar" CssClass="text-warning"> Modificar </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <div class="modal fade" id="detalleModal" tabindex="-1" aria-labelledby="detalleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">            
            <div class="modal-header bg-info text-white">     
                <button type="button" class="btn-custom" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>            
            <div class="modal-body">                
                <p><strong>Fecha:</strong> <asp:Label ID="lblDetalleFecha" runat="server" /></p>
                <p><strong>Hora:</strong> <asp:Label ID="lblDetalleHora" runat="server" /></p>
                <p><strong>Servicio:</strong> <asp:Label ID="lblDetalleServicioNombre" runat="server" /></p>
                <p><strong>Estado Actual:</strong> <asp:Label ID="lblDetalleEstado" runat="server" /></p>  
                <p><strong>Nombre Completo:</strong> <asp:Label ID="lblDetalleClienteNombre" runat="server" /></p>
                <p><strong>Monto Pagado:</strong> <asp:Label ID="lblDetalleMonto" runat="server" /></p>
                <p><strong>Tipo de Pago:</strong> <asp:Label ID="lblDetalleTipoPago" runat="server" /></p>
                <p><strong>Forma de Pago:</strong> <asp:Label ID="lblDetalleFormaPago" runat="server" /></p>
                <p><strong>Fecha de Pago:</strong> <asp:Label ID="lblDetalleFechaPago" runat="server" /></p>
            </div>            
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
            
        </div>
    </div>
</div>

</asp:Content>

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
                    <asp:LinkButton ID="btnVerPagos" runat="server" CommandName="VerPagos" CommandArgument='<%# Eval("IDTurno") %>' ToolTip="Ver Pagos del turno" CssClass="text-primary"> Ver Pagos </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="">
                <ItemTemplate>
                    <asp:LinkButton ID="btnModificar" runat="server" CommandName="Modificar" CommandArgument='<%# Eval("IDTurno") %>' ToolTip="Modificar" CssClass="text-warning"> Modificar </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

   <div class="modal fade" id="pagoModal" tabindex="-1" aria-labelledby="pagoModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-md">  
        <div class="modal-content">

            <div class="modal-header ">
                <h5 class="modal-title">Pagos del Turno</h5>
            </div>

            <div class="modal-body" style="max-height: 300px; overflow-y: auto;">
                <asp:Repeater ID="repPagos" runat="server">
                    <ItemTemplate>
                        <div class="border rounded p-2 mb-2">
                            <p><strong>Monto:</strong> <%# Eval("Monto","{0:C}") %></p>
                            <p><strong>Tipo:</strong> <%# Eval("Tipo") %></p>
                            <p><strong>Forma:</strong> <%# Eval("FormaDePago") %></p>
                            <p><strong>Fecha:</strong> <%# Convert.ToDateTime(Eval("Fecha")).ToString("dd/MM/yyyy") %></p>
                            <p><strong>Es devolución:</strong> <%# (bool)Eval("EsDevolucion") ? "Sí" : "No" %></p>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>

        </div>
    </div>
</div>


</asp:Content>

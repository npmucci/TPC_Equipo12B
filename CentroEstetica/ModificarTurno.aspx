<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ModificarTurno.aspx.cs" Inherits="CentroEstetica.ModificarTurno" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4 mb-5">
    
    <h3 class="mb-4 fw-bold text-dark"><i class="bi bi-calendar-check me-2"></i> Gestión de Turno</h3>
    <div class="row g-4">
        <div class="col-md-5">
            <div class="card shadow-sm border-0 rounded-4 h-100">                
                <div class="card-header fw-bold border-0 pt-3" style="background-color: var(--colorPrincipal); color: var(--colorTexto);"> Detalles del Turno
                </div>                
                <div class="card-body p-4">                    
                    <div class="mb-4 pb-3 border-bottom">
                        <div class="row g-2">
                            <div class="col-12">
                                <h5 class="fw-bold mb-1"><asp:Label ID="lblServicio" runat="server" /></h5>
                            </div>
                            <div class="col-12">
                                <span class="badge bg-secondary-subtle text-secondary me-2">
                                     <asp:Label ID="lblFecha" runat="server" /> - <asp:Label ID="lblHora" runat="server" />
                                </span>
                            </div>
                        </div>
                        <div class="mt-3 small">
                            <p class="mb-1"><strong>Profesional:</strong> <asp:Label ID="lblProfesional" runat="server" /></p>
                            <p class="mb-1"><strong>Cliente:</strong> <asp:Label ID="lblCliente" runat="server" /></p>
                        </div>
                    </div>

                    <div class="mt-4">
                        <h6 class="fw-bold text-muted text-uppercase small">Estado y Acciones</h6>
                        
                        <div class="d-flex align-items-center mb-3">
                            <strong class="me-2">Estado Actual:</strong>
                            <span class='badge bg-info text-white fs-6'>
                                <asp:Label ID="lblEstadoActual" runat="server" />
                            </span>
                        </div>

                        <label class="form-label small fw-bold">Cambiar Estado:</label>
                        <asp:DropDownList ID="ddlEstado" CssClass="form-select form-select-sm" runat="server"></asp:DropDownList>
                        <asp:Button ID="btnGuardarEstado" runat="server"  CssClass="btn btn-sm mt-3 fw-bold" Text="Guardar Estado" OnClick="btnGuardarEstado_Click" style="background-color: var(--colorPrincipalHover); color: white;" />
                     </div>
                </div>
            </div>
        </div>
        <div class="col-md-7">            
            <div class="card shadow-sm border-0 rounded-4 mb-4">
                <div class="card-header fw-bold border-0 pt-3"   style="background-color: var(--colorFondoOpcional); color: var(--colorTexto);">
                   Historial de Pagos
                </div>
                <div class="card-body p-4" style="max-height: 250px; overflow-y: auto;">                    
                    <asp:Repeater ID="repPagos" runat="server">
                        <ItemTemplate>
                            <div class="d-flex justify-content-between align-items-center p-2 mb-2 rounded border" style="background-color: <%# (bool)Eval("EsDevolucion") ? "var(--colorPrincipal)" : "var(--colorFondoClaro)" %>;">
                                 <div class="small">
                                    <span class="fw-bold text-dark me-3">
                                        <%# (bool)Eval("EsDevolucion") ? "DEVOLUCIÓN" : "PAGO" %>
                                    </span>
                                    <span class="text-muted">
                                        <%# Convert.ToDateTime(Eval("Fecha")).ToString("dd/MM/yyyy") %> - <%# Eval("FormaDePago.Descripcion") %>
                                    </span>
                                </div>
                                <div class="fw-bold text-end" style="color: <%# (bool)Eval("EsDevolucion") ? "red" : "green" %>;">
                                    <%# Eval("Monto", "{0:C}") %>
                                </div>
                            </div>
                        </ItemTemplate>                       
                    </asp:Repeater>

                </div>
            </div>
<div class="card-body p-4">

    <asp:Panel ID="pnlRegistrarPago" runat="server" Visible="false">
        <h6 class="fw-bold text-dark mb-3">Registrar Pago/Seña</h6>

        <div class="row g-3">
            <div class="col-md-4">
                <label class="form-label small fw-bold">Monto</label>
                <asp:TextBox ID="txtMonto" runat="server" CssClass="form-control form-control-sm" TextMode="Number"></asp:TextBox>
            </div>
            <div class="col-md-4">
                <label class="form-label small fw-bold">Tipo de Pago</label>
                <asp:DropDownList ID="ddlTipoPago" runat="server" CssClass="form-select form-select-sm"></asp:DropDownList>
            </div>
            <div class="col-md-4">
                <label class="form-label small fw-bold">Forma de Pago</label>
                <asp:DropDownList ID="ddlFormaPago" runat="server" CssClass="form-select form-select-sm"></asp:DropDownList>
            </div>
        </div>
        
        <asp:Button ID="btnAgregarPago" runat="server"    Text="Agregar Pago"  CssClass="btn btn-sm btn-success mt-4 fw-bold"   OnClick="btnAgregarPago_Click" />
    </asp:Panel>
    <asp:Panel ID="pnlRegistrarDevolucion" runat="server" Visible="false"> <h6 class="fw-bold text-danger mb-3">Gestión de Devolución</h6>        <label class="form-label small fw-bold">Monto a devolver</label>
        <asp:TextBox ID="txtMontoDevolucion" runat="server" CssClass="form-control form-control-sm mb-3" TextMode="Number"></asp:TextBox>
        <asp:Button ID="btnRegistrarDevolucion" runat="server"   Text="Registrar Devolución" CssClass="btn btn-danger mt-1 fw-bold"  OnClick="btnRegistrarDevolucion_Click" 
            OnClientClick="return confirm('¿Confirma que desea registrar esta devolución?');" />
    </asp:Panel>

</div>

    <div class="text-center mt-5">
        <a href="PanelRecepcionista.aspx" class="btn btn-secondary px-5 rounded-pill"> Volver al Panel </a>
    </div>

</div>
</asp:Content>

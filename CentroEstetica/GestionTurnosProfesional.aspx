<%@ Page Title="Gestión de Turnos" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="GestionTurnosProfesional.aspx.cs" Inherits="CentroEstetica.GestionTurnosProfesional" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5">

        <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <asp:Literal ID="litMensaje" runat="server"></asp:Literal>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </asp:Panel>

        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h4 class="fw-bold mb-0 text-secondary">Agenda Profesional</h4>
                <h5 class="text-primary mb-0"><asp:Literal ID="litNombreProfesional" runat="server"></asp:Literal></h5>
            </div>
            <asp:Button ID="btnVolver" runat="server" Text="← Volver al Panel" 
                CssClass="btn btn-outline-secondary btn-sm rounded-pill px-3" OnClick="btnVolver_Click" CausesValidation="false" />
        </div>

        <div class="card shadow-sm border-0 rounded-4 mb-4">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <asp:GridView ID="dgvTurnos" runat="server" CssClass="table table-hover align-middle mb-0" 
                        AutoGenerateColumns="false" DataKeyNames="IDTurno" OnRowCommand="dgvTurnos_RowCommand"
                        EmptyDataText="No hay turnos pendientes para este profesional." EmptyDataRowStyle-CssClass="text-muted text-center py-4">
                        <Columns>
                            <asp:BoundField HeaderText="Fecha" DataField="FechaString" ItemStyle-CssClass="ps-4" HeaderStyle-CssClass="ps-4"/>
                            <asp:BoundField HeaderText="Hora" DataField="HoraInicio" DataFormatString="{0:hh\:mm} hs" />
                            <asp:BoundField HeaderText="Servicio" DataField="Servicio.Nombre" />
                            <asp:BoundField HeaderText="Cliente" DataField="ClienteNombreCompleto" />
                            
                            <asp:TemplateField HeaderText="Estado">
                                <ItemTemplate>
                                    <span class='badge rounded-pill <%# (string)Eval("Estado.Descripcion") == "Confirmado" ? "bg-success" : "bg-warning text-dark" %>'>
                                        <%# Eval("Estado.Descripcion") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Acción" ItemStyle-HorizontalAlign="Left" HeaderStyle-CssClass="pe-4" ItemStyle-CssClass="pe-4">
                                <ItemTemplate>
                                    <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" 
                                        CssClass="btn btn-outline-danger btn-sm fw-bold" 
                                        CommandName="PreCancelar" CommandArgument='<%# Eval("IDTurno") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="table-light text-uppercase small fw-bold text-secondary" />
                    </asp:GridView>
                </div>
            </div>
        </div>

        <asp:Panel ID="pnlProcesoCancelacion" runat="server" Visible="false" CssClass="card border-danger shadow rounded-4 border-start border-4">
            <div class="card-header bg-white border-0 pt-4 px-4">
                <h5 class="text-danger fw-bold"><i class="bi bi-exclamation-triangle-fill me-2"></i>Procesar Cancelación y Devolución</h5>
            </div>
            <div class="card-body p-4">
                
                <asp:HiddenField ID="hfIdTurnoCancelar" runat="server" />

                <div class="row g-4">
                    <div class="col-md-5 border-end">
                        <div class="alert alert-light border d-flex align-items-center justify-content-between">
                            <div>
                                <small class="text-muted d-block text-uppercase fw-bold">Monto a Devolver</small>
                                <h2 class="mb-0 text-dark fw-bold"><asp:Label ID="lblMontoDevolucion" runat="server" Text="$0"></asp:Label></h2>
                            </div>
                            <i class="bi bi-wallet2 fs-1 text-secondary opacity-25"></i>
                        </div>
                        <p class="small text-muted">
                            Este turno tiene un pago registrado. Al cancelarlo por decisión administrativa, corresponde el reintegro total.
                        </p>
                    </div>

                    <div class="col-md-7 ps-md-4">
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold small text-secondary">Medio de Devolución</label>
                            <asp:DropDownList ID="ddlFormaDevolucion" runat="server" CssClass="form-select" 
                                AutoPostBack="true" OnSelectedIndexChanged="ddlFormaDevolucion_SelectedIndexChanged">
                                <asp:ListItem Text="Transferencia Bancaria" Value="Transferencia" />
                                <asp:ListItem Text="Efectivo (Caja)" Value="Efectivo" />
                            </asp:DropDownList>
                        </div>

                        <asp:Panel ID="pnlComprobante" runat="server">
                            <div class="mb-3">
                                <label class="form-label fw-bold small text-secondary">N° de Operación / Transferencia</label>
                                <asp:TextBox ID="txtComprobanteDevolucion" runat="server" CssClass="form-control" placeholder="Ej: 8261941915"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvComprobante" runat="server" ControlToValidate="txtComprobanteDevolucion" 
                                    ValidationGroup="GrupoDevolucion" ErrorMessage="Ingresá el número de operación." 
                                    CssClass="text-danger small d-block mt-1" Display="Dynamic" />
                            </div>
                        </asp:Panel>

                        <div class="d-flex gap-2 justify-content-end mt-4">
                            <asp:Button ID="btnCerrarPanel" runat="server" Text="No cancelar" 
                                CssClass="btn btn-light text-secondary fw-bold" OnClick="btnCerrarPanel_Click" CausesValidation="false" />
                            
                            <asp:Button ID="btnConfirmarCancelacion" runat="server" Text="Confirmar Devolución" 
                                CssClass="btn btn-danger fw-bold px-4" OnClick="btnConfirmarCancelacion_Click" ValidationGroup="GrupoDevolucion" />
                        </div>

                    </div>
                </div>

            </div>
        </asp:Panel>

    </div>
</asp:Content>
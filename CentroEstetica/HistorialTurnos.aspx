<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="HistorialTurnos.aspx.cs" Inherits="CentroEstetica.HistorialTurnos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid dashboard-container">
        <div class="row">

            <div class="col-lg-2 col-xl-2 mb-4">
                <div class="sticky-top" style="top: 90px; z-index: 1;">
                    <h5 class="text-muted text-uppercase mb-3 ms-2 small fw-bold">Menú</h5>

                    <div class="nav flex-column nav-pills me-3" id="v-pills-tab-recepcionista" role="tablist" aria-orientation="vertical">
                        <button class="nav-link active" id="v-pills-historial-tab" data-bs-toggle="pill" data-bs-target="#v-pills-historial" type="button" role="tab" aria-controls="v-pills-historial" aria-selected="true">
                            Historial Turnos 
                        </button>

                        <asp:HyperLink ID="lnkVolver" runat="server" NavigateUrl="~/PanelRecepcionista.aspx" CssClass="nav-link">
                             Volver al Panel 
                        </asp:HyperLink>
                    </div>
                </div>
            </div>

            <div class="col-lg-10 col-xl-10">
                <div class="content-area tab-content" id="v-pills-tabContent-recepcionista">

                    <div class="tab-pane fade show active" id="v-pills-historial" role="tabpanel" aria-labelledby="v-pills-historial-tab" tabindex="0">

                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div>
                                <h2 class="fw-bold mb-1 text-dark">
                                    <asp:Label ID="lblBienvenida" runat="server" Text="¡Bienvenido/a!"></asp:Label>
                                </h2>
                                <h5 class="text-muted fw-normal">
                                    <asp:Label ID="lblNombre" runat="server" Text=""></asp:Label>
                                </h5>
                            </div>
                            <div class="text-end">
                                <span class="lblfecha border px-3 py-2 fs-6 text-white">
                                    <asp:Label ID="lblFechaHoy" runat="server"></asp:Label>
                                </span>
                            </div>
                        </div>

                        <h3 class="mb-4 fw-bold text-dark"><i class="bi bi-archive me-2"></i>Historial de Turnos</h3>

                        <div class="card shadow-sm border-0 rounded-4 mb-4">
                            <div class="card-header fw-bold border-0 pt-3"
                                style="background-color: var(--colorPrincipal); color: var(--colorTexto);">
                                Opciones de Filtrado
                            </div>

                            <div class="card-body p-4">
                                <asp:Label Text="Búsqueda Rápida" runat="server" CssClass="form-label small fw-bold" />
                                <asp:TextBox runat="server" ID="txtFiltro" CssClass="form-control mb-4"
                                    AutoPostBack="true" OnTextChanged="filtro_TextChanged"
                                    placeholder="Buscar por cliente, profesional o servicio..." />


                                <div>
                                    <asp:CheckBox CssClass="form-check-input"
                                        ID="chkAvanzado" runat="server" AutoPostBack="true"
                                        OnCheckedChanged="chkAvanzado_CheckedChanged" />
                                    <label class="form-check-label small fw-bold text-muted" for="<%= chkAvanzado.ClientID %>">Filtros</label>
                                </div>

                                <%if (chkAvanzado.Checked)
                                    { %>
                                <div class="row g-3 border-top pt-3 align-items-end">

                                    <div class="col-md-4">
                                        <asp:Label Text="Fecha Desde" runat="server" CssClass="form-label small fw-bold" />
                                        <asp:TextBox runat="server" ID="txtFechaDesde" CssClass="form-control form-control-sm" TextMode="Date" />
                                    </div>

                                    <div class="col-md-4">
                                        <asp:Label Text="Fecha Hasta" runat="server" CssClass="form-label small fw-bold" />
                                        <asp:TextBox runat="server" ID="txtFechaHasta" CssClass="form-control form-control-sm" TextMode="Date" />
                                    </div>

                                    <div class="col-md-4">
                                        <asp:Label Text="Estado del Turno" runat="server" CssClass="form-label small fw-bold" />
                                        <asp:DropDownList runat="server" ID="ddlEstado" CssClass="form-select form-select-sm">
                                        </asp:DropDownList>
                                    </div>

                                    <div class="col-12 text-end mt-4">
                                        <asp:Button Text="Aplicar Filtros" runat="server" CssClass="btn fw-bold px-4"
                                            ID="btnBuscarAvanzado" OnClick="btnBuscar_Click"
                                            Style="background-color: var(--colorPrincipalHover); color: white;" />
                                    </div>
                                </div>
                                <%} %>
                            </div>

                            <div class="card shadow-sm border-0 rounded-4">
                                <div class="card-header bg-custom-accent text-white pt-4 px-4 rounded-top-4">
                                    <h5 class="mb-0 fw-bold"><i class="bi bi-list-task me-2"></i>Resultado de Búsqueda</h5>
                                </div>
                                <div class="card-body p-4">
                                    <asp:UpdatePanel ID="updGridTurnos" runat="server">
                                        <ContentTemplate>
                                            <div class="table-responsive">
                                                <asp:GridView ID="dgvTurnos" runat="server" DataKeyNames="IDTurno" CssClass="table table-hover align-middle mb-0"
                                                    AutoGenerateColumns="false" AllowPaging="True" PageSize="10" OnRowCommand="dgvTurnos_RowCommand" OnPageIndexChanging="dgvTurnos_PageIndexChanging">
                                                    <Columns>
                                                        <asp:BoundField HeaderText="Fecha" DataField="FechaString" />
                                                        <asp:BoundField HeaderText="Hora" DataField="HoraInicio" />
                                                        <asp:BoundField HeaderText="Paciente" DataField="ClienteNombreCompleto" />
                                                        <asp:BoundField HeaderText="Servicio" DataField="Servicio.Nombre" />
                                                        <asp:BoundField HeaderText="Profesional" DataField="ProfesionalNombreCompleto" />
                                                        <asp:BoundField HeaderText="Estado" DataField="Estado.Descripcion" />
                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="">
                                                            <ItemTemplate>
                                                                <div class="btn-group btn-group-sm" role="group">
                                                                    <asp:LinkButton ID="btnVerPagos" runat="server" CommandName="VerPagos" CommandArgument='<%# Eval("IDTurno") %>'
                                                                        ToolTip="Ver Pagos del turno" CssClass="btn-custom btn-sm me-3">   Pagos  </asp:LinkButton>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <HeaderStyle CssClass="bg-light text-muted small text-uppercase" />
                                                    <PagerStyle CssClass="p-2 border-top bg-light" HorizontalAlign="Center" />
                                                </asp:GridView>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="pagoModal" tabindex="-1" aria-labelledby="pagoModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: var(--colorPrincipalHover); color: white;">
                        <h5 class="modal-title" id="pagoModalLabel">Detalle de Pagos del Turno</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>
                    <div class="modal-body p-4">
                        <h6 class="fw-bold mb-3">Turno para:
                        <asp:Literal ID="litNombreTurno" runat="server"></asp:Literal></h6>
                        <div class="table-responsive">
                            <asp:GridView ID="dgvPagos" runat="server" AutoGenerateColumns="false" CssClass="table table-hover align-middle mb-0" ShowHeaderWhenEmpty="true">
                                <Columns>
                                    <asp:TemplateField HeaderText="Tipo de Transacción" ItemStyle-Width="150px">
                                        <ItemTemplate>
                                            <span class='badge fw-bold <%# (bool)Eval("EsDevolucion") ? "bg-danger" : "bg-success" %>'>
                                                <%# (bool)Eval("EsDevolucion") ? "Devolución" : "Pago" %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="Monto" DataField="Monto" DataFormatString="{0:C}" ItemStyle-CssClass="fw-bold" />
                                    <asp:BoundField HeaderText="Forma de Pago" DataField="FormaDePago.Descripcion" />
                                    <asp:BoundField HeaderText="Fecha" DataField="Fecha" DataFormatString="{0:dd/MM/yyyy}" />
                                    <asp:BoundField HeaderText="Concepto" DataField="Tipo.Descripcion" />
                                </Columns>
                                <HeaderStyle CssClass="bg-light text-muted small text-uppercase" />
                            </asp:GridView>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PanelProfesional.aspx.cs" Inherits="CentroEstetica.PanelProfesional" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<asp:HiddenField ID="hfTabActivo" runat="server" Value="Hoy" />

    <div class="container-fluid dashboard-container">
        <div class="row">

            <div class="col-lg-2 col-xl-2 mb-4">
                <div class="sticky-top" style="top: 90px; z-index: 1;">
                    <h5 class="text-muted text-uppercase mb-3 ms-2 small fw-bold">Menú Profesional</h5>
                    <div class="nav flex-column nav-pills me-3" id="v-pills-tab-profesional" role="tablist" aria-orientation="vertical">

                        <asp:LinkButton ID="lnkAgendaHoy" runat="server" Text=" Agenda de Hoy"
                            CssClass="nav-link" OnClick="lnkMenu_Click" CommandArgument="Hoy" />

                        <asp:LinkButton ID="lnkAgendaSemana" runat="server" Text=" Agenda de la Semana"
                            CssClass="nav-link" OnClick="lnkMenu_Click" CommandArgument="Semana" />

                        <asp:HyperLink ID="lnkHistorial" runat="server" NavigateUrl="~/HistorialTurnos.aspx"
                            CssClass="nav-link" ToolTip="Ver todos los turnos pasados">Historial de Turnos</asp:HyperLink>
                    </div>
                </div>
            </div>
            <div class="col-lg-10 col-xl-10">
                <div class="content-area">

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h2 class="fw-bold mb-1 text-dark">
                                <asp:Label ID="lblTituloPrincipal" runat="server" Text="Agenda de Hoy"></asp:Label>
                            </h2>
                            <h5 class="text-muted fw-normal">
                                <asp:Label ID="lblNombre" runat="server" Text="[Nombre Profesional]"></asp:Label>
                            </h5>
                        </div>
                        <div class="text-end">
                            <span class="lblfecha border px-3 py-2 fs-6">
                                <asp:Label ID="lblFechaHoy" runat="server"></asp:Label>
                            </span>
                        </div>
                    </div>

                    <asp:Panel ID="pnlEstadisticas" runat="server">
                        <div class="row mb-5 justify-content-start">
                            <div class="col-md-5 col-lg-4 col-xl-3 me-3">
                                <div class="kpi-card bg-personalizado text-center shadow-sm">
                                    <p class="stat-label"> Turnos Hoy</p>
                                    <div class="stat-value">
                                        <asp:Label ID="lblTurnosHoy" runat="server" Text="0"></asp:Label>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-5 col-lg-4 col-xl-3">
                                <div class="kpi-card bg-personalizado text-center shadow-sm">
                                    <p class="stat-label"> Próximos 7 días</p>
                                    <div class="stat-value">
                                        <asp:Label ID="lblTurnosProximos" runat="server" Text="0"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>

                    <div class="card shadow-sm border-0 rounded-4">
                        <div class="card-header bg-custom-accent text-white pt-4 px-4 rounded-top-4"">
                            <h5 class="mb-0 fw-bold">
                                <asp:Label ID="lblSubTituloGrid" runat="server" Text="Turnos Programados para Hoy"></asp:Label>
                            </h5>
                        </div>
                        <div class="card-body p-4">
                            <div class="table-responsive">
                                <asp:GridView ID="dgvTurnos" runat="server" DataKeyNames="IDTurno" CssClass="table table-hover align-middle mb-0"
                                    AutoGenerateColumns="false" AllowPaging="True" PageSize="10" OnPageIndexChanging="dgvTurnos_PageIndexChanging">
                                    <Columns>
                                        <asp:BoundField HeaderText="Fecha" DataField="FechaString" ItemStyle-Width="120px" />
                                        <asp:BoundField HeaderText="Hora" DataField="HoraInicio" />
                                        <asp:BoundField HeaderText="Paciente" DataField="ClienteNombreCompleto" />
                                        <asp:BoundField HeaderText="Servicio" DataField="Servicio.Nombre" />
                                        <asp:BoundField HeaderText="Estado" DataField="Estado.Descripcion" />                                     
                                    </Columns>
                                    <HeaderStyle CssClass="bg-light text-muted small text-uppercase" />
                                    <PagerStyle CssClass="p-2 border-top bg-light" HorizontalAlign="Center" />
                                </asp:GridView>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            </div>
    </div>

</asp:Content>


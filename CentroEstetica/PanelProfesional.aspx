<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PanelProfesional.aspx.cs" Inherits="CentroEstetica.PanelProfesional" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-3">
        <asp:Panel ID="pnlMensajeExito" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i> Turno reservado con éxito.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </asp:Panel>
    </div>

    <div class="container mb-5">
        <h1 class="display-6 mb-2">Panel Profesional</h1>

        <h3>
            <asp:Label ID="lblNombre" runat="server"></asp:Label>
        </h3>

    </div>
    <!-- ESTADÍSTICAS -->
    <div class=" row container justify-content-center">
        <div class="col-md-3 custom-card mx-3">
            <div class="stat-card text-center">
                <p class="stat-label">📅 Turnos Hoy</p>
                <div class="stat-value">
                    <asp:Label ID="lblTurnosHoy" runat="server" Text="0"></asp:Label></div>
            </div>
        </div>

        <div class="col-md-3 custom-card mx-3 ">
            <div class="stat-card text-center">
                <p class="stat-label">📊 Próximos 7 días</p>
                <div class="stat-value">
                    <asp:Label ID="lblTurnosProximos" runat="server" Text="0"></asp:Label></div>
            </div>
        </div>
       
<!-- Turnos-->
    <div class="container mt-4">

        <ul class="nav nav-tabs" id="tabTurnos" role="tablist">
            <li class="nav-item" role="presentation">
                <asp:LinkButton ID="lnkHoy" runat="server" CssClass="nav-link active" OnClick="lnk_Click">Hoy</asp:LinkButton>
            </li>
            <li class="nav-item" role="presentation">
                <asp:LinkButton ID="lnkProximos" runat="server" CssClass="nav-link" OnClick="lnk_Click">Próximos</asp:LinkButton>
            </li>
            <li class="nav-item" role="presentation">
                <asp:LinkButton ID="lnkPasados" runat="server" CssClass="nav-link" OnClick="lnk_Click">Pasados</asp:LinkButton>
            </li>
        </ul>

        <asp:MultiView ID="mvTurnos" runat="server" ActiveViewIndex="0">

            <asp:View ID="viewHoy" runat="server">
                <h2 class="mt-4 mb-3">Turnos de Hoy 
        <small class="text-muted float-end">
            <asp:Label ID="lblFechaHoy" runat="server" Text=""></asp:Label>
        </small>
                </h2>
                <p>Aquí iría el listado de turnos del dia.</p>
            </asp:View>

            <asp:View ID="viewProximos" runat="server">
                <h2 class="mt-4">Próximos Turnos</h2>
                <p>Aquí iría el listado de turnos de los próximos días.</p>
            </asp:View>

            <asp:View ID="viewPasados" runat="server">
                <h2 class="mt-4">Turnos Pasados</h2>
                <p>Aquí iría el listado de turnos que ya se completaron o cancelaron.</p>
            </asp:View>

        </asp:MultiView>
    </div>

</asp:Content>


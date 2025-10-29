<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PanelCliente.aspx.cs" Inherits="CentroEstetica.PanelCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container py-5">

        <!-- PERFIL DEL CLIENTE -->
        <div class="card shadow-sm mb-4">
            <div class="card-body">
                <h2 class="h4 mb-3">Mi Perfil</h2>
                <p><strong>Nombre:</strong> Juan Pérez</p>
                <p><strong>Email:</strong> juan.perez@email.com</p>
                <p><strong>Teléfono:</strong> 011-1234-5678</p>
                <button class="btn btn-danger btn-sm mt-2">Modificar</button>
            </div>
        </div>

        <!-- MIS TURNOS -->
        <div class="mb-5">
            <h2 class="h4 mb-3">Mis Turnos</h2>
            <div class="d-flex flex-column gap-3">

                <!-- Turno 1 -->
                <div class="card shadow-sm">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <p class="mb-1"><strong>Servicio:</strong> Masaje Relajante</p>
                            <p class="mb-1"><strong>Profesional:</strong> María González</p>
                            <p class="mb-0"><strong>Fecha y Hora:</strong> 05/11/2025 - 15:00</p>
                        </div>
                        <button class="btn btn-danger btn-sm">Cancelar</button>
                    </div>
                </div>

                <!-- Turno 2 -->
                <div class="card shadow-sm">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <p class="mb-1"><strong>Servicio:</strong> Lifting de Pestañas</p>
                            <p class="mb-1"><strong>Profesional:</strong> Luisa Fernández</p>
                            <p class="mb-0"><strong>Fecha y Hora:</strong> 12/11/2025 - 10:00</p>
                        </div>
                        <button class="btn btn-danger btn-sm">Cancelar</button>
                    </div>
                </div>

            </div>
        </div>
    </div>



</asp:Content>

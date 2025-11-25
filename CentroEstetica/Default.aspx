<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CentroEstetica.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="banner-section">
        <div class="container text-center">
            <h1 class="display-2 fw-bold mb-4">Tu Belleza, Nuestra Pasión</h1>
            <p class="lead mb-4">Descubre una experiencia única de bienestar y cuidado personal con nuestros tratamientos especializados</p>

            <asp:LinkButton ID="btnReservarTurno" runat="server" CssClass="btn-custom" OnClick="btnReservarTurno_Click">
                Reservar Turno
            </asp:LinkButton>

        </div>
    </section>

    <!-- Features -->
    <div class="container py-5">
        <div class="row g-4 mb-5">
            <div class="col-md-4">
                <div class="card custom-card h-100 border-0 shadow-sm text-center">
                    <div class="card-body">
                        <h3 class="h4 mb-3">Reserva Online</h3>
                        <p class="text-muted">Agenda tu turno de forma rápida y sencilla desde cualquier dispositivo.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card custom-card h-100 border-0 shadow-sm text-center">
                    <div class="card-body">
                        <h3 class="h4 mb-3">Profesionales Expertos</h3>
                        <p class="text-muted">Equipo altamente capacitado con años de experiencia en el sector.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card custom-card h-100 border-0 shadow-sm text-center">
                    <div class="card-body">
                        <h3 class="h4 mb-3">Tratamientos Premium</h3>
                        <p class="text-muted">Utilizamos productos de primera calidad y técnicas innovadoras.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Profesionales -->
    <div class="container mt-5">
        <h2 class="text-center mb-4">Nuestros Profesionales</h2>
        <div class="row g-4">

        <asp:Repeater ID="rptProfesionales" runat="server">
            <ItemTemplate>
                <div class="col-md-3 col-lg-3 mb-4">
                    <div class="card service-card custom-card h-100 border-0 shadow-sm text-center">
        
                        <img src='<%# Eval("Foto") %>' 
                             class="card-img-top rounded-circle mx-auto mt-3" 
                             alt='<%# Eval("Nombre") + " " + Eval("Apellido") %>' 
                             style="width: 120px; height: 120px; object-fit: cover;" />
        
                        <div class="card-body">
                            <h5 class="card-title mb-1">
                                <%# Eval("Nombre") + " " + Eval("Apellido") %>
                            </h5>
        
                           
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>


        </div>


        <!-- Especialidades -->
        <h2 class="text-center display-5 mb-5" id="servicios">Nuestras Especialidades</h2>

        <div class="row g-4">

            <asp:Repeater ID="rptEspecialidades" runat="server">
                <ItemTemplate>
                    <div class="col-md-3 col-lg-3">
                        <div class="card service-card custom-card h-100 border-0 shadow-sm">

                            <img src='<%# Eval("Foto") %>' class="card-img-top" alt='<%# Eval("Nombre") %>'>

                            <div class="card-body">

                                <h3 class="h5 mb-2"><%# Eval("Nombre") %></h3>

                                <p class="text-muted mb-3"><%# Eval("Descripcion") %></p>

                                <a href="Servicios.aspx?id=<%# Eval("IDEspecialidad") %>" class="btn-custom btn-lg w-100">Ver Servicios
                                </a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

        </div>
    </div>
</asp:Content>

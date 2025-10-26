<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CentroEstetica.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       
    <section class="banner-section">
        <div class="container">
            <h1 class="display-2 fw-bold mb-4">Tu Belleza, Nuestra Pasión</h1>
            <p class="lead mb-4">Descubre una experiencia única de bienestar y cuidado personal con nuestros tratamientos especializados</p>
            <a href="PanelCliente.aspx" class="btn btn-primary btn-lg">Reservar Turno</a>
        </div>
    </section>

    <!-- Features -->
    <div class="container py-5">
        <div class="row g-4 mb-5">
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm text-center">
                    <div class="card-body">
                        <div class="feature-icon">📅</div>
                        <h3 class="h4 mb-3">Reserva Online</h3>
                        <p class="text-muted">Agenda tu turno de forma rápida y sencilla desde cualquier dispositivo.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm text-center">
                    <div class="card-body">
                        <div class="feature-icon">👥</div>
                        <h3 class="h4 mb-3">Profesionales Expertos</h3>
                        <p class="text-muted">Equipo altamente capacitado con años de experiencia en el sector.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm text-center">
                    <div class="card-body">
                        <div class="feature-icon">✨</div>
                        <h3 class="h4 mb-3">Tratamientos Premium</h3>
                        <p class="text-muted">Utilizamos productos de primera calidad y técnicas innovadoras.</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Servicios -->
        <h2 class="text-center display-5 mb-5" id="servicios">Nuestros Servicios</h2>
        <div class="row g-4">
        
            <div class="col-md-6 col-lg-4">
                <div class="card service-card h-100 border-0 shadow-sm">
                    <img src="Assets/img/facial.jpg" class="card-img-top" alt="Tratamiento Facial">
                    <div class="card-body">
                        <h3 class="h5 mb-2">Tratamiento Facial</h3>
                        <div class="text-primary-custom fw-bold fs-5 mb-2">$8,000</div>
                        <p class="text-muted mb-3">Limpieza profunda, hidratación y rejuvenecimiento facial.</p>
                        <a href="PanelCliente.aspx" class="btn btn-primary w-100">Reservar</a>
                    </div>
                </div>
            </div>

    
            <div class="col-md-6 col-lg-4">
                <div class="card service-card h-100 border-0 shadow-sm">
                    <img src="Assets/img/manicura.jpg" class="card-img-top" alt="Manicura y Pedicura">
                    <div class="card-body">
                        <h3 class="h5 mb-2">Manicura y Pedicura</h3>
                        <div class="text-primary-custom fw-bold fs-5 mb-2">$5,500</div>
                        <p class="text-muted mb-3">Cuidado completo de manos y pies con esmaltado semipermanente.</p>
                        <a href="PanelCliente.aspx" class="btn btn-primary w-100">Reservar</a>
                    </div>
                </div>
            </div>


            <div class="col-md-6 col-lg-4">
                <div class="card service-card h-100 border-0 shadow-sm">
                    <img src="Assets/img/masaje.jpg" class="card-img-top" alt="Masajes Relajantes">
                    <div class="card-body">
                        <h3 class="h5 mb-2">Masajes Relajantes</h3>
                        <div class="text-primary-custom fw-bold fs-5 mb-2">$7,000</div>
                        <p class="text-muted mb-3">Masajes terapéuticos para aliviar tensiones y mejorar tu bienestar.</p>
                        <a href="PanelCliente.aspx" class="btn btn-primary w-100">Reservar</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

 
</asp:Content>

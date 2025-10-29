<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CentroEstetica.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       
    <section class="banner-section">
        <div class="container text-center">
            <h1 class="display-2 fw-bold mb-4">Tu Belleza, Nuestra Pasión</h1>
            <p class="lead mb-4">Descubre una experiencia única de bienestar y cuidado personal con nuestros tratamientos especializados</p>
            <a href="login.aspx"  class="btn-custom"> Reservar Turno</a>
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

<!-- Profesionales -->
<div class="container mt-5">
    <h2 class="text-center mb-4">Nuestros Profesionales</h2>
    
    
    <div class="row g-4 justify-content-center"> 
        <!-- Card 1 -->
        <div class="col-12 col-md-3 d-flex justify-content-center"> 
            <div class="card custom-card">
                <img src="https://plus.unsplash.com/premium_photo-1705009607254-5618bb0d0c35?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8bXVqZXIlMjBzb25yaWVuZG98ZW58MHx8MHx8fDA%3D&fm=jpg&q=60&w=3000" class="card-img-top" alt="Profesional 1">
                <div class="card-body text-center">
                    <h5 class="card-title">María González</h5>
                    <p class="card-text">Especialidad: Esteticista</p>
                    <a href="#" class="btn-custom">Reservar Turno</a>
                </div>
            </div>
        </div>
        
        <!-- Card 2 -->
        <div class="col-12 col-md-3 d-flex justify-content-center">
            <div class="card custom-card">
                <img src="https://img.freepik.com/foto-gratis/retrato-mujer-joven-expresiva_1258-48167.jpg" class="card-img-top" alt="Profesional 2">
                <div class="card-body text-center">
                    <h5 class="card-title">Carla Ruiz</h5>
                    <p class="card-text">Especialidad: Masajes</p>
                    <a href="#" class="btn-custom">Reservar Turno</a>
                </div>
            </div>
        </div>
        
        <!-- Card 3 -->
        <div class="col-12 col-md-3 d-flex justify-content-center">
            <div class="card custom-card">
                <img src="https://image.jimcdn.com/app/cms/image/transf/none/path/s70f5679ceb3714b2/image/i2cceb8a4aa75b9cf/version/1666629063/image.jpg" class="card-img-top" alt="Profesional 3">
                <div class="card-body text-center">
                    <h5 class="card-title">Luisa Fernandez</h5>
                    <p class="card-text">Especialidad: Lashista</p>
                    <a href="#" class="btn-custom">Reservar Turno</a>
                </div>
            </div>
        </div>
        
        <!-- Card 4 -->
        <div class="col-12 col-md-3 d-flex justify-content-center">
            <div class="card custom-card">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8gi0ZLlmIhYygwOcEO3zEkR2fm8sjSNzA64N5kvyKrkULkrH6EX2uo0_BzXqJOtUb0P0&usqp=CAU" class="card-img-top" alt="Profesional 4">
                <div class="card-body text-center">
                    <h5 class="card-title">Jazmin Torres</h5>
                    <p class="card-text">Especialidad: Manicura y Pedicura</p>
                    <a href="#" class="btn-custom">Reservar Turno</a>
                </div>
            </div>
        </div>
        
    
    </div>
</div>
        <!-- Especialidades -->
        <h2 class="text-center display-5 mb-5" id="servicios">Nuestras Especialidades</h2>

        <div class="row g-4">
            
            <asp:Repeater ID="rptEspecialidades" runat="server">
                <ItemTemplate>
                    <%--<div class="col-md-3 col-lg-3">
                        <div class="card service-card custom-card h-100 border-0 shadow-sm">
                            
                            <img src='<%# Eval("Imagen") %>' class="card-img-top" alt='<%# Eval("Nombre") %>'>
                            
                            <div class="card-body">
                                
                                <h3 class="h5 mb-2"><%# Eval("Nombre") %></h3>
                                
                                <p class="text-muted mb-3"><%# Eval("Descripcion") %></p>
                                
                                <a href="Servicios.aspx?id=<%# Eval("IDEspecialidad") %>" class="btn-custom btn-lg w-100">
                                    Ver Servicios
                                </a>
                            </div>
                        </div>
                    </div>--%>
                </ItemTemplate>
            </asp:Repeater>
            
        </div>
        </div>
   
 
</asp:Content>

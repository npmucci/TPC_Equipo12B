<%@ Page Title="Servicios" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Servicios.aspx.cs" Inherits="CentroEstetica.Servicios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="container py-5">
        
        <div class="d-flex justify-content-between align-items-end mb-4 border-bottom pb-3">
            <div>
                <h2 id="h2Titulo" runat="server" class="fw-bold text-secondary h3 mb-0"></h2>
                <small class="text-muted">Lista de precios y duración estimada</small>
            </div>
            
            <asp:LinkButton ID="btnReservar" runat="server" CssClass="btn-custom shadow-sm" OnClick="btnReservar_Click">
                Reservar un Turno
            </asp:LinkButton>
        </div>

        <div class="row g-3" id="divServicios" runat="server">
            <asp:Repeater ID="rptServicios" runat="server">
                <ItemTemplate>
                    <div class="col-md-4 col-lg-3">
                        
                        <div class="card h-100 border-0 shadow-sm" 
                             style="border-top: 4px solid var(--colorPrincipalHover) !important; background-color: #fff;">
                            
                            <div class="card-body p-3 d-flex flex-column">
                                
                                <h5 class="card-title fw-bold text-dark mb-2" style="font-size: 1.1rem;">
                                    <%# Eval("Nombre") %>
                                </h5>
                                
                                <p class="card-text text-muted small flex-grow-1 mb-3" style="line-height: 1.4;">
                                    <%# Eval("Descripcion") %>
                                </p>
                                
                                <div class="d-flex justify-content-between align-items-center pt-2 border-top">
                                    <span class="fw-bold" style="color: var(--coloroFondoOscuro); font-size: 1.2rem;">
                                        $<%# Eval("Precio", "{0:N0}") %>
                                    </span>
                                    
                                    <span class="badge bg-light text-secondary border fw-normal">
                                        <i class="bi bi-clock me-1"></i><%# Eval("DuracionMinutos") %> min
                                    </span>
                                </div>

                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <div class="mt-5">
            <a href="Default.aspx" class="text-decoration-none text-secondary small fw-bold">
                <i class="bi bi-arrow-left me-1"></i> Volver al Inicio
            </a>
        </div>

    </div>

</asp:Content>
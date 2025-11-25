<%@ Page Title="Recuperar Contraseña" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="RecuperarPassword.aspx.cs" Inherits="CentroEstetica.RecuperarPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                
                <div class="card shadow-sm border-0 rounded-4">
                    <div class="card-body p-5">
                        <h3 class="text-center fw-bold mb-4">Recuperar Acceso</h3>
                        <p class="text-center text-muted mb-4">Ingresá tu email y te enviaremos una nueva contraseña.</p>

                        <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="alert alert-danger alert-dismissible fade show small" role="alert">
                            <asp:Literal ID="litMensaje" runat="server"></asp:Literal>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </asp:Panel>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Correo Electrónico</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="ejemplo@mail.com" TextMode="Email"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                                ErrorMessage="Ingresá tu email." CssClass="text-danger small" Display="Dynamic" ValidationGroup="Recupero"/>
                        </div>

                        <div class="d-grid gap-2 mt-4">
                            <asp:Button ID="btnRecuperar" runat="server" Text="Restablecer Contraseña" 
                                CssClass="btn btn-primary rounded-pill" OnClick="btnRecuperar_Click" ValidationGroup="Recupero" />
                            
                            <a href="Login.aspx" class="btn btn-link text-secondary text-decoration-none small">Volver al Login</a>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>

</asp:Content>
<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CentroEstetica.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="login-section d-flex align-items-center justify-content-center">
    <div class="login-card shadow p-5 rounded-4">
        <h2 class="text-center mb-4">Iniciar Sesión</h2>

            <div class="mb-3">
                <label for="txtUsuario" class="form-label">Usuario (Email)</label>
                <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" placeholder="Ingrese su email"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label for="txtPassword" class="form-label">Contraseña</label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Ingrese su contraseña"></asp:TextBox>
            </div>
            
            <div class="text-end mb-3">
                <a href="RecuperarPassword.aspx" class="small text-muted text-decoration-none">¿Olvidaste tu contraseña?</a>
            </div>

            <div class="d-grid">
                
                <asp:Button ID="btnIngresar" runat="server" Text="Ingresar" CssClass="btn btn-dark btn-lg fw-bold" OnClick="btnIngresar_Click" />
            
            </div>

            <asp:Label ID="lblError" runat="server" CssClass="text-danger text-center d-block mt-3" Visible="false"></asp:Label>


            <p class="text-center text-muted mt-3">
                ¿No tenés cuenta? 
                <a href="RegistroPage.aspx" class="link-dark fw-bold text-decoration-underline">Registrate</a>
            </p>
        
    </div>
</section>
</asp:Content>
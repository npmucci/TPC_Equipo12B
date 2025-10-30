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
            <div class="d-grid">
                
                <asp:Button ID="btnIngresar" runat="server" Text="Ingresar" CssClass="btn btn-primary" OnClick="btnIngresar_Click" />
            
            </div>

            <asp:Label ID="lblError" runat="server" CssClass="text-danger text-center d-block mt-3" Visible="false"></asp:Label>


            <p class="text-center text-muted mt-3">
                ¿No tenés cuenta? <a href="Registro.aspx" class="text-primary-custom text-decoration-none">Registrate</a>
            </p>
        
    </div>
</section>
</asp:Content>
<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="RegistroPage.aspx.cs" Inherits="CentroEstetica.RegistroPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container py-5">

        <!-- PANEL 1: VALIDACIÓN DE MAIL Y CONTRASEÑA -->
        <asp:Panel ID="pnlCredenciales" runat="server" CssClass="card shadow-sm mb-4">
            <div class="card-body">
                <h2 class="h4 mb-3">Crear cuenta</h2>

                <div class="mb-3">
                    <label for="txtMail" class="form-label"><strong>Email:</strong></label>
                    <asp:TextBox ID="txtMail" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvMail" runat="server" ControlToValidate="txtMail"
                        ErrorMessage="El email es obligatorio." CssClass="text-danger" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revMail" runat="server" ControlToValidate="txtMail"
                        ErrorMessage="Formato de email no válido." CssClass="text-danger" Display="Dynamic"
                        ValidationExpression="^[\w\.-]+@[\w\.-]+\.\w+$" />
                </div>

                <div class="mb-3">
                    <label for="txtContraseña" class="form-label"><strong>Contraseña:</strong></label>
                    <asp:TextBox ID="txtContraseña" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvContraseña" runat="server" ControlToValidate="txtContraseña"
                        ErrorMessage="La contraseña es obligatoria." CssClass="text-danger" Display="Dynamic" />
                </div>

                <div class="mb-3">
                    <label for="txtRepetirContraseña" class="form-label"><strong>Repetir Contraseña:</strong></label>
                    <asp:TextBox ID="txtRepetirContraseña" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                    <asp:CompareValidator ID="cvContraseña" runat="server" ControlToValidate="txtRepetirContraseña"
                        ControlToCompare="txtContraseña" ErrorMessage="Las contraseñas no coinciden."
                        CssClass="text-danger" Display="Dynamic" />
                </div>

                <asp:Button ID="btnValidar" runat="server" Text="Validar datos" CssClass="btn btn-primary"
                    OnClick="btnValidar_Click" />
                <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger ms-3"></asp:Label>
            </div>
        </asp:Panel>

        <!-- PANEL 2: DATOS PERSONALES (OCULTO AL INICIO) -->
        <asp:Panel ID="pnlDatos" runat="server" Visible="false" CssClass="card shadow-sm mb-4">
            <div class="card-body">
                <h2 class="h4 mb-3">Completar el formulario</h2>

                <div class="mb-3">
                    <label for="txtNombre" class="form-label"><strong>Nombre:</strong></label>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre"
                        ErrorMessage="El nombre es obligatorio." CssClass="text-danger" Display="Dynamic" />
                </div>

                <div class="mb-3">
                    <label for="txtApellido" class="form-label"><strong>Apellido:</strong></label>
                    <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvApellido" runat="server" ControlToValidate="txtApellido"
                        ErrorMessage="El apellido es obligatorio." CssClass="text-danger" Display="Dynamic" />
                </div>

                <div class="mb-3">
                    <label for="txtDni" class="form-label"><strong>DNI:</strong></label>
                    <asp:TextBox ID="txtDni" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvDni" runat="server" ControlToValidate="txtDni"
                        ErrorMessage="El DNI es obligatorio." CssClass="text-danger" Display="Dynamic" />
                </div>

                <div class="mb-3">
                    <label for="txtTelefono" class="form-label"><strong>Teléfono:</strong></label>
                    <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="txtTelefono"
                        ErrorMessage="El teléfono es obligatorio." CssClass="text-danger" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revTelefono" runat="server" ControlToValidate="txtTelefono"
                        ErrorMessage="El teléfono debe contener 10 dígitos." CssClass="text-danger" Display="Dynamic"
                        ValidationExpression="^\d{10}$" />
                </div>

                <div class="mb-3">
                    <label for="txtDomicilio" class="form-label"><strong>Domicilio:</strong></label>
                    <asp:TextBox ID="txtDomicilio" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <asp:Button ID="btnRegistrar" runat="server" Text="Registrar usuario" CssClass="btn btn-success"
                    OnClick="btnRegistrar_Click" />
            </div>
        </asp:Panel>
    </div>

</asp:Content>
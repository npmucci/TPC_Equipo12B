<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="RegistroPage.aspx.cs" Inherits="CentroEstetica.RegistroPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container py-5">

        <asp:Panel ID="pnlMensaje" runat="server" Visible="false" role="alert">
            <asp:Literal ID="litMensaje" runat="server"></asp:Literal>
        </asp:Panel>

        <asp:Panel ID="pnlCredenciales" runat="server" CssClass="card shadow-sm mb-4">
            <div class="card-body">
                <h2 class="h4 mb-3">Crear cuenta</h2>

                <div class="mb-3">
                    <label for="txtMail" class="form-label"><strong>Email:</strong></label>
                    <asp:TextBox ID="txtMail" runat="server" CssClass="form-control" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvMail" runat="server" ControlToValidate="txtMail"
                        ErrorMessage="El email es obligatorio." CssClass="text-danger small" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revMail" runat="server" ControlToValidate="txtMail"
                        ErrorMessage="Formato de email no válido." CssClass="text-danger small" Display="Dynamic"
                        ValidationExpression="^[\w\.-]+@[\w\.-]+\.\w+$" />
                </div>

                <div class="mb-3">
                    <label for="txtContraseña" class="form-label"><strong>Contraseña:</strong></label>
                    <asp:TextBox ID="txtContraseña" runat="server" CssClass="form-control" TextMode="Password" autocomplete="new-password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvContraseña" runat="server" ControlToValidate="txtContraseña"
                        ErrorMessage="La contraseña es obligatoria." CssClass="text-danger small" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revContraseniaLargo" runat="server" ControlToValidate="txtContraseña"
                        ErrorMessage="La contraseña debe tener al menos 6 caracteres." CssClass="text-danger small" Display="Dynamic"
                        ValidationExpression="^.{6,}$" />
                </div>

                <div class="mb-3">
                    <label for="txtRepetirContraseña" class="form-label"><strong>Repetir Contraseña:</strong></label>
                    <asp:TextBox ID="txtRepetirContraseña" runat="server" CssClass="form-control" TextMode="Password" autocomplete="new-password"></asp:TextBox>
                    <asp:CompareValidator ID="cvContraseña" runat="server" ControlToValidate="txtRepetirContraseña"
                        ControlToCompare="txtContraseña" ErrorMessage="Las contraseñas no coinciden."
                        CssClass="text-danger small" Display="Dynamic" />
                </div>

                <asp:Button ID="btnValidar" runat="server" Text="Siguiente: Datos Personales" CssClass="btn btn-primary"
                    OnClick="btnValidar_Click" />
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlAdminControls" runat="server" Visible="false" CssClass="card shadow-sm mb-4 border-primary">
            <div class="card-body">
                <h2 class="h5 mb-3 text-primary">Opciones de Administrador</h2>
                
                <div class="mb-3">
                    <label class="form-label"><strong>Crear usuario con Rol:</strong></label>
                    <asp:DropDownList ID="ddlRoles" runat="server" CssClass="form-select"
                        AutoPostBack="true" OnSelectedIndexChanged="ddlRoles_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>

                <asp:Panel ID="pnlEspecialidad" runat="server" Visible="false">
                    <div class="mb-3">
                        <label class="form-label"><strong>Asignar Especialidades:</strong></label>
                        <div class="border rounded p-2" style="max-height: 150px; overflow-y: auto;">
                            <asp:CheckBoxList ID="cblEspecialidades" runat="server" CssClass="form-check">
                            </asp:CheckBoxList>
                        </div>
                    </div>
                </asp:Panel>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlDatos" runat="server" Visible="false" CssClass="card shadow-sm mb-4">
            <div class="card-body">
                <h2 class="h4 mb-3">Datos Personales</h2>

                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="txtNombre" class="form-label"><strong>Nombre:</strong></label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" autocomplete="off"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre"
                            ErrorMessage="El nombre es obligatorio." CssClass="text-danger small" Display="Dynamic" />
                    </div>

                    <div class="col-md-6">
                        <label for="txtApellido" class="form-label"><strong>Apellido:</strong></label>
                        <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" autocomplete="off"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvApellido" runat="server" ControlToValidate="txtApellido"
                            ErrorMessage="El apellido es obligatorio." CssClass="text-danger small" Display="Dynamic" />
                    </div>

                    <div class="col-md-6">
                        <label for="txtDni" class="form-label"><strong>DNI:</strong></label>
                        <asp:TextBox ID="txtDni" runat="server" CssClass="form-control" autocomplete="off"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvDni" runat="server" ControlToValidate="txtDni"
                            ErrorMessage="El DNI es obligatorio." CssClass="text-danger small" Display="Dynamic" />
                        <asp:RegularExpressionValidator ID="revDni" runat="server" ControlToValidate="txtDni"
                            ErrorMessage="Solo se permiten números." CssClass="text-danger small" Display="Dynamic"
                            ValidationExpression="^\d+$" />
                    </div>

                    <div class="col-md-6">
                        <label for="txtTelefono" class="form-label"><strong>Teléfono:</strong></label>
                        <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="txtTelefono"
                            ErrorMessage="El teléfono es obligatorio." CssClass="text-danger small" Display="Dynamic" />
                        </div>

                    <div class="col-12">
                        <label for="txtDomicilio" class="form-label"><strong>Domicilio:</strong></label>
                        <asp:TextBox ID="txtDomicilio" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>

                <div class="mt-4">
                    <asp:Button ID="btnRegistrar" runat="server" Text="Confirmar Registro" CssClass="btn btn-success btn-lg"
                        OnClick="btnRegistrar_Click" />
                </div>
            </div>
        </asp:Panel>
    </div>

</asp:Content>
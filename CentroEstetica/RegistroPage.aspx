<%@ Page Title="Registro" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="RegistroPage.aspx.cs" Inherits="CentroEstetica.RegistroPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container py-4">

        <asp:Panel ID="pnlMensaje" runat="server" Visible="false" role="alert">
            <asp:Literal ID="litMensaje" runat="server"></asp:Literal>
        </asp:Panel>

        <div class="row justify-content-center">
            <div class="col-md-10 col-lg-8">

                <asp:Panel ID="pnlCredenciales" runat="server" CssClass="card shadow-sm mb-4 border-0 rounded-4">
                    <div class="card-body p-4">
                        <h4 class="mb-3 fw-bold text-primary"><i class="bi bi-shield-lock me-2"></i>Crear Cuenta</h4>

                        <div class="form-floating mb-3">
                            <asp:TextBox ID="txtMail" runat="server" CssClass="form-control" placeholder="Email" autocomplete="off" MaxLength="250"></asp:TextBox>
                            <label for="<%= txtMail.ClientID %>">Correo Electrónico</label>
                            
                            <div class="ps-2">
                                <asp:RequiredFieldValidator ID="rfvMail" runat="server" ControlToValidate="txtMail"
                                    ErrorMessage="Requerido." CssClass="text-danger small fw-bold" Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="revMail" runat="server" ControlToValidate="txtMail"
                                    ErrorMessage="Formato inválido." CssClass="text-danger small" Display="Dynamic"
                                    ValidationExpression="^[\w\.-]+@[\w\.-]+\.\w+$" />
                            </div>
                        </div>

                        <div class="row g-2"> 
                            <div class="col-md-6">
                                <div class="form-floating mb-2">
                                    <asp:TextBox ID="txtContraseña" runat="server" CssClass="form-control" TextMode="Password" placeholder="Contraseña" autocomplete="new-password" MaxLength="16"></asp:TextBox>
                                    <label for="<%= txtContraseña.ClientID %>">Contraseña</label>
                                </div>
                                <div class="ps-2 mb-2">
                                    <asp:RequiredFieldValidator ID="rfvContraseña" runat="server" ControlToValidate="txtContraseña"
                                        ErrorMessage="Requerida." CssClass="text-danger small fw-bold" Display="Dynamic" />
                                    
                                    <asp:RegularExpressionValidator ID="revContraseniaFuerte" runat="server" ControlToValidate="txtContraseña"
                                        ErrorMessage="8-16 caracteres, 1 mayúscula, 1 minúscula y 1 número." CssClass="text-danger small" Display="Dynamic"
                                        ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,16}$" />
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-floating mb-2">
                                    <asp:TextBox ID="txtRepetirContraseña" runat="server" CssClass="form-control" TextMode="Password" placeholder="Repetir" autocomplete="new-password" MaxLength="16"></asp:TextBox>
                                    <label for="<%= txtRepetirContraseña.ClientID %>">Repetir Contraseña</label>
                                </div>
                                <div class="ps-2 mb-2">
                                    <asp:CompareValidator ID="cvContraseña" runat="server" ControlToValidate="txtRepetirContraseña"
                                        ControlToCompare="txtContraseña" ErrorMessage="No coinciden."
                                        CssClass="text-danger small fw-bold" Display="Dynamic" />
                                </div>
                            </div>
                        </div>

                        <div class="text-end mt-2">
                            <asp:Button ID="btnValidar" runat="server" Text="Continuar →" CssClass="btn btn-primary px-4 rounded-pill"
                                OnClick="btnValidar_Click" />
                        </div>
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlDatos" runat="server" Visible="false" CssClass="card shadow-sm mb-4 border-0 rounded-4">
                    <div class="card-body p-4">
                        <h4 class="mb-3 fw-bold text-primary"><i class="bi bi-person-vcard me-2"></i>Datos Personales</h4>

                        <div class="row g-2">
                            <div class="col-md-6">
                                <div class="form-floating mb-1">
                                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Nombre" autocomplete="off" MaxLength="100"></asp:TextBox>
                                    <label for="<%= txtNombre.ClientID %>">Nombre</label>
                                </div>
                                <div class="ps-2 mb-2">
                                    <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre"
                                        ErrorMessage="Requerido." CssClass="text-danger small fw-bold" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revNombre" runat="server" ControlToValidate="txtNombre"
                                        ErrorMessage="Solo letras." CssClass="text-danger small" Display="Dynamic" 
                                        ValidationExpression="^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$" />
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-floating mb-1">
                                    <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" placeholder="Apellido" autocomplete="off" MaxLength="100"></asp:TextBox>
                                    <label for="<%= txtApellido.ClientID %>">Apellido</label>
                                </div>
                                <div class="ps-2 mb-2">
                                    <asp:RequiredFieldValidator ID="rfvApellido" runat="server" ControlToValidate="txtApellido"
                                        ErrorMessage="Requerido." CssClass="text-danger small fw-bold" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revApellido" runat="server" ControlToValidate="txtApellido"
                                        ErrorMessage="Solo letras." CssClass="text-danger small" Display="Dynamic" 
                                        ValidationExpression="^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$" />
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-floating mb-1">
                                    <asp:TextBox ID="txtDni" runat="server" CssClass="form-control" placeholder="DNI" autocomplete="off" MaxLength="20"></asp:TextBox>
                                    <label for="<%= txtDni.ClientID %>">DNI</label>
                                </div>
                                <div class="ps-2 mb-2">
                                    <asp:RequiredFieldValidator ID="rfvDni" runat="server" ControlToValidate="txtDni"
                                        ErrorMessage="Requerido." CssClass="text-danger small fw-bold" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revDni" runat="server" ControlToValidate="txtDni"
                                        ErrorMessage="Solo números." CssClass="text-danger small" Display="Dynamic"
                                        ValidationExpression="^\d+$" />
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-floating mb-1">
                                    <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" placeholder="Teléfono" MaxLength="19"></asp:TextBox>
                                    <label for="<%= txtTelefono.ClientID %>">Teléfono</label>
                                </div>
                                <div class="ps-2 mb-2">
                                    <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="txtTelefono"
                                        ErrorMessage="Requerido." CssClass="text-danger small fw-bold" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revTelefono" runat="server" ControlToValidate="txtTelefono"
                                        ErrorMessage="Formato inválido." CssClass="text-danger small" Display="Dynamic"
                                        ValidationExpression="^[0-9\-\+\s]+$" />
                                </div>
                            </div>

                            <div class="col-12">
                                <div class="form-floating mb-1">
                                    <asp:TextBox ID="txtDomicilio" runat="server" CssClass="form-control" placeholder="Domicilio" MaxLength="250"></asp:TextBox>
                                    <label for="<%= txtDomicilio.ClientID %>">Domicilio</label>
                                </div>
                            </div>
                        </div>

                        <div class="mt-4 d-grid">
                            <asp:Button ID="btnRegistrar" runat="server" Text="Confirmar Registro" CssClass="btn btn-success btn-lg rounded-pill"
                                OnClick="btnRegistrar_Click" />
                        </div>
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlAdminControls" runat="server" Visible="false" CssClass="card shadow-sm mb-4 border-primary rounded-4">
                    <div class="card-body p-3 bg-light rounded-4">
                        <h6 class="fw-bold text-primary mb-2"><i class="bi bi-gear-fill me-2"></i>Opciones Admin</h6>
                        <div class="row align-items-center g-2">
                            <div class="col-auto">
                                <label class="form-label mb-0">Rol:</label>
                            </div>
                            <div class="col">
                                <asp:DropDownList ID="ddlRoles" runat="server" CssClass="form-select form-select-sm"
                                    AutoPostBack="true" OnSelectedIndexChanged="ddlRoles_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>

                        <asp:Panel ID="pnlEspecialidad" runat="server" Visible="false" CssClass="mt-3">
                            <label class="form-label small fw-bold">Especialidades:</label>
                            <div class="bg-white border rounded p-2" style="max-height: 100px; overflow-y: auto;">
                                <asp:CheckBoxList ID="cblEspecialidades" runat="server" CssClass="form-check ps-0 small" RepeatLayout="Flow">
                                </asp:CheckBoxList>
                            </div>
                        </asp:Panel>
                    </div>
                </asp:Panel>

            </div>
        </div>
    </div>

</asp:Content>
<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PanelPerfil.aspx.cs" Inherits="CentroEstetica.PanelPerfil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="container mt-3">
        <asp:Button ID="btnVolverAdmin" runat="server" Text="← Volver al Panel" 
            CssClass="btn btn-link text-decoration-none fw-bold" Visible="false" 
            OnClick="btnVolverAdmin_Click" CausesValidation="false" />
    </div>

    <h2 class="mb-4 text-center"><asp:Label ID="lblTituloPerfil" runat="server" Text="Mi Perfil"></asp:Label></h2>
    
    <asp:HiddenField ID="hfIdUsuario" runat="server" />

    <asp:UpdatePanel ID="upPerfil" runat="server">
        <ContentTemplate>

            <div class="container">
                <div class="card shadow-lg border-0 rounded-4 mx-auto" style="max-width: 700px;">
                    <div class="card-body p-4">

                        <div class="row g-3">

                            <div class="col-md-6">
                                <label for="txtNombre" class="form-label fw-bold">Nombre</label>
                                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre" CssClass="text-danger small" ErrorMessage="El nombre es obligatorio." Display="Dynamic" />
                            </div>

                            <div class="col-md-6">
                                <label for="txtApellido" class="form-label fw-bold">Apellido</label>
                                <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvApellido" runat="server" ControlToValidate="txtApellido" CssClass="text-danger small" ErrorMessage="El apellido es obligatorio." Display="Dynamic" />
                            </div>

                            <div class="col-md-12">
                                <label for="txtMail" class="form-label fw-bold">Email</label>
                                <asp:TextBox ID="txtMail" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvMail" runat="server" ControlToValidate="txtMail" CssClass="text-danger small" ErrorMessage="El email es obligatorio." Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="revMail" runat="server" ControlToValidate="txtMail" CssClass="text-danger small" ErrorMessage="Formato de email no válido." ValidationExpression="^[\w\.-]+@[\w\.-]+\.\w+$" Display="Dynamic" />
                            </div>

                            <div class="col-md-6">
                                <label for="txtTelefono" class="form-label fw-bold">Teléfono</label>
                                <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="txtTelefono" CssClass="text-danger small" ErrorMessage="El teléfono es obligatorio." Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="revTelefono" runat="server" ControlToValidate="txtTelefono" CssClass="text-danger small" ErrorMessage="Debe contener 10 números." ValidationExpression="^\d{10}$" Display="Dynamic" />
                            </div>

                            <div class="col-md-6">
                                <label for="txtDomicilio" class="form-label fw-bold">Domicilio</label>
                                <asp:TextBox ID="txtDomicilio" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>

                        </div>

                        <div class="mt-4 d-flex justify-content-end gap-2 flex-wrap">
                            
                            <asp:Button ID="btnBlanquearPass" runat="server" Text="🔑 Blanquear Contraseña" 
                                CssClass="btn btn-warning btn-sm text-dark" 
                                OnClick="btnBlanquearPass_Click" Visible="false" 
                                OnClientClick="return confirm('⚠️ ATENCIÓN ⚠️\n\n¿Está seguro que desea restablecer la contraseña de este usuario?\n\nSe cambiará por defecto a: 1234');" 
                                CausesValidation="false"/>

                            <div class="vr mx-2"></div> 

                            <asp:Button ID="btnEditar" runat="server" Text="Modificar" CssClass="btn btn-danger btn-sm" OnClick="btnEditar_Click" />
                            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-success btn-sm" OnClick="btnGuardar_Click" Visible="false" />
                            <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary btn-sm" OnClick="btnCancelar_Click" Visible="false" CausesValidation="false" />
                        </div>

                        <div id="divMensaje" runat="server" class="mt-3" visible="false">
                            <asp:Label ID="lblMensaje" runat="server" CssClass="alert alert-success d-block" />
                        </div>

                    </div>
                </div>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
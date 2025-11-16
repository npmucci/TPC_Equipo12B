<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PanelPerfil.aspx.cs" Inherits="CentroEstetica.PanelPerfil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2 class="mb-4 text-center">Mi Perfil</h2>
    <asp:UpdatePanel ID="upPerfil" runat="server">
        <ContentTemplate>

            <div class="container">
                <div class="card shadow-lg border-0 rounded-4 mx-auto" style="max-width: 700px;">
                    <div class="card-body p-4">

                        <div class="row g-3">

                            <div class="col-md-6">
                                <label for="txtNombre" class="form-label fw-bold">Nombre</label>
                                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre" CssClass="text-danger" ErrorMessage="El nombre es obligatorio." Display="Dynamic" />
                            </div>

                            <div class="col-md-6">
                                <label for="txtApellido" class="form-label fw-bold">Apellido</label>
                                <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvApellido" runat="server" ControlToValidate="txtApellido" CssClass="text-danger" ErrorMessage="El apellido es obligatorio." Display="Dynamic" />
                            </div>

                            <div class="col-md-12">
                                <label for="txtMail" class="form-label fw-bold">Email</label>
                                <asp:TextBox ID="txtMail" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvMail" runat="server" ControlToValidate="txtMail" CssClass="text-danger" ErrorMessage="El email es obligatorio." Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="revMail" runat="server" ControlToValidate="txtMail" CssClass="text-danger" ErrorMessage="Formato de email no válido." ValidationExpression="^[\w\.-]+@[\w\.-]+\.\w+$" Display="Dynamic" />
                            </div>

                            <div class="col-md-6">
                                <label for="txtTelefono" class="form-label fw-bold">Teléfono</label>
                                <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="txtTelefono" CssClass="text-danger" ErrorMessage="El teléfono es obligatorio." Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="revTelefono" runat="server" ControlToValidate="txtTelefono" CssClass="text-danger" ErrorMessage="Debe contener 10 números." ValidationExpression="^\d{10}$" Display="Dynamic" />
                            </div>

                            <div class="col-md-6">
                                <label for="txtDomicilio" class="form-label fw-bold">Domicilio</label>
                                <asp:TextBox ID="txtDomicilio" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>

                        </div>

                        <div class="mt-4 d-flex justify-content-end gap-2">
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

<%@ Page Title="Contacto" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Contacto.aspx.cs" Inherits="CentroEstetica.Contacto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                
                <!-- Tarjeta de Contacto -->
                <div class="card shadow-sm border-0 rounded-4">
                    <div class="card-body p-5">
                        <h2 class="text-center mb-4 fw-bold" style="font-family: 'Playfair Display', serif;">Contacto</h2>
                        <p class="text-center text-muted mb-4">¿Tenés alguna duda o consulta? Escribinos y te responderemos a la brevedad.</p>

                        <!-- Panel de Mensajes-->
                        <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="alert" role="alert">
                            <asp:Literal ID="litMensaje" runat="server"></asp:Literal>
                        </asp:Panel>

                        <!-- Nombre -->
                        <div class="mb-3">
                            <label for="txtNombre" class="form-label fw-bold">Nombre Completo</label>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Tu nombre"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre"
                                ErrorMessage="El nombre es requerido." CssClass="text-danger small" Display="Dynamic" ValidationGroup="Contacto" />
                        </div>

                        <!-- Email -->
                        <div class="mb-3">
                            <label for="txtEmail" class="form-label fw-bold">Email</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="tucorreo@ejemplo.com"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                                ErrorMessage="El email es requerido." CssClass="text-danger small" Display="Dynamic" ValidationGroup="Contacto" />
                            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                                ErrorMessage="Formato de email inválido." CssClass="text-danger small" Display="Dynamic" ValidationGroup="Contacto"
                                ValidationExpression="^[\w\.-]+@[\w\.-]+\.\w+$" />
                        </div>

                        <!-- Asunto -->
                        <div class="mb-3">
                            <label for="txtAsunto" class="form-label fw-bold">Asunto</label>
                            <asp:TextBox ID="txtAsunto" runat="server" CssClass="form-control" placeholder="Motivo de la consulta"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvAsunto" runat="server" ControlToValidate="txtAsunto"
                                ErrorMessage="El asunto es requerido." CssClass="text-danger small" Display="Dynamic" ValidationGroup="Contacto" />
                        </div>

                        <!-- Mensaje -->
                        <div class="mb-4">
                            <label for="txtMensaje" class="form-label fw-bold">Mensaje</label>
                            <asp:TextBox ID="txtMensaje" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" placeholder="Escribí tu mensaje aquí..."></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvMensaje" runat="server" ControlToValidate="txtMensaje"
                                ErrorMessage="El mensaje no puede estar vacío." CssClass="text-danger small" Display="Dynamic" ValidationGroup="Contacto" />
                        </div>

                        <!-- Botón Enviar -->
                        <div class="d-grid">
                            <asp:Button ID="btnEnviar" runat="server" Text="Enviar Mensaje" CssClass="btn btn-primary btn-lg rounded-pill"
                                OnClick="btnEnviar_Click" ValidationGroup="Contacto" />
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
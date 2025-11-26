<%@ Page Title="Formulario de Especialidad" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="FormEspecialidad.aspx.cs" Inherits="CentroEstetica.FormEspecialidad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8 col-md-10">

                <asp:Panel ID="pnlMensaje" runat="server" Visible="false" role="alert">
                    <asp:Literal ID="litMensaje" runat="server"></asp:Literal>
                </asp:Panel>

                <div class="card shadow-sm mb-4 border-0 rounded-4">
                    <div class="card-body p-4">
                        
                        <h2 class="h4 mb-4 fw-bold" runat="server" id="tituloPagina" style="font-family: 'Playfair Display', serif;">Nueva Especialidad</h2>

                        <div class="mb-3">
                            <label for="txtNombre" class="form-label fw-bold text-secondary small">Nombre</label>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" MaxLength="100"></asp:TextBox>
                            
                            <div class="mt-1">
                                <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre"
                                    ErrorMessage="El nombre es obligatorio." CssClass="text-danger small" Display="Dynamic" 
                                    ValidationGroup="Especialidad" />
                                
                                <asp:RegularExpressionValidator ID="revNombre" runat="server" ControlToValidate="txtNombre"
                                    ErrorMessage="Solo letras y espacios." CssClass="text-danger small" Display="Dynamic" 
                                    ValidationGroup="Especialidad" ValidationExpression="^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$" />
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="txtDescripcion" class="form-label fw-bold text-secondary small">Descripción</label>
                            <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" MaxLength="500"></asp:TextBox>
                            
                            <div class="mt-1">
                                <asp:RegularExpressionValidator ID="revDescripcion" runat="server" ControlToValidate="txtDescripcion"
                                    ErrorMessage="Máximo 500 caracteres." CssClass="text-danger small" Display="Dynamic" 
                                    ValidationGroup="Especialidad" ValidationExpression="^[\s\S]{0,500}$" />
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="txtFoto" class="form-label fw-bold text-secondary small">URL de Foto</label>
                            <asp:TextBox ID="txtFoto" runat="server" CssClass="form-control" MaxLength="255"></asp:TextBox>
                            
                            <div class="mt-1">
                                <asp:RegularExpressionValidator ID="revFoto" runat="server" ControlToValidate="txtFoto"
                                    ErrorMessage="Formato de URL inválido (debe empezar con http:// o https://)." 
                                    CssClass="text-danger small" Display="Dynamic" ValidationGroup="Especialidad" 
                                    ValidationExpression="^(http|https)://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?$" />
                            </div>
                        </div>

                        <asp:Panel ID="pnlControlesEdicion" runat="server" Visible="false">
                            <div class="mb-3 form-check">
                                <input type="checkbox" id="chkActivo" runat="server" class="form-check-input" />
                                <label class="form-check-label" for="<%= chkActivo.ClientID %>">
                                    Especialidad Activa
                                </label>
                            </div>
                        </asp:Panel>

                        <div class="d-flex gap-2 mt-4">
                            <asp:Button ID="btnGuardar" runat="server" Text="Crear Especialidad" CssClass="btn btn-primary px-4" 
                                OnClick="btnGuardar_Click" ValidationGroup="Especialidad" />
                            
                            <asp:Button ID="btnVolver" runat="server" Text="Volver" CssClass="btn btn-secondary px-4" 
                                OnClick="btnVolver_Click" CausesValidation="false" />
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
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

                <div class="card shadow-sm mb-4">
                    <div class="card-body p-4">
                        
                        
                        <h2 class="h4 mb-4" runat="server" id="tituloPagina">Nueva Especialidad</h2>

                        <div class="mb-3">
                            <label for="txtNombre" class="form-label"><strong>Nombre:</strong></label>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre"
                                ErrorMessage="El nombre es obligatorio." CssClass="text-danger" Display="Dynamic" />
                        </div>

                        <div class="mb-3">
                            <label for="txtDescripcion" class="form-label"><strong>Descripción:</strong></label>
                            <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4"></asp:TextBox>
                            
                        </div>

                        <div class="mb-3">
                            <label for="txtFoto" class="form-label"><strong>URL de Foto:</strong></label>
                            <asp:TextBox ID="txtFoto" runat="server" CssClass="form-control" TextMode="Url"></asp:TextBox>
                            
                        </div>

                        
                        <asp:Panel ID="pnlControlesEdicion" runat="server" Visible="false">
                            <div class="form-check mb-3">
                                <asp:CheckBox ID="chkActivo" runat="server" Text=" Activa" CssClass="form-check-input" />
                            </div>
                        </asp:Panel>

                        <div class="d-flex gap-2">
                            <asp:Button ID="btnGuardar" runat="server" Text="Crear Especialidad" CssClass="btn btn-primary" OnClick="btnGuardar_Click" />
                            <asp:Button ID="btnVolver" runat="server" Text="Volver" CssClass="btn btn-secondary" OnClick="btnVolver_Click" CausesValidation="false" />
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
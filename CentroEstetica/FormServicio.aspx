<%@ Page Title="Formulario de Servicio" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="FormServicio.aspx.cs" Inherits="CentroEstetica.FormServicio" %>

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
                        <h2 class="h4 mb-4 fw-bold" runat="server" id="tituloPagina" style="font-family: 'Playfair Display', serif;">Nuevo Servicio</h2>

                        <div class="mb-3">
                            <label for="ddlEspecialidad" class="form-label fw-bold text-secondary small">Especialidad</label>
                            <asp:DropDownList ID="ddlEspecialidad" runat="server" CssClass="form-select">
                            </asp:DropDownList>
                            
                            <div class="mt-1">
                                <asp:RequiredFieldValidator ID="rfvEspecialidad" runat="server" ControlToValidate="ddlEspecialidad"
                                    ErrorMessage="Debe seleccionar una especialidad." CssClass="text-danger small" Display="Dynamic"
                                    InitialValue="0" ValidationGroup="Servicio" />
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="txtNombre" class="form-label fw-bold text-secondary small">Nombre del Servicio</label>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                            
                            <div class="mt-1">
                                <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre"
                                    ErrorMessage="El nombre es obligatorio." CssClass="text-danger small" Display="Dynamic" ValidationGroup="Servicio" />
                                
                                <asp:RegularExpressionValidator ID="revNombreLetras" runat="server" ControlToValidate="txtNombre"
                                    ErrorMessage="Solo letras y espacios." CssClass="text-danger small" Display="Dynamic" 
                                    ValidationGroup="Servicio" ValidationExpression="^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$" />
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="txtDescripcion" class="form-label fw-bold text-secondary small">Descripción</label>
                            <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" MaxLength="500"></asp:TextBox>
                            
                            <div class="mt-1">
                                <asp:RegularExpressionValidator ID="revDescripcion" runat="server" ControlToValidate="txtDescripcion"
                                    ErrorMessage="Máximo 500 caracteres." CssClass="text-danger small" Display="Dynamic" 
                                    ValidationGroup="Servicio" ValidationExpression="^[\s\S]{0,500}$" />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="txtPrecio" class="form-label fw-bold text-secondary small">Precio ($)</label>
                                <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" TextMode="Number" step="0.01"></asp:TextBox>
                                
                                <div class="mt-1">
                                    <asp:RequiredFieldValidator ID="rfvPrecio" runat="server" ControlToValidate="txtPrecio"
                                        ErrorMessage="Requerido." CssClass="text-danger small" Display="Dynamic" ValidationGroup="Servicio" />
                                    
                                    <asp:CompareValidator ID="cvPrecio" runat="server" ControlToValidate="txtPrecio"
                                        ErrorMessage="Debe ser numérico." CssClass="text-danger small" Display="Dynamic"
                                        Operator="DataTypeCheck" Type="Currency" ValidationGroup="Servicio" />
                                    
                                    <asp:RangeValidator ID="rvPrecio" runat="server" ControlToValidate="txtPrecio"
                                        ErrorMessage="Debe ser mayor a 0." CssClass="text-danger small" Display="Dynamic"
                                        MinimumValue="0.01" MaximumValue="1000000" Type="Currency" ValidationGroup="Servicio" />
                                </div>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="txtDuracion" class="form-label fw-bold text-secondary small">Duración (minutos)</label>
                                <asp:TextBox ID="txtDuracion" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                
                                <div class="mt-1">
                                    <asp:RequiredFieldValidator ID="rfvDuracion" runat="server" ControlToValidate="txtDuracion"
                                        ErrorMessage="Requerido." CssClass="text-danger small" Display="Dynamic" ValidationGroup="Servicio" />
                                    
                                    <asp:CompareValidator ID="cvDuracion" runat="server" ControlToValidate="txtDuracion"
                                        ErrorMessage="Debe ser entero." CssClass="text-danger small" Display="Dynamic"
                                        Operator="DataTypeCheck" Type="Integer" ValidationGroup="Servicio" />
                                    
                                    <asp:RangeValidator ID="rvDuracion" runat="server" ControlToValidate="txtDuracion"
                                        ErrorMessage="Entre 1 y 1440 min." CssClass="text-danger small" Display="Dynamic"
                                        MinimumValue="1" MaximumValue="1440" Type="Integer" ValidationGroup="Servicio" />
                                </div>
                            </div>
                        </div>

                        <asp:Panel ID="pnlControlesEdicion" runat="server" Visible="false">
                            <div class="mb-3 form-check">
                                <input type="checkbox" id="chkActivo" runat="server" class="form-check-input" />
                                <label class="form-check-label" for="<%= chkActivo.ClientID %>">
                                    Servicio Activo
                                </label>
                            </div>
                        </asp:Panel>

                        <div class="d-flex gap-2 mt-4">
                            <asp:Button ID="btnGuardar" runat="server" Text="Guardar Cambios" CssClass="btn btn-primary px-4" 
                                OnClick="btnGuardar_Click" ValidationGroup="Servicio" />
                            
                            <asp:Button ID="btnVolver" runat="server" Text="Volver" CssClass="btn btn-secondary px-4" 
                                OnClick="btnVolver_Click" CausesValidation="false" />
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
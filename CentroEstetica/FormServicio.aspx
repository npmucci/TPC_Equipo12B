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

                <div class="card shadow-sm mb-4">
                    <div class="card-body p-4">
                        <h2 class="h4 mb-4" runat="server" id="tituloPagina">Nuevo Servicio</h2>

                        <div class="mb-3">
                            <label for="ddlEspecialidad" class="form-label"><strong>Especialidad:</strong></label>
                            <asp:DropDownList ID="ddlEspecialidad" runat="server" CssClass="form-select">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvEspecialidad" runat="server" ControlToValidate="ddlEspecialidad"
                                ErrorMessage="Debe seleccionar una especialidad." CssClass="text-danger" Display="Dynamic"
                                InitialValue="0" /> 
                        </div>

                        <div class="mb-3">
                            <label for="txtNombre" class="form-label"><strong>Nombre del Servicio:</strong></label>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre"
                                ErrorMessage="El nombre es obligatorio." CssClass="text-danger" Display="Dynamic" />
                        </div>

                        <div class="mb-3">
                            <label for="txtDescripcion" class="form-label"><strong>Descripción:</strong></label>
                            <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4"></asp:TextBox>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="txtPrecio" class="form-label"><strong>Precio ($):</strong></label>
                                <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" TextMode="Number" step="0.01"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPrecio" runat="server" ControlToValidate="txtPrecio"
                                    ErrorMessage="El precio es obligatorio." CssClass="text-danger" Display="Dynamic" />
                                <asp:CompareValidator ID="cvPrecio" runat="server" ControlToValidate="txtPrecio"
                                    ErrorMessage="Debe ser un valor numérico." CssClass="text-danger" Display="Dynamic"
                                    Operator="DataTypeCheck" Type="Currency" />
                                <asp:RangeValidator ID="rvPrecio" runat="server" ControlToValidate="txtPrecio"
                                    ErrorMessage="El precio debe ser mayor a 0." CssClass="text-danger" Display="Dynamic"
                                    MinimumValue="0.01" MaximumValue="1000000" Type="Currency" />
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="txtDuracion" class="form-label"><strong>Duración (minutos):</strong></label>
                                <asp:TextBox ID="txtDuracion" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvDuracion" runat="server" ControlToValidate="txtDuracion"
                                    ErrorMessage="La duración es obligatoria." CssClass="text-danger" Display="Dynamic" />
                                <asp:CompareValidator ID="cvDuracion" runat="server" ControlToValidate="txtDuracion"
                                    ErrorMessage="Debe ser un número entero." CssClass="text-danger" Display="Dynamic"
                                    Operator="DataTypeCheck" Type="Integer" />
                                <asp:RangeValidator ID="rvDuracion" runat="server" ControlToValidate="txtDuracion"
                                    ErrorMessage="La duración debe ser mayor a 0." CssClass="text-danger" Display="Dynamic"
                                    MinimumValue="1" MaximumValue="1440" Type="Integer" />
                            </div>
                        </div>

                        
                        <asp:Panel ID="pnlControlesEdicion" runat="server" Visible="false">
                            <div class="form-check mb-3">
                                <asp:CheckBox ID="chkActivo" runat="server" Text=" Activo" CssClass="form-check-input" />
                            </div>
                        </asp:Panel>

                        <div class="d-flex gap-2">
                            <asp:Button ID="btnGuardar" runat="server" Text="Crear Servicio" CssClass="btn btn-primary" OnClick="btnGuardar_Click" />
                            <asp:Button ID="btnVolver" runat="server" Text="Volver" CssClass="btn btn-secondary" OnClick="btnVolver_Click" CausesValidation="false" />
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
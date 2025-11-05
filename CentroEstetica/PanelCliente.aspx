<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PanelCliente.aspx.cs" Inherits="CentroEstetica.PanelCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container py-5">

        <!-- PERFIL DEL CLIENTE -->
 <div class="card shadow-sm mb-4">
        <div class="card-body">
            <h2 class="h4 mb-3">Mi Perfil</h2>

            <div class="mb-3">
                <label for="txtNombre" class="form-label"><strong>Nombre:</strong></label>
                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                <asp:RequiredFieldValidator  ID="rfvNombre" runat="server" ControlToValidate="txtNombre" ErrorMessage="El nombre es obligatorio." CssClass="text-danger"  Display="Dynamic" />
            </div>

            <div class="mb-3">
                <label for="txtApellido" class="form-label"><strong>Apellido:</strong></label>
                <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                <asp:RequiredFieldValidator  ID="rfvApellido" runat="server"  ControlToValidate="txtApellido" ErrorMessage="El apellido es obligatorio." CssClass="text-danger"  Display="Dynamic" />
            </div>

            <div class="mb-3">
                <label for="txtMail" class="form-label"><strong>Email:</strong></label>
                <asp:TextBox ID="txtMail" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvMail" runat="server" ControlToValidate="txtMail" ErrorMessage="El email es obligatorio." CssClass="text-danger"  Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revMail" runat="server"  ControlToValidate="txtMail"  ErrorMessage="Formato de email no válido."  CssClass="text-danger"  Display="Dynamic" ValidationExpression="^[\w\.-]+@[\w\.-]+\.\w+$" />
                
            </div>

            <div class="mb-3">
                <label for="txtTelefono" class="form-label"><strong>Teléfono:</strong></label>
                <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                <asp:RequiredFieldValidator  ID="rfvTelefono" runat="server"  ControlToValidate="txtTelefono" ErrorMessage="El teléfono es obligatorio." CssClass="text-danger"  Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revTelefono" runat="server" ControlToValidate="txtTelefono" ErrorMessage="El teléfono solo debe contener números." CssClass="text-danger" Display="Dynamic" ValidationExpression="^\d{10}$" />
            </div>

            <div class="mb-3">
                <label for="txtDomicilio" class="form-label"><strong>Domicilio:</strong></label>
                <asp:TextBox ID="txtDomicilio" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
            </div>

            <asp:Button ID="btnEditar" runat="server" Text="Modificar" CssClass="btn btn-danger btn-sm mt-2" OnClick="btnEditar_Click" />
            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-success btn-sm mt-2" OnClick="btnGuardar_Click" Visible="false" />
            <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary btn-sm mt-2" OnClick="btnCancelar_Click" Visible="false" CausesValidation="false" /> <!-- para que no se ejecuten las valiadciones y me permita cancelar una modificacion-->
        </div>
    </div>

        <!-- MIS TURNOS -->
        <div class="mb-5">
            <h2 class="h4 mb-3">Mis Turnos</h2>
            <div class="d-flex flex-column gap-3">

                <!-- Turno 1 -->
                <div class="card shadow-sm">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <p class="mb-1"><strong>Servicio:</strong> Masaje Relajante</p>
                            <p class="mb-1"><strong>Profesional:</strong> María González</p>
                            <p class="mb-0"><strong>Fecha y Hora:</strong> 05/11/2025 - 15:00</p>
                        </div>
                        <button class="btn btn-danger btn-sm">Cancelar</button>
                    </div>
                </div>

                <!-- Turno 2 -->
                <div class="card shadow-sm">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <p class="mb-1"><strong>Servicio:</strong> Lifting de Pestañas</p>
                            <p class="mb-1"><strong>Profesional:</strong> Luisa Fernández</p>
                            <p class="mb-0"><strong>Fecha y Hora:</strong> 12/11/2025 - 10:00</p>
                        </div>
                        <button class="btn btn-danger btn-sm">Cancelar</button>
                    </div>
                </div>

            </div>
        </div>
    </div>



</asp:Content>

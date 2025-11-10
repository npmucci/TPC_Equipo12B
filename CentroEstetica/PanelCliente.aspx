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
                    <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre" ErrorMessage="El nombre es obligatorio." CssClass="text-danger" Display="Dynamic" />
                </div>

                <div class="mb-3">
                    <label for="txtApellido" class="form-label"><strong>Apellido:</strong></label>
                    <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvApellido" runat="server" ControlToValidate="txtApellido" ErrorMessage="El apellido es obligatorio." CssClass="text-danger" Display="Dynamic" />
                </div>

                <div class="mb-3">
                    <label for="txtDni" class="form-label"><strong>Dni:</strong></label>
                    <asp:TextBox ID="txtDni" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDni" ErrorMessage="El Dni es obligatorio." CssClass="text-danger" Display="Dynamic" />
                </div>

                <div class="mb-3">
                    <label for="txtMail" class="form-label"><strong>Email:</strong></label>
                    <asp:TextBox ID="txtMail" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvMail" runat="server" ControlToValidate="txtMail" ErrorMessage="El email es obligatorio." CssClass="text-danger" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revMail" runat="server" ControlToValidate="txtMail" ErrorMessage="Formato de email no válido." CssClass="text-danger" Display="Dynamic" ValidationExpression="^[\w\.-]+@[\w\.-]+\.\w+$" />

                </div>

                <div class="mb-3">
                    <label for="txtTelefono" class="form-label"><strong>Teléfono:</strong></label>
                    <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="txtTelefono" ErrorMessage="El teléfono es obligatorio." CssClass="text-danger" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revTelefono" runat="server" ControlToValidate="txtTelefono" ErrorMessage="El teléfono solo debe contener números." CssClass="text-danger" Display="Dynamic" ValidationExpression="^\d{10}$" />
                </div>

                <div class="mb-3">
                    <label for="txtDomicilio" class="form-label"><strong>Domicilio:</strong></label>
                    <asp:TextBox ID="txtDomicilio" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                </div>

                <asp:Button ID="btnEditar" runat="server" Text="Modificar" CssClass="btn btn-danger btn-sm mt-2" OnClick="btnEditar_Click" />
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-success btn-sm mt-2" OnClick="btnGuardar_Click" Visible="false" />
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary btn-sm mt-2" OnClick="btnCancelar_Click" Visible="false" CausesValidation="false" />
                <asp:Button ID="btnCambiarPass" runat="server" Text="Modificar Contraseña" CssClass="btn btn-success btn-sm mt-2" Visible = false OnClientClick="abrirModalCambiarPass();" />


            </div>
        </div>

        <!-- TURNOS Pasados-->
        <h3>Turnos Pasados</h3>
        <asp:Repeater ID="rptTurnosPasados" runat="server">
            <ItemTemplate>

                <div class="mb-5">
                    <div class="d-flex flex-column gap-3">
                        <div class="card shadow-sm">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <p class="mb-1"><strong>Servicio:</strong> <%# Eval("Servicio.Nombre") %></p>
                                    <p class="mb-1"><strong>Profesional:</strong> <%# Eval("Profesional.Nombre") + " " + Eval("Profesional.Apellido") %></p>
                                    <p class="mb-0"><strong>Fecha y Hora:</strong> <%# Eval("FechaString") + " " + Eval("HoraInicio") %></p>
                                    <p class="mb-0"><strong>Estado</strong> <%# Eval("Estado") %></p>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <!-- TURNOS Actuales-->
        <h3>Turnos Actuales</h3>
        <asp:Repeater ID="rptTurnosActuales" runat="server">
            <ItemTemplate>

                <div class="mb-5">
                    <div class="d-flex flex-column gap-3">
                        <div class="card shadow-sm">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <p class="mb-1"><strong>Servicio:</strong> <%# Eval("Servicio.Nombre") %></p>
                                    <p class="mb-1"><strong>Profesional:</strong> <%# Eval("Profesional.Nombre") + " " + Eval("Profesional.Apellido") %></p>
                                    <p class="mb-0"><strong>Fecha y Hora:</strong> <%# Eval("FechaString") + " " + Eval("HoraInicio") %></p>
                                    <p class="mb-0"><strong>Estado</strong> <%# Eval("Estado") %></p>
                                </div>
                                <button class="btn btn-danger btn-sm">Cancelar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>

        </asp:Repeater>


        <!--  Cambiar Contraseña -->
    
        <div class="modal fade" id="modalCambiarPass" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">

                    <div class="modal-header">
                        <h5 class="modal-title" id="modalLabel">Cambiar Contraseña</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>

                    <div class="modal-body">
                        <asp:UpdatePanel ID="updCambiarPass" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>

                                <div class="mb-3">
                                    <label class="form-label">Contraseña Actual</label>
                                    <asp:TextBox ID="txtPassActual" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvPassActual" runat="server"
                                        ControlToValidate="txtPassActual"
                                        ErrorMessage="La contraseña actual es obligatoria."
                                        CssClass="text-danger" Display="Dynamic" ValidationGroup="PassGroup" />
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Nueva Contraseña</label>
                                    <asp:TextBox ID="txtPassNueva" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvPassNueva" runat="server"
                                        ControlToValidate="txtPassNueva"
                                        ErrorMessage="La nueva contraseña es obligatoria."
                                        CssClass="text-danger" Display="Dynamic" ValidationGroup="PassGroup" />
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Confirmar Contraseña</label>
                                    <asp:TextBox ID="txtPassConfirmar" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvPassConfirmar" runat="server"
                                        ControlToValidate="txtPassConfirmar"
                                        ErrorMessage="La confirmación es obligatoria."
                                        CssClass="text-danger" Display="Dynamic" ValidationGroup="PassGroup" />
                                    <asp:CompareValidator ID="cvPassConfirmar" runat="server"
                                        ControlToValidate="txtPassConfirmar" ControlToCompare="txtPassNueva"
                                        ErrorMessage="Las contraseñas no coinciden."
                                        CssClass="text-danger" Display="Dynamic" ValidationGroup="PassGroup" />
                                </div>

                                <asp:Label ID="lblErrorPass" runat="server" CssClass="text-danger d-block" EnableViewState="false"></asp:Label>
                                <asp:Label ID="lblExitoPass" runat="server" CssClass="text-success d-block" EnableViewState="false"></asp:Label>

                                <div class="text-end">
                                    <asp:Button ID="btnGuardarContraseniaPnl" runat="server" Text="Guardar" CssClass="btn btn-primary btn-sm"
                                        OnClick="btnGuardarContrasenia_Click" ValidationGroup="PassGroup" />
                                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cancelar</button>
                                </div>

                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnGuardarContraseniaPnl" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>

                </div>
            </div>
        </div>


    </div>
    <script>
        function abrirModalCambiarPass() {
            var modal = new bootstrap.Modal(document.getElementById('modalCambiarPass'));
            modal.show();
        }
        function cerrarModalCambiarPass() {
            var modalElement = document.getElementById('modalCambiarPass');
            var modalInstance = bootstrap.Modal.getInstance(modalElement);
            if (modalInstance) {
                modalInstance.hide();
            }
        }
    </script>

</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PanelCliente.aspx.cs" Inherits="CentroEstetica.PanelCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container py-5">

        <!-- PERFIL DEL CLIENTE -->
        <div class="card shadow-sm mb-4">
            <div class="card-body">
                <h2 class="h4 mb-3">Mi Perfil</h2>


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

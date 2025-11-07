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
                <!-- para que no se ejecuten las valiadciones y me permita cancelar una modificacion-->
                <button type="button" class="btn btn-outline-danger btn-sm"
                    data-bs-toggle="modal"
                    data-bs-target="#modalCambiarPass">
                    Cambiar Contraseña
                </button>
            </div>
        </div>

        <!-- TURNOS-->
        <asp:Repeater ID="rptTurnos" runat="server">
            <ItemTemplate>

                <div class="mb-5">
                    <h2 class="h4 mb-3">Mis Turnos</h2>
                    <div class="d-flex flex-column gap-3">
                        <div class="card shadow-sm">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <p class="mb-1"><strong>Servicio:</strong> <%# Eval("Descripcion") %></p>
                                    <p class="mb-1"><strong>Profesional:</strong> <%# Eval("Nombre") + " " + Eval("Apellido") %></p>
                                    <p class="mb-0"><strong>Fecha y Hora:</strong> <%# Eval("Fecha") + " " + Eval("HoraInicio") %></p>
                                    <p class="mb-0"><strong>Estado</strong> <%# Eval("Fecha") + " " + Eval("Estado") %></p>
                                </div>
                                <button class="btn btn-danger btn-sm">Cancelar</button>
                            </div>
                        </div>
            </ItemTemplate>


        </asp:Repeater>
     

    <div class="modal fade" id="modalCambiarPass" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

                <asp:UpdatePanel ID="updModalPass" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>

                        <div class="modal-header">
                            <h5 class="modal-title" id="modalLabel">Cambiar Contraseña</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>

                        <div class="modal-body">

                            <div class="mb-3" id="divPassActual" runat="server">
                                <label for="<%= txtPassActual.ClientID %>" class="form-label">Contraseña Actual</label>
                                <asp:TextBox ID="txtPassActual" runat="server" CssClass="form-control" TextMode="Password" autocomplete="off"></asp:TextBox>
                                <!-- VALIDADOR (NECESARIO) -->
                                <asp:RequiredFieldValidator ID="rfvPassActual" runat="server" ControlToValidate="txtPassActual"
                                    ErrorMessage="La contraseña actual es obligatoria." CssClass="text-danger"
                                    Display="Dynamic" ValidationGroup="PassGroup" />
                            </div>
                            0

                    <div class="mb-3" id="divPassNueva" runat="server">
                        <label for="<%= txtPassNueva.ClientID %>" class="form-label">Nueva Contraseña</label>
                        <asp:TextBox ID="txtPassNueva" runat="server" CssClass="form-control" TextMode="Password" autocomplete="new-password"></asp:TextBox>
                        <!-- VALIDADOR (NECESARIO) -->
                        <asp:RequiredFieldValidator ID="rfvPassNueva" runat="server" ControlToValidate="txtPassNueva"
                            ErrorMessage="La nueva contraseña es obligatoria." CssClass="text-danger"
                            Display="Dynamic" ValidationGroup="PassGroup" />
                    </div>

                            <div class="mb-3" id="divPassConfirmar" runat="server">
                                <label for="<%= txtPassConfirmar.ClientID %>" class="form-label">Confirmar Contraseña</label>
                                <asp:TextBox ID="txtPassConfirmar" runat="server" CssClass="form-control" TextMode="Password" autocomplete="new-password"></asp:TextBox>
                                <!-- VALIDADORES (NECESARIOS) -->
                                <asp:RequiredFieldValidator ID="rfvPassConfirmar" runat="server" ControlToValidate="txtPassConfirmar"
                                    ErrorMessage="La confirmación es obligatoria." CssClass="text-danger"
                                    Display="Dynamic" ValidationGroup="PassGroup" />
                                <asp:CompareValidator ID="cvPassConfirmar" runat="server" ControlToValidate="txtPassConfirmar" ControlToCompare="txtPassNueva"
                                    ErrorMessage="Las contraseñas no coinciden." CssClass="text-danger"
                                    Display="Dynamic" ValidationGroup="PassGroup" />
                            </div>

                            <asp:Label ID="lblModalError" runat="server" CssClass="text-danger" Style="display: none;"></asp:Label>
                            <asp:Label ID="lblModalExito" runat="server" CssClass="text-success" Style="display: none;"></asp:Label>

                        </div>

                        <div class="modal-footer" id="modalFooter" runat="server" clientidmode="Static">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
                                id="btnModalCancelar" runat="server">
                                Cancelar
                            </button>
                            <asp:Button ID="btnGuardarContrasenia" runat="server" Text="Guardar Cambios"
                                CssClass="btn btn-primary"
                                OnClick="btnGuardarContrasenia_Click"
                                ValidationGroup="PassGroup" />
                        </div>

                    </ContentTemplate>


                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnGuardarContrasenia" EventName="Click" />
                    </Triggers>

                </asp:UpdatePanel>


            </div>
        </div>
    </div>

    <script type="text/javascript">

        $(document).ready(function () {

            var modal = $('#modalCambiarPass');


            modal.on('show.bs.modal', function () {

                $("input[id$='txtPassActual']").val('');
                $("input[id$='txtPassNueva']").val('');
                $("input[id$='txtPassConfirmar']").val('');


                $("span[id$='lblModalError']").hide().text('');
                $("span[id$='lblModalExito']").hide().text('');


                $("div[id$='divPassActual']").show();
                $("div[id$='divPassNueva']").show();
                $("div[id$='divPassConfirmar']").show();


                $("div[id$='modalFooter']").css('display', 'flex');
            });
        });

    </script>


</asp:Content>

<%@ Page Title="Confirmar y Pagar" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PagoTurno.aspx.cs" Inherits="CentroEstetica.PagoTurno" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .payment-card {
            background: white;
            border: 1px solid #e9ecef;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        .bank-info-box {
            background-color: #f8f9fa;
            border-left: 4px solid var(--colorPrincipalHover);
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        .total-highlight {
            color: var(--colorPrincipalHover);
            font-weight: 800;
            font-size: 1.5rem;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-7">
                
                <h2 class="text-center fw-bold mb-4" style="font-family:'Playfair Display'">Finalizar Reserva</h2>

                <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="alert alert-danger mb-4">
                    <asp:Literal ID="litMensaje" runat="server"></asp:Literal>
                </asp:Panel>

                <div class="payment-card">
                    
                    <h5 class="fw-bold mb-3 border-bottom pb-2">Resumen del Turno</h5>
                    <div class="row mb-4">
                        <div class="col-6">
                            <small class="text-muted d-block">Servicio</small>
                            <span class="fw-bold"><asp:Label ID="lblServicio" runat="server"></asp:Label></span>
                        </div>
                        <div class="col-6">
                            <small class="text-muted d-block">Profesional</small>
                            <span class="fw-bold"><asp:Label ID="lblProfesional" runat="server"></asp:Label></span>
                        </div>
                        <div class="col-12 mt-2">
                            <small class="text-muted d-block">Fecha y Hora</small>
                            <span class="fw-bold text-primary"><asp:Label ID="lblFechaHora" runat="server"></asp:Label></span>
                        </div>
                    </div>

                    <h5 class="fw-bold mb-3 border-bottom pb-2">Monto a Pagar</h5>
                    <div class="mb-4">
                        
                        <asp:Panel ID="pnlInfoSenia" runat="server" Visible="false" CssClass="alert alert-warning border-warning d-flex align-items-center">
                            <i class="bi bi-piggy-bank fs-3 me-3"></i>
                            <div>
                                <strong>Pago de Seña (50%)</strong><br />
                                <small>Abonás la mitad ahora para reservar. El resto se paga en el local.</small>
                            </div>
                        </asp:Panel>
                    
                        <asp:Panel ID="pnlInfoTotal" runat="server" Visible="false" CssClass="alert alert-info border-info d-flex align-items-center">
                            <i class="bi bi-lightning-charge fs-3 me-3"></i>
                            <div>
                                <strong>Pago Total (100%)</strong><br />
                                <small>Al reservar con menos de 24hs de antelación, se requiere el pago completo.</small>
                            </div>
                        </asp:Panel>
                        
                        <div class="d-flex justify-content-between align-items-center mt-3 bg-light p-3 rounded">
                            <span class="fw-bold">Total a Pagar Ahora:</span>
                            <asp:Label ID="lblMontoAPagar" runat="server" Text="$0" CssClass="total-highlight"></asp:Label>
                        </div>
                        
                        <asp:HiddenField ID="hfTipoPagoCalculado" runat="server" />
                    </div>

                    <h5 class="fw-bold mb-3 border-bottom pb-2">Forma de Pago</h5>
                    
                    <asp:Panel ID="pnlOpcionesAdmin" runat="server" Visible="false">
                        <asp:RadioButtonList ID="rblFormaPagoAdmin" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblFormaPagoAdmin_SelectedIndexChanged">
                            <asp:ListItem Value="Efectivo"> Efectivo (En el local)</asp:ListItem>
                            <asp:ListItem Value="Transferencia"> Transferencia Bancaria</asp:ListItem>
                        </asp:RadioButtonList>
                    </asp:Panel>

                    <asp:Panel ID="pnlOpcionesCliente" runat="server" Visible="false">
                        <div class="alert alert-info border-0">
                            <i class="bi bi-info-circle-fill me-2"></i>
                            Para confirmar tu turno, debes realizar una transferencia bancaria.
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnlDatosTransferencia" runat="server" Visible="false">
                        <div class="bank-info-box">
                            <h6 class="fw-bold mb-2">Datos Bancarios:</h6>
                            <p class="mb-1"><strong>Banco:</strong> Santander Río</p>
                            <p class="mb-1"><strong>CBU:</strong> 0720000088000035489221</p>
                            <p class="mb-1"><strong>Alias:</strong> ESTETICA.CENTRO.PAGO</p>
                            <p class="mb-0"><strong>Titular:</strong> Centro de Estética S.A.</p>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Código de Transacción / Comprobante</label>
                            <asp:TextBox ID="txtCodigoTransaccion" runat="server" CssClass="form-control" placeholder="Ej: 2023005849..."></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCodigo" runat="server" ControlToValidate="txtCodigoTransaccion" 
                                ErrorMessage="Por favor, ingrese el código de operación." CssClass="text-danger small" Display="Dynamic" Enabled="false" />
                        </div>
                    </asp:Panel>

                    <div class="d-grid gap-2 mt-4">
                        <asp:Button ID="btnConfirmar" runat="server" Text="Confirmar y Reservar" 
                            CssClass="btn btn-dark btn-lg fw-bold" OnClick="btnConfirmar_Click" />
                        <asp:Button ID="btnVolver" runat="server" Text="Volver atrás" 
                            CssClass="btn btn-outline-secondary" OnClick="btnVolver_Click" CausesValidation="false" />
                    </div>

                </div>
            </div>
        </div>
    </div>

</asp:Content>
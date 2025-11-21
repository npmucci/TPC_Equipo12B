<%@ Page Title="Reservar Turno" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ReservarTurno.aspx.cs" Inherits="CentroEstetica.ReservarTurno" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
    

    /* Badges */
    .step-badge {
        background-color: var(--coloroFondoOscuro);
        color: white;
        width: 32px; height: 32px;
        display: flex; align-items: center; justify-content: center;
        border-radius: 8px;
        font-family: 'Playfair Display', serif;
    }

    /* Tarjeta Resumen */
    .resumen-card {
        background-color: var(--colorFondoOpcional);
        color: var(--colorTexto);
        border: 1px solid #e6dac8;
        border-radius: 4px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    }

    .resumen-label {
        color: var(--coloroFondoOscuro);
        font-family: 'Playfair Display', serif;
        font-style: italic;
        font-size: 0.9rem;
        margin-bottom: 0;
    }

    .resumen-dato {
        color: #333;
        font-weight: 700;
        font-size: 1.05rem;
        border-bottom: 1px solid rgba(175, 141, 132, 0.3);
        display: block;
        padding-bottom: 2px;
    }

    .resumen-total {
        color: var(--coloroFondoOscuro);
        font-family: 'Playfair Display', serif;
        font-size: 2rem;
    }

    .resumen-divider { border-color: rgba(175, 141, 132, 0.2) !important; }

    /* Botones de Horario */
    .btn-time-slot {
        border: 1px solid var(--coloroFondoOscuro);
        color: var(--coloroFondoOscuro);
        background-color: transparent;
        border-radius: 4px !important;
        width: 100px;
        margin: 6px;
        transition: all 0.2s;
    }
    .btn-time-slot:hover {
        background-color: var(--coloroFondoOscuro);
        color: white;
    }
    .btn-time-slot.selected {
        background-color: var(--coloroFondoOscuro);
        color: white;
        border: 1px solid var(--coloroFondoOscuro);
    }

    /* Calendario*/
    .modern-calendar { width: 100%; border: 1px solid #e0e0e0; }
    .modern-calendar th { background-color: #f9f9f9; font-family: 'Playfair Display', serif; color: #333; }
    .modern-calendar td { border: 1px solid #eee; height: 50px; width: 50px; text-align: center; }
    
    .modern-calendar a { 
        text-decoration: none; 
        display: flex; align-items: center; justify-content: center;
        height: 100%; width: 100%;
        color: #555; 
        border-radius: 50%; 
        transition: background-color 0.2s;
    }

    /* DÍA CON DISPONIBILIDAD */
    .day-available {
        background-color: color-mix(in srgb,var(--colorPrincipal) 60%,var(--colorPrincipalHover) 40%) !important;
        color: white !important;
        font-weight: bold;
        border-radius: 50% !important; 
    }
    
    
    .modern-calendar a.day-available:hover {
        background-color: var(--coloroFondoOscuro) !important;
        color: white !important;
    }

  
    .selected-day-style {
        background-color: var(--colorPrincipalHover) !important;
        color: white !important;
        position: relative;
        
        border-radius: 50% !important;
    }
    
    .selected-day-style::after {
        content: '';
        position: absolute;
        top: 3px; left: 3px; right: 3px; bottom: 3px;
        border: 1px solid white;
        
        border-radius: 50%; 
    }

    .btn-continuar {
        background-color: var(--coloroFondoOscuro);
        color: white;
        border-radius: 4px;
        text-transform: uppercase;
        font-family: 'Playfair Display', serif;
        letter-spacing: 1px;
    }
    .btn-continuar:hover {
        background-color: #8c6a61;
        color: white;
    }
    .btn-continuar:disabled { background-color: #ccc; }

</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="container py-5">
        <div class="row">
            
            <div class="col-lg-8 mb-5">
                <h2 class="fw-bold mb-4" style="font-family: 'Playfair Display', serif;">Reservar Nuevo Turno</h2>

                <asp:UpdatePanel ID="upReserva" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>

                        <div class="card border-0 shadow-sm mb-4 rounded-4">
                            <div class="card-header bg-white border-0 pt-4 px-4 rounded-top-4">
                                <div class="d-flex align-items-center">
                                    <div class="step-badge me-3">1</div>
                                    <h5 class="mb-0 fw-bold">Seleccioná el Servicio</h5>
                                </div>
                            </div>
                            <div class="card-body p-4">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label text-muted small fw-bold">Especialidad</label>
                                        <asp:DropDownList ID="ddlEspecialidad" runat="server" CssClass="form-select" 
                                            AutoPostBack="true" OnSelectedIndexChanged="ddlEspecialidad_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label text-muted small fw-bold">Servicio</label>
                                        <asp:DropDownList ID="ddlServicio" runat="server" CssClass="form-select" 
                                            AutoPostBack="true" OnSelectedIndexChanged="ddlServicio_SelectedIndexChanged" Enabled="false">
                                            <asp:ListItem Text="Seleccione especialidad primero" Value="0" />
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <asp:Panel ID="pnlProfesional" runat="server" Visible="false"> 
                            <div class="card border-0 shadow-sm mb-4 rounded-4">
                                <div class="card-header bg-white border-0 pt-4 px-4 rounded-top-4">
                                    <div class="d-flex align-items-center">
                                        <div class="step-badge me-3">2</div>
                                        <h5 class="mb-0 fw-bold">Elegí al Profesional</h5>
                                    </div>
                                </div>
                                <div class="card-body p-4">
                                    <asp:DropDownList ID="ddlProfesional" runat="server" CssClass="form-select" 
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlProfesional_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <div id="msgProfesional" runat="server" visible="false" class="alert alert-warning mt-3 mb-0 small border-0 bg-warning-subtle text-warning-emphasis">
                                        <i class="bi bi-exclamation-circle me-2"></i> No hay profesionales disponibles para este servicio.
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="pnlFechaHora" runat="server" Visible="false">
                            <div class="card border-0 shadow-sm mb-4 rounded-4">
                                <div class="card-header bg-white border-0 pt-4 px-4 rounded-top-4">
                                    <div class="d-flex align-items-center">
                                        <div class="step-badge me-3">3</div>
                                        <h5 class="mb-0 fw-bold">Fecha y Hora</h5>
                                    </div>
                                </div>
                                <div class="card-body p-4">
                                    <div class="row">
                                        <div class="col-md-6 border-end">
                                            <label class="form-label text-muted small fw-bold mb-3">Seleccioná un día:</label>
                                            <div class="d-flex justify-content-center">
                                                <asp:Calendar ID="calFecha" runat="server" 
                                                    CssClass="modern-calendar" 
                                                    DayNameFormat="Shortest" 
                                                    OnSelectionChanged="calFecha_SelectionChanged"
                                                    OnDayRender="calFecha_DayRender"
                                                    OnVisibleMonthChanged="calFecha_VisibleMonthChanged">
                                                
                                                    <TitleStyle BackColor="White" Font-Bold="True" ForeColor="Black" CssClass="py-2 font-playfair" />
                                                    <NextPrevStyle Font-Bold="True" ForeColor="#D85C7E" />
                                                    <DayHeaderStyle Font-Bold="True" />
                                                    <SelectedDayStyle CssClass="selected-day-style" />
                                                    <OtherMonthDayStyle ForeColor="#cccccc" />
                                                </asp:Calendar>
                                            </div>
                                        </div>
                                        
                                        <div class="col-md-6 ps-md-4 pt-3 pt-md-0">
                                            <label class="form-label text-muted small fw-bold mb-3">Horarios disponibles:</label>
                                            
                                            <asp:Panel ID="pnlHorarios" runat="server">
                                                <div id="msgSeleccionarFecha" runat="server" class="text-center py-4 text-muted opacity-50">
                                                    <i class="bi bi-calendar-touch fs-1 mb-2 d-block"></i>
                                                    Tocá un día para ver horarios.
                                                </div>
                                                
                                                <div id="msgSinHorarios" runat="server" visible="false" class="alert alert-light text-center small border-0 text-muted">
                                                    <i class="bi bi-emoji-frown fs-5 d-block mb-1"></i>
                                                    Sin turnos para esta fecha.
                                                </div>

                                                <div class="d-flex flex-wrap gap-2 justify-content-center">
                                                    <asp:Repeater ID="rptHorarios" runat="server" OnItemCommand="rptHorarios_ItemCommand">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="btnHora" runat="server" 
                                                                Text='<%# Container.DataItem %>' 
                                                                CommandArgument='<%# Container.DataItem %>'
                                                                CssClass='<%# "btn btn-sm btn-time-slot rounded-pill py-2 " + ((string)Container.DataItem == hfHoraSeleccionada.Value ? "selected" : "") %>' 
                                                                />
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </asp:Panel>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>

                        <asp:HiddenField ID="hfHoraSeleccionada" runat="server" />

                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>

            <div class="col-lg-4">
                <div class="sticky-top" style="top: 110px; z-index: 100;">
                    
                    <asp:UpdatePanel ID="upResumen" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="card resumen-card p-4">
                                <h5 class="fw-bold mb-4 border-bottom resumen-divider pb-3" style="font-family: 'Playfair Display', serif; color: var(--colorPrincipalHover);">Tu Reserva</h5>
                                
                                <div class="mb-4">
                                    <small class="resumen-label">Servicio</small>
                                    <asp:Label ID="lblResumenServicio" runat="server" Text="-" CssClass="resumen-dato"></asp:Label>
                                </div>
                    
                                <div class="mb-4">
                                    <small class="resumen-label">Profesional</small>
                                    <asp:Label ID="lblResumenProfesional" runat="server" Text="-" CssClass="resumen-dato"></asp:Label>
                                </div>
                    
                                <div class="mb-4">
                                    <div class="row">
                                        <div class="col-6 border-end resumen-divider">
                                            <small class="resumen-label">Fecha</small>
                                            <asp:Label ID="lblResumenFecha" runat="server" Text="-" CssClass="resumen-dato fs-6"></asp:Label>
                                        </div>
                                        <div class="col-6 ps-3">
                                            <small class="resumen-label">Hora</small>
                                            <asp:Label ID="lblResumenHora" runat="server" Text="-" CssClass="resumen-dato text-resumen-highlight fs-5"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                    
                                <div class="d-flex justify-content-between align-items-center border-top resumen-divider pt-3 mb-4">
                                    <span class="h6 mb-0 fw-bold text-muted">Total Estimado</span>
                                    <asp:Label ID="lblResumenPrecio" runat="server" Text="$0" CssClass="h3 mb-0 resumen-total"></asp:Label>
                                </div>
                    
                                <div class="d-grid">
                                    <asp:Button ID="btnContinuarReserva" runat="server" Text="Continuar" 
                                        CssClass="btn btn-lg text-white fw-bold rounded-pill btn-continuar" 
                                        OnClick="btnContinuarReserva_Click" Enabled="false" />
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>

        </div>
    </div>
</asp:Content>
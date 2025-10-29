<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PanelProfesional.aspx.cs" Inherits="CentroEstetica.PanelProfesional" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="container py-5">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-3">
            <div>
                <h1 class="display-6 mb-2">Panel Profesional</h1>
                <p class="text-muted mb-0">Bienvenida, María González</p>
            </div>
            <div class="d-flex gap-2">
                <button class="btn btn-outline-secondary">⚙️ Configurar Horarios</button>
                <button class="btn btn-primary">+ Bloquear Horario</button>
            </div>
        </div>

            <!-- Turnos de Hoy -->
            <div class="col-lg-8">
                <div class="card shadow-sm">
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h2 class="h4 mb-0">Turnos de Hoy</h2>
                            <span class="text-muted small">Miércoles, 15 de Enero</span>
                        </div>
                        
                        <div class="d-flex flex-column gap-3">
                            <div class="appointment-card border rounded-3 p-3">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <div class="fw-bold" style="color: var(--primary-color); font-size: 1.125rem;">09:00 - 10:00</div>
                                    <span class="badge bg-success">Confirmado</span>
                                </div>
                                <div class="mb-3">
                                    <div class="mb-1"><span class="fw-bold">Cliente:</span> Laura Pérez</div>
                                    <div class="mb-1"><span class="fw-bold">Servicio:</span> Tratamiento Facial</div>
                                    <div><span class="fw-bold">Teléfono:</span> (011) 4567-8901</div>
                                </div>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-sm btn-primary">✓ Completar</button>
                                    <button class="btn btn-sm btn-outline-secondary">✕ Cancelar</button>
                                    <button class="btn btn-sm btn-outline-secondary">💬 Contactar</button>
                                </div>
                            </div>

                            <div class="appointment-card border rounded-3 p-3">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <div class="fw-bold" style="color: var(--primary-color); font-size: 1.125rem;">11:00 - 12:00</div>
                                    <span class="badge bg-success">Confirmado</span>
                                </div>
                                <div class="mb-3">
                                    <div class="mb-1"><span class="fw-bold">Cliente:</span> Sofía Ramírez</div>
                                    <div class="mb-1"><span class="fw-bold">Servicio:</span> Tratamiento Facial Premium</div>
                                    <div><span class="fw-bold">Teléfono:</span> (011) 4567-8902</div>
                                </div>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-sm btn-primary">✓ Completar</button>
                                    <button class="btn btn-sm btn-outline-secondary">✕ Cancelar</button>
                                    <button class="btn btn-sm btn-outline-secondary">💬 Contactar</button>
                                </div>
                            </div>

                            <div class="appointment-card border rounded-3 p-3">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <div class="fw-bold" style="color: var(--primary-color); font-size: 1.125rem;">14:00 - 15:00</div>
                                    <span class="badge bg-warning text-dark">Pendiente</span>
                                </div>
                                <div class="mb-3">
                                    <div class="mb-1"><span class="fw-bold">Cliente:</span> Carla Mendoza</div>
                                    <div class="mb-1"><span class="fw-bold">Servicio:</span> Limpieza Facial</div>
                                    <div><span class="fw-bold">Teléfono:</span> (011) 4567-8903</div>
                                </div>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-sm btn-primary">✓ Confirmar</button>
                                    <button class="btn btn-sm btn-outline-secondary">✕ Rechazar</button>
                                    <button class="btn btn-sm btn-outline-secondary">💬 Contactar</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


                <!-- Próximos Turnos -->
                <div class="card shadow-sm">
                    <div class="card-body p-4">
                        <h2 class="h5 mb-3">Próximos Turnos</h2>
                        <div class="d-flex flex-column gap-3">
                            <div class="bg-light rounded p-3 border-start border-4" style="border-color: var(--primary-color) !important;">
                                <div class="small text-muted mb-1">Mañana - 10:00</div>
                                <div class="fw-bold mb-1">Tratamiento Facial</div>
                                <div class="small text-muted">Ana García</div>
                            </div>
                            <div class="bg-light rounded p-3 border-start border-4" style="border-color: var(--primary-color) !important;">
                                <div class="small text-muted mb-1">Viernes - 14:00</div>
                                <div class="fw-bold mb-1">Limpieza Profunda</div>
                                <div class="small text-muted">Lucía Fernández</div>
                            </div>
                            <div class="bg-light rounded p-3 border-start border-4" style="border-color: var(--primary-color) !important;">
                                <div class="small text-muted mb-1">Sábado - 11:00</div>
                                <div class="fw-bold mb-1">Tratamiento Anti-edad</div>
                                <div class="small text-muted">Patricia Ruiz</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PanelCliente.aspx.cs" Inherits="CentroEstetica.PanelCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container py-5">

        <!-- PERFIL DEL CLIENTE -->
        <div class="card shadow-sm mb-4">
            <div class="card-body">
                <h2 class="h4 mb-3">Mi Perfil</h2>
                <p><strong>Nombre:</strong> Juan Pérez</p>
                <p><strong>Email:</strong> juan.perez@email.com</p>
                <p><strong>Teléfono:</strong> 011-1234-5678</p>
                <button class="btn btn-danger btn-sm mt-2">Modificar</button>
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


        <div class="text-center mb-5">
            <h1 class="display-5 mb-3">Reservar Turno</h1>
            <p class="text-muted">Completa los siguientes pasos para agendar tu cita</p>
        </div>


        <div class="d-flex justify-content-center gap-3 mb-5 flex-wrap">
            <div class="step active d-flex align-items-center gap-2">
                <div class="step-number">1</div>
                <span class="small">Servicio</span>
            </div>
            <span class="text-muted">→</span>
            <div class="step d-flex align-items-center gap-2">
                <div class="step-number">2</div>
                <span class="small text-muted">Profesional</span>
            </div>
            <span class="text-muted">→</span>
            <div class="step d-flex align-items-center gap-2">
                <div class="step-number">3</div>
                <span class="small text-muted">Fecha y Hora</span>
            </div>
            <span class="text-muted">→</span>
            <div class="step d-flex align-items-center gap-2">
                <div class="step-number">4</div>
                <span class="small text-muted">Confirmar</span>
            </div>
        </div>

        <div class="card shadow-sm mb-4">
            <div class="card-body p-4">
                <h2 class="h4 mb-4">Selecciona un Servicio</h2>

                <!-- Especialidades -->
                <ul class="nav nav-tabs mb-3" id="especialidadTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="masajista-tab" data-bs-toggle="tab" data-bs-target="#masajista" type="button" role="tab">Masajista</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="lashista-tab" data-bs-toggle="tab" data-bs-target="#lashista" type="button" role="tab">Lashista</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="manicura-tab" data-bs-toggle="tab" data-bs-target="#manicura" type="button" role="tab">Manicura</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="esteticista-tab" data-bs-toggle="tab" data-bs-target="#esteticista" type="button" role="tab">Esteticista</button>
                    </li>
                </ul>

                <div class="tab-content" id="especialidadTabsContent">

                    <!-- Masajista -->
                    <div class="tab-pane fade show active" id="masajista" role="tabpanel">
                        <div id="carouselMasajista" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <div class="d-flex gap-3 justify-content-center">
                                        <div class="service-option border rounded-3 p-3 text-center">
                                            <h3 class="h6 mb-2">Masaje Relajante</h3>
                                            <div class="text-primary fw-bold mb-1">$7,000</div>
                                            <small class="text-muted">60 minutos</small>
                                        </div>
                                        <div class="service-option border rounded-3 p-3 text-center">
                                            <h3 class="h6 mb-2">Masaje Descontracturante</h3>
                                            <div class="text-primary fw-bold mb-1">$8,000</div>
                                            <small class="text-muted">90 minutos</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselMasajista" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon"></span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carouselMasajista" data-bs-slide="next">
                                <span class="carousel-control-next-icon"></span>
                            </button>
                        </div>
                    </div>

                    <!-- Lashista -->
                    <div class="tab-pane fade" id="lashista" role="tabpanel">
                        <div id="carouselLashista" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <div class="d-flex gap-3 justify-content-center">
                                        <div class="service-option border rounded-3 p-3 text-center">
                                            <h3 class="h6 mb-2">Lifting de Pestañas</h3>
                                            <div class="text-primary fw-bold mb-1">$6,500</div>
                                            <small class="text-muted">30 minutos</small>
                                        </div>
                                        <div class="service-option border rounded-3 p-3 text-center">
                                            <h3 class="h6 mb-2">Perfilado de Cejas</h3>
                                            <div class="text-primary fw-bold mb-1">$5,500</div>
                                            <small class="text-muted">30 minutos</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselLashista" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon"></span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carouselLashista" data-bs-slide="next">
                                <span class="carousel-control-next-icon"></span>
                            </button>
                        </div>
                    </div>

                    <!-- Manicura -->
                    <div class="tab-pane fade" id="manicura" role="tabpanel">
                        <div id="carouselManicura" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <div class="d-flex gap-3 justify-content-center">
                                        <div class="service-option border rounded-3 p-3 text-center">
                                            <h3 class="h6 mb-2">Semipermanente</h3>
                                            <div class="text-primary fw-bold mb-1">$4,500</div>
                                            <small class="text-muted">60 minutos</small>
                                        </div>
                                        <div class="service-option border rounded-3 p-3 text-center">
                                            <h3 class="h6 mb-2">Pedicura</h3>
                                            <div class="text-primary fw-bold mb-1">$5,000</div>
                                            <small class="text-muted">60 minutos</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselManicura" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon"></span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carouselManicura" data-bs-slide="next">
                                <span class="carousel-control-next-icon"></span>
                            </button>
                        </div>
                    </div>

                    <!-- Esteticista -->
                    <div class="tab-pane fade" id="esteticista" role="tabpanel">
                        <div id="carouselEsteticista" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <div class="d-flex gap-3 justify-content-center">
                                        <div class="service-option border rounded-3 p-3 text-center">
                                            <h3 class="h6 mb-2">Limpieza Facial Profunda</h3>
                                            <div class="text-primary fw-bold mb-1">$8,000</div>
                                            <small class="text-muted">60 minutos</small>
                                        </div>
                                        <div class="service-option border rounded-3 p-3 text-center">
                                            <h3 class="h6 mb-2">Peeling Químico</h3>
                                            <div class="text-primary fw-bold mb-1">$7,500</div>
                                            <small class="text-muted">60 minutos</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselEsteticista" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon"></span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carouselEsteticista" data-bs-slide="next">
                                <span class="carousel-control-next-icon"></span>
                            </button>
                        </div>
                    </div>

                </div>
            </div>
        </div>


        <!-- Profesionales -->
        <div class="card shadow-sm mb-4">
            <div class="card-body p-4">
                <h2 class="h4 mb-4">Selecciona un Profesional</h2>
                <div class="row g-3">
                    <div class="col-md-6 col-lg-3">
                        <div class="professional-option border rounded-3 p-3 text-center selected">

                            <h3 class="h6 mb-1">María González</h3>
                            <small class="text-muted">Esteticista</small>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="professional-option border rounded-3 p-3 text-center">

                            <h3 class="h6 mb-1">Carlas Ruiz</h3>
                            <small class="text-muted">Masajista</small>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="professional-option border rounded-3 p-3 text-center">

                            <h3 class="h6 mb-1">Luisa Fernández</h3>
                            <small class="text-muted">Lashista</small>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="professional-option border rounded-3 p-3 text-center">
                            <h3 class="h6 mb-1">Andrea Perez</h3>
                            <small class="text-muted">Manicura</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Fecha y Hora -->
        <div class="card shadow-sm mb-4">
            <div class="card-body p-4">
                <h2 class="h4 mb-4">Selecciona Fecha y Hora</h2>
                <div class="row g-4">
                    <!-- Fecha -->
                    <div class="col-lg-6">
                        <div class="border rounded-3 p-3">
                            <h3 class="h6 mb-3">Fecha</h3>
                            <input type="date" class="form-control" />
                        </div>
                    </div>

                    <!-- Hora -->
                    <div class="col-lg-6">
                        <div class="border rounded-3 p-3">
                            <h3 class="h6 mb-3">Hora</h3>
                            <select class="form-select">
                                <option value="09:00">09:00</option>
                                <option value="11:00">11:00</option>
                                <option value="12:00">12:00</option>
                                <option value="15:00">15:00</option>
                                <option value="16:00">16:00</option>
                                <option value="17:00">17:00</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Resumen -->
        <div class="card shadow-sm mb-4">
            <div class="card-body p-4">
                <h2 class="h4 mb-4">Resumen de la Reserva</h2>
                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <div class="bg-light rounded p-3 d-flex justify-content-between">
                            <span class="text-muted">Servicio:</span>
                            <span class="fw-bold">Tratamiento Facial</span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="bg-light rounded p-3 d-flex justify-content-between">
                            <span class="text-muted">Profesional:</span>
                            <span class="fw-bold">María González</span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="bg-light rounded p-3 d-flex justify-content-between">
                            <span class="text-muted">Fecha:</span>
                            <span class="fw-bold">15 de Enero, 2025</span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="bg-light rounded p-3 d-flex justify-content-between">
                            <span class="text-muted">Hora:</span>
                            <span class="fw-bold">14:00 hs</span>
                        </div>
                    </div>
                </div>

                <div class="bg-dark text-white rounded p-4 d-flex justify-content-between align-items-center mb-3">
                    <span class="h5 mb-0">Total:</span>
                    <span class="h4 mb-0">$8,000</span>
                </div>

                <div class="alert alert-warning border-warning">
                    <p class="mb-1"><strong>Seña requerida:</strong> $4,000 (50% del total)</p>
                    <p class="mb-0 small">El resto se abona en el centro al finalizar el servicio</p>
                </div>

                <div class="d-flex gap-2 justify-content-end">
                    <button class="btn btn-secondary">Volver</button>
                    <button class="btn btn-primary">Confirmar y Pagar Seña</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

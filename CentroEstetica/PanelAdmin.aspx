<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PanelAdmin.aspx.cs" Inherits="CentroEstetica.PanelAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">

        <h1 class="display-6 mb-4">Panel de Administración</h1>

                <div class="row g-3">
                    <!-- PROFESIONALES -->
                    <div class="card mb-4">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h2 class="h5 mb-0">Gestión de Profesionales</h2>
                                <button class="btn btn-primary btn-sm">+ Agregar Profesional</button>
                            </div>

                            <div class="row g-3">


                                <div class="col-md-6 col-lg-4">
                                    <div class="card h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center mb-3">
                                                <div>
                                                    <h6 class="mb-0">María González</h6>
                                                    <small class="text-muted">maria@estetica.com</small>
                                                </div>
                                            </div>

                                            <p class="mb-2"><strong>Especialidad:</strong> Esteticista</p>

                                            <div class="dropdown mb-3">
                                                <button class="btn btn-outline-primary btn-sm dropdown-toggle w-100" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                    Servicios que presta
                                                </button>
                                                <ul class="dropdown-menu w-100">
                                                    <li><a class="dropdown-item" href="#">Limpieza facial profunda</a></li>
                                                    <li><a class="dropdown-item" href="#">Peeling químico</a></li>
                                                    <li><a class="dropdown-item" href="#">Tratamiento hidratante</a></li>
                                                </ul>
                                            </div>

                                            <span class="badge bg-success mb-3">Activo</span>

                                            <div class="d-flex gap-2">
                                                <button class="btn btn-outline-secondary btn-sm">Editar</button>
                                                <button class="btn btn-outline-danger btn-sm">Eliminar</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 col-lg-4">
                                    <div class="card h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center mb-3">
                                                <div>
                                                    <h6 class="mb-0">Carla Ruiz</h6>
                                                    <small class="text-muted">carla@estetica.com</small>
                                                </div>
                                            </div>

                                            <p class="mb-2"><strong>Especialidad:</strong> Masajes</p>

                                            <div class="dropdown mb-3">
                                                <button class="btn btn-outline-primary btn-sm dropdown-toggle w-100" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                    Servicios que presta
                                                </button>
                                                <ul class="dropdown-menu w-100">
                                                    <li><a class="dropdown-item" href="#">Masaje relajante</a></li>
                                                    <li><a class="dropdown-item" href="#">Masaje descontracturante</a></li>
                                                </ul>
                                            </div>

                                            <span class="badge bg-success mb-3">Activo</span>

                                            <div class="d-flex gap-2">
                                                <button class="btn btn-outline-secondary btn-sm">Editar</button>
                                                <button class="btn btn-outline-danger btn-sm">Eliminar</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 col-lg-4">
                                    <div class="card h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center mb-3">
                                                <div>
                                                    <h6 class="mb-0">Luisa Fernández</h6>
                                                    <small class="text-muted">luisa@estetica.com</small>
                                                </div>
                                            </div>

                                            <p class="mb-2"><strong>Especialidad:</strong> Lashista</p>

                                            <div class="dropdown mb-3">
                                                <button class="btn btn-outline-primary btn-sm dropdown-toggle w-100" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                    Servicios que presta
                                                </button>
                                                <ul class="dropdown-menu w-100">
                                                    <li><a class="dropdown-item" href="#">Lifting de Pestañas</a></li>
                                                    <li><a class="dropdown-item" href="#">Perfilado de Cejas</a></li>
                                                </ul>
                                            </div>

                                            <span class="badge bg-danger mb-3">Inactivo</span>

                                            <div class="d-flex gap-2">
                                                <button class="btn btn-outline-secondary btn-sm">Editar</button>
                                                <button class="btn btn-outline-danger btn-sm">Eliminar</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
<div class="container py-4">

    <!-- Panel de Especialidades -->
    <div class="card mb-4">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2 class="h5 mb-0">Especialidades</h2>
                <button class="btn btn-primary btn-sm">+ Agregar Especialidad</button>
            </div>

            <div class="accordion" id="especialidadesAccordion">

             
                <div class="accordion-item">
                    <h2 class="accordion-header" id="heading1">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse1" aria-expanded="false" aria-controls="collapse1">
                            <span class="me-2">Tratamientos Faciales</span>
                            <span class="badge bg-success">Activo</span>
                        </button>
                    </h2>
                    <div id="collapse1" class="accordion-collapse collapse" aria-labelledby="heading1" data-bs-parent="#especialidadesAccordion">
                        <div class="accordion-body">
                       
                            <ul class="list-group mb-2">
                                <li class="list-group-item d-flex justify-content-between align-items-start">
                                    <div>
                                        <h6 class="mb-1">Limpieza Facial Profunda</h6>
                                        <small class="text-muted">Duración: 60 min</small>
                                    </div>
                                    <div class="text-end">
                                        <div class="fw-bold text-primary mb-1">$8.000</div>
                                        <div class="btn-group btn-group-sm">
                                            <button class="btn btn-outline-secondary">Editar</button>
                                            <button class="btn btn-outline-danger">Eliminar</button>
                                        </div>
                                    </div>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-start">
                                    <div>
                                        <h6 class="mb-1">Peeling Químico</h6>
                                        <small class="text-muted">Duración: 45 min</small>
                                    </div>
                                    <div class="text-end">
                                        <div class="fw-bold text-primary mb-1">$7.500</div>
                                        <div class="btn-group btn-group-sm">
                                            <button class="btn btn-outline-secondary">Editar</button>
                                            <button class="btn btn-outline-danger">Eliminar</button>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                            <button class="btn btn-outline-primary btn-sm">+ Agregar Servicio</button>
                            <button class="btn btn-outline-danger btn-sm mt-2">Eliminar Especialidad</button>
                        </div>
                    </div>
                </div>

              
                <div class="accordion-item">
                    <h2 class="accordion-header" id="heading2">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse2" aria-expanded="false" aria-controls="collapse2">
                            <span class="me-2">Masajes Terapéuticos</span>
                            <span class="badge bg-success">Activo</span>
                        </button>
                    </h2>
                    <div id="collapse2" class="accordion-collapse collapse" aria-labelledby="heading2" data-bs-parent="#especialidadesAccordion">
                        <div class="accordion-body">
                            
                            <ul class="list-group mb-2">
                                <li class="list-group-item d-flex justify-content-between align-items-start">
                                    <div>
                                        <h6 class="mb-1">Masaje Relajante</h6>
                                        <small class="text-muted">Duración: 60 min</small>
                                    </div>
                                    <div class="text-end">
                                        <div class="fw-bold text-primary mb-1">$7.000</div>
                                        <div class="btn-group btn-group-sm">
                                            <button class="btn btn-outline-secondary">Editar</button>
                                            <button class="btn btn-outline-danger">Eliminar</button>
                                        </div>
                                    </div>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-start">
                                    <div>
                                        <h6 class="mb-1">Masaje Descontracturante</h6>
                                        <small class="text-muted">Duración: 75 min</small>
                                    </div>
                                    <div class="text-end">
                                        <div class="fw-bold text-primary mb-1">$8.500</div>
                                        <div class="btn-group btn-group-sm">
                                            <button class="btn btn-outline-secondary">Editar</button>
                                            <button class="btn btn-outline-danger">Eliminar</button>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                            <button class="btn btn-outline-primary btn-sm">+ Agregar Servicio</button>
                            <button class="btn btn-outline-danger btn-sm mt-2">Eliminar Especialidad</button>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

</div>




                    <!-- CONFIGURACIÓN -->
                    <div class="col-lg-6">
                        <div class="card h-100">
                            <div class="card-body">
                                <h2 class="h5 mb-3">Configuración General</h2>
                                <div>
                                    <div class="mb-3">
                                        <label class="form-label">Nombre del Centro</label>
                                        <input type="text" class="form-control" value="Centro de Estética">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Porcentaje de Seña</label>
                                        <input type="number" class="form-control" value="50">
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Email de Notificaciones</label>
                                        <input type="email" class="form-control" value="admin@esteticapremium.com">
                                    </div>
                                    <button type="submit" class="btn btn-primary w-100">Guardar Cambios</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
           
</asp:Content>

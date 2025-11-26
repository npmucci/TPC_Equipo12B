<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="CambiarContrasenia.aspx.cs" Inherits="CentroEstetica.CambiarContrasenia" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <div class="container mt-5 p-4">
       
       <div class="card shadow-lg border-0 rounded-4 mx-auto" style="max-width: 500px;">
           <div class="card-body p-4">
               
               <h3 class="card-title text-center mb-4">Cambiar Contraseña</h3>
               
               <div class="mb-3">
                   <label class="form-label fw-bold">Contraseña Actual</label>
                   <asp:TextBox ID="txtPassActual" runat="server" CssClass="form-control" TextMode="Password" MaxLength="50"></asp:TextBox>
                   <div class="mt-1">
                       <asp:RequiredFieldValidator ID="rfvPassActual" runat="server" ControlToValidate="txtPassActual" ErrorMessage="La contraseña actual es obligatoria." CssClass="text-danger small" Display="Dynamic" ValidationGroup="PassGroup" EnableClientScript="false"/>
                   </div>
               </div>

               <div class="mb-3">
                   <label class="form-label fw-bold">Nueva Contraseña</label>
                   <asp:TextBox ID="txtPassNueva" runat="server" CssClass="form-control" TextMode="Password" MaxLength="16"></asp:TextBox>
                   <div class="mt-1">
                       <asp:RequiredFieldValidator ID="rfvPassNueva" runat="server" ControlToValidate="txtPassNueva" ErrorMessage="La nueva contraseña es obligatoria." CssClass="text-danger small" Display="Dynamic" ValidationGroup="PassGroup" EnableClientScript="false"/>
                       <asp:RegularExpressionValidator ID="revPassNuevaFuerte" runat="server" ControlToValidate="txtPassNueva" 
                           ErrorMessage="Debe tener 8-16 caracteres, 1 mayúscula, 1 minúscula y 1 número." 
                           CssClass="text-danger small" Display="Dynamic" ValidationGroup="PassGroup" 
                           ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,16}$" />
                   </div>
               </div>

               <div class="mb-3">
                   <label class="form-label fw-bold">Confirmar Contraseña</label>
                   <asp:TextBox ID="txtPassConfirmar" runat="server" CssClass="form-control" TextMode="Password" MaxLength="16"></asp:TextBox>
                   <div class="mt-1">
                       <asp:RequiredFieldValidator ID="rfvPassConfirmar" runat="server" ControlToValidate="txtPassConfirmar" ErrorMessage="La confirmación es obligatoria." CssClass="text-danger small" Display="Dynamic" ValidationGroup="PassGroup" />
                       <asp:CompareValidator ID="cvPassConfirmar" runat="server" ControlToValidate="txtPassConfirmar" ControlToCompare="txtPassNueva" ErrorMessage="Las contraseñas no coinciden." CssClass="text-danger small" Display="Dynamic" ValidationGroup="PassGroup" EnableClientScript="false" />
                   </div>
               </div>

               <asp:Label ID="lblErrorPass" runat="server" CssClass="text-danger d-block mt-3 mb-2" Visible="false" EnableViewState="false"></asp:Label>
               <asp:Label ID="lblExitoPass" runat="server" CssClass="text-success d-block mt-3 mb-2" Visible="false"  EnableViewState="false"></asp:Label>

               <div ID="botones" class="d-flex justify-content-between mt-4">
                   <asp:HyperLink ID="hlCancelar" runat="server" NavigateUrl="~/PanelPerfil.aspx" CssClass="btn btn-secondary btn-sm"> Cancelar</asp:HyperLink>
                   <asp:Button ID="btnGuardarContraseniaPnl" runat="server" Text="Guardar Cambios" CssClass="btn btn-primary btn-sm"  OnClick="btnGuardarContrasenia_Click"  ValidationGroup="PassGroup" EnableClientScript="false" />
               </div>

           </div>
       </div>
       
   </div>
</asp:Content>
<%@ Page Title="Servicios" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Servicios.aspx.cs" Inherits="CentroEstetica.Servicios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h2 id="h2Titulo" runat="server"></h2>

        <div class="row" id="divServicios" runat="server">
            <asp:Repeater ID="rptServicios" runat="server">
                <ItemTemplate>
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="card shadow-sm h-100">
                             <div class="card-body">
                                <h5 class="card-title"><%# Eval("Nombre") %></h5>
                                <p class="card-text"><%# Eval("Descripcion") %></p>
                                <p class="text-muted">Precio: $<%# Eval("Precio") %></p>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
</asp:Content>

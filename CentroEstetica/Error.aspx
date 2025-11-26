<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="CentroEstetica.Error" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="alert alert-danger" role="alert" style="margin-top: 20px;">
    <h3 class="alert-heading">
        <i class="fas fa-exclamation-triangle"></i> Error
    </h3>
    <hr>
    <asp:Label ID="lblError" runat="server" />
</div>
</asp:Content>

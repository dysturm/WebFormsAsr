<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Logout.aspx.cs" Inherits="ASR_Management_System.Pages.Logout" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="../Design/LogoutPgStyle.css" rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <asp:Panel runat="server" CssClass="msgLogoutPanel">

        <asp:Label ID="Label1" runat="server" Text="You must be logged in as administrator to view this page."></asp:Label>
        <br/><br/>
        <asp:LinkButton ID="LinkButton_Logout" runat="server" OnClick="LinkButton_Logout_OnClick">Click Here to Logout</asp:LinkButton>

    </asp:Panel>

</asp:Content>

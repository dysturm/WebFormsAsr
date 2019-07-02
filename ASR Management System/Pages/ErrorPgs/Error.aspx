<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="ASR_Management_System.Pages.ErrorPgs.Error" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../Design/LogoutPgStyle.css" rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <asp:Panel CssClass="msgLogoutPanel" runat="server">
        <asp:Label ID="lblErrorMsg" runat="server">Oops! An error occured.<br/>Administrator has been notified.<br/></asp:Label>
        <br/><br/>
        <asp:LinkButton runat="server" PostBackUrl="~/Pages/Home.aspx">Click Here to Return To Home</asp:LinkButton>
    </asp:Panel>


</asp:Content>

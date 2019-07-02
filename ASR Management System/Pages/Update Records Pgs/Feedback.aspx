<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Feedback.aspx.cs" Inherits="ASR_Management_System.Pages.Update_Records_Pgs.Feedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


</asp:Content>




<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Label ID="DisplaySubmittedName" runat="server" Text="Error Processing Data"></asp:Label>

    <br />
    <br />
    <br />

    <asp:Button ID="Button1" runat="server" Text="Add New Consultant" PostBackUrl="~/Pages/Update Records Pgs/AddConsultant.aspx" CssClass="BigButton" />
    <asp:Button ID="Button2" runat="server" Text="Return To Home" PostBackUrl="~/Pages/Home.aspx" CssClass="BigButton" />

</asp:Content>

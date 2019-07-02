<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="UpdateRecords.aspx.cs" Inherits="ASR_Management_System.Pages.UpdateRecords" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>





<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Button ID="Button1" runat="server" Text="Add New Consultant" CssClass="BigButton" PostBackUrl="~/Pages/Update Records Pgs/AddConsultant.aspx" />
    <asp:Button ID="Button2" runat="server" Text="Add New Recruiter" CssClass="BigButton" PostBackUrl="~/Pages/Update Records Pgs/AddRecruiter.aspx" />
    <asp:Button ID="Button5" runat="server" Text="Manage Tables" CssClass="BigButton" PostBackUrl="~/Pages/Update Records Pgs/ManageTables.aspx" />


</asp:Content>

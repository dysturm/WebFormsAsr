<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Records.aspx.cs" Inherits="ASR_Management_System.Pages.Records1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Button ID="JumpToConsultantViewBtn" runat="server" Text="View by Consultant" PostBackUrl="~/Pages/Consultants.aspx" CssClass="BigButton" />
&nbsp;
<asp:Button ID="JumpToRecruitersBtn" runat="server" Text="View By Recruiter" PostBackUrl="~/Pages/ASR-Recruiters.aspx" CssClass="BigButton" />
&nbsp;<asp:Button ID="Button1" runat="server" CssClass="BigButton" PostBackUrl="~/Pages/Clients.aspx" Text="View By Client" />
&nbsp;
</asp:Content>

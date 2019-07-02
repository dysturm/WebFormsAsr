<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Clients.aspx.cs" Inherits="ASR_Management_System.Pages.Clients" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--<script src="../Scripts/MaintainScrollAndResizePosition.js" defer></script>--%>
    <link href="../Design/ClientPg.css" rel="stylesheet" />
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <br />
    <asp:Label runat="server" CssClass="lblClientHeader">Select a Client:</asp:Label>
    <asp:Label runat="server" CssClass="lblClientTableHeader">Client Name (# of Submissions)</asp:Label>

    <asp:Panel runat="server" CssClass="clientPanel">
        <asp:Repeater runat="server" DataSourceID="ClientsDS" OnItemCommand="OnItemCommand">
            <ItemTemplate>
                <asp:LinkButton runat="server" ToolTip="Client Name" CommandArgument='<%#Eval("ID") %>'>
                    <%# Eval("CLIENT_NAME") %>
                </asp:LinkButton>
                <asp:Label runat="server" ToolTip="Number of Submissions">(<%# Eval("TotalSubmissions") %>)</asp:Label>
            </ItemTemplate>
            <SeparatorTemplate>
                <br />
                <hr />
                <br />
            </SeparatorTemplate>
        </asp:Repeater>
    </asp:Panel>

    <asp:SqlDataSource runat="server" ID="ClientsDS" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' ProviderName='<%$ ConnectionStrings:ConnectionString.ProviderName %>' SelectCommand="SELECT [CLIENT NAME] AS CLIENT_NAME, [TotalSubmissions], [ActiveSubmissions], [ID] FROM [ClientCount]"></asp:SqlDataSource>


</asp:Content>

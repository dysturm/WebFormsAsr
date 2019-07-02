<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ClientInfo.aspx.cs" Inherits="ASR_Management_System.Pages.ClientInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Design/ClientPg.css" rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <asp:HiddenField ID="HiddenField_ClientId" runat="server" />
    
    <asp:LinkButton runat="server" PostBackUrl="~/Pages/Clients.aspx" CssClass="lnkbtnBack">< Back</asp:LinkButton>
    
    <asp:Label ID="lblSubmissionCount" runat="server" CssClass="lblClientHeader"></asp:Label>

    <asp:Panel runat="server" CssClass="clientPanel">
        
        <asp:Repeater runat="server" DataSourceID="ClientInfoDS" OnItemCommand="OnItemCommand">
            <ItemTemplate>
                <span style="color: green"><%#Eval("RATE_PER_HOUR") %></span> - 
                <asp:LinkButton runat="server" CommandArgument='<%#Eval("SLNO") %>'>
                    <%# Eval("LastName") %> submitted by <%# Eval("Recruiter") %> on <%# Eval("Date", "{0:d}") %>
                </asp:LinkButton>
                <span style="font-size: 12px;"> -- <%#Eval("Submission_Status") %></span>
            </ItemTemplate>
            <SeparatorTemplate>
                <br/><hr/><br/>
            </SeparatorTemplate>
        </asp:Repeater>
    </asp:Panel>
    
    <asp:SqlDataSource runat="server" ID="ClientInfoDS" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' ProviderName='<%$ ConnectionStrings:ConnectionString.ProviderName %>' SelectCommand="SELECT [SLNO], [Date], [JOB TITLE] AS JOB_TITLE, [CITY], [STATE], [Duration], [CLIENT ID] AS CLIENT_ID, [RATE PER HOUR] AS RATE_PER_HOUR, [METHOD], [CLIENT SUBMISSION] AS CLIENT_SUBMISSION, [REMARKS], [LastName], [ASR-RECRUITERS.RECRUITER NAME] AS Recruiter, [VENDOR COMPANY NAME] AS VENDOR_COMPANY_NAME, [Vendor Contact.RECRUITER NAME] AS column2, [Client Name] AS Client_Name, [Submission Status] AS Submission_Status, [Active] FROM [Sub Query FULL] WHERE ([CLIENT ID] = ?) ORDER BY [Date] desc">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_ClientId" PropertyName="Value" Name="CLIENT_ID" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    


</asp:Content>

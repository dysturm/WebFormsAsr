<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Statistics.aspx.cs" Inherits="ASR_Management_System.Pages.Statistics" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="OuterContainer">

        <asp:GridView ID="ConsultantCountGridView" runat="server" AllowSorting="True" AutoGenerateColumns="False" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DataSourceID="ConsultantCountDS" CssClass="PositionTopLeft">
            <Columns>
                <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
                <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                <asp:BoundField DataField="TotalSubmissions" HeaderText="TotalSubmissions" SortExpression="TotalSubmissions" />
                <asp:BoundField DataField="ActiveSubmissions" HeaderText="ActiveSubmissions" SortExpression="ActiveSubmissions" ReadOnly="True" />
            </Columns>
            <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
            <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
            <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#FFF1D4" />
            <SortedAscendingHeaderStyle BackColor="#B95C30" />
            <SortedDescendingCellStyle BackColor="#F1E5CE" />
            <SortedDescendingHeaderStyle BackColor="#93451F" />
        </asp:GridView>

        <br />

        <asp:GridView ID="ASRRecruiterCountGridView" runat="server" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataSourceID="ASRRecruiterCountDS" CssClass="PositionBottomLeft">
            <Columns>
                <asp:BoundField DataField="Recruiter Name" HeaderText="Recruiter Name" SortExpression="Recruiter Name" />
                <asp:BoundField DataField="TotalSubmissions" HeaderText="Total Submissions" SortExpression="TotalSubmissions" />
                <asp:BoundField DataField="ActiveSubmissions" HeaderText="Active Submissions" SortExpression="ActiveSubmissions" />
            </Columns>
            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
            <RowStyle BackColor="White" ForeColor="#003399" />
            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
            <SortedAscendingCellStyle BackColor="#EDF6F6" />
            <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
            <SortedDescendingCellStyle BackColor="#D6DFDF" />
            <SortedDescendingHeaderStyle BackColor="#002876" />
        </asp:GridView>
        <asp:SqlDataSource ID="ASRRecruiterCountDS" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [ASR-Recruiter Count]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="ConsultantCountDS" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [ConsultantCount]"></asp:SqlDataSource>


        <div class="PositionTopRight">
            <asp:GridView ID="ClientCountGridView" runat="server" HorizontalAlign="Right" AutoGenerateColumns="False" BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataSourceID="ClientCountDS" AllowSorting="True">
                <Columns>
                    <asp:BoundField DataField="CLIENT NAME" HeaderText="CLIENT NAME" SortExpression="CLIENT NAME" />
                    <asp:BoundField DataField="TotalSubmissions" HeaderText="Total Submissions" SortExpression="TotalSubmissions" />
                    <asp:BoundField DataField="ActiveSubmissions" HeaderText="Active Submissions" ReadOnly="True" SortExpression="ActiveSubmissions" />
                </Columns>
                <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
                <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
                <RowStyle BackColor="White" ForeColor="#330099" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
                <SortedAscendingCellStyle BackColor="#FEFCEB" />
                <SortedAscendingHeaderStyle BackColor="#AF0101" />
                <SortedDescendingCellStyle BackColor="#F6F0C0" />
                <SortedDescendingHeaderStyle BackColor="#7E0000" />
            </asp:GridView>
            <asp:SqlDataSource ID="ClientCountDS" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [ClientCount]"></asp:SqlDataSource>
        </div>

    </div>
</asp:Content>

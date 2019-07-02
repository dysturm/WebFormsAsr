<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AddRecruiter.aspx.cs" Inherits="ASR_Management_System.Pages.Update_Records_Pgs.AddRecruiter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../Design/RecruiterAddPage.css" rel="stylesheet" />
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <asp:Panel runat="server" CssClass="recruiterPanel" DefaultButton="btnAddRecruiter">

                <br />
                
                <asp:Label runat="server" Text="Recruiters: "></asp:Label>
                <asp:DropDownList ID="DropDownList_ExistingRecruiterNames" DataSourceID="RecruiterNamesDS" DataTextField="Recruiter_Name" runat="server"></asp:DropDownList>
                <asp:SqlDataSource ID="RecruiterNamesDS" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' ProviderName='<%$ ConnectionStrings:ConnectionString.ProviderName %>' SelectCommand="SELECT [Recruiter Name] AS Recruiter_Name FROM [ASR-RECRUITERS]"></asp:SqlDataSource>
                
                <br/>
                <br/>
                <br/>

                <asp:Label runat="server" AssociatedControlID="tbName" Text="Recruiter Name:"></asp:Label>
                <br />
                <asp:TextBox ID="tbName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator CssClass="errorMessage" ControlToValidate="tbName" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                <br/>
                <asp:RegularExpressionValidator CssClass="errorMessage" ControlToValidate="tbName" runat="server" ErrorMessage="Invalid Name" ValidationExpression="^[a-zA-Z ]*$"></asp:RegularExpressionValidator>
                <br />
                <br />

                <asp:Button ID="btnAddRecruiter" CssClass="button" runat="server" Text="Add Recruiter" OnClick="btnAddRecruiter_OnClick" />
                
                <br/>
                <br/>
                
                <asp:Label ID="lblStatus" runat="server"></asp:Label>

            </asp:Panel>

        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AddConsultant.aspx.cs" Inherits="ASR_Management_System.Pages.Update_Records_Pgs.AddConsultant" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>





<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Panel ID="FormPanel" runat="server" CssClass="FormPanel">
        List of Existing Consultants:
        <div id="NameGridView">

            <asp:GridView ID="ConsultantNameGridView" runat="server" ShowHeader="False" AutoGenerateColumns="False" DataSourceID="ConsultantNameDS">
                <Columns>
                    <asp:BoundField DataField="Consultant_Name" HeaderText="Consultant_Name" SortExpression="Consultant_Name" />
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="ConsultantNameDS" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT IIF(ISNULL([FirstName]), [LastName], ([FirstName]+' '+[LastName]))  AS [Consultant_Name] FROM [Consultants]"></asp:SqlDataSource>

        </div>


        <br />
        <br />
        <br />
        <br />

        <asp:Label ID="FirstNameLabel" runat="server" Text="Label">Enter First Name: </asp:Label>
        <asp:TextBox ID="FirstNameInputTxtbox" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Name is Required" ControlToValidate="FirstNameInputTxtbox" ValidationGroup="ValidateSubmit">*</asp:RequiredFieldValidator>

        <br />
        <asp:Label ID="LastNameLabel" runat="server" Text="Label">Enter Last Name: </asp:Label>
        <asp:TextBox ID="LastNameInputTxtbox" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ControlToValidate="LastNameInputTxtbox" ValidationGroup="ValidateSubmit"></asp:RequiredFieldValidator>
        <br />
        <br />
        <asp:Button ID="SubmitBtn" runat="server" Text="Add Consultant" OnClick="SubmitBtn_Click" CssClass="SubmitBtn" ValidationGroup="ValidateSubmit" />

        <br />
        <br />
        <br />

    </asp:Panel>

</asp:Content>

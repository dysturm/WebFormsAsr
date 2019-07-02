<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="SelectConsultant.aspx.cs" Inherits="ASR_Management_System.Pages.SelectConsultant" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <style>
        h3 {
            display: inline-block;
            margin: auto;
            margin-top: 20px;
            background-color: azure;
            padding: 10px;
            border-radius: 5px;
        }
        .pnlNameBtns {
            margin: auto;
            display: block;
            margin-top: 30px;
            width: 250px;
            white-space: normal;
            text-align: center;
            max-height: 80%;
            overflow-y: auto;
        }
        .btnConsultantName {
            background-color: lightgoldenrodyellow;
            width: inherit;
            padding: 5px;
            font-size: 18px;
            border: 1px solid blue;
            border-radius: 3px;
        }
        .btnConsultantName:hover {
            cursor: pointer;
        }
        hr {
            margin-top: 3px; 
            margin-bottom: 3px;
        }
    </style>
    

</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <h3>Select a Consultant:</h3>
    
    <asp:Panel runat="server" CssClass="pnlNameBtns">
        <asp:Repeater runat="server" DataSourceID="ConsultantsDS" OnItemCommand="OnItemCommand">
            <ItemTemplate>
                <asp:Button runat="server" Text='<%#Eval("LastName")+", "+ Eval("FirstName") %>' CommandArgument='<%#Eval("ID") %>' CssClass="btnConsultantName"/>
            </ItemTemplate>
            <SeparatorTemplate>
                <hr/>
            </SeparatorTemplate>
        </asp:Repeater>
    </asp:Panel>
    
    <asp:SqlDataSource ID="ConsultantsDS" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' ProviderName='<%$ ConnectionStrings:ConnectionString.ProviderName %>' SelectCommand="SELECT [LastName], [FirstName], [ID] FROM [Consultants]"></asp:SqlDataSource>


</asp:Content>

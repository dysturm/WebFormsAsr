<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ConfirmDeletions.aspx.cs" Inherits="ASR_Management_System.Pages.Update_Records_Pgs.ConfirmDeletions" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        h3 {
            white-space: normal;
            margin: auto;
            margin-top: 20px;
        }

        hr {
            margin-top: 15px;
            margin-bottom: 15px;
        }
        .lbl {
            color: gray;
            text-align: center;
            font-weight: bold;
        }
        .cb {
            float: right;
            font-size: 12px;
        }
        .panel_deletedSubmissions {
            width: 650px;
            margin: auto;
            margin-top: 30px;
            max-height: 600px;
            overflow-y: auto;
            padding: 10px;
            border: 1px solid blue;
            border-radius: 5px;
            background-color: darkgrey;
            text-align: left;
        }
        .btnConfirmChanges {
            padding: 5px;
            text-align: right;
            font-size: 20px;
            background-color: darkgrey;
            border: 1px solid white;
            border-bottom-right-radius: 5px;
            border-bottom-left-radius: 5px;
        }
        .btnConfirmChanges:hover {
            font-size: 22px;
            cursor: pointer;
            border: 2px solid white;
            opacity: 20;
        }
    </style>
    
    <script defer>
        function get(className) {
            return document.getElementsByClassName(className);
        };

        function deleteAll() {
            var dltcbs = get("rb");
            var isChecked = dltcbs.checked;
            for (var i = 0; i < dltcbs.size; i++) {
                dltcbs[i].checked = isChecked;
            }
        };

        window.onload = function () {
            get("rb")[0].onselectionchange = deleteAll;
        };
    </script>


</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    

    <h3>The Following Submissions have been marked for deletion:</h3>

    <asp:Panel CssClass="panel_deletedSubmissions" runat="server">
        
        <asp:Label runat="server" CssClass="lbl">Submissions</asp:Label>
        <asp:CheckBox ID="cbDeleteAll" runat="server" CssClass="cb" Text="Delete All" TextAlign="Left"/>
        <ajaxToolkit:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender1" runat="server" TargetControlID="cbDeleteAll" Key="option"/>
        <asp:CheckBox ID="cbRestoreAll" runat="server" CssClass="cb" Text="Restore All" TextAlign="Left"/>
        <ajaxToolkit:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender3" runat="server" TargetControlID="cbRestoreAll" Key="option"/>

        <br/><hr style="background-color: black; border: none; height: 5px;"/>

        <asp:Repeater ID="rptrDeletedSubmissions" runat="server" DataSourceID="SubmissionDS">
            <ItemTemplate>
                <asp:HiddenField ID="Slno" runat="server" Value='<%#Eval("SLNO") %>'/>
                <p style="color: blue"><%# Eval("DeleteUser") %></p> deleted submission <%#Eval("SLNO") %> to <%#Eval("Client_Name") %>
                <asp:CheckBox ID="cbDelete" runat="server" CssClass="cb" Text="Delete" TextAlign="Left"/>
                <ajaxToolkit:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender1" runat="server" TargetControlID="cbDelete" Key="option"/>
                <asp:CheckBox ID="cbRestore" runat="server" CssClass="cb" Text="Restore" TextAlign="Left"/>
                <ajaxToolkit:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender2" runat="server" TargetControlID="cbRestore" Key="option"/>
            </ItemTemplate>
            <SeparatorTemplate>
                <hr />
            </SeparatorTemplate>
        </asp:Repeater>

    </asp:Panel>
    
    <asp:Button runat="server" CssClass="btnConfirmChanges" Text="Apply Changes" OnClick="OnClick"/>

    <asp:SqlDataSource ID="SubmissionDS" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' ProviderName='<%$ ConnectionStrings:ConnectionString.ProviderName %>' SelectCommand="SELECT [SLNO], [Date], [JOB TITLE] AS JOB_TITLE, [CITY], [STATE], [Duration], [RATE PER HOUR] AS RATE_PER_HOUR, [METHOD], [CLIENT SUBMISSION] AS CLIENT_SUBMISSION, [REMARKS], [LastName], [ASR-RECRUITERS.RECRUITER NAME] AS column1, [VENDOR COMPANY NAME] AS VENDOR_COMPANY_NAME, [Vendor Contact.RECRUITER NAME] AS column2, [Client Name] AS Client_Name, [Submission Status] AS Submission_Status, [Active], [Deleted], [DeleteUser] FROM [Sub Query FULL] WHERE ([Deleted] = -1)">
       
    </asp:SqlDataSource>


</asp:Content>

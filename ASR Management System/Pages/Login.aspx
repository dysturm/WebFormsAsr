<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ASR_Management_System.Pages.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ASR Login</title>
    <link href="../Design/LoginStyleSheet.css" rel="stylesheet" />
</head>

<body>
    
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="none" runat="server"></asp:ScriptManager>

            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>

                    <asp:Panel ID="Panel1" runat="server" CssClass="panelLogin">

                        <asp:Label ID="Label1" runat="server" Text="ASR Login" CssClass="label"></asp:Label>
                        <br />
                        <asp:Label ID="lblUsername" AssociatedControlID="tbUsername" runat="server" Text="Username" CssClass="label"></asp:Label>
                        <asp:TextBox ID="tbUsername" runat="server" CssClass="tb"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="tbUsername" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>

                        <asp:Label ID="lblPassword" AssociatedControlID="tbPassword" runat="server" Text="Password" CssClass="label"></asp:Label>
                        <asp:TextBox ID="tbPassword" TextMode="Password" runat="server" CssClass="tb"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="tbPassword" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                        
                        <br />
                        <br />
                        
                        <asp:CheckBox ID="ChkRememberme" runat="server" Text="Remember Me" CssClass="tb"/>
                        <br/>
                        <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="tb" OnClick="btnLogin_OnClick" />

                        <br />
                        <br />

                        <asp:Label ID="lblLoginStatus" runat="server"></asp:Label>

                    </asp:Panel>

                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>

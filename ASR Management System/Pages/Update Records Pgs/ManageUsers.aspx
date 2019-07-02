<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="ASR_Management_System.Pages.Update_Records_Pgs.Manage_Users" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    
    <asp:UpdatePanel runat="server">
        <ContentTemplate>

       
    

    <asp:LinkButton ID="lnkbtnAddNewUser" Style="display: inline-block; margin: auto; margin-top: 50px; font-size: 25px;" runat="server">Add New User</asp:LinkButton>

    <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server"
        ExpandControlID="lnkbtnAddNewUser"
        CollapseControlID="lnkbtnAddNewUser"
        TargetControlID="panel_AddUser"
        Collapsed="True" />



    <asp:Panel ID="panel_AddUser" Style="margin-top: 25px; display: none;" runat="server">



        <asp:FormView ID="FormView1" HorizontalAlign="Center" runat="server" DefaultMode="Insert" DataKeyNames="ID" DataSourceID="UsersDS" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal">

            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C"></FooterStyle>
            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7"></HeaderStyle>

            <InsertItemTemplate>
                Username:
                <asp:TextBox Text='<%# Bind("Username") %>' runat="server" ID="UsernameTextBox" />
                <asp:RequiredFieldValidator ControlToValidate="UsernameTextBox" ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>

                <br />
                Password:
                <asp:TextBox Text='<%# Bind("Password") %>' TextMode="Password" runat="server" ID="PasswordTextBox" />
                <asp:RequiredFieldValidator ControlToValidate="PasswordTextBox" ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>

                <br />
                Confirm Password:
                <asp:TextBox runat="server" TextMode="Password" ID="ConfirmPasswordTextBox"></asp:TextBox>
                <asp:CompareValidator ControlToValidate="PasswordTextBox" ControlToCompare="ConfirmPasswordTextBox" Style="font-size: 12px; float: right; white-space: normal;" ID="CompareValidator1" runat="server" ErrorMessage="Passwords<br> Do Not Match"></asp:CompareValidator>

                <br />
                Role:
                <asp:DropDownList ID="DropDownList_Role" Text='<%# Bind("Role") %>' runat="server">
                    <Items>
                        <asp:ListItem Value="">Select:</asp:ListItem>
                        <asp:ListItem>User</asp:ListItem>
                        <asp:ListItem>Admin</asp:ListItem>
                    </Items>
                </asp:DropDownList>
                <%--<asp:TextBox Text='<%# Bind("Role") %>' runat="server" ID="RoleTextBox" />--%>
                <asp:RequiredFieldValidator ControlToValidate="DropDownList_Role" ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>

                <br />
                <asp:LinkButton runat="server" Text="Insert" CommandName="Insert" ID="InsertButton" CausesValidation="True" />&nbsp;
            </InsertItemTemplate>

            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C"></RowStyle>
        </asp:FormView>



    </asp:Panel>

    <asp:GridView ID="gv_Users" HorizontalAlign="Center" Style="margin-top: 50px;" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="UsersDS" BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px" CellPadding="4" AllowPaging="True">
        <Columns>
            <asp:CommandField ShowEditButton="True" ShowDeleteButton="True"></asp:CommandField>
            <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" InsertVisible="False" SortExpression="ID"></asp:BoundField>
            <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username"></asp:BoundField>
            <asp:BoundField DataField="Password" HeaderText="Password" SortExpression="Password"></asp:BoundField>
            <asp:BoundField DataField="Role" HeaderText="Role" SortExpression="Role"></asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099"></FooterStyle>

        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC"></HeaderStyle>

        <PagerStyle HorizontalAlign="Center" BackColor="#FFFFCC" ForeColor="#330099"></PagerStyle>

        <RowStyle BackColor="White" ForeColor="#330099"></RowStyle>

        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399"></SelectedRowStyle>

        <SortedAscendingCellStyle BackColor="#FEFCEB"></SortedAscendingCellStyle>

        <SortedAscendingHeaderStyle BackColor="#AF0101"></SortedAscendingHeaderStyle>

        <SortedDescendingCellStyle BackColor="#F6F0C0"></SortedDescendingCellStyle>

        <SortedDescendingHeaderStyle BackColor="#7E0000"></SortedDescendingHeaderStyle>
    </asp:GridView>




    <asp:SqlDataSource runat="server" ID="UsersDS" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' DeleteCommand="DELETE FROM [Users] WHERE [ID] = ?" InsertCommand="INSERT INTO [Users] ([Username], [Password], [Role]) VALUES (?, ?, ?)" ProviderName='<%$ ConnectionStrings:ConnectionString.ProviderName %>' SelectCommand="SELECT * FROM [Users]" UpdateCommand="UPDATE [Users] SET [Username] = ?, [Password] = ?, [Role] = ? WHERE [ID] = ?">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Username" Type="String"></asp:Parameter>
            <asp:Parameter Name="Password" Type="String"></asp:Parameter>
            <asp:Parameter Name="Role" Type="String"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Username" Type="String"></asp:Parameter>
            <asp:Parameter Name="Password" Type="String"></asp:Parameter>
            <asp:Parameter Name="Role" Type="String"></asp:Parameter>
            <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>





        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>

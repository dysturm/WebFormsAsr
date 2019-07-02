<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ManageTables.aspx.cs" Inherits="ASR_Management_System.Pages.Update_Records_Pgs.ManageTables" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../Design/ManageTables.css" rel="stylesheet" />
    <script src="../../Scripts/MaintainScrollPos_ManageTablesPg.js" defer></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>


            <asp:Button ID="btn_goLeft" runat="server" Text="<" CommandName="PrevView" OnClick="btn_goLeft_OnClick" CssClass="btn_navigate btn_navigate_left" />
            <asp:Button ID="btn_goRight" runat="server" Text=">" CommandName="NextView" OnClick="btn_goRight_OnClick" CssClass="btn_navigate btn_navigate_right" />



            <asp:MultiView ID="Multiview1" runat="server" ActiveViewIndex="0">


                <asp:View ID="view_consultants" runat="server">



                    <asp:Label runat="server" Text="Consultants" CssClass="lbl_title"></asp:Label>


                    <asp:Panel runat="server" CssClass="panel_gv">
                        
                        
                        <asp:GridView ID="GridView_Consultants" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="ConsultantDS" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                            <Columns>
                                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True"></asp:CommandField>
                                <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" InsertVisible="False" SortExpression="ID"></asp:BoundField>
                                <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName"></asp:BoundField>
                                <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName"></asp:BoundField>
                                <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status"></asp:BoundField>
                                <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes"></asp:BoundField>
                            </Columns>

                            <FooterStyle BackColor="White" ForeColor="#000066"></FooterStyle>
                            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White"></HeaderStyle>
                            <PagerStyle HorizontalAlign="Left" BackColor="White" ForeColor="#000066"></PagerStyle>
                            <RowStyle ForeColor="#000066"></RowStyle>
                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White"></SelectedRowStyle>
                            <SortedAscendingCellStyle BackColor="#F1F1F1"></SortedAscendingCellStyle>
                            <SortedAscendingHeaderStyle BackColor="#007DBB"></SortedAscendingHeaderStyle>
                            <SortedDescendingCellStyle BackColor="#CAC9C9"></SortedDescendingCellStyle>
                            <SortedDescendingHeaderStyle BackColor="#00547E"></SortedDescendingHeaderStyle>
                        </asp:GridView>

                        <asp:SqlDataSource runat="server" ID="ConsultantDS" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' ProviderName='<%$ ConnectionStrings:ConnectionString.ProviderName %>' SelectCommand="SELECT * FROM [Consultants]" DeleteCommand="DELETE FROM [Consultants] WHERE [ID] = ?" InsertCommand="INSERT INTO [Consultants] ([ID], [LastName], [FirstName], [Status], [Notes]) VALUES (?, ?, ?, ?, ?)" UpdateCommand="UPDATE [Consultants] SET [LastName] = ?, [FirstName] = ?, [Status] = ?, [Notes] = ? WHERE [ID] = ?">
                            <DeleteParameters>
                                <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
                                <asp:Parameter Name="LastName" Type="String"></asp:Parameter>
                                <asp:Parameter Name="FirstName" Type="String"></asp:Parameter>
                                <asp:Parameter Name="Status" Type="String"></asp:Parameter>
                                <asp:Parameter Name="Notes" Type="String"></asp:Parameter>
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="LastName" Type="String"></asp:Parameter>
                                <asp:Parameter Name="FirstName" Type="String"></asp:Parameter>
                                <asp:Parameter Name="Status" Type="String"></asp:Parameter>
                                <asp:Parameter Name="Notes" Type="String"></asp:Parameter>
                                <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
                            </UpdateParameters>
                        </asp:SqlDataSource>

                    </asp:Panel>

                </asp:View>


                <asp:View ID="view_recruiters" runat="server">


                    <asp:Label runat="server" Text="Recruiters" CssClass="lbl_title"></asp:Label>


                    <asp:Panel runat="server" CssClass="panel_gv">

                        <asp:GridView ID="gv_Recruiters" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="RecruitersDS" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal">
                            <Columns>
                                <asp:CommandField ShowEditButton="True" ShowDeleteButton="True"></asp:CommandField>
                                <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" InsertVisible="False" SortExpression="ID"></asp:BoundField>
                                <asp:BoundField DataField="Recruiter Name" HeaderText="Recruiter Name" SortExpression="Recruiter Name"></asp:BoundField>
                            </Columns>

                            <FooterStyle BackColor="White" ForeColor="#333333"></FooterStyle>
                            <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White"></HeaderStyle>
                            <PagerStyle HorizontalAlign="Center" BackColor="#336666" ForeColor="White"></PagerStyle>
                            <RowStyle BackColor="White" ForeColor="#333333"></RowStyle>
                            <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White"></SelectedRowStyle>
                            <SortedAscendingCellStyle BackColor="#F7F7F7"></SortedAscendingCellStyle>
                            <SortedAscendingHeaderStyle BackColor="#487575"></SortedAscendingHeaderStyle>
                            <SortedDescendingCellStyle BackColor="#E5E5E5"></SortedDescendingCellStyle>
                            <SortedDescendingHeaderStyle BackColor="#275353"></SortedDescendingHeaderStyle>
                        </asp:GridView>


                        <asp:SqlDataSource runat="server" ID="RecruitersDS" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' DeleteCommand="DELETE FROM [ASR-RECRUITERS] WHERE [ID] = ?" InsertCommand="INSERT INTO [ASR-RECRUITERS] ([ID], [Recruiter Name]) VALUES (?, ?)" ProviderName='<%$ ConnectionStrings:ConnectionString.ProviderName %>' SelectCommand="SELECT * FROM [ASR-RECRUITERS]" UpdateCommand="UPDATE [ASR-RECRUITERS] SET [Recruiter Name] = ? WHERE [ID] = ?">
                            <DeleteParameters>
                                <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
                                <asp:Parameter Name="Recruiter_Name" Type="String"></asp:Parameter>
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="Recruiter_Name" Type="String"></asp:Parameter>
                                <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
                            </UpdateParameters>
                        </asp:SqlDataSource>

                    </asp:Panel>

                </asp:View>


                <asp:View ID="view_clients" runat="server">

                    <asp:Label runat="server" Text="Clients" CssClass="lbl_title"></asp:Label>

                    <asp:Panel runat="server" CssClass="panel_gv">

                        <asp:GridView ID="gv_Clients" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="ClientDS" CellPadding="4" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
                            <Columns>
                                <asp:CommandField ShowEditButton="True" ShowDeleteButton="True"></asp:CommandField>
                                <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" InsertVisible="False" SortExpression="ID"></asp:BoundField>
                                <asp:BoundField DataField="CLIENT NAME" HeaderText="CLIENT NAME" SortExpression="CLIENT NAME"></asp:BoundField>
                            </Columns>
                            <EditRowStyle BackColor="#7C6F57"></EditRowStyle>
                            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White"></FooterStyle>
                            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White"></HeaderStyle>
                            <PagerStyle HorizontalAlign="Center" BackColor="#666666" ForeColor="White"></PagerStyle>
                            <RowStyle BackColor="#E3EAEB"></RowStyle>
                            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333"></SelectedRowStyle>
                            <SortedAscendingCellStyle BackColor="#F8FAFA"></SortedAscendingCellStyle>
                            <SortedAscendingHeaderStyle BackColor="#246B61"></SortedAscendingHeaderStyle>
                            <SortedDescendingCellStyle BackColor="#D4DFE1"></SortedDescendingCellStyle>
                            <SortedDescendingHeaderStyle BackColor="#15524A"></SortedDescendingHeaderStyle>
                        </asp:GridView>


                        <asp:SqlDataSource runat="server" ID="ClientDS" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' DeleteCommand="DELETE FROM [Clients] WHERE [ID] = ?" InsertCommand="INSERT INTO [Clients] ([ID], [CLIENT NAME]) VALUES (?, ?)" ProviderName='<%$ ConnectionStrings:ConnectionString.ProviderName %>' SelectCommand="SELECT * FROM [Clients]" UpdateCommand="UPDATE [Clients] SET [CLIENT NAME] = ? WHERE [ID] = ?">
                            <DeleteParameters>
                                <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
                                <asp:Parameter Name="CLIENT_NAME" Type="String"></asp:Parameter>
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="CLIENT_NAME" Type="String"></asp:Parameter>
                                <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
                            </UpdateParameters>
                        </asp:SqlDataSource>

                    </asp:Panel>

                </asp:View>

                <asp:View runat="server">

                    <asp:Label runat="server" Text="Vendors" CssClass="lbl_title"></asp:Label>

                    <asp:Panel runat="server" CssClass="panel_gv">
                        
                        <asp:GridView runat="server" ID="gv_Vendors" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="VendorsDS" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal">
                            <Columns>
                                <asp:CommandField ShowEditButton="True" ShowDeleteButton="True"></asp:CommandField>
                                <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" InsertVisible="False" SortExpression="ID"></asp:BoundField>
                                <asp:BoundField DataField="VENDOR COMPANY NAME" HeaderText="VENDOR COMPANY NAME" SortExpression="VENDOR COMPANY NAME"></asp:BoundField>
                            </Columns>
                            <FooterStyle BackColor="#CCCC99" ForeColor="Black"></FooterStyle>
                            <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White"></HeaderStyle>
                            <PagerStyle HorizontalAlign="Right" BackColor="White" ForeColor="Black"></PagerStyle>
                            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White"></SelectedRowStyle>
                            <SortedAscendingCellStyle BackColor="#F7F7F7"></SortedAscendingCellStyle>
                            <SortedAscendingHeaderStyle BackColor="#4B4B4B"></SortedAscendingHeaderStyle>
                            <SortedDescendingCellStyle BackColor="#E5E5E5"></SortedDescendingCellStyle>
                            <SortedDescendingHeaderStyle BackColor="#242121"></SortedDescendingHeaderStyle>
                        </asp:GridView>

                        <asp:SqlDataSource runat="server" ID="VendorsDS" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' DeleteCommand="DELETE FROM [Vendors] WHERE [ID] = ?" InsertCommand="INSERT INTO [Vendors] ([ID], [VENDOR COMPANY NAME]) VALUES (?, ?)" ProviderName='<%$ ConnectionStrings:ConnectionString.ProviderName %>' SelectCommand="SELECT * FROM [Vendors]" UpdateCommand="UPDATE [Vendors] SET [VENDOR COMPANY NAME] = ? WHERE [ID] = ?">
                            <DeleteParameters>
                                <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
                                <asp:Parameter Name="VENDOR_COMPANY_NAME" Type="String"></asp:Parameter>
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="VENDOR_COMPANY_NAME" Type="String"></asp:Parameter>
                                <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
                            </UpdateParameters>
                        </asp:SqlDataSource>

                    </asp:Panel>
                </asp:View>
                
                
                <asp:View ID="view_submissions" runat="server">

                    <asp:Label runat="server" Text="Submissions" CssClass="lbl_title"></asp:Label>

                    <asp:Panel runat="server" CssClass="panel_gv">
                        
                        <asp:GridView ID="gv_submissions" Style="float: left" runat="server" AutoGenerateColumns="False" DataKeyNames="SLNO" DataSourceID="SubmissionsDS" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" AllowSorting="True">
                            <AlternatingRowStyle BackColor="#DCDCDC"></AlternatingRowStyle>
                            <Columns>
                                <asp:CommandField ShowEditButton="True" ShowDeleteButton="True"></asp:CommandField>
                                <asp:BoundField DataField="SLNO" HeaderText="SLNO" ReadOnly="True" SortExpression="SLNO"></asp:BoundField>
                                <asp:BoundField DataField="DATE" HeaderText="DATE" SortExpression="DATE" DataFormatString="{0:d}" HtmlEncode="False"></asp:BoundField>
                                <asp:BoundField DataField="RATE_PER_HOUR" HeaderText="RATE" SortExpression="RATE_PER_HOUR"></asp:BoundField>
                                <asp:BoundField DataField="Submission_Status" HeaderText="Submission_Status" SortExpression="Submission_Status"></asp:BoundField>
                                <asp:CheckBoxField DataField="Active" HeaderText="Active" SortExpression="Active"></asp:CheckBoxField>
                                <asp:CheckBoxField DataField="Deleted" HeaderText="Deleted" SortExpression="Deleted"></asp:CheckBoxField>
                            </Columns>
                            <FooterStyle BackColor="#CCCCCC" ForeColor="Black"></FooterStyle>

                            <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White"></HeaderStyle>

                            <PagerStyle HorizontalAlign="Center" BackColor="#999999" ForeColor="Black"></PagerStyle>

                            <RowStyle BackColor="#EEEEEE" ForeColor="Black"></RowStyle>

                            <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White"></SelectedRowStyle>

                            <SortedAscendingCellStyle BackColor="#F1F1F1"></SortedAscendingCellStyle>

                            <SortedAscendingHeaderStyle BackColor="#0000A9"></SortedAscendingHeaderStyle>

                            <SortedDescendingCellStyle BackColor="#CAC9C9"></SortedDescendingCellStyle>

                            <SortedDescendingHeaderStyle BackColor="#000065"></SortedDescendingHeaderStyle>
                        </asp:GridView>

                        <asp:SqlDataSource runat="server" ID="SubmissionsDS" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' DeleteCommand="DELETE FROM [Submissions] WHERE [SLNO] = ?" InsertCommand="INSERT INTO [Submissions] ([SLNO], [DATE], [RATE PER HOUR], [Submission Status], [Active], [Deleted]) VALUES (?, ?, ?, ?, ?, ?)" ProviderName='<%$ ConnectionStrings:ConnectionString.ProviderName %>' SelectCommand="SELECT [SLNO], [DATE], [RATE PER HOUR] AS RATE_PER_HOUR, [Submission Status] AS Submission_Status, [Active], [Deleted] FROM [Submissions]" UpdateCommand="UPDATE [Submissions] SET [DATE] = ?, [RATE PER HOUR] = ?, [Submission Status] = ?, [Active] = ?, [Deleted] = ? WHERE [SLNO] = ?">
                            <DeleteParameters>
                                <asp:Parameter Name="SLNO" Type="Int32"></asp:Parameter>
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="SLNO" Type="Int32"></asp:Parameter>
                                <asp:Parameter Name="DATE" Type="DateTime"></asp:Parameter>
                                <asp:Parameter Name="RATE_PER_HOUR" Type="Decimal"></asp:Parameter>
                                <asp:Parameter Name="Submission_Status" Type="String"></asp:Parameter>
                                <asp:Parameter Name="Active" Type="Boolean"></asp:Parameter>
                                <asp:Parameter Name="Deleted" Type="Boolean"></asp:Parameter>
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="DATE" Type="DateTime"></asp:Parameter>
                                <asp:Parameter Name="RATE_PER_HOUR" Type="Decimal"></asp:Parameter>
                                <asp:Parameter Name="Submission_Status" Type="String"></asp:Parameter>
                                <asp:Parameter Name="Active" Type="Boolean"></asp:Parameter>
                                <asp:Parameter Name="Deleted" Type="Boolean"></asp:Parameter>
                                <asp:Parameter Name="SLNO" Type="Int32"></asp:Parameter>
                            </UpdateParameters>
                        </asp:SqlDataSource>
                    </asp:Panel>

                </asp:View>
                
                
            <asp:View ID="view_interviews" runat="server">
                
                <asp:Label runat="server" Text="Interviews" CssClass="lbl_title"></asp:Label>
                
                <asp:Panel runat="server" CssClass="panel_gv">
                    
                    <asp:GridView runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="InterviewsDS" AllowSorting="True" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal">
                        <AlternatingRowStyle BackColor="#F7F7F7"></AlternatingRowStyle>
                        <Columns>
                            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True"></asp:CommandField>
                            <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" InsertVisible="False" SortExpression="ID"></asp:BoundField>
                            <asp:BoundField DataField="column1" HeaderText="Submission SLNO" SortExpression="column1"></asp:BoundField>
                            <asp:BoundField DataField="Date_Scheduled" HeaderText="Date_Scheduled" SortExpression="Date_Scheduled" DataFormatString="{0:d}" HtmlEncode="False"></asp:BoundField>
                            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status"></asp:BoundField>
                            <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type"></asp:BoundField>
                            <asp:BoundField DataField="Method" HeaderText="Method" SortExpression="Method"></asp:BoundField>
                            <asp:CheckBoxField DataField="Deleted" HeaderText="Deleted" SortExpression="Deleted"></asp:CheckBoxField>
                        </Columns>
                        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C"></FooterStyle>

                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7"></HeaderStyle>

                        <PagerStyle HorizontalAlign="Right" BackColor="#E7E7FF" ForeColor="#4A3C8C"></PagerStyle>

                        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C"></RowStyle>

                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7"></SelectedRowStyle>

                        <SortedAscendingCellStyle BackColor="#F4F4FD"></SortedAscendingCellStyle>

                        <SortedAscendingHeaderStyle BackColor="#5A4C9D"></SortedAscendingHeaderStyle>

                        <SortedDescendingCellStyle BackColor="#D8D8F0"></SortedDescendingCellStyle>

                        <SortedDescendingHeaderStyle BackColor="#3E3277"></SortedDescendingHeaderStyle>
                    </asp:GridView>

                    <asp:SqlDataSource runat="server" ID="InterviewsDS" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' DeleteCommand="DELETE FROM [Interviews] WHERE [ID] = ?" InsertCommand="INSERT INTO [Interviews] ([ID], [Submission-SLNO], [Date Scheduled], [Status], [Deleted], [Type], [Method]) VALUES (?, ?, ?, ?, ?, ?, ?)" ProviderName='<%$ ConnectionStrings:ConnectionString.ProviderName %>' SelectCommand="SELECT [ID], [Submission-SLNO] AS column1, [Date Scheduled] AS Date_Scheduled, [Status], [Deleted], [Type], [Method] FROM [Interviews]" UpdateCommand="UPDATE [Interviews] SET [Submission-SLNO] = ?, [Date Scheduled] = ?, [Status] = ?, [Deleted] = ?, [Type] = ?, [Method] = ? WHERE [ID] = ?">
                        <DeleteParameters>
                            <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="column1" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="Date_Scheduled" Type="DateTime"></asp:Parameter>
                            <asp:Parameter Name="Status" Type="String"></asp:Parameter>
                            <asp:Parameter Name="Deleted" Type="Boolean"></asp:Parameter>
                            <asp:Parameter Name="Type" Type="String"></asp:Parameter>
                            <asp:Parameter Name="Method" Type="String"></asp:Parameter>
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="column1" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="Date_Scheduled" Type="DateTime"></asp:Parameter>
                            <asp:Parameter Name="Status" Type="String"></asp:Parameter>
                            <asp:Parameter Name="Deleted" Type="Boolean"></asp:Parameter>
                            <asp:Parameter Name="Type" Type="String"></asp:Parameter>
                            <asp:Parameter Name="Method" Type="String"></asp:Parameter>
                            <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </asp:Panel>

            </asp:View>
            


            </asp:MultiView>

        </ContentTemplate>
    </asp:UpdatePanel>


</asp:Content>

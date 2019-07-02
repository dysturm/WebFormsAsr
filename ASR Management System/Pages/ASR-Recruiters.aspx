<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ASR-Recruiters.aspx.cs" Inherits="ASR_Management_System.Pages.ASR_Recruiters" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/MaintainScrollAndResizePosition.js" defer></script>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    Select ASR-Recruiter:
    <asp:DropDownList ID="RecruiterDropdown" runat="server" AutoPostBack="True" DataSourceID="DropDownDataSource" DataTextField="Recruiter_Name" DataValueField="Recruiter_Name" Style="margin-top: 0px" OnSelectedIndexChanged="RecruiterDropdown_SelectedIndexChanged">
    </asp:DropDownList>
    <br />
    <br />

    <asp:DetailsView ID="DetailsView1" CssClass="NumSubmissionsField" AlternatingRowStyle-Width="30%" runat="server" AutoGenerateRows="False" DataSourceID="NumSubmitsDS" Height="50px" Width="125px" CellPadding="4" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle Width="30%" BackColor="White" ForeColor="#284775"></AlternatingRowStyle>
        <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
        <EditRowStyle BackColor="#999999" />
        <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
        <Fields>
            <asp:BoundField DataField="TotalSubmissions" HeaderText="Total Submissions:" SortExpression="TotalSubmissions">
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="ActiveSubmissions" HeaderText="Active Submissions:" ReadOnly="True" SortExpression="ActiveSubmissions">
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
        </Fields>
        <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" CssClass="NumSubmissionsFieldHeader" />
        <PagerStyle ForeColor="White" HorizontalAlign="Center" BackColor="#284775" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
    </asp:DetailsView>

    <asp:SqlDataSource ID="DropDownDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [Recruiter Name] AS Recruiter_Name FROM [ASR-RECRUITERS]"></asp:SqlDataSource>
    <br />

    <asp:Button ID="ViewAllSubs" runat="server" Text="View All Records" PostBackUrl="~/Pages/ASR-Recruiters.aspx" BackColor="Black" ForeColor="White" CssClass="MediumButton" />
    &nbsp;&nbsp;
    <asp:Button ID="ViewOpenSubs" runat="server" Text="View Active Submissions" PostBackUrl="~/Pages/ASR-RecruitersActiveSubOnly.aspx" CssClass="MediumButton" />

    <br />

        <br />
        <asp:SqlDataSource ID="NumSubmitsDS" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [TotalSubmissions], [ActiveSubmissions] FROM [ASR-Recruiter Count] WHERE (([Recruiter Name] = ?) AND ([Recruiter Name] = ?))">
            <SelectParameters>
                <asp:ControlParameter ControlID="RecruiterDropdown" Name="Recruiter_Name" PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter ControlID="RecruiterDropdown" Name="Recruiter_Name2" PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>


<%--    div container for left side of page  --%>

    <div class="LeftGridViewContainer" id="GridViewContainer">
        <asp:GridView ID="GridView1" CssClass="GridViewsLeft" runat="server" DataKeyNames="SLNO" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="GridViewDataSource" ForeColor="#333333" GridLines="None" OnRowDataBound="GridView1_RowDataBound">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="SLNO" HeaderText="SLNO" SortExpression="SLNO" />
                <asp:BoundField DataField="Consultant_Name" HeaderText="Consultant" SortExpression="Consultant_Name" />
                <asp:BoundField DataField="VENDOR_COMPANY_NAME" HeaderText="VENDOR" SortExpression="VENDOR_COMPANY_NAME" />
                <asp:BoundField DataField="Client_Name" HeaderText="Client" SortExpression="Client_Name" />
                <asp:BoundField DataField="Submission_Status" HeaderText="Status" SortExpression="Submission_Status" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
    </div>

    <%--    hidden fields for scrolling and resize  --%>

    <asp:HiddenField ID="ScrollPosition" runat="server" Value="0" ClientIDMode="Static" />
    <asp:HiddenField ID="GridViewResizeHeight" runat="server" Value="0" ClientIDMode="Static"/>
    <asp:HiddenField ID="GridViewResizeWidth" runat="server" Value="0" ClientIDMode="Static"/>


    <%--    div container for right side of page  --%>

    <div class="RightGridViewContainer">
        <asp:Label ID="Label1" runat="server" Text="Label">Submission Details:</asp:Label><br />
        <br />
        <asp:GridView ID="GridView2" CssClass="GridViewsRight" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataSourceID="GV2DS" ForeColor="Black" GridLines="Vertical">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="SLNO" HeaderText="SLNO" SortExpression="SLNO" />
                <asp:BoundField DataField="Consultant_Name" HeaderText="Consultant" SortExpression="Consultant_Name" />
                <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" DataFormatString="{0:d}" HtmlEncode="false" />
                <asp:BoundField DataField="JOB_TITLE" HeaderText="JOB_TITLE" SortExpression="JOB_TITLE" />
                <asp:BoundField DataField="CITY" HeaderText="CITY" SortExpression="CITY" />
                <asp:BoundField DataField="STATE" HeaderText="STATE" SortExpression="STATE" />
                <asp:BoundField DataField="Duration" HeaderText="Duration" SortExpression="Duration" />
            </Columns>
            <FooterStyle BackColor="#CCCC99" />
            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
            <RowStyle BackColor="#F7F7DE" />
            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#FBFBF2" />
            <SortedAscendingHeaderStyle BackColor="#848384" />
            <SortedDescendingCellStyle BackColor="#EAEAD3" />
            <SortedDescendingHeaderStyle BackColor="#575357" />
        </asp:GridView>
        <asp:SqlDataSource ID="GV2DS" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [SLNO], [Date], [JOB TITLE] AS JOB_TITLE, [CITY], [STATE], [Duration], [Consultant Name] AS Consultant_Name FROM [Sub Query FULL] WHERE ([SLNO] = ?)">
            <SelectParameters>
                <asp:ControlParameter ControlID="GridView1" Name="SLNO" PropertyName="SelectedValue" Type="Int16" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="GridViewDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [SLNO], [Consultant Name] AS Consultant_Name, [VENDOR COMPANY NAME] AS VENDOR_COMPANY_NAME, [Client Name] AS Client_Name, [Submission Status] AS Submission_Status FROM [Sub Query FULL] WHERE ([ASR-RECRUITERS.RECRUITER NAME] = ?)">
            <SelectParameters>
                <asp:ControlParameter ControlID="RecruiterDropdown" Name="column1" PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>


        <asp:GridView ID="GridView3" runat="server" CssClass="GridViewsRight" AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataSourceID="GV3DS" ForeColor="Black" GridLines="Vertical" OnRowDataBound="GridView3_RowDataBound">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="RATE_PER_HOUR" HeaderText="RATE" SortExpression="RATE_PER_HOUR" />
                <asp:BoundField DataField="METHOD" HeaderText="METHOD" SortExpression="METHOD" />
                <asp:BoundField DataField="CLIENT_SUBMISSION" HeaderText="CLIENT" SortExpression="CLIENT_SUBMISSION" />
                <asp:BoundField DataField="column1" HeaderText="ASR-Recruiter" SortExpression="column1" />
                <asp:BoundField DataField="VENDOR_COMPANY_NAME" HeaderText="VENDOR" SortExpression="VENDOR_COMPANY_NAME" />
                <asp:BoundField DataField="column2" HeaderText="Vendor Contact" SortExpression="column2" />
                <asp:BoundField DataField="Client_Name" HeaderText="Client" SortExpression="Client_Name" />
                <asp:BoundField DataField="Submission_Status" HeaderText="Submission Status" SortExpression="Submission_Status" />
            </Columns>
            <FooterStyle BackColor="#CCCC99" />
            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
            <RowStyle BackColor="#F7F7DE" />
            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#FBFBF2" />
            <SortedAscendingHeaderStyle BackColor="#848384" />
            <SortedDescendingCellStyle BackColor="#EAEAD3" />
            <SortedDescendingHeaderStyle BackColor="#575357" />
        </asp:GridView>
        <asp:SqlDataSource ID="GV3DS" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [RATE PER HOUR] AS RATE_PER_HOUR, [METHOD], [CLIENT SUBMISSION] AS CLIENT_SUBMISSION, [ASR-RECRUITERS.RECRUITER NAME] AS column1, [VENDOR COMPANY NAME] AS VENDOR_COMPANY_NAME, [Vendor Contact.RECRUITER NAME] AS column2, [Client Name] AS Client_Name, [Submission Status] AS Submission_Status FROM [Sub Query FULL] WHERE ([SLNO] = ?)">
            <SelectParameters>
                <asp:ControlParameter ControlID="GridView1" Name="SLNO" PropertyName="SelectedValue" Type="Int16" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:GridView ID="GridView4" runat="server" CssClass="GridViewsRight" AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataSourceID="GV4DS" ForeColor="Black" GridLines="Vertical">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="REMARKS" HeaderText="REMARKS" SortExpression="REMARKS" />
            </Columns>
            <FooterStyle BackColor="#CCCC99" />
            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
            <RowStyle BackColor="#F7F7DE" />
            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#FBFBF2" />
            <SortedAscendingHeaderStyle BackColor="#848384" />
            <SortedDescendingCellStyle BackColor="#EAEAD3" />
            <SortedDescendingHeaderStyle BackColor="#575357" />
        </asp:GridView>
        <asp:SqlDataSource ID="GV4DS" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [REMARKS] FROM [Sub Query FULL] WHERE ([SLNO] = ?)">
            <SelectParameters>
                <asp:ControlParameter ControlID="GridView1" Name="SLNO" PropertyName="SelectedValue" Type="Int16" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <br />


        <asp:Label ID="Label2" runat="server" Text="Label">Interviews:</asp:Label><br />


        <br />
        <asp:GridView ID="GridView5" runat="server" CssClass="GridViewsRight" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="ID" DataSourceID="InterviewGVDS" ForeColor="Black" GridLines="Vertical" OnRowDataBound="GridView5_RowDataBound">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                <asp:BoundField DataField="Date_Scheduled" HeaderText="Date_Scheduled" SortExpression="Date_Scheduled" DataFormatString="{0:d}" HtmlEncode="false" />
                <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" />
                <asp:BoundField DataField="Method" HeaderText="Method" SortExpression="Method" />
                <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                <asp:BoundField DataField="Feedback" HeaderText="Feedback" SortExpression="Feedback" />
                <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks" />
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#808080" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#383838" />
        </asp:GridView>
        <asp:SqlDataSource ID="InterviewGVDS" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [ID], [Date Scheduled] AS Date_Scheduled, [Type], [Method], [Status], [Feedback], [Remarks] FROM [Interviews] WHERE ([Submission-SLNO] = ?)">
            <SelectParameters>
                <asp:ControlParameter ControlID="GridView1" Name="column1" PropertyName="SelectedValue" Type="Int16" />
            </SelectParameters>
        </asp:SqlDataSource>

    </div>
</asp:Content>

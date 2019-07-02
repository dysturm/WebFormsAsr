<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Consultants.aspx.cs" Inherits="ASR_Management_System.Pages.Consultants" MaintainScrollPositionOnPostback="true" SmartNavigation="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Design/ConsultantDetails.css" rel="stylesheet" />


    <%-- script to keep sub panel scroll pos on postback --%>
    <%--<script src="../Scripts/MaintainSubmissionPanelScrollPosition.js" defer></script>--%>

    <%-- script to set focus on notes box when edit btn clicked --%>
    <%--<script src="../Scripts/SetFocusOnNotesEdit.js" defer></script>--%>
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <%--hidden id field (set in pg_load when postbacked from home pg)--%>
    <asp:HiddenField ID="ConsultantId" runat="server" Value="1" />

    <%--back to home button--%>
    <asp:LinkButton ID="ReturnToHomebtn" runat="server" CssClass="backBtn" PostBackUrl="~/Pages/SelectConsultant.aspx">
        < Back To Consultants
    </asp:LinkButton>
    
    <%-- consultant name --%>
    <asp:Label ID="NameLabel" runat="server" Text='Name Not Set' CssClass="nameLabel"></asp:Label>
    
    <%-- btn view submissions --%>
    <asp:LinkButton runat="server" OnClick="Button_View_All_Submissions_Click" CssClass="lnkbtnViewSubmissions">
        View Submissions >
    </asp:LinkButton>

    <%-- consultant overall STATUS box --%>
    <asp:UpdatePanel ID="UpdatePanel_Consultant_Status" runat="server">
        <ContentTemplate>
            <div id="status_box">
                <asp:ListView ID="ListView_Consultant_Status" runat="server" DataSourceID="ConsultantStatsDS">
                    <ItemTemplate>
                        <asp:LinkButton ID="Label_Consultant_Status" Text='<%# Eval("Status") %>' ToolTip="Click To Change" CssClass="status_textbox" OnClick="Label_Consultant_Status_Click" runat="server"></asp:LinkButton>
                        <ajaxToolkit:ComboBox ID="ComboBox_Consultant_Status" Visible="false" Text='<%# Eval("Status") %>' runat="server" AutoCompleteMode="SuggestAppend" DataSourceID="SqlDataSource_ConsultantStatusOptions" DataTextField="Status" DataValueField="Status" MaxLength="0" Width="200px" Font-Size="20px" Height="20px"></ajaxToolkit:ComboBox>
                        <asp:SqlDataSource ID="SqlDataSource_ConsultantStatusOptions" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [Status] FROM [Consultant Status Options]"></asp:SqlDataSource>

                    </ItemTemplate>
                </asp:ListView>

                <asp:Button ID="Button_Edit_Status" Visible="false" runat="server" Text="Change" OnClick="Button_Edit_Status_Click" CssClass="consultant_status_btn" />
                <asp:Button ID="Button_Save_Status" Visible="false" runat="server" Text="Save" OnClick="Button_Save_Status_Click" CssClass="consultant_status_btn" />
                <asp:Button ID="Button_Cancel_Save" Visible="false" runat="server" Text="Cancel" OnClick="Button_Cancel_Save_Click" CssClass="consultant_status_btn" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    

    <%--listview with label for consultant name + labels for general consultant stats--%>
    <asp:ListView ID="NameLabelDataControl" runat="server" DataSourceID="ConsultantStatsDS">
        <ItemTemplate>

            <div id="stat_labels_container">
                <asp:Label ID="Active_Submits_Label" runat="server" CssClass="active_submits_label stat_Labels">
                    Submissions: <br /><span class="stat_num_span"><%# Eval("ActiveSubmissions") %></span>
                </asp:Label>

                <asp:Label ID="Pending_Interviews_Label" runat="server" CssClass="pending_interviews_label stat_Labels">
                      Pending Interviews: <br /><span class="stat_num_span"><%# Eval("PendingInterviews") %></span>
                </asp:Label>

                <asp:Label ID="Avg_Rate_Label" runat="server" CssClass="avg_rate_label stat_Labels">Average Rate: <span class="stat_rate_span">$<%# Eval("AvgRate", "{0:#}") %></span>
                    Range: <span class="stat_rate_span">$<%# Eval("MinRate", "{0:#}") %> - $<%# Eval("MaxRate", "{0:#}") %></span>
                    <br />
                    Past 3:          
                    <%-- repeater for past few RATES OF SUBMISSIONS --%>
                    <asp:Repeater ID="Repeater_Recent_Rates" runat="server" DataSourceID="SqlDataSource_Recent_Rates">
                        <ItemTemplate>
                            <span class="stat_rate_span">$<%# Eval("SubmissionRate", "{0:#}") %></span>
                        </ItemTemplate>
                        <SeparatorTemplate><span class="stat_rate_span">,</span></SeparatorTemplate>
                    </asp:Repeater>
                </asp:Label>
            </div>
        </ItemTemplate>
    </asp:ListView>


    <%--data source for detail view of stats and consultant name - based on hidden id field--%>
    <asp:SqlDataSource ID="ConsultantStatsDS" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [FirstName], [LastName], [ActiveSubmissions], [PendingInterviews], [AvgRate], [MaxRate], [MinRate], [Status] FROM [ConsultantOverviewQuery] WHERE ([ID] = ?)">
        <SelectParameters>
            <asp:ControlParameter ControlID="ConsultantId" Name="ID" PropertyName="Value" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <%--data source for recent consultant rates --%>
    <asp:SqlDataSource ID="SqlDataSource_Recent_Rates" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT TOP 3 [SubmissionRate] FROM [ConsultantPast5Rates] WHERE ([ConsultantID] = ?)">
        <SelectParameters>
            <asp:ControlParameter ControlID="ConsultantId" Name="ConsultantID" PropertyName="Value" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>





    <%-- *********************************** --%>
    <%-- removed submission contect --%>
    <%-- *********************************** --%>



    <%--container to hold CONTROL btns (bottom of screen)--%>
    <%--<div id="ctrl_btns_container">

        <%--btn to add NEW SUBMISSION--%>
        <%--<asp:Button ID="Button_add_new_submission" runat="server" Text="Add New Submission +" CssClass="ctrl_btn" />--%>

        <%--btn to add NEW INTERVIEW--%>
        <%--<asp:Button ID="Button_Add_New_Interview" Enabled="false" runat="server" Text="Add New Interview +" CssClass="ctrl_btn" />--%>

        <%--btn to open popup to view ALL submissions--%>
        <%--<asp:Button ID="Button_View_All_Submissions" runat="server" OnClick="Button_View_All_Submissions_Click" Text="View All Submissions" CssClass="ctrl_btn" />--%>

    <%--</div>--%>







    <%-- placeholder 111 = viewing gridview of all submissions --%>



    <%-- panel for general consultant notes --%>
    <asp:UpdatePanel ID="UpdatePanel_Consultant_Notes" runat="server">
        <ContentTemplate>
            <asp:Panel ID="Panel_Consultant_Notes" CssClass="panel_consultant_notes" runat="server">
                <asp:Label ID="Label_consultant_notes" runat="server" Text="NOTES" CssClass="lblForNotes"></asp:Label>



                <asp:ListView ID="ListView_Consultant_Notes" runat="server" DataSourceID="SqlDataSource_Consultant_Notes">
                    <ItemTemplate>
                        <asp:TextBox ID="TextBox_Consultant_Notes" Text='<%# Eval("Notes") %>' runat="server" TextMode="MultiLine" Width="99.6%" Height="60%" ReadOnly="true" CssClass="consulant_notes_txtbox"></asp:TextBox>
                    </ItemTemplate>
                </asp:ListView>

                <br />

                <asp:Button ID="Button_Edit_Consultant_Notes" runat="server" Text="Edit" OnClick="Button_Edit_Consultant_Notes_Click" OnClientClick="setFocus()" CssClass="notes_btn" />
                <asp:Button ID="Button_Save_Notes" runat="server" Text="Save" Visible="false" OnClick="Button_Save_Notes_Click" CssClass="notes_btn" />
                <asp:Button ID="Button_Cancel_Notes_Save" runat="server" Text="Cancel" Visible="false" OnClick="Button_Cancel_Notes_Save_Click" CssClass="notes_btn" />

                <asp:SqlDataSource ID="SqlDataSource_Consultant_Notes" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [Status], [Notes] FROM [Consultants] WHERE ([ID] = ?)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ConsultantId" Name="ID" PropertyName="Value" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>



    <asp:Button ID="Button_HiddenForModalPopup" runat="server" Text="hiddenbtn" Style="display: none" />

    <ajaxToolkit:ModalPopupExtender runat="server" BackgroundCssClass="modalBackground"
        DropShadow="false" CancelControlID="Button_OkMsg"
        BehaviorID="ModalPopupExtender_ShowMsg" TargetControlID="Button_HiddenForModalPopup" ID="ModalPopupExtender_ShowMsg" PopupControlID="MsgPanelPopup">
    </ajaxToolkit:ModalPopupExtender>

    <asp:Panel ID="MsgPanelPopup" runat="server" CssClass="msgPanel">
        <asp:Label ID="MsgPanelPopup_LabelText" runat="server" Text="My Message" CssClass="msgTextLabel"></asp:Label>
        <asp:Button ID="Button_OkMsg" runat="server" Text="OK" CssClass="msgBtn" />
    </asp:Panel>



</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ViewAllSubmissions.aspx.cs" Inherits="ASR_Management_System.Pages.ViewAllSubmissions" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Design/ConsultantDetails.css" rel="stylesheet" />

    <%-- script to keep sub panel scroll pos on postback --%>
    <script src="../Scripts/MaintainScrollPosAllSubmissions.js" defer></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%--hidden id field (set in pg_load when postbacked from home pg)--%>
    <asp:HiddenField ID="ConsultantId" runat="server" Value="1" />

    <%--back to home button--%>
    <asp:LinkButton ID="Backbtn" runat="server" CssClass="backBtn" OnClick="Backbtn_Click" ToolTip="Return To Consultant Page">
        < Back
    </asp:LinkButton>

    <%-- add new submission btn --%>
    <asp:Button ID="btnMakeNewSubmission" runat="server" Text="New Submission"  CssClass="lnkbtnViewSubmissions" ToolTip="Create New Submission For This Consultant"/>
    <%-- OnClick="btnMakeNewSubmission_OnClick" --%>

    <%--listview with label for consultant name + labels for general consultant stats--%>
    <asp:ListView ID="NameLabelDataControl" runat="server" DataSourceID="ConsultantStatsDS">
        <ItemTemplate>
            <asp:Label ToolTip="Consultant Name" ID="NameLabel" runat="server" Text='<%# Eval("LastName") +", "+ Eval("FirstName") %>' CssClass="nameLabel"></asp:Label>
        </ItemTemplate>
    </asp:ListView>

    <%--data source for detail view of stats and consultant name - based on hidden id field--%>
    <asp:SqlDataSource ID="ConsultantStatsDS" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [FirstName], [LastName], [ActiveSubmissions], [PendingInterviews], [AvgRate], [MaxRate], [MinRate], [Status] FROM [ConsultantOverviewQuery] WHERE ([ID] = ?)">
        <SelectParameters>
            <asp:ControlParameter ControlID="ConsultantId" Name="ID" PropertyName="Value" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


    <%--update panel to contain SUBMISSION + INTERVIEW panels (so whole pg doesn't postback every time panel is collapsed/expanded)--%>
    <asp:UpdatePanel ID="UpdatePanel_Submissions_Interviews" runat="server">

        <ContentTemplate>





            <%--panel for active submissions details--%>
            <asp:Panel ID="Active_Submissions_Panel" runat="server" CssClass="Active_Submissions_Panel">

                <%--active submissions repeater--%>
                <asp:Repeater ID="All_Submissions_Repeater" runat="server" DataSourceID="All_Submissions_DS" OnItemCommand="All_Submissions_Repeater_ItemCommand">

                    <ItemTemplate>
                        <div class="submission_row_linkbutton">
                            (<asp:Label Style="color: green;" ToolTip="Rate Per Hour" runat="server"><%# Eval("RATE_PER_HOUR")%></asp:Label>)
                            <asp:LinkButton ToolTip="Submission (Client Name / Date)" Font-Underline="False" ID="LinkButton_Submission_Row" runat="server" CommandName="ShowSubmission" CommandArgument='<%# Eval("SLNO") %>'>
                                        <%# Eval("Client_Name") %> on <%# Eval("Date", "{0:d}") %>
                            </asp:LinkButton>
                             
                                        <%--<asp:Button ID="Button_Toggle_Interviews" runat="server" Text="-" CssClass="interview_toggle_btn" />--%>
                            <asp:Label ToolTip="Submission Status" Style="font-size: 12px; white-space: normal;" runat="server"> -- <%# Eval("Submission_Status") %></asp:Label>
                            <asp:Button ToolTip="Add New Interview For This Submission" ID="Button_Add_Interview" runat="server" Text="+Intvw" CssClass="Btn_New_Interview" CommandName="AddInterview" CommandArgument='<%# Eval("SLNO") %>' />
                        </div>

                        <%--collapsible panel extender to display interviews attached to submission--%>
                        <%--<ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender_Submission_Interviews" runat="server"
                                        AutoCollapse="false"
                                        TargetControlID="Panel_Submission_Interviews"
                                        CollapseControlID="Button_Toggle_Interviews"
                                        ExpandControlID="Button_Toggle_Interviews" />--%>


                        <asp:HiddenField ID="HiddenField_Submission_SLNO" runat="server" Value='<%# Eval("SLNO") %>' />

                        <%--data source for pending interviews panel--%>
                        <asp:SqlDataSource ID="Pending_Interviews_DS" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [ID], [Submission-SLNO] AS column1, [Type], [Date Scheduled] AS Date_Scheduled, [Method], [Interviewer], [Skills Required] AS Skills_Required, [Status], [Feedback], [Remarks] FROM [Interviews] WHERE ([ConsultantID] = ?) AND ([Submission-SLNO] = ?) AND [Deleted] = 0">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ConsultantId" Name="ConsultantID" PropertyName="Value" Type="Int32" />
                                <asp:ControlParameter ControlID="HiddenField_Submission_SLNO" Name="Submission-SLNO" PropertyName="Value" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>




                        <%--repeater to display submission interviews--%>
                        <asp:Repeater ID="Repeater_Submission_Interviews" DataSourceID="Pending_Interviews_DS" runat="server" OnItemCommand="Repeater_Submission_Interviews_ItemCommand">
                            <ItemTemplate>
                                <%--collapsible panel to display interviews attached to submission--%>
                                <asp:Panel ID="Panel_Submission_Interviews" CssClass="submission_intvw_collapsible_panel" runat="server">


                                    <div class="interview_row_linkbutton">

                                        <span style="/*float: left; */background-color: lightblue; padding: 5px; font-size: 14px;"><%# Eval("Status") %></span>
                                        <asp:LinkButton ID="LinkButton_Interview_Row" runat="server" Font-Underline="false" CommandName="ShowInterview" CommandArgument='<%# Eval("ID") %>'>
                                                    Interview on <span style="/*color: red*/"><%# Eval("Date_Scheduled", "{0:d}") %></span> via <span style="/*color: forestgreen*/"><%# Eval("Method") %></span>
                                        </asp:LinkButton>
                                        <asp:Button ID="Button_View_Interview_Feedback" runat="server" Text="+" CssClass="intvw_feedback_toggle_btn" />

                                        <%--collapse extender to display interview feedback--%>
                                        <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender_Interview_Feedback" runat="server"
                                            Collapsed="true"
                                            TargetControlID="Panel_Interview_Feedback"
                                            ExpandControlID="Button_View_Interview_Feedback"
                                            CollapseControlID="Button_View_Interview_Feedback" />


                                        <%--collapsible panel to display interview feedback--%>
                                        <asp:Panel ID="Panel_Interview_Feedback" runat="server">
                                            <span style=""><span style="text-decoration: underline;">Feedback:</span> <%# Eval("Feedback") %>
                                                <br />
                                                <span style="text-decoration: underline">Remarks:</span>  <%# Eval("Remarks") %></span>
                                        </asp:Panel>

                                    </div>
                                </asp:Panel>
                            </ItemTemplate>
                        </asp:Repeater>




                    </ItemTemplate>
                    <SeparatorTemplate>
                        <hr style="margin-top: 15px; margin-bottom: 15px;"/>
                    </SeparatorTemplate>
                </asp:Repeater>

            </asp:Panel>

            <%--end submissions div--%>

            <%--data source for ALL submissions panel--%>
            <asp:SqlDataSource ID="All_Submissions_DS" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [LastName], [SLNO], [Date], [JOB TITLE] AS JOB_TITLE, [CITY], [STATE], [Duration], [RATE PER HOUR] AS RATE_PER_HOUR, [METHOD], [CLIENT SUBMISSION] AS CLIENT_SUBMISSION, [REMARKS], [ASR-RECRUITERS.RECRUITER NAME] AS Recruiter, [VENDOR COMPANY NAME] AS VENDOR_COMPANY_NAME, [Vendor Contact.RECRUITER NAME] AS column2, [Client Name] AS Client_Name, [Submission Status] AS Submission_Status, Active, Deleted FROM [ConsultantAllSubmits] WHERE ([CONSULTANT ID] = ?) AND ([Deleted] = 0) ORDER BY [Date] DESC">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ConsultantId" Name="CONSULTANT_ID" PropertyName="Value" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />


            <%--end all panels div container--%>
        </ContentTemplate>
    </asp:UpdatePanel>
    <%--end update panel for submissions + interviews--%>

    <asp:SqlDataSource ID="SqlDataSource_Recruiters" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [Recruiter Name] FROM [ASR-RECRUITERS]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="ComboBox_Clients_DS" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [Client Name] FROM [Clients]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_States" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT UCName, LCName, Initials FROM [US_States]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Vendors" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [Vendor Company Name] FROM [Vendors]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Vendor_Contact" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [Recruiter Name] FROM [Vendor Contact]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Submission_Status" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [Status Option] FROM [Submission Status Options]"></asp:SqlDataSource>


    <%-- submission view panel --%>
    <asp:UpdatePanel ID="UpdatePanel_Submission" runat="server">
        <ContentTemplate>


            <asp:Button ID="Button_PopupHelper" runat="server" Style="display: none" />

            <%--modal POPUP extender for VIEWING submissions--%>
            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender_View_Submissions" runat="server"
                TargetControlID="Button_PopupHelper"
                PopupControlID="popupMenu_View_Submission"
                BackgroundCssClass="modalBackground"
                DropShadow="true">
            </ajaxToolkit:ModalPopupExtender>



            <%--POPUP panel to VIEW submissions--%>
            <asp:Panel ID="popupMenu_View_Submission" CssClass="popupMenu_View_Submissions" runat="server" Style="display: none">

                <asp:Label ID="Label_Title_View" runat="server" Text="View Submission" CssClass="label_title"></asp:Label>
                <asp:Button ID="Cancel_Btn" runat="server" Text="X" CssClass="cancel_btn" OnClick="Cancel_Btn_Click" />
                <asp:Button ID="Button_Delete_Submission" runat="server" Text="Delete Submission" CssClass="delete_Btn" OnClick="Button_Delete_Submission_OnClick" />
                <div class="cmnd_btns_div">
                    <asp:Button ID="Button_Edit_Submission" runat="server" Text="Edit" CssClass="btn_edit_submission" OnClick="Button_Edit_Submission_Click" />
                    <asp:Button ID="Button_Cancel_Edit" runat="server" Visible="false" Text="Cancel" CssClass="btn_edit_submission" OnClick="Button_Cancel_Edit_Click" />
                    <asp:Button ID="Button_Save_Changes" runat="server" Visible="false" Text="Save Changes" CssClass="btn_edit_submission" OnClick="Button_Save_Changes_Click" />
                    <asp:Button ID="Button_Create_New_Submission" runat="server" Visible="false" Text="Create Submission" CssClass="btn_edit_submission" OnClick="Button_Create_New_Submission_OnClick" />
                </div>

                <div class="input_fields">
                    <asp:Label ID="Label1" runat="server" Text="SLNO: " CssClass="label" />
                    <asp:TextBox ID="TextBox_SLNO" TextMode="Number" ReadOnly="true" Text='' CssClass="textbox" runat="server" />
                </div>

                <div class="input_fields">
                    <asp:Label ID="Label2" runat="server" Text="Consultant: " CssClass="label" />
                    <asp:TextBox ID="TextBox_LName" ReadOnly="true" CssClass="textbox" runat="server" />
                </div>

                <div class="input_fields">
                    <asp:Label ID="Label3" runat="server" Text="Recruiter: " CssClass="label" />
                    <ajaxToolkit:ComboBox ID="ComboBox_Recruiter" runat="server" Visible="false" CssClass="combobox" AutoCompleteMode="Append" DataSourceID="SqlDataSource_Recruiters" DataTextField="Recruiter Name" DataValueField="Recruiter Name" MaxLength="0" Style="display: inline; position: absolute; bottom: 5px;" Font-Size="18px" Width="200px" Height="20px"></ajaxToolkit:ComboBox>
                    <asp:TextBox ID="TextBox_Recruiter" ReadOnly="true" CssClass="textbox" runat="server"></asp:TextBox>
                </div>

                <div class="input_fields">
                    <asp:Label ID="Label4" runat="server" Text="Client: " CssClass="label" />
                    <ajaxToolkit:ComboBox ID="ComboBox_Client" Visible="false" runat="server" AutoCompleteMode="Append" DataSourceID="ComboBox_Clients_DS" DataTextField="Client Name" DataValueField="Client Name" MaxLength="0" CssClass="combobox_client" Style="display: inline; position: absolute; bottom: 5px;" Font-Size="18px" Width="300px" Height="20px"></ajaxToolkit:ComboBox>
                    <asp:TextBox ID="TextBox_Client" ReadOnly="true" CssClass="textbox" runat="server"></asp:TextBox>
                </div>

                <div class="input_fields">
                    <asp:Label ID="Label5" runat="server" Text="Rate: " CssClass="label" />
                    <asp:TextBox ID="TextBox_Rate" TextMode="Number" ReadOnly="true" CssClass="textbox" runat="server" />
                </div>

                <div class="input_fields">
                    <asp:Label ID="Label6" runat="server" Text="Method: " CssClass="label" />
                    <asp:TextBox ID="TextBox_Method" ReadOnly="true" CssClass="textbox" runat="server" />
                </div>

                <div class="input_fields">
                    <asp:Label ID="Label7" runat="server" Text="City: " CssClass="label" />
                    <asp:TextBox ID="TextBox_City" ReadOnly="true" CssClass="textbox" runat="server" />
                </div>

                <div class="input_fields">
                    <asp:Label ID="Label8" runat="server" Text="State: " CssClass="label" />
                    <ajaxToolkit:ComboBox ID="ComboBox_State" Visible="false" runat="server" AutoCompleteMode="Append" DataSourceID="SqlDataSource_States" DataTextField="LCName" DataValueField="Initials" MaxLength="0" CssClass="combobox_state" Style="display: inline; position: absolute; bottom: 5px;" Width="150px" Font-Size="18px" Height="20px"></ajaxToolkit:ComboBox>
                    <asp:TextBox ID="TextBox_State" ReadOnly="true" CssClass="textbox" runat="server" />
                </div>

                <div class="input_fields">
                    <asp:Label ID="Label9" runat="server" Text="Job Title: " CssClass="label" />
                    <asp:TextBox ID="TextBox_JobTitle" ReadOnly="true" CssClass="textbox" runat="server" />
                </div>

                <div class="input_fields">
                    <asp:Label ID="Label10" runat="server" Text="Duration: " CssClass="label" />
                    <asp:TextBox ID="TextBox_Duration" ReadOnly="true" CssClass="textbox" runat="server" />
                </div>

                <div class="input_fields">
                    <asp:Label ID="Label11" runat="server" Text="Vendor: " CssClass="label" />
                    <ajaxToolkit:ComboBox ID="ComboBox_Vendor" Visible="false" runat="server" AutoCompleteMode="Append" DataSourceID="SqlDataSource_Vendors" DataTextField="Vendor Company Name" DataValueField="Vendor Company Name" MaxLength="0" CssClass="combobox_vendor" Style="display: inline; position: absolute; bottom: 5px;" Width="250px" Font-Size="18px" Height="20px"></ajaxToolkit:ComboBox>
                    <asp:TextBox ID="TextBox_Vendor" ReadOnly="true" CssClass="textbox" runat="server" />
                </div>

                <div class="input_fields">
                    <asp:Label ID="Label12" runat="server" Text="Vendor Contact: " CssClass="label" />
                    <ajaxToolkit:ComboBox ID="ComboBox_VendorContact" Visible="false" runat="server" AutoCompleteMode="Append" DataSourceID="SqlDataSource_Vendor_Contact" DataTextField="Recruiter Name" DataValueField="Recruiter Name" MaxLength="0" CssClass="combobox_vendor_contact" Style="display: inline; position: absolute; bottom: 5px;" Width="200px" Font-Size="18px" Height="20px"></ajaxToolkit:ComboBox>
                    <asp:TextBox ID="TextBox_VendorContact" ReadOnly="true" CssClass="textbox" runat="server" />
                </div>

                <div class="input_fields">
                    <asp:Label ID="Label13" runat="server" Text="Client Submission: " CssClass="label" />
                    <asp:TextBox ID="TextBox_ClientSubmission" ReadOnly="true" CssClass="textbox" runat="server" />
                </div>

                <div class="input_fields" style="position: relative">
                    <asp:Label ID="Label16" runat="server" Text="Date: " CssClass="label" />
                    <asp:TextBox ID="Edit_TextBox_Date" ReadOnly="true" CssClass="textbox" runat="server" />
                    <ajaxToolkit:CalendarExtender runat="server" Enabled="false" TargetControlID="Edit_TextBox_Date" PopupPosition="Left" ID="CalendarExtender1"></ajaxToolkit:CalendarExtender>
                </div>

                <div class="input_fields">
                    <asp:Label ID="Label14" runat="server" Text="Remarks: " CssClass="label" />
                    <asp:TextBox ID="TextBox_Remarks" ReadOnly="true" CssClass="textbox" runat="server" />
                </div>

                <div class="input_fields">
                    <asp:Label ID="Label15" runat="server" Text="Submission Status: " CssClass="label" />
                    <ajaxToolkit:ComboBox ID="ComboBox_SubmissionStatus" Visible="false" runat="server" AutoCompleteMode="Append" DataSourceID="SqlDataSource_Submission_Status" DataTextField="Status Option" DataValueField="Status Option" MaxLength="0" CssClass="combobox_submission_status" Style="display: inline; position: absolute; bottom: 5px;" Width="300px" Font-Size="18px" Height="20px"></ajaxToolkit:ComboBox>
                    <asp:TextBox ID="TextBox_SubmissionStatus" ReadOnly="true" CssClass="textbox" runat="server" />
                </div>

                <div class="input_fields">
                    <asp:Label ID="Label17" runat="server" Text="Is Active: " CssClass="label" />
                    <asp:CheckBox ID="CheckBox_Active" Enabled="false" runat="server" CssClass="ChkBoxClass" />
                </div>

                <%-- confirm btn extender (works with the modal popup) --%>
                <ajaxToolkit:ConfirmButtonExtender ID="ConfirmButtonExtender_Delete_Submission" runat="server"
                    TargetControlID="Button_Delete_Submission"
                    DisplayModalPopupID="ModalPopupExtender_Confirm_Delete" />

                <%--modal POPUP extender for confirming DELETE of submission--%>
                <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender_Confirm_Delete" runat="server"
                    TargetControlID="Button_Delete_Submission"
                    PopupControlID="popupMenu_Confirm_Delete"
                    BackgroundCssClass="modalBackground"
                    DropShadow="true"
                    CancelControlID="NoBtn"
                    OkControlID="YesBtn">
                </ajaxToolkit:ModalPopupExtender>

                <%--popup panel to confirm DELETE of submission--%>
                <asp:Panel ID="popupMenu_Confirm_Delete" CssClass="popupMenu_Confirm_Delete" runat="server">
                    <asp:Label ID="Label_Confirm_Delete" runat="server" Text="Are You Sure You Want To Delete This Submission?" CssClass="label_title"></asp:Label>

                    <asp:Button ID="YesBtn" runat="server" Text="Yes" CssClass="option_bts"/>
                    <asp:Button ID="NoBtn" runat="server" Text="No" CssClass="option_bts" />
                </asp:Panel>

            </asp:Panel>

        </ContentTemplate>
    </asp:UpdatePanel>


    <%-- interview view panel --%>
    <asp:UpdatePanel ID="UpdatePanel_Interview" runat="server">
        <ContentTemplate>
            <asp:Button ID="Button_dummy" runat="server" Style="display: none" />

            <%--modal popop extender for viewing INTERVIEW--%>
            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender_View_Interview" runat="server"
                TargetControlID="Button_dummy"
                PopupControlID="Panel_View_Interview"
                BackgroundCssClass="modalBackground"
                DropShadow="true">
            </ajaxToolkit:ModalPopupExtender>

            <%--popup panel for viewing INTERVIEW--%>
            <asp:Panel ID="Panel_View_Interview" runat="server" CssClass="popupMenu_add_new_interview" Style="display: none">

                <%--title--%>
                <asp:Label ID="Label_Intvw_Title" runat="server" CssClass="label_title" />

                <%--ctrl btns--%>
                <asp:Button ID="Button_popup_Cancel" runat="server" Text="X" CssClass="cancel_btn" OnClick="Button_popup_Cancel_Click" />
                <asp:Button ID="Button_Delete_Interview" runat="server" Text="Delete" CssClass="delete_Btn" OnClick="Button_Delete_Interview_OnClick"/>
                <asp:Button ID="Button_Add_Interview" Visible="false" runat="server" Text="Add Interview" CssClass="Btn_Command" OnClick="Button_Add_Interview_Click" />

                <div class="cmnd_btns_div">
                    <asp:Button ID="Button_Edit_Interview" runat="server" Text="Edit" CssClass="btn_edit_submission" OnClick="Button_Edit_Interview_Click" />
                    <asp:Button ID="Button_Update_Interview" Visible="false" runat="server" Text="Save Changes" CssClass="btn_edit_submission" OnClick="Button_Update_Interview_Click" />
                    <asp:Button ID="Button_Cancel_Interview_Update" Visible="false" runat="server" Text="Cancel" CssClass="btn_edit_submission" OnClick="Button_Cancel_Interview_Update_Click" />
                </div>

                <asp:HiddenField ID="HiddenField_Submission_SLNO" runat="server" />

                <%-- input fields --%>
                <div class="input_fields">
                    <asp:Label ID="Label20" runat="server" Text="ID: " CssClass="label" />
                    <asp:TextBox ID="TextBox_Intvw_ID" TextMode="Number" ReadOnly="true" CssClass="textbox" runat="server" />
                </div>

                <div class="input_fields">
                    <asp:Label ID="Label21" runat="server" Text="Consultant: " CssClass="label" />
                    <asp:TextBox ID="TextBox_Intvw_Constultant" ReadOnly="true" CssClass="textbox" runat="server" />
                </div>

                <div class="input_fields">
                    <asp:Label ID="Label22" runat="server" Text="Type: " CssClass="label" />
                    <ajaxToolkit:ComboBox ID="ComboBox_Intvw_Type" runat="server" Visible="false" CssClass="combobox" AutoCompleteMode="Append" DataSourceID="SqlDataSource_Interview_Type" DataTextField="Options" DataValueField="Options" MaxLength="0" Style="display: inline; position: absolute; bottom: 5px;" Font-Size="18px" Width="200px" Height="20px"></ajaxToolkit:ComboBox>
                    <asp:SqlDataSource ID="SqlDataSource_Interview_Type" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' ProviderName='<%$ ConnectionStrings:ConnectionString.ProviderName %>' SelectCommand="SELECT [Options] FROM [Interview Types]"></asp:SqlDataSource>
                    <asp:TextBox ID="TextBox_Intvw_Type" ReadOnly="true" CssClass="textbox" runat="server"></asp:TextBox>
                </div>

                <div class="input_fields">
                    <asp:Label ID="Label19" runat="server" Text="Method: " CssClass="label" />
                    <ajaxToolkit:ComboBox ID="ComboBox_Intvw_Method" Visible="false" runat="server" AutoCompleteMode="Append" DataSourceID="SqlDataSource_Interview_Method" DataTextField="Methods" DataValueField="Methods" MaxLength="0" CssClass="combobox_vendor_contact" Style="display: inline; position: absolute; bottom: 5px;" Width="200px" Font-Size="18px" Height="20px"></ajaxToolkit:ComboBox>
                    <asp:SqlDataSource ID="SqlDataSource_Interview_Method" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' ProviderName='<%$ ConnectionStrings:ConnectionString.ProviderName %>' SelectCommand="SELECT [ID], [Methods] FROM [Interview Methods]"></asp:SqlDataSource>
                    <asp:TextBox ID="TextBox_Intvw_Method" ReadOnly="true" CssClass="textbox" runat="server" />
                </div>

                <div class="input_fields">
                    <asp:Label ID="Label23" runat="server" Text="Interviewer: " CssClass="label" />
                    <asp:TextBox ID="TextBox_Intvw_Interviewer" ReadOnly="true" CssClass="textbox" runat="server" />
                </div>

                <div class="input_fields" style="position: relative">
                    <asp:Label ID="Label24" runat="server" Text="Date: " CssClass="label" />
                    <asp:TextBox ID="TextBox_Intvw_Date" ReadOnly="true" CssClass="textbox" runat="server" />
                    <ajaxToolkit:CalendarExtender runat="server" Enabled="false" TargetControlID="TextBox_Intvw_Date" PopupPosition="Left" ID="CalendarExtender_Intvw_Date"></ajaxToolkit:CalendarExtender>
                </div>

                <div class="input_fields">
                    <asp:Label ID="Label25" runat="server" Text="Skills Required: " CssClass="label" />
                    <asp:TextBox ID="TextBox_Intvw_SkillsRequired" ReadOnly="true" CssClass="textbox" runat="server" />
                </div>

                <div class="input_fields">
                    <asp:Label ID="Label26" runat="server" Text="Interview Status: " CssClass="label" />
                    <ajaxToolkit:ComboBox ID="ComboBox_Intvw_Status" Visible="false" runat="server" AutoCompleteMode="Append" DataSourceID="SqlDataSource_Interview_Status" DataTextField="Option" DataValueField="Option" MaxLength="0" CssClass="combobox_submission_status" Style="display: inline; position: absolute; bottom: 5px;" Width="300px" Font-Size="18px" Height="20px"></ajaxToolkit:ComboBox>
                    <asp:SqlDataSource ID="SqlDataSource_Interview_Status" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' ProviderName='<%$ ConnectionStrings:ConnectionString.ProviderName %>' SelectCommand="SELECT [ID], [Option] FROM [Interview Status Options]"></asp:SqlDataSource>
                    <asp:TextBox ID="TextBox_Intvw_Status" ReadOnly="true" CssClass="textbox" runat="server" />
                </div>

                <div class="input_fields">
                    <asp:Label ID="Label28" runat="server" Text="Feedback: " CssClass="label" />
                    <asp:TextBox ID="TextBox_Intvw_Feedback" ReadOnly="true" CssClass="textbox" runat="server" />
                </div>

                <div class="input_fields">
                    <asp:Label ID="Label29" runat="server" Text="Remarks: " CssClass="label" />
                    <asp:TextBox ID="TextBox_Intvw_Remarks" ReadOnly="true" CssClass="textbox" runat="server" />
                </div>



                <%-- confirm btn extender (works with the modal popup) --%>
                <ajaxToolkit:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server"
                    TargetControlID="Button_Delete_Interview"
                    DisplayModalPopupID="ModalPopupExtender_Confirm_Interview_Delete" />

                <%--modal POPUP extender for confirming DELETE of interview--%>
                <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender_Confirm_Interview_Delete" runat="server"
                    TargetControlID="Button_Delete_Interview"
                    PopupControlID="Panel_Confirm_Interview_Delete"
                    BackgroundCssClass="modalBackground"
                    DropShadow="true"
                    CancelControlID="Btn_No"
                    OkControlID="Btn_Yes">
                </ajaxToolkit:ModalPopupExtender>

                <%--popup panel to confirm DELETE of interview--%>
                <asp:Panel ID="Panel_Confirm_Interview_Delete" CssClass="popupMenu_Confirm_Delete" runat="server">
                    <asp:Label ID="Label18" runat="server" Text="Are You Sure You Want To Delete This Interview?" CssClass="label_title"></asp:Label>

                    <asp:Button ID="Btn_Yes" runat="server" Text="Yes" CssClass="option_bts"/>
                    <asp:Button ID="Btn_No" runat="server" Text="No" CssClass="option_bts"/>
                </asp:Panel>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>




    <%--modal popop extender for adding NEW submission--%>
    <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender_add_new_submission" runat="server"
        TargetControlID="btnMakeNewSubmission"
        PopupControlID="Panel_Add_New_Submission"
        BackgroundCssClass="modalBackground"
        DropShadow="true"
        CancelControlID="Button_Cancel">
    </ajaxToolkit:ModalPopupExtender>

    <%--popup panel to add NEW submission--%>
    <asp:Panel ID="Panel_Add_New_Submission" Style="display: none" CssClass="popupMenu_add_new_submission" runat="server">

        <%--title--%>
        <asp:Label ID="Label_Title" runat="server" Text="Add New Submission" CssClass="label_title"></asp:Label>


        <%--ctrl btns--%>
        <asp:Button ID="Button_Cancel" runat="server" Text="X" CssClass="cancel_btn" />
        <asp:Button ID="Button_Create_Submission" CausesValidation="true" ValidationGroup="CreateNewSubmissionGroup" OnClick="Button_Create_Submission_Click" runat="server" Text="Create Submission" CssClass="Btn_Command" />


        <%--input fields and labels--%>
        <div class="input_fields">
            <asp:Label ID="SLNO_Label" runat="server" Text="SLNO: " CssClass="label" />
            <asp:TextBox ID="tb_SLNO" ReadOnly="true" Text='' CssClass="textbox" runat="server" />
        </div>

        <asp:ListView ID="DetailsView_Consultant_Name" runat="server" DataSourceID="ConsultantStatsDS">
            <ItemTemplate>
                <div class="input_fields">
                    <asp:Label ID="Label_Consultant" runat="server" Text="Consultant: " CssClass="label" />
                    <asp:TextBox ID="TextBox_Consultant" ReadOnly="true" Text='<%# Eval("LastName") %>' CssClass="textbox" runat="server" />
                </div>
            </ItemTemplate>
        </asp:ListView>

        <div class="input_fields">
            <asp:Label ID="Label_Recruiter" runat="server" Text="Recruiter: " CssClass="label" AssociatedControlID="ComboBox_Recruiter" />
            <ajaxToolkit:ComboBox ID="cb_Recruiter" CausesValidation="true" runat="server" AutoCompleteMode="SuggestAppend" DataSourceID="SqlDataSource_Recruiters" DataTextField="Recruiter Name" DataValueField="Recruiter Name" MaxLength="0" Style="display: inline; position: absolute; bottom: 5px;" Font-Size="18px" Width="200px" Height="20px"></ajaxToolkit:ComboBox>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [Recruiter Name] FROM [ASR-RECRUITERS]"></asp:SqlDataSource>
            <asp:RequiredFieldValidator CssClass="newsubmissionValidators" ControlToValidate="cb_Recruiter" ValidationGroup="CreateNewSubmissionGroup" ID="RequiredFieldValidator6" runat="server" ErrorMessage="Recruiter is required" Text="*" InitialValue=""></asp:RequiredFieldValidator>
        </div>

        <div class="input_fields">
            <asp:Label ID="Label_Client" runat="server" Text="Client: " CssClass="label" />
            <ajaxToolkit:ComboBox ID="cb_Client" runat="server" AutoCompleteMode="SuggestAppend" DataSourceID="ComboBox_Clients_DS" DataTextField="Client Name" DataValueField="Client Name" MaxLength="0" CssClass="combobox_client" Style="display: inline; position: absolute; bottom: 5px;" Font-Size="18px" Width="300px" Height="20px"></ajaxToolkit:ComboBox>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [Client Name] FROM [Clients]"></asp:SqlDataSource>
        </div>

        <div class="input_fields">
            <asp:Label ID="Label_Rate" runat="server" Text="Rate: " CssClass="label" />
            <asp:TextBox ID="tb_Rate" ReadOnly="false" Text='' CssClass="textbox" runat="server" />
            <asp:RequiredFieldValidator CssClass="newsubmissionValidators" ControlToValidate="tb_Rate" ValidationGroup="CreateNewSubmissionGroup" ID="RequiredFieldValidator1" runat="server" ErrorMessage="RequiredFieldValidator" Text="*"></asp:RequiredFieldValidator>
        </div>

        <div class="input_fields">
            <asp:Label ID="Label27" runat="server" Text="Method: " CssClass="label" />
            <asp:TextBox ID="tb_Method" Text='' CssClass="textbox" runat="server" />
        </div>

        <div class="input_fields">
            <asp:Label ID="Label30" runat="server" Text="City: " CssClass="label" />
            <asp:TextBox ID="tb_City" Text='' CssClass="textbox" runat="server" />
            <asp:RequiredFieldValidator CssClass="newsubmissionValidators" ControlToValidate="tb_City" ValidationGroup="CreateNewSubmissionGroup" ID="RequiredFieldValidator2" runat="server" ErrorMessage="RequiredFieldValidator" Text="*"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator SetFocusOnError="true" ValidationExpression="^[a-zA-Z -]+$" CssClass="newsubmissionValidators" ValidationGroup="CreateNewSubmissionGroup" ControlToValidate="tb_City" ToolTip="Invalid City Name" ID="RegularExpressionValidator1" runat="server" ErrorMessage="Only text allowed" Text="Only text allowed"></asp:RegularExpressionValidator>
        </div>

        <div class="input_fields">
            <asp:Label ID="Label31" runat="server" Text="State: " CssClass="label" />
            <ajaxToolkit:ComboBox ID="cb_State" runat="server" AutoCompleteMode="SuggestAppend" DataSourceID="SqlDataSource_States" DataTextField="LCName" DataValueField="Initials" MaxLength="0" CssClass="combobox_state" Style="display: inline; position: absolute; bottom: 5px;" Width="150px" Font-Size="18px" Height="20px"></ajaxToolkit:ComboBox>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT UCName, LCName, Initials FROM [US_States]"></asp:SqlDataSource>
            <%--<asp:TextBox ID="TextBox_State" Text='' CssClass="textbox" runat="server" />--%>
        </div>

        <div class="input_fields">
            <asp:Label ID="Label32" runat="server" Text="Job Title: " CssClass="label" />
            <asp:TextBox ID="tb_Job_Title" Text='' CssClass="textbox" runat="server" />
            <asp:RequiredFieldValidator CssClass="newsubmissionValidators" ControlToValidate="tb_Job_Title" ValidationGroup="CreateNewSubmissionGroup" ID="RequiredFieldValidator3" runat="server" ErrorMessage="RequiredFieldValidator" Text="*"></asp:RequiredFieldValidator>
        </div>

        <div class="input_fields">
            <asp:Label ID="Label33" runat="server" Text="Duration: " CssClass="label" />
            <asp:TextBox ID="tb_Duration" Text='' CssClass="textbox" runat="server" />
            <asp:RequiredFieldValidator CssClass="newsubmissionValidators" ControlToValidate="tb_Duration" ValidationGroup="CreateNewSubmissionGroup" ID="RequiredFieldValidator4" runat="server" ErrorMessage="RequiredFieldValidator" Text="*"></asp:RequiredFieldValidator>
        </div>

        <div class="input_fields">
            <asp:Label ID="Label35" runat="server" Text="Vendor: " CssClass="label" />
            <ajaxToolkit:ComboBox ID="cb_Vendor" runat="server" AutoCompleteMode="SuggestAppend" DataSourceID="SqlDataSource_Vendors" DataTextField="Vendor Company Name" DataValueField="Vendor Company Name" MaxLength="0" CssClass="combobox_vendor" Style="display: inline; position: absolute; bottom: 5px;" Width="250px" Font-Size="18px" Height="20px"></ajaxToolkit:ComboBox>
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [Vendor Company Name] FROM [Vendors]"></asp:SqlDataSource>
            <%--<asp:TextBox ID="TextBox7" Text='' CssClass="textbox" runat="server" />--%>
        </div>

        <div class="input_fields">
            <asp:Label ID="Label37" runat="server" Text="Vendor Contact: " CssClass="label" />
            <ajaxToolkit:ComboBox ID="cb_Vendor_Contact" runat="server" AutoCompleteMode="SuggestAppend" DataSourceID="SqlDataSource_Vendor_Contact" DataTextField="Recruiter Name" DataValueField="Recruiter Name" MaxLength="0" CssClass="combobox_vendor_contact" Style="display: inline; position: absolute; bottom: 5px;" Width="200px" Font-Size="18px" Height="20px"></ajaxToolkit:ComboBox>
            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [Recruiter Name] FROM [Vendor Contact]"></asp:SqlDataSource>
            <%--<asp:TextBox ID="TextBox_Vendor_Contact" Text='' CssClass="textbox" runat="server" />--%>
        </div>

        <div class="input_fields">
            <asp:Label ID="Label39" runat="server" Text="Client Submission: " CssClass="label" />
            <asp:TextBox ID="tb_Client_Submission" Text='' CssClass="textbox" runat="server" />
        </div>

        <div class="input_fields">
            <asp:Label ID="Label41" runat="server" Text="Remarks: " CssClass="label" />
            <asp:TextBox ID="tb_Remarks" Text='' CssClass="textbox" runat="server" />
        </div>

        <div class="input_fields">
            <asp:Label ID="Label43" runat="server" Text="Submission Status: " CssClass="label" />
            <ajaxToolkit:ComboBox ID="cb_Submission_Status" runat="server" AutoCompleteMode="SuggestAppend" DataSourceID="SqlDataSource_Submission_Status" DataTextField="Status Option" DataValueField="Status Option" MaxLength="0" CssClass="combobox_submission_status" Style="display: inline; position: absolute; bottom: 5px;" Width="300px" Font-Size="18px" Height="20px"></ajaxToolkit:ComboBox>
            <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [Status Option] FROM [Submission Status Options]"></asp:SqlDataSource>
        </div>

        <div class="input_fields">
            <asp:Label ID="Label34" runat="server" Text="Date: " CssClass="label" />
            <asp:TextBox ID="tb_Date" Text='' CssClass="textbox" runat="server" />
            <asp:RequiredFieldValidator CssClass="newsubmissionValidators" ControlToValidate="tb_Date" ValidationGroup="CreateNewSubmissionGroup" ID="RequiredFieldValidator5" runat="server" ErrorMessage="RequiredFieldValidator" Text="*"></asp:RequiredFieldValidator>
            <ajaxToolkit:CalendarExtender runat="server" TargetControlID="tb_Date" PopupPosition="TopRight" ID="TextBox_Date_CalendarExtender"></ajaxToolkit:CalendarExtender>
        </div>

        <%--<asp:CustomValidator ID="CustomValidator1" ControlToValidate="TextBox_Remarks" ValidateEmptyText="true" runat="server" ErrorMessage="Invalid Information" ValidationGroup="CreateNewSubmissionGroup" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>--%>

    </asp:Panel>



    <asp:Button ID="Button_dummy_for_popup" runat="server" Style="display: none" />
    <asp:Panel ID="Panel_Msg_Popup" runat="server" Style="width: 350px; height: 250px; background-color: lightblue; text-align: center; border: 3px solid black; border-radius: 5px;">
        <asp:Panel runat="server" Style="width: 80%; margin: auto; padding-top: 20px;">
            <asp:Label ID="Popup_Message_Label" runat="server" Style="font-size: 18px; white-space: normal;">Error Occured</asp:Label>
        </asp:Panel>
        <asp:Button ID="Button_OK" runat="server" Text="OK" Style="font-size: 16px; position: absolute; bottom: 10px; left: 40%; width: 20%; cursor: pointer;" />
        <%--<asp:Panel ID="dragHandle" runat="server" Style="position:absolute; top: 5px; left:5px; width: 10px; height: 10px; background-color:gray;"></asp:Panel>--%>
    </asp:Panel>

    <ajaxToolkit:ModalPopupExtender runat="server"
        ID="Panel_Msg_Popup_ModalPopupExtender"
        BehaviorID="Panel_Msg_Popup_ModalPopupExtender"
        PopupControlID="Panel_Msg_Popup"
        TargetControlID="Button_dummy_for_popup"
        BackgroundCssClass="modalBackground"
        DropShadow="true"
        CancelControlID="Button_OK">
    </ajaxToolkit:ModalPopupExtender>

</asp:Content>

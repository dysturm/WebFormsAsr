<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="ASR_Management_System.Pages.WebForm1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <%-- test btn throws error --%>
    <%--<asp:Button ID="Button2" runat="server" Style="font-size: 30px; position: absolute; right: 20px; top: 20px; z-index: 10;" Text="Throw Error" OnClick="Button2_OnClick"/>--%>

    <%--hidden field to hold consultant id (retreived after postback to pg Consultants.aspx)--%>
    <asp:HiddenField ID="HomePage_HiddenField_ConsultantID" runat="server" value="0"/>

    <%--label for test purposes only--%>
    <asp:Label ID="DisplayLabel" runat="server" Text="" CssClass="displayLabel"></asp:Label>


    <%--update panel for consultant + recruiter panels (to prevent unecessary postback of entire pg)--%>
    <asp:UpdatePanel ID="UpdatePanel_Consultants_Recruiters" runat="server">

        <ContentTemplate>

            <%--div for panel toggle buttons--%>
            <div id="topBtns_Container">
                <div id="button_div">
                    <asp:Button ID="ConsultantPanel_BtnCollapse" runat="server" Text="Consultants" CssClass="Btn_Style Btn_Style_Consultant" />
                    <asp:Button ID="RecruiterPanel_BtnCollapse" runat="server" Text="Recruiters" CssClass="Btn_Style Btn_Style_Recruiter" />
                </div>
            </div>


            <%--div to hold consultant + recrutier panels--%>
            <div id="collapsiblePanel_container">

                <%--    -------------  consultant dropdown panel   ---------------   --%>

                <asp:Panel ID="ConsultantPanel" runat="server" CssClass="CollapsiblePanelCss">


                    <%--repeater to create button for each consultant--%>
                    <asp:Repeater ID="Repeater_ConsultantNameBtns" runat="server" DataSourceID="SqlDataSource_Consultants" OnItemCommand="Repeater_ConsultantNameBtns_ItemCommand">

                        <ItemTemplate>
                            <asp:Button ID="Button1" runat="server"
                                CssClass="Btn_ConsultantName"
                                Text='<%# Eval("Consultant_Name") %>' 
                                CommandArgument='<%# Eval("ID") %>'  />
                            <br />
                        </ItemTemplate>

                    </asp:Repeater>

                </asp:Panel>


                <%--enables collapse functionality for consultant panel--%>
                <ajaxToolkit:CollapsiblePanelExtender ID="ConsultantPanel_CollapsiblePanelExtender" runat="server"
                    BehaviorID="ConsultantPanel_CollapsiblePanelExtender"
                    TargetControlID="ConsultantPanel"
                    CollapseControlID="RecruiterPanel_BtnCollapse"
                    ExpandControlID="ConsultantPanel_BtnCollapse"
                    Collapsed="true" />



                <asp:SqlDataSource ID="SqlDataSource_Consultants" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [ID], IIF(ISNULL([FirstName]), [LastName], ([FirstName]+' '+[LastName])) AS Consultant_Name, [Status] FROM [Consultants]"></asp:SqlDataSource>




                <%--     -----------  recruiter dropdown panel    ------------   --%>


                <asp:Panel ID="Panel_Recruiters" runat="server" CssClass="CollapsiblePanelCss">


                    <%--repeater to create button for each recruiter--%>
                    <asp:Repeater ID="Repeater_Recruiters" runat="server" DataSourceID="SqlDataSource_Recruiters">

                        <ItemTemplate>
                            <asp:Button ID="Button1" runat="server"
                                CssClass="Btn_RecruiterName"
                                Text='<%# Eval("Recruiter_Name") %>' />
                            <br />
                        </ItemTemplate>

                    </asp:Repeater>

                </asp:Panel>

                <%--enables collapse functionality for recruiter panel--%>
                <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server"
                    BehaviorID="Panel_Recruiters_CollapsiblePanelExtender"
                    TargetControlID="Panel_Recruiters"
                    CollapseControlID="ConsultantPanel_BtnCollapse"
                    ExpandControlID="RecruiterPanel_BtnCollapse"
                    Collapsed="true" />

                <asp:SqlDataSource ID="SqlDataSource_Recruiters" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [ID], [Recruiter Name] AS Recruiter_Name FROM [ASR-RECRUITERS]"></asp:SqlDataSource>


            <%--end div for consulant+recruiter panels--%>
            </div>

        <%--end update panel for consultant+recuiter panels--%>
        </ContentTemplate>

    </asp:UpdatePanel>

</asp:Content>

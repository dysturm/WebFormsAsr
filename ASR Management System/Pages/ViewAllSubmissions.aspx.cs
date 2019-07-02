using AjaxControlToolkit;
using ASR_Management_System.App_Code;
using ASR_Management_System.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASR_Management_System.Pages
{
    public partial class ViewAllSubmissions : System.Web.UI.Page
    {
        //use to trigger pg refresh when user saves changes for submission/interview
        private static bool changesMade = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            //get consultant id from url
            using (ModelContext db = new ModelContext())
            {
                int id;
                if (int.TryParse(Request.QueryString["Id"], out id))
                {
                    if (db.Consultants.FirstOrDefault(c => c.Id == id) != null)
                        ConsultantId.Value = id.ToString();
                }
                else
                {
                    ConsultantId.Value = db.Consultants.First().Id.ToString();
                }
            }
            if (Request.QueryString["Target"] != null)
            {
                int submissionSlno;
                if (Request.QueryString["Target"].Equals("ErrorMessage") && Session["ErrorMessage"] != null)
                {
                    Popup_Message_Label.Text = Session["ErrorMessage"].ToString();
                    Session["ErrorMessage"] = null;
                    Panel_Msg_Popup_ModalPopupExtender.Show();
                }
                else if (Request.QueryString["Target"].Equals("AddInterview") && int.TryParse(Request.QueryString["Sub"], out submissionSlno) && Session["InterviewTarget"] != null)
                {
                    Session["InterviewTarget"] = null;
                    try
                    {
                        ComboBox_Intvw_Type.DataBind();
                        ComboBox_Intvw_Method.DataBind();
                        ComboBox_Intvw_Status.DataBind();
                        //ClearFieldValues(Panel_View_Interview);
                        SetInterviewPanelTitle(submissionSlno);
                        EnableInterviewFieldEdit(true);
                        Button_Add_Interview.Visible = true;
                        Button_Update_Interview.Visible = Button_Cancel_Interview_Update.Visible = Button_Edit_Interview.Visible = Button_Delete_Interview.Visible = false;
                        ModalPopupExtender_View_Interview.Show();
                    }
                    catch (Exception ex) { handleException(ex, sender.ToString()); }
                }
                else if (Request.QueryString["Target"].Equals("ShowSubmission") && int.TryParse(Request.QueryString["Slno"], out submissionSlno))
                {
                    LoggingUtility.LogMessage($"showsubmission in pg load called");
                    ShowSubmission(submissionSlno);
                }  
            }

            //add null values to combos
            //ComboBox_Intvw_Type.Items.Insert(0, new ListItem("", ""));
            //ComboBox_Intvw_Method.Items.Insert(0, new ListItem("", ""));
            //ComboBox_Intvw_Status.Items.Insert(0, new ListItem("", ""));
        }

        protected void Backbtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Consultants.aspx?" +
                "Id=" + ConsultantId.Value);
        }

        protected void All_Submissions_Repeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                //check btn cmnd
                if (e.CommandName.Equals("ShowSubmission"))
                {
                    int slno = int.Parse(e.CommandArgument.ToString());
                    ShowSubmission(slno);
                }
                else if (e.CommandName.Equals("AddInterview"))
                {
                    int slno = int.Parse(e.CommandArgument.ToString());
                    Session["InterviewTarget"] = slno;
                    Response.Redirect("~/Pages/ViewAllSubmissions.aspx?Id=" + ConsultantId.Value + "&Target=AddInterview&Sub=" + slno, false);
                }
            }
            catch (Exception ex) { handleException(ex, source); }
        }

        private void ShowSubmission(int slno)
        {
            setSubmissionFieldValues(slno);
            Button_Edit_Submission.Visible = true;
            Button_Cancel_Edit.Visible = false;
            Button_Save_Changes.Visible = false;
            EnableSubmissionFieldEdit(false);
            ModalPopupExtender_View_Submissions.Show();
        }

        protected void Button_Edit_Submission_Click(object sender, EventArgs e)
        {
            Button_Edit_Submission.Visible = false;
            Button_Cancel_Edit.Visible = true;
            Button_Save_Changes.Visible = true;
            EnableSubmissionFieldEdit(true);
            ModalPopupExtender_View_Submissions.Show();
        }

        protected void Button_Cancel_Edit_Click(object sender, EventArgs e)
        {
            Button_Edit_Submission.Visible = true;
            Button_Cancel_Edit.Visible = false;
            Button_Save_Changes.Visible = false;
            EnableSubmissionFieldEdit(false);
            try { setSubmissionFieldValues(int.Parse(TextBox_SLNO.Text)); }
            catch (Exception ex) { handleException(ex, sender); }
            ModalPopupExtender_View_Submissions.Show();
        }

        protected void Button_Save_Changes_Click(object sender, EventArgs e)
        {
            try
            {
                updateSubmission(int.Parse(TextBox_SLNO.Text));
                Button_Edit_Submission.Visible = true;
                Button_Cancel_Edit.Visible = false;
                Button_Save_Changes.Visible = false;
                EnableSubmissionFieldEdit(false);
                setSubmissionFieldValues(int.Parse(TextBox_SLNO.Text));
                changesMade = true;
                ModalPopupExtender_View_Submissions.Show();
            }
            catch (Exception ex)
            {
                handleException(ex, sender);
            }
        }

        private void setSubmissionFieldValues(int slnoNum)
        {
            using (ModelContext db = new ModelContext())
            {
                var submissionDb = db.Submissions.FirstOrDefault(c => c.Slno == slnoNum);

                if (submissionDb == null)
                {
                    throw new ArgumentException(String.Format("Submission for SLNO #{0} cannot be found", slnoNum));
                }

                //set fields (if null set to "")
                TextBox_SLNO.Text = submissionDb.Slno.ToString();
                TextBox_LName.Text = db.Consultants.FirstOrDefault(c => c.Id == submissionDb.ConsultantId).LastName.ToString();
                try { TextBox_Recruiter.Text = db.AsrRecruiters.FirstOrDefault(c => c.Id == submissionDb.AsrRecruiterId).RecruiterName.ToString(); }
                catch { TextBox_Recruiter.Text = ""; }
                try { TextBox_Client.Text = db.Clients.FirstOrDefault(c => c.Id == submissionDb.ClientId).ClientName.ToString(); }
                catch { TextBox_Client.Text = ""; }
                TextBox_Rate.Text = submissionDb.RatePerHour != null ? submissionDb.RatePerHour.ToString() : "";
                TextBox_Method.Text = submissionDb.Method != null ? submissionDb.Method.ToString() : "";
                TextBox_City.Text = submissionDb.City != null ? submissionDb.City.ToString() : "";
                TextBox_State.Text = submissionDb.State != null ? submissionDb.State.ToString() : "";
                TextBox_JobTitle.Text = submissionDb.JobTitle != null ? submissionDb.JobTitle.ToString() : "";
                TextBox_Duration.Text = submissionDb.Duration != null ? submissionDb.Duration.ToString() : "";
                try { TextBox_Vendor.Text = db.Vendors.FirstOrDefault(c => c.Id == submissionDb.VendorId).VendorCompanyName.ToString(); }
                catch { TextBox_Vendor.Text = ""; }
                try { TextBox_VendorContact.Text = db.VendorContact.FirstOrDefault(c => c.Id == submissionDb.VendorContactId).RecruiterName.ToString(); }
                catch { TextBox_VendorContact.Text = ""; }
                TextBox_ClientSubmission.Text = submissionDb.ClientSubmission != null ? submissionDb.ClientSubmission.ToString() : "";
                TextBox_Remarks.Text = submissionDb.Remarks != null ? submissionDb.Remarks.ToString() : "";
                TextBox_SubmissionStatus.Text = submissionDb.SubmissionStatus != null ? submissionDb.SubmissionStatus.ToString() : "";

                try
                {
                    DateTime date = DateTime.Parse(submissionDb.Date.ToString());
                    Edit_TextBox_Date.Text = date.ToShortDateString();
                }
                catch (Exception ex)
                {
                    LoggingUtility.LogException(ex, "setFieldVals for slno #" + slnoNum + " in ViewAllSubmissions.aspx");
                    Edit_TextBox_Date.Text = "";
                }


                CheckBox_Active.Checked = (bool)submissionDb.Active;
            }
        }

        private void EnableSubmissionFieldEdit(bool setEnabled)
        {
            //set textbox's readonly property, or switch from txtbox to combobox 
            TextBox_Recruiter.Visible = TextBox_Client.Visible = TextBox_State.Visible = TextBox_Vendor.Visible = TextBox_VendorContact.Visible = TextBox_SubmissionStatus.Visible = !setEnabled;
            ComboBox_Recruiter.Visible = ComboBox_Client.Visible = ComboBox_State.Visible = ComboBox_Vendor.Visible = ComboBox_VendorContact.Visible = ComboBox_SubmissionStatus.Visible = setEnabled;

            TextBox_Rate.ReadOnly = TextBox_Method.ReadOnly = TextBox_City.ReadOnly = TextBox_JobTitle.ReadOnly = TextBox_Duration.ReadOnly = TextBox_ClientSubmission.ReadOnly = TextBox_Remarks.ReadOnly = Edit_TextBox_Date.ReadOnly = !setEnabled;
            CalendarExtender1.Enabled = CheckBox_Active.Enabled = setEnabled;

            //when switching to edit mode, set text of comboboxes from txtboxes
            if (setEnabled)
            {
                ComboBox_Recruiter.Text = TextBox_Recruiter.Text;
                ComboBox_Client.Text = TextBox_Client.Text;
                ComboBox_State.SelectedValue = TextBox_State.Text;
                ComboBox_Vendor.Text = TextBox_Vendor.Text;
                ComboBox_VendorContact.Text = TextBox_VendorContact.Text;
                ComboBox_SubmissionStatus.Text = TextBox_SubmissionStatus.Text;
            }
        }


        private void updateSubmission(int slnoNum)
        {
            using (ModelContext db = new ModelContext())
            {
                var submissionDb = db.Submissions.FirstOrDefault(c => c.Slno == slnoNum);

                if (submissionDb == null)
                {
                    throw new ArgumentException(String.Format("Submission for SLNO #{0} cannot be found", slnoNum));
                }

                //get fields

                string recruiter, client, rateString, method, city, state, jobTitle, duration, vendor, vendorContact, clientSubmission, remarks, status, dateString;

                bool active;

                recruiter = ComboBox_Recruiter.Text;
                client = ComboBox_Client.Text;
                rateString = TextBox_Rate.Text;
                method = TextBox_Method.Text;
                city = TextBox_City.Text;
                state = ComboBox_State.Text;
                jobTitle = TextBox_JobTitle.Text;
                duration = TextBox_Duration.Text;
                vendor = ComboBox_Vendor.Text;
                vendorContact = ComboBox_VendorContact.Text;
                clientSubmission = TextBox_ClientSubmission.Text;
                remarks = TextBox_Remarks.Text;
                status = ComboBox_SubmissionStatus.Text;
                dateString = Edit_TextBox_Date.Text;
                active = CheckBox_Active.Checked;

                //check fields
                FieldValidator.checkFields(recruiter, client, rateString, method, city, state, jobTitle, duration, vendor, vendorContact, clientSubmission, remarks, status, dateString);

                int rate = Int32.Parse(rateString);
                DateTime date = DateTime.Parse(dateString);


                //process submission changes

                //check if recruiter was changed, and then if recruiter doesn't exist, throw exception
                if (submissionDb.AsrRecruiterId == null || !db.AsrRecruiters.FirstOrDefault(c => c.Id == submissionDb.AsrRecruiterId).RecruiterName.Equals(recruiter))
                {
                    var recruiterDb = db.AsrRecruiters.FirstOrDefault(c => c.RecruiterName.Equals(recruiter));
                    if (recruiterDb == null)
                    {
                        throw new ArgumentException(String.Format("Recruiter Name '{0}' does not exist in database. Go to 'Add New Recruiter'", recruiter));
                    }
                    else
                    {
                        submissionDb.AsrRecruiterId = recruiterDb.Id;
                    }
                }

                //if client/vendor/vendorContact changed, and doesn't exist, first add to db
                if (submissionDb.ClientId == null || !db.Clients.FirstOrDefault(c => c.Id == submissionDb.ClientId).ClientName.Equals(client))
                {
                    var clientDb = db.Clients.FirstOrDefault(c => c.ClientName.Equals(client));
                    if (clientDb == null)
                    {
                        clientDb = new Models.Clients { ClientName = client };
                        db.Clients.Add(clientDb);
                        db.SaveChanges();
                        LoggingUtility.appendToLog(String.Format("new client added '{0}'", client));
                    }
                    submissionDb.ClientId = clientDb.Id;
                }

                if (submissionDb.VendorId == null || !db.Vendors.FirstOrDefault(c => c.Id == submissionDb.VendorId).VendorCompanyName.Equals(vendor))
                {
                    var vendorDb = db.Vendors.FirstOrDefault(c => c.VendorCompanyName.Equals(vendor));
                    if (vendorDb == null)
                    {
                        vendorDb = new Models.Vendors { VendorCompanyName = vendor };
                        db.Vendors.Add(vendorDb);
                        db.SaveChanges();
                        LoggingUtility.appendToLog(String.Format("new vendor added '{0}'", vendor));
                    }
                    submissionDb.VendorId = vendorDb.Id;
                }

                if (submissionDb.VendorContactId == null || !db.VendorContact.FirstOrDefault(c => c.Id == submissionDb.VendorContactId).RecruiterName.Equals(vendorContact))
                {
                    var vendorContactDb = db.VendorContact.FirstOrDefault(c => c.RecruiterName.Equals(vendorContact));
                    if (vendorContactDb == null)
                    {
                        vendorContactDb = new Models.VendorContact { RecruiterName = vendorContact };
                        db.VendorContact.Add(vendorContactDb);
                        db.SaveChanges();
                        LoggingUtility.appendToLog($"new vendor contact added '{vendorContact}'");
                    }
                    submissionDb.VendorContactId = vendorContactDb.Id;
                }

                var stateDb = db.UsStates.FirstOrDefault(c => c.Initials.Equals(state) || c.Ucname.Equals(state) || c.Lcname.Equals(state));
                submissionDb.State = stateDb.Initials;

                submissionDb.RatePerHour = rate;
                submissionDb.Method = method;
                submissionDb.City = city;
                submissionDb.JobTitle = jobTitle;
                submissionDb.Duration = duration;
                submissionDb.ClientSubmission = clientSubmission;
                submissionDb.Remarks = remarks;
                submissionDb.SubmissionStatus = status;
                submissionDb.Date = date;
                submissionDb.Active = active;

                db.SaveChanges();

                LoggingUtility.writeMessage();
            }
        }


        private void ClearFieldValues(Panel panel)
        {
            //popupMenu_View_Submission
            foreach (Control c in panel.Controls)
            {
                if (c is TextBox)
                {
                    ((TextBox)c).Text = "";
                }
                else if (c is ComboBox)
                {
                    ((ComboBox)c).Text = "";
                }
            }
        }

        private void handleException(Exception ex, object sender)
        {
            LoggingUtility.LogException(ex, sender.ToString());
            Session["ErrorMessage"] = ex.Message;
            Response.Redirect($"~/Pages/ViewAllSubmissions.aspx?Id={ConsultantId.Value}&Target=ErrorMessage");
        }


        protected void Repeater_Submission_Interviews_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                //check btn cmnd
                if (e.CommandName.Equals("ShowInterview"))
                {
                    int interviewID = int.Parse(e.CommandArgument.ToString());
                    SetInterviewFieldValues(interviewID);
                    EnableInterviewFieldEdit(false);
                    Button_Edit_Interview.Visible = Button_Delete_Interview.Visible = true;
                    Button_Update_Interview.Visible = Button_Cancel_Interview_Update.Visible = Button_Add_Interview.Visible = false;
                    ModalPopupExtender_View_Interview.Show();
                }
            }
            catch (Exception ex) { handleException(ex, source); }
        }

        protected void Button_Edit_Interview_Click(object sender, EventArgs e)
        {
            try
            {
                Button_Edit_Interview.Visible = false;
                Button_Update_Interview.Visible = Button_Cancel_Interview_Update.Visible = true;
                EnableInterviewFieldEdit(true);
                ModalPopupExtender_View_Interview.Show();
            }
            catch (Exception ex) { handleException(ex, sender.ToString()); }
        }

        protected void Button_Update_Interview_Click(object sender, EventArgs e)
        {
            try
            {
                UpdateInterview();
                Button_Edit_Interview.Visible = true;
                Button_Update_Interview.Visible = Button_Cancel_Interview_Update.Visible = false;
                EnableInterviewFieldEdit(false);
                SetInterviewFieldValues(int.Parse(TextBox_Intvw_ID.Text));
                changesMade = true;
                ModalPopupExtender_View_Interview.Show();
            }
            catch (Exception ex) { handleException(ex, sender.ToString()); }
        }

        protected void Button_Cancel_Interview_Update_Click(object sender, EventArgs e)
        {
            Button_Edit_Interview.Visible = true;
            Button_Update_Interview.Visible = Button_Cancel_Interview_Update.Visible = false;
            EnableInterviewFieldEdit(false);
            SetInterviewFieldValues(int.Parse(TextBox_Intvw_ID.Text));
            ModalPopupExtender_View_Interview.Show();
        }

        private void SetInterviewPanelTitle(int slno)
        {
            using (ModelContext db = new ModelContext())
            {
                var submissionDb = db.Submissions.FirstOrDefault(c => c.Slno == slno);
                if (submissionDb == null)
                    throw new ArgumentException($"No submission found for slno #{slno}");
                string clientName = db.Clients.FirstOrDefault(c => c.Id == submissionDb.ClientId).ClientName;
                Label_Intvw_Title.Text = $"Add New Interview for Submission #{submissionDb.Slno} to {clientName}";
                TextBox_Intvw_ID.Text = (db.Interviews.Max(c => c.Id) + 1).ToString();
                TextBox_Intvw_Constultant.Text = db.Consultants.FirstOrDefault(c => c.Id == submissionDb.ConsultantId).LastName;
            }
            HiddenField_Submission_SLNO.Value = slno.ToString();
        }

        private void EnableInterviewFieldEdit(bool setEnabled)
        {
            TextBox_Intvw_Type.Visible = TextBox_Intvw_Method.Visible = TextBox_Intvw_Status.Visible = !setEnabled;
            ComboBox_Intvw_Type.Visible = ComboBox_Intvw_Method.Visible = ComboBox_Intvw_Status.Visible = setEnabled;

            TextBox_Intvw_Interviewer.ReadOnly = TextBox_Intvw_Date.ReadOnly = TextBox_Intvw_SkillsRequired.ReadOnly = TextBox_Intvw_Feedback.ReadOnly = TextBox_Intvw_Remarks.ReadOnly = !setEnabled;
            CalendarExtender_Intvw_Date.Enabled = setEnabled;

            if (setEnabled)
            {
                LoggingUtility.appendToLog("Num items = " + ComboBox_Intvw_Type.Items.Count.ToString());
                foreach (ListItem listItem in ComboBox_Intvw_Type.Items)
                {
                    LoggingUtility.appendToLog($"text = '{listItem.Text}' value = '{listItem.Value}'");
                }
                //LoggingUtility.appendToLog(ComboBox_Intvw_Type.Items.FindByText("Initial").ToString());
                LoggingUtility.writeMessage();
                try
                {
                    ComboBox_Intvw_Type.Text = TextBox_Intvw_Type.Text;
                    ComboBox_Intvw_Method.Text = TextBox_Intvw_Method.Text;
                    ComboBox_Intvw_Status.Text = TextBox_Intvw_Status.Text;
                }
                catch (Exception ex) { LoggingUtility.LogException(ex, "EnableInterviewFieldEdit"); }


            }
        }

        private void SetInterviewFieldValues(int interviewID)
        {
            using (ModelContext db = new ModelContext())
            {
                var interviewDb = db.Interviews.FirstOrDefault(c => c.Id == interviewID);

                if (interviewDb == null)
                {
                    throw new ArgumentException($"No interview found with id #{interviewID}");
                }

                string clientName = db.Clients.FirstOrDefault(c => c.Id == db.Submissions.FirstOrDefault(e => e.Slno == interviewDb.SubmissionSlno).ClientId).ClientName;
                Label_Intvw_Title.Text = $"Interview for Submission #{interviewDb.SubmissionSlno} to {clientName}";

                TextBox_Intvw_ID.Text = interviewDb.Id.ToString();
                TextBox_Intvw_Constultant.Text = db.Consultants.FirstOrDefault(c => c.Id == interviewDb.ConsultantId).LastName;
                TextBox_Intvw_Type.Text = interviewDb.Type ?? "";
                TextBox_Intvw_Method.Text = interviewDb.Method ?? "";
                TextBox_Intvw_Interviewer.Text = interviewDb.Interviewer ?? "";
                if (interviewDb.DateScheduled != null)
                    TextBox_Intvw_Date.Text = DateTime.Parse(interviewDb.DateScheduled.ToString()).ToShortDateString();
                TextBox_Intvw_SkillsRequired.Text = interviewDb.SkillsRequired ?? "";
                TextBox_Intvw_Status.Text = interviewDb.Status ?? "";
                TextBox_Intvw_Feedback.Text = interviewDb.Feedback ?? "";
                TextBox_Intvw_Remarks.Text = interviewDb.Remarks ?? "";
            }
        }

        private void UpdateInterview()
        {
            using (ModelContext db = new ModelContext())
            {
                int interviewId;
                if (!Int32.TryParse(TextBox_Intvw_ID.Text, out interviewId))
                    throw new ArgumentException($"Value '{TextBox_Intvw_ID.Text}' in Interview ID TextBox could not be parsed.");

                var interviewDb = db.Interviews.FirstOrDefault(c => c.Id == interviewId);
                if (interviewDb == null)
                    throw new ArgumentException($"No Interview found with ID #{interviewId}.");

                Dictionary<string, string> newInterviewFields = LoadInterviewFieldValues();
                FieldValidator.CheckInterviewFields(newInterviewFields);

                interviewDb.Type = newInterviewFields["Type"];
                interviewDb.Method = newInterviewFields["Method"];
                interviewDb.Interviewer = newInterviewFields["Interviewer"];
                interviewDb.DateScheduled = DateTime.Parse(newInterviewFields["Date"]);
                interviewDb.SkillsRequired = newInterviewFields["Skills"];
                interviewDb.Status = newInterviewFields["Status"];
                interviewDb.Feedback = newInterviewFields["Feedback"];
                interviewDb.Remarks = newInterviewFields["Remarks"];

                db.SaveChanges();
                LoggingUtility.LogMessage($"Interview #{interviewDb.Id} successfully updated.");
            }
        }

        private Dictionary<string, string> LoadInterviewFieldValues()
        {
            Dictionary<string, string> interviewValues = new Dictionary<string, string>();
            interviewValues.Add("ID", TextBox_Intvw_ID.Text);
            interviewValues.Add("Type", ComboBox_Intvw_Type.Text);
            interviewValues.Add("Method", ComboBox_Intvw_Method.Text);
            interviewValues.Add("Interviewer", TextBox_Intvw_Interviewer.Text);
            interviewValues.Add("Skills", TextBox_Intvw_SkillsRequired.Text);
            interviewValues.Add("Status", ComboBox_Intvw_Status.Text);
            interviewValues.Add("Feedback", TextBox_Intvw_Feedback.Text);
            interviewValues.Add("Remarks", TextBox_Intvw_Remarks.Text);
            interviewValues.Add("Date", TextBox_Intvw_Date.Text);

            return interviewValues;
        }

        protected void Button_Add_Interview_Click(object sender, EventArgs e)
        {
            try
            {
                using (ModelContext db = new ModelContext())
                {
                    int submissionSlno, consultantID;
                    DateTime date;

                    submissionSlno = Convert.ToInt32(HiddenField_Submission_SLNO.Value);
                    consultantID = db.Consultants.FirstOrDefault(c => c.LastName.Equals(TextBox_Intvw_Constultant.Text)).Id;


                    Dictionary<string, string> interviewValues = LoadInterviewFieldValues();

                    FieldValidator.CheckInterviewFields(interviewValues);

                    date = DateTime.Parse(interviewValues["Date"]);
                    var newInterview = new Models.Interviews
                    {
                        SubmissionSlno = submissionSlno,
                        ConsultantId = consultantID,
                        Type = interviewValues["Type"],
                        Method = interviewValues["Method"],
                        Interviewer = interviewValues["Interviewer"],
                        SkillsRequired = interviewValues["Skills"],
                        Status = interviewValues["Status"],
                        Feedback = interviewValues["Feedback"],
                        Remarks = interviewValues["Remarks"],
                        DateScheduled = date
                    };
                    db.Interviews.Add(newInterview);
                    db.SaveChanges();
                    LoggingUtility.LogMessage($"New Interview #{newInterview.Id} successfully added.");
                }
            }
            catch (Exception ex) { handleException(ex, sender.ToString()); }
            Response.Redirect($"~/Pages/ViewAllSubmissions.aspx?Id={ConsultantId.Value}");
        }

        //submission cancel
        protected void Cancel_Btn_Click(object sender, EventArgs e)
        {
            if (changesMade)
            {
                changesMade = false;
                Response.Redirect($"~/Pages/ViewAllSubmissions.aspx?Id={ConsultantId.Value}");
            }
            else
            {
                ModalPopupExtender_View_Submissions.Hide();
            }
        }
        //intvw cancel
        protected void Button_popup_Cancel_Click(object sender, EventArgs e)
        {
            if (changesMade)
            {
                changesMade = false;
                Response.Redirect($"~/Pages/ViewAllSubmissions.aspx?Id={ConsultantId.Value}");
            }
            else
            {
                ModalPopupExtender_View_Interview.Hide();
            }
        }

        protected void btnMakeNewSubmission_OnClick(object sender, EventArgs e)
        {
            try
            {
                Button_Edit_Submission.Visible = Button_Cancel_Edit.Visible = Button_Save_Changes.Visible = false;
                Button_Create_New_Submission.Visible = true;
                ClearFieldValues(popupMenu_View_Submission);
                EnableSubmissionFieldEdit(true);
                ModalPopupExtender_View_Submissions.Show();
            } catch (Exception ex) { handleException(ex, sender.ToString()); }
        }

        protected void Button_Create_New_Submission_OnClick(object sender, EventArgs e)
        {
            try
            {
                Dictionary<string, string> values = GetSubmissionFieldValues();

                using (ModelContext db = new ModelContext())
                {
                    var newSubmissionDb = new Submissions {  };

                    db.Submissions.Add(newSubmissionDb);
                    db.SaveChanges();
                }

            } catch (Exception ex) { handleException(ex, sender.ToString()); }
        }

        private Dictionary<string, string> GetSubmissionFieldValues()
        {
            Dictionary<string, string> values = new Dictionary<string, string>();
            
            values["recruiter"] = ComboBox_Recruiter.Text;
            values["client"] = ComboBox_Client.Text;
            values["rateString"] = TextBox_Rate.Text;
            values["method"] = TextBox_Method.Text;
            values["city"] = TextBox_City.Text;
            values["state"] = ComboBox_State.Text;
            values["jobTitle"] = TextBox_JobTitle.Text;
            values["duration"] = TextBox_Duration.Text;
            values["vendor"] = ComboBox_Vendor.Text;
            values["vendorContact"] = ComboBox_VendorContact.Text;
            values["clientSubmission"] = TextBox_ClientSubmission.Text;
            values["remarks"] = TextBox_Remarks.Text;
            values["status"] = ComboBox_SubmissionStatus.Text;
            values["dateString"] = Edit_TextBox_Date.Text;
            values["active"] = CheckBox_Active.Checked.ToString(); //bool val


            return values;
        }


        //*******************************************************************************************
        //adding new submission
        protected void Button_Create_Submission_Click(object sender, EventArgs e)
        {
            try
            {
                ContentPlaceHolder placeholder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");

                //ListView notes = (ListView)placeholder.FindControl("ListView_Consultant_Status");


                //string statusMessage = "message not changed";
                string recruiter, client,
                    method, city, state, jobTitle, duration,
                    vendor, vendorContact,
                    clientSubmission, remarks,
                    submissionStatus;

                DateTime date;
                Decimal rate;
                bool active;

                int sLNO, consultantId, recruiterID = 0, clientID, vendorID, vendorContactID;

                //get values entered by user
                using (var db = new ModelContext())
                {
                    sLNO = db.Submissions.Max(c => c.Slno) + 1;
                }
                consultantId = Int32.Parse(ConsultantId.Value);
                recruiter = cb_Recruiter.Text;
                client = cb_Client.Text;
                rate = Decimal.Parse(tb_Rate.Text);
                method = tb_Method.Text;
                city = tb_City.Text;
                state = cb_State.SelectedValue;
                jobTitle = tb_Job_Title.Text;
                duration = tb_Duration.Text;
                vendor = cb_Vendor.Text;
                vendorContact = cb_Vendor_Contact.Text;
                clientSubmission = tb_Client_Submission.Text;
                remarks = tb_Remarks.Text;
                submissionStatus = cb_Submission_Status.Text;
                date = DateTime.Parse(tb_Date.Text);
                active = true;

                //dtbs connect

                string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:/Users/joshh/OneDrive/Documents/Database2.accdb";
                OleDbConnection con = new OleDbConnection(connectionString);
                con.Open();



                //get all SLNO numbers
                ArrayList sLNONums = new ArrayList();

                string selectSLNONumbersQuery = "SELECT [SLNO] FROM Submissions;";
                OleDbCommand readCmd = new OleDbCommand(selectSLNONumbersQuery, con);
                OleDbDataReader reader = readCmd.ExecuteReader();
                while (reader.Read())
                {
                    sLNONums.Add(reader["SLNO"].ToString());
                }

                reader.Close();

                //check if SLNO already taken
                if (sLNONums.Contains(sLNO))
                {
                    throw new ArgumentException("SLNO number already used for different submission.");
                }



                //check recruiter name exists and get recruiter id
                List<string> recruiterNames = new List<string>();
                ArrayList recruiters = new ArrayList();

                string selectRecruiterNamesQuery = "SELECT [ID], [Recruiter Name] FROM [ASR-RECRUITERS];";
                readCmd = new OleDbCommand(selectRecruiterNamesQuery, con);
                reader = readCmd.ExecuteReader();
                while (reader.Read())
                {
                    recruiterNames.Add(reader["Recruiter Name"].ToString());
                    recruiters.Add(new Recruiter(reader["ID"].ToString(), reader["Recruiter Name"].ToString()));
                }

                reader.Close();

                //check if recruiter name already taken
                if (!recruiterNames.Contains(recruiter))
                {
                    throw new ArgumentException("Recruiter name does not exist. First click add new Recruiter.");
                }


                //get the rec id #
                foreach (Recruiter r in recruiters)
                {
                    if (recruiter.Equals(r.name))
                    {
                        recruiterID = Int32.Parse(r.id);
                        continue;
                    }
                }


                using (ModelContext db = new ModelContext())
                {
                    //get client id
                    var clientDb = db.Clients.FirstOrDefault(c => c.ClientName == client);
                    if (clientDb == null)
                    {
                        clientDb = new Models.Clients { ClientName = client };
                        db.Clients.Add(clientDb);
                        db.SaveChanges();
                        LoggingUtility.appendToLog(String.Format("new client added '{0}'", client));
                    }
                    clientID = clientDb.Id;


                    //get vendor id
                    var vendorDb = db.Vendors.FirstOrDefault(c => c.VendorCompanyName == vendor);
                    if (vendorDb == null)
                    {
                        vendorDb = new Models.Vendors { VendorCompanyName = vendor };
                        db.Vendors.Add(vendorDb);
                        db.SaveChanges();
                        LoggingUtility.appendToLog(String.Format("new vendor added '{0}'", vendor));
                    }
                    vendorID = vendorDb.Id;

                    //get vendor contact id
                    var vendorContactDb = db.VendorContact.FirstOrDefault(c => c.RecruiterName == vendorContact);
                    if (vendorContactDb == null)
                    {
                        vendorContactDb = new Models.VendorContact { RecruiterName = vendorContact };
                        db.VendorContact.Add(vendorContactDb);
                        db.SaveChanges();
                        LoggingUtility.appendToLog(String.Format("new vendor contact added '{0}'", vendorContact));
                    }
                    vendorContactID = vendorContactDb.Id;



                    //create new submission
                    var newSubmission = new Models.Submissions
                    {
                        Slno = sLNO,
                        AsrRecruiterId = recruiterID,
                        Date = date,
                        ConsultantId = consultantId,
                        JobTitle = jobTitle,
                        City = city,
                        State = state,
                        Duration = duration,
                        VendorId = vendorID,
                        VendorContactId = vendorContactID,
                        ClientId = clientID,
                        RatePerHour = rate,
                        Method = method,
                        ClientSubmission = clientSubmission,
                        Remarks = remarks,
                        SubmissionStatus = submissionStatus,
                        Active = active
                    };

                    db.Submissions.Add(newSubmission);
                    db.SaveChanges();
                    LoggingUtility.appendToLog(String.Format("new submission successfully created with SLNO # {0} to client {1}", newSubmission.Slno, newSubmission.Client));
                }


                
                con.Close();

                //showMessage(String.Format("New submission #{0} to {1} successfully created.", sLNO, client));

                //refresh page
                Response.Redirect($"~/Pages/ViewAllSubmissions.aspx?Id={ConsultantId.Value}");
            }
            catch (Exception ex)
            {
                //statusMessage = ex.Message;
                //showMessage(ex.Message);
                //LoggingUtility.appendToLog(ex.Message);
                //LoggingUtility.appendToLog(ex.StackTrace);
                handleException(ex, sender.ToString());
            }



            LoggingUtility.writeMessage();
            //Response.Write("<script>alert('" + statusMessage + "')</script>");
        }
        

        protected void Button_Delete_Submission_OnClick(object sender, EventArgs e)
        {
            try
            {
                int slno = Convert.ToInt32(TextBox_SLNO.Text);

                using (var db = new ModelContext())
                {
                    var submissionDb = db.Submissions.FirstOrDefault(c => c.Slno == slno);

                    submissionDb.Active = false;
                    submissionDb.Deleted = true;
                    submissionDb.DeleteUser = ((Users) Session["User"]).Username;

                    db.SaveChanges();

                    LoggingUtility.LogMessage(
                        $"submission {submissionDb.Slno} to {db.Clients.FirstOrDefault(c => c.Id == submissionDb.ClientId).ClientName ?? ""} successfully marked for deletion.");
                }
            }
            catch (Exception ex)
            {
                handleException(ex, sender.ToString());
            }
            

            Response.Redirect($"~/Pages/ViewAllSubmissions.aspx?Id={ConsultantId.Value}");
        }

        protected void Button_Delete_Interview_OnClick(object sender, EventArgs e)
        {
            LoggingUtility.LogMessage("interview delete btn clicked.");
            int id = Convert.ToInt32(TextBox_Intvw_ID.Text);

            using (var db = new ModelContext())
            {
                var interviewDb = db.Interviews.FirstOrDefault(c => c.Id == id);

                interviewDb.Deleted = true;

                db.SaveChanges();

                LoggingUtility.LogMessage($"Interview {interviewDb.Id} for {db.Consultants.FirstOrDefault(c => c.Id == interviewDb.ConsultantId).LastName ?? ""} successfully marked for deletion.");
            }

            Response.Redirect($"~/Pages/ViewAllSubmissions.aspx?Id={ConsultantId.Value}");
        }
    }
}
using AjaxControlToolkit;
using ASR_Management_System.App_Code;
using ASR_Management_System.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASR_Management_System.Pages
{

    public partial class Consultants : System.Web.UI.Page
    {
         static string tempNotesText;

        protected void Page_Load(object sender, EventArgs e)
        {
            int id;
            //get consultant id from url
            if (Int32.TryParse(Request.QueryString["Id"], out id))
            {
                ConsultantId.Value = id.ToString();
            }
            else
            {
                Response.Redirect($"");
            }

            using (var db = new ModelContext())
            {
                var consultantDb = db.Consultants.FirstOrDefault(c => c.Id.ToString() == ConsultantId.Value);
                if (consultantDb != null)
                {
                    NameLabel.Text = $"{consultantDb.LastName ?? ""}, {consultantDb.FirstName ?? ""}";
                }
            }
        }


        //*******************************************************************************
        //consultant notes btns
        protected void Button_Edit_Consultant_Notes_Click(object sender, EventArgs e)
        {
            ContentPlaceHolder placeholder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");

            ListView notes = (ListView)placeholder.FindControl("ListView_Consultant_Notes");

            ListViewDataItem item = notes.Items.First();

            TextBox tb = (TextBox)item.FindControl("TextBox_Consultant_Notes");

            //save text in case user cancels changes
            tempNotesText = tb.Text;

            tb.ReadOnly = false;
            Button_Edit_Consultant_Notes.Visible = false;
            Button_Save_Notes.Visible = true;
            Button_Cancel_Notes_Save.Visible = true;
            tb.Focus();
            //ScriptManager.GetCurrent(this.Page).SetFocus(tb);
            //Response.Write("<script type='text/javascript'>alert('hello');</script>");
            //string id = tb.ID;
            //Page.ClientScript.RegisterStartupScript(GetType(), "ScrollToTB", "setPosition", true);
        }

        protected void Button_Save_Notes_Click(object sender, EventArgs e)
        {
            ContentPlaceHolder placeholder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
            ListView notes = (ListView)placeholder.FindControl("ListView_Consultant_Notes");
            ListViewDataItem item = notes.Items.First();

            TextBox tb = (TextBox)item.FindControl("TextBox_Consultant_Notes");

            string text = tb.Text;
            string statusMessage;

            try
            {
                string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:/Users/joshh/OneDrive/Documents/Database2.accdb";




                OleDbConnection con = new OleDbConnection(connectionString);
                con.Open();


                //insert new name into dtbs

                OleDbCommand updateCmd = new OleDbCommand();
                string updateQueryString = "UPDATE Consultants SET Consultants.Notes = (@text) WHERE(((Consultants.ID) = (@id)));";
                updateCmd.CommandText = updateQueryString;
                updateCmd.CommandType = CommandType.Text;
                updateCmd.Connection = con;
                updateCmd.Parameters.Add(new OleDbParameter("@text", text));
                string id = ConsultantId.Value;
                updateCmd.Parameters.Add(new OleDbParameter("@id", id));

                updateCmd.ExecuteNonQuery();

                statusMessage = "Consultant Notes Successfully updated.";



                con.Close();

            }
            catch (Exception ex)
            {
                statusMessage = ex.Message;
                Response.Write("<script>alert('" + statusMessage + "')</script>");
            }



            tb.ReadOnly = true;
            Button_Edit_Consultant_Notes.Visible = true;
            Button_Save_Notes.Visible = false;
            Button_Cancel_Notes_Save.Visible = false;
        }

        protected void Button_Cancel_Notes_Save_Click(object sender, EventArgs e)
        {
            ContentPlaceHolder placeholder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
            ListView notes = (ListView)placeholder.FindControl("ListView_Consultant_Notes");
            ListViewDataItem item = notes.Items.First();

            TextBox tb = (TextBox)item.FindControl("TextBox_Consultant_Notes");

            //restore original text
            tb.Text = tempNotesText;

            tb.ReadOnly = true;
            Button_Edit_Consultant_Notes.Visible = true;
            Button_Save_Notes.Visible = false;
            Button_Cancel_Notes_Save.Visible = false;
        }
        //end consultant notes btns
        //*********************************************************************************





        //*********************************************************************************
        //consultant status box btns
        protected void Button_Edit_Status_Click(object sender, EventArgs e)
        {
            ContentPlaceHolder placeholder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");

            ListView notes = (ListView)placeholder.FindControl("ListView_Consultant_Status");

            ListViewDataItem item = notes.Items.First();

            Label statusLabel = (Label)item.FindControl("Label_Consultant_Status");
            ComboBox statusComboBox = (ComboBox)item.FindControl("ComboBox_Consultant_Status");

            Button_Edit_Status.Visible = false;
            Button_Save_Status.Visible = true;
            Button_Cancel_Save.Visible = true;

            statusLabel.Visible = false;
            statusComboBox.Visible = true;
        }

        protected void Button_Save_Status_Click(object sender, EventArgs e)
        {
            ContentPlaceHolder placeholder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");

            ListView notes = (ListView)placeholder.FindControl("ListView_Consultant_Status");

            ListViewDataItem item = notes.Items.First();

            LinkButton statusLabel = (LinkButton)item.FindControl("Label_Consultant_Status");
            ComboBox statusComboBox = (ComboBox)item.FindControl("ComboBox_Consultant_Status");

            string text = statusComboBox.Text;
            string statusMessage;

            try
            {
                string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:/Users/joshh/OneDrive/Documents/Database2.accdb";


                //first collect pre-existing consultant names into array

                OleDbConnection con = new OleDbConnection(connectionString);
                con.Open();


                //insert new name into dtbs

                OleDbCommand updateCmd = new OleDbCommand();
                string updateQueryString = "UPDATE Consultants SET Consultants.Status = (@text) WHERE(((Consultants.ID) = (@id)));";
                updateCmd.CommandText = updateQueryString;
                updateCmd.CommandType = CommandType.Text;
                updateCmd.Connection = con;
                updateCmd.Parameters.Add(new OleDbParameter("@text", text));
                string id = ConsultantId.Value;
                updateCmd.Parameters.Add(new OleDbParameter("@id", id));

                updateCmd.ExecuteNonQuery();

                statusMessage = "Consultant Notes Successfully updated.";



                con.Close();

            }
            catch (Exception ex)
            {
                statusMessage = ex.Message;
                Response.Write("<script>alert('" + statusMessage + "')</script>");
            }



            //Button_Edit_Status.Visible = true;
            Button_Save_Status.Visible = false;
            Button_Cancel_Save.Visible = false;

            //Label_Popup_Text.Visible = true;

            statusLabel.Text = text;

            statusLabel.Visible = true;
            statusComboBox.Visible = false;
        }

        protected void Button_Cancel_Save_Click(object sender, EventArgs e)
        {
            ContentPlaceHolder placeholder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");

            ListView notes = (ListView)placeholder.FindControl("ListView_Consultant_Status");

            ListViewDataItem item = notes.Items.First();

            LinkButton statusLabel = (LinkButton)item.FindControl("Label_Consultant_Status");
            ComboBox statusComboBox = (ComboBox)item.FindControl("ComboBox_Consultant_Status");

            //restore text of combobox to original value
            statusComboBox.Text = statusLabel.Text;

            statusComboBox.Visible = false;
            statusLabel.Visible = true;

            //Label_Popup_Text.Visible = true;

            //Button_Edit_Status.Visible = true;
            Button_Save_Status.Visible = false;
            Button_Cancel_Save.Visible = false;
        }

        protected void Label_Consultant_Status_Click(object sender, EventArgs e)
        {
            ContentPlaceHolder placeholder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");

            ListView notes = (ListView)placeholder.FindControl("ListView_Consultant_Status");

            ListViewDataItem item = notes.Items.First();

            LinkButton statusLabel = (LinkButton)item.FindControl("Label_Consultant_Status");
            ComboBox statusComboBox = (ComboBox)item.FindControl("ComboBox_Consultant_Status");

            //Button_Edit_Status.Visible = false;
            Button_Save_Status.Visible = true;
            Button_Cancel_Save.Visible = true;

            //Label_Popup_Text.Visible = false;

            statusLabel.Visible = false;
            statusComboBox.Visible = true;
        }
        //end consultant status box btns
        //***************************************************************************************





        

        public void showMessage(string msg)
        {
            MsgPanelPopup_LabelText.Text = msg;
            ModalPopupExtender_ShowMsg.Show();
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = false;
        }

        protected void Button_View_All_Submissions_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/ViewAllSubmissions.aspx?" +
                "Id=" + ConsultantId.Value);


            //Active_Submissions_Repeater.DataSourceID = "All_Submissions_DS";
            //Active_Submissions_Repeater.DataBind();
            //foreach (RepeaterItem item in Active_Submissions_Repeater.Items)
            //{
            //    item.FindControl("Pending_Interviews_DS").DataBind();
            //    item.FindControl("Repeater_Submission_Interviews").DataBind();
            //}
        }
    }
}
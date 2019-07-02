using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASR_Management_System.App_Code;

namespace ASR_Management_System.Pages
{
    public partial class ASR_Recruiters : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Session["Recruiter"] != null)
            {
                RecruiterDropdown.SelectedValue = Session["Recruiter"].ToString();
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TableCell SubmissionStatusCell = e.Row.Cells[5];

                FormatStatusCell.FormatSubmissionStatusCell(SubmissionStatusCell);
            }
        }

        protected void GridView3_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TableCell SubmissionStatusCell = e.Row.Cells[7];

                FormatStatusCell.FormatSubmissionStatusCell(SubmissionStatusCell);
            }
        }

        protected void GridView5_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TableCell InterviewStatusCell = e.Row.Cells[4];

                FormatStatusCell.FormatInterviewStatusCell(InterviewStatusCell);
            }
        }

        protected void RecruiterDropdown_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["Recruiter"] = RecruiterDropdown.SelectedValue;
        }
    }
}
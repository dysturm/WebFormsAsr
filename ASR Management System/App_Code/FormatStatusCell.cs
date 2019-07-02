using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace ASR_Management_System.App_Code
{
    public static class FormatStatusCell
    {
        public static void FormatSubmissionStatusCell(TableCell SubmissionStatusCell)
        {
            if (SubmissionStatusCell.Text.Contains("Pending")
                 || SubmissionStatusCell.Text.Contains("Waiting")
                 || SubmissionStatusCell.Text.Equals("1st Interview Scheduled"))
            {
                SubmissionStatusCell.ForeColor = System.Drawing.Color.YellowGreen;
            }
            else if (SubmissionStatusCell.Text.Equals("Closed"))
            {
                SubmissionStatusCell.ForeColor = Color.DarkRed;
            }
            else if (SubmissionStatusCell.Text.Contains("Completed"))
            {
                SubmissionStatusCell.ForeColor = Color.LimeGreen;
            }
            else if (SubmissionStatusCell.Text.Equals("Resume Rejected")
                || SubmissionStatusCell.Text.Equals("Rejected By Client"))
            {
                SubmissionStatusCell.ForeColor = Color.Red;
            }
            else if (SubmissionStatusCell.Text.Equals("Hired"))
            {
                SubmissionStatusCell.BackColor = Color.LimeGreen;
                SubmissionStatusCell.ForeColor = Color.White;
            }
        }
        public static void FormatInterviewStatusCell(TableCell InterviewStatusCell)
        {
            if (InterviewStatusCell.Text.Equals("Completed"))
            {
                InterviewStatusCell.ForeColor = Color.LimeGreen;
            }
            else if (InterviewStatusCell.Text.Equals("Pending"))
            {
                InterviewStatusCell.ForeColor = Color.Black;
            }
            else
            {
                InterviewStatusCell.ForeColor = Color.Red;
            }
        }
    }
}
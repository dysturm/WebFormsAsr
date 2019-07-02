using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASR_Management_System.App_Code;
using ASR_Management_System.Models;

namespace ASR_Management_System.Pages.Update_Records_Pgs
{
    public partial class AddRecruiter : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAddRecruiter_OnClick(object sender, EventArgs e)
        {
            string recruiterName = tbName.Text;

            try
            {
                ValidateName(recruiterName);

                using (ModelContext db = new ModelContext())
                {
                    var recruiterDb = db.AsrRecruiters.FirstOrDefault(c => c.RecruiterName.Equals(recruiterName, StringComparison.OrdinalIgnoreCase));
                    if (recruiterDb != null)
                        throw new ArgumentException("Recruiter Name already exists.");

                    recruiterDb = new AsrRecruiters {RecruiterName = recruiterName};

                    db.AsrRecruiters.Add(recruiterDb);
                    db.SaveChanges();
                    LoggingUtility.LogMessage($"New recruiter '{recruiterName}' added.");

                    lblStatus.Text = "Recruiter successfully added.";
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text = ex.Message;
                LoggingUtility.LogException(ex, sender.ToString());
            }
        }

        private void ValidateName(string recruiterName)
        {
            if (recruiterName.Any(char.IsDigit))
            {
                throw new ArgumentException("Name cannot contain digits.");
            }
        }
    }
}
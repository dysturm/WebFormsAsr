using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASR_Management_System.Models;
using Microsoft.EntityFrameworkCore;

namespace ASR_Management_System.Pages.Update_Records_Pgs
{
    public partial class ConfirmDeletions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            (Master as Site1).CheckIfAdmin();
        }

        protected void OnClick(object sender, EventArgs e)
        {
            using (var db = new ModelContext())
            {
                foreach (RepeaterItem item in rptrDeletedSubmissions.Items)
                {
                    if (((CheckBox)item.FindControl("cbDelete")).Checked)
                    {
                        int slno = Convert.ToInt32(((HiddenField)item.FindControl("Slno")).Value);
                        db.Remove(db.Submissions.FirstOrDefault(c => c.Slno == slno));
                        foreach (var dbInterview in db.Interviews)
                        {
                            if (dbInterview.SubmissionSlno == slno)
                            {
                                db.Remove(dbInterview);
                            }
                        }
                    }
                    else if (((CheckBox)item.FindControl("cbRestore")).Checked)
                    {
                        int slno = Convert.ToInt32(((HiddenField)item.FindControl("Slno")).Value);
                        var submissionDb = db.Submissions.First(c => c.Slno == slno);
                        submissionDb.Deleted = false;
                        submissionDb.DeleteUser = "";  
                    }
                }
                db.SaveChanges();
            }
            
            Server.Transfer("~/Pages/Update Records Pgs/ConfirmDeletions.aspx");
        }
    }
}
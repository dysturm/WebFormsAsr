using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASR_Management_System.Models;
using Microsoft.EntityFrameworkCore.Internal;

namespace ASR_Management_System.Pages
{
    public partial class ClientInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //get client from querystring or default
            int clientId;
            if (!Int32.TryParse(Request.QueryString["Id"], out clientId))
            {
                using (ModelContext db = new ModelContext())
                {
                    clientId = db.Clients.FirstOrDefault().Id;
                }
            }
            HiddenField_ClientId.Value = clientId.ToString();

            //get+set num submissions for client
            using (ModelContext db = new ModelContext())
            {
                if (lblSubmissionCount != null)
                    lblSubmissionCount.Text = $"{db.Submissions.Count(c => c.ClientId == clientId).ToString()} Submission(s)";
            }
        }

        protected void OnItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int slno = Convert.ToInt32(e.CommandArgument);

            int consultantId;

            using (ModelContext db = new ModelContext())
            {
                consultantId = (int)db.Submissions.FirstOrDefault(c => c.Slno == slno).ConsultantId;
            }

            Response.Redirect($"~/Pages/ViewAllSubmissions.aspx?Id={consultantId}&Target=ShowSubmission&Slno={e.CommandArgument}");
        }
    }
}
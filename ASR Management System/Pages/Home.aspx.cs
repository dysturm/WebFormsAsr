
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace ASR_Management_System.Pages
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //String name = "no name";
            //using (var db = new ModelContext())
            //{
            //    name = db.Consultants.FirstOrDefault().FirstName;
            //}

            //DisplayLabel.Text = name;
        }

        protected void Repeater_ConsultantNameBtns_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            Response.Redirect("~/Pages/Consultants.aspx?" +
                "Id=" + e.CommandArgument.ToString());
        }

        protected void Button2_OnClick(object sender, EventArgs e)
        {
            string[] nothing = new string[0];

            string none = nothing[5];
        }
    }
}
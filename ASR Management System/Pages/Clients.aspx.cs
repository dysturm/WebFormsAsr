using ASR_Management_System.App_Code;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASR_Management_System.Pages
{
    public partial class Clients : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void OnItemCommand(object source, RepeaterCommandEventArgs e)
        {
            var clientId = e.CommandArgument.ToString();
            Response.Redirect($"~/Pages/ClientInfo.aspx?Id={clientId}");
        }
    }
}
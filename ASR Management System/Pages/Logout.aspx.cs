using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASR_Management_System.Pages
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LinkButton_Logout_OnClick(object sender, EventArgs e)
        {
            (Master as Site1).lnkbtnLogout_OnClick(sender, e);
        }
    }
}
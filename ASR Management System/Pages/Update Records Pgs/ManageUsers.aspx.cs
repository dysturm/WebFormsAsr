using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASR_Management_System.Models;

namespace ASR_Management_System.Pages.Update_Records_Pgs
{
    public partial class Manage_Users : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            (Master as Site1).CheckIfAdmin();
        }
    }
}
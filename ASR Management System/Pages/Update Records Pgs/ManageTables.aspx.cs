using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASR_Management_System.Models;

namespace ASR_Management_System.Pages.Update_Records_Pgs
{
    public partial class ManageTables : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            (Master as Site1).CheckIfAdmin();
        }

        protected void btn_goLeft_OnClick(object sender, EventArgs e)
        {
            if (Multiview1.ActiveViewIndex == 0)
            {
                Multiview1.ActiveViewIndex = Multiview1.Views.Count-1;
            }
            else
            {
                Multiview1.ActiveViewIndex--;
            }
        }

        protected void btn_goRight_OnClick(object sender, EventArgs e)
        {
            if (Multiview1.ActiveViewIndex == Multiview1.Views.Count - 1)
            {
                Multiview1.ActiveViewIndex = 0;
            }
            else
            {
                Multiview1.ActiveViewIndex++;
            }
        }
    }
}
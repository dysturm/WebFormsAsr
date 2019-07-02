using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASR_Management_System.Pages
{
    public partial class TestPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.PreviousPage != null)
            {
                ContentPlaceHolder placeholder = (ContentPlaceHolder)Page.PreviousPage.Master.FindControl("ContentPlaceHolder1");

                TextBox previousPageTextBox = (TextBox)placeholder.FindControl("NameInputTxtbox");
                //Label SourceDropDown = (Label)Page.PreviousPage.FindControl("ConsultantDropdown");
                if (previousPageTextBox != null)
                {
                    DisplaySubmittedName.Text = previousPageTextBox.Text;
                }
                else
                {
                    DisplaySubmittedName.Text = "previousPageTextBox is null";
                }
            }
            else
            {
                DisplaySubmittedName.Text = "Previous pg is null";
            }
        }

    }
}
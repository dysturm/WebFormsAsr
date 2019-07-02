using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASR_Management_System.App_Code;
using ASR_Management_System.Models;

namespace ASR_Management_System
{
    public partial class Site1 : System.Web.UI.MasterPage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                HttpCookie cookie = Request.Cookies["User"];
                if (cookie != null && !string.IsNullOrEmpty(cookie.Values["UserID"]))
                {
                    using (ModelContext db = new ModelContext())
                    {
                        Session["User"] = db.Users.FirstOrDefault(c => c.Username + c.Password == Encryptor.Decrypt(cookie.Values["UserID"]));
                    }
                }
                else
                {
                    LoggingUtility.LogMessage($"cookie tests failed. cookie null = {cookie==null}");
                }

                if (Session["User"] == null)
                {
                    Response.Redirect("~/Pages/Login.aspx");
                }
            }

            lblUsername.Text = $"Logged in as {((Users) Session["User"]).Username}";
        }


        public void lnkbtnLogout_OnClick(object sender, EventArgs e)
        {
            Session["User"] = null;
            //overwrite cookie
            if (Request.Cookies["User"] != null)
            {
                HttpCookie cookie = new HttpCookie("User");
                cookie.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(cookie);
            }
                
            Response.Redirect("~/Pages/Login.aspx");
        }

        public void CheckIfAdmin()
        {
            try
            {
                if (((Users) Session["User"]).Role != "Admin")
                {
                    Response.Redirect("~/Pages/Logout.aspx");
                }
            }
            catch (Exception ex)
            {
                LoggingUtility.LogException(ex, "masterPgLoginValidation");
                Response.Redirect("~/Pages/Logout.aspx");
            }
        }
    }
}
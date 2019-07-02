using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASR_Management_System.App_Code;
using ASR_Management_System.Models;
using Microsoft.EntityFrameworkCore.Internal;
using ASR_Management_System.App_Code;


namespace ASR_Management_System.Pages
{
    public partial class Login : System.Web.UI.Page
    {
        private static int _loginAttempts = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Session["checkRefresh"] != null && (bool)Session["checkRefresh"])
            {
                _loginAttempts = 0;
                lblLoginStatus.Text = "";
                Session["checkRefresh"] = false;
            }
        }

        protected void btnLogin_OnClick(object sender, EventArgs e)
        {
            if (_loginAttempts > 3)
            {
                lblLoginStatus.Text = "Too many login attempts.  Reload page to try again.";
                Session["checkRefresh"] = true;
                return;
            }

            _loginAttempts++;

            string username = tbUsername.Text;
            string password = tbPassword.Text;

            using (ModelContext db = new ModelContext())
            {
                var userDb = db.Users.FirstOrDefault(c => c.Username == username && c.Password == password);
                
                if (userDb != null)
                {
                    Session["User"] = userDb;
                    if (ChkRememberme.Checked)
                    {
                        HttpCookie cookie = new HttpCookie("User");
                        cookie.Values.Add("UserID", Encryptor.Encrypt(tbUsername.Text, tbPassword.Text));
                        cookie.Expires = DateTime.Now.AddMonths(1);
                        Response.Cookies.Add(cookie);
                    }
                    Response.Redirect("~/Pages/Home.aspx");
                }
                else
                {
                    lblLoginStatus.Text = "Invalid Username or Password";
                }
            }
        }
    }
}
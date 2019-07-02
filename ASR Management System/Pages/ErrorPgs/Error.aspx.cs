using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASR_Management_System.App_Code;

namespace ASR_Management_System.Pages.ErrorPgs
{
    public partial class Error : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Exception ex = null;
            try
            {
                ex = (Exception) Session["Error"];
            }
            catch (Exception exc) { LoggingUtility.LogException(exc, sender.ToString()); }


            if (ex != null)
            {
                LoggingUtility.LogException(ex, sender.ToString());
                try
                {
                    SendEmail(ex);
                }
                catch (Exception exc) { LoggingUtility.LogException(exc, sender.ToString()); }
            }
        }

        private void SendEmail(Exception exception)
        {
            //sending email
            SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);

            smtpClient.Credentials = new System.Net.NetworkCredential("doivsturm93@gmail.com", "myPassword99");

            smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;

            smtpClient.EnableSsl = true;

            MailMessage mail = new MailMessage();



            mail.From = new MailAddress("doivsturm93@gmail.com", "ASR Website");

            mail.To.Add(new MailAddress("dsturm@student.touro.edu"));

            mail.Subject = "Exception Test";

            mail.Body = FormMailBodyForException(exception);

            smtpClient.Send(mail);
        }

        private static string FormMailBodyForException(Exception exception)
        {
            string body = "";

            if (exception.InnerException != null)
            {
                body +=
                    $"Inner Exception: {exception.InnerException.Message}\nSource: {exception.InnerException.Source}\nInner Stack Trace: {exception.InnerException.StackTrace}\n";
            }

            body += $"Message: {exception.Message}\n";

            if (exception.StackTrace != null)
            {
                body += $"Stack Trace:\n{exception.StackTrace}";
            }

            return body;
        }
    }
}
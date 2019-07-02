using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASR_Management_System.Pages.Update_Records_Pgs
{
    public partial class AddConsultant : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SubmitBtn_Click(object sender, EventArgs e)
        {
            string statusMessage;

            //ContentPlaceHolder placeholder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");

            var newConsultantName = FirstNameInputTxtbox.Text +" "+LastNameInputTxtbox.Text;
            ArrayList existingNames = new ArrayList();

            try
            {
                string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:/Users/joshh/OneDrive/Documents/Database2.accdb";


                //first collect pre-existing consultant names into array

                OleDbConnection con = new OleDbConnection(connectionString);
                con.Open();
                string selectConsultantNamesQuery = "SELECT [FirstName], [LastName] FROM Consultants";
                OleDbCommand readCmd = new OleDbCommand(selectConsultantNamesQuery, con);
                OleDbDataReader reader = readCmd.ExecuteReader();
                while (reader.Read())
                {
                    existingNames.Add(reader["FirstName"].ToString()+" "+ reader["LastName"].ToString());
                }

                reader.Close();

                //check if name exists

                if (!existingNames.Contains(newConsultantName))
                {
                    //insert new name into dtbs

                    OleDbCommand insertCmd = new OleDbCommand();
                    string insertQueryString = "INSERT INTO Consultants ([LastName]) Values(@0)";
                    insertCmd.CommandText = insertQueryString;
                    insertCmd.CommandType = CommandType.Text;
                    insertCmd.Connection = con;
                    insertCmd.Parameters.Add(new OleDbParameter("@0", newConsultantName));

                    insertCmd.ExecuteNonQuery();

                    statusMessage = "Consultant Sucessfully Added To Database.";
                }
                else
                {
                    statusMessage = "Name " + "'" + newConsultantName + "'" + " already exists in Dtbs.";
                }


                con.Close();

            }
            catch (Exception ex)
            {
                statusMessage = ex.Message;
            }

            Response.Write("<script>alert('" + statusMessage + "')</script>");

            Server.Transfer("~/Pages/Home.aspx");
        }
    }
}
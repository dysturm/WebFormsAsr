using ASR_Management_System.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ASR_Management_System.App_Code
{
    public class FieldValidator
    {
        public static void checkFields(string recruiter, string client, string rateString, string method, string city, string state, string jobTitle, string duration, string vendor, string vendorContact, string clientSubmission, string remarks, string status, string dateString)
        {
            List<string> invalidFields = new List<string>();
            

            if (recruiter.Any(char.IsDigit))
            {
                invalidFields.Add($"Invalid Recruiter Name '{recruiter}'. Cannot contain digit.");
            }

            if (vendorContact.Any(char.IsDigit))
            {
                invalidFields.Add($"Invalid Vendor Contact Name '{vendorContact}'. Cannot contain digit.");
            }
            int helper;
            if (!Int32.TryParse(rateString, out helper))
            {
                invalidFields.Add($"Invalid Rate Entered '{rateString}'. Cannot be parsed.");
            }
            DateTime helperDate;
            if (!DateTime.TryParse(dateString, out helperDate))
            {
                invalidFields.Add($"Invalid Date Entered '{dateString}'. Cannot be parsed.");
            }

            using (ModelContext db = new ModelContext())
            {
                if (db.UsStates.FirstOrDefault(c => c.Initials.Equals(state) || c.Ucname.Equals(state) || c.Lcname.Equals(state)) == null)
                {
                    invalidFields.Add(String.Format("Invalid State Entered '{0}'. Does not exist.", state));
                }
            }


            //check if any tests failed
            if (invalidFields.Count > 0)
            {
                throwException(invalidFields);
            }
        }

        private static void throwException(List<string> invalidFields)
        {
            string errorMessage = "";

            foreach (string s in invalidFields)
            {
                errorMessage += s + "\n";
            }

            LoggingUtility.logArray(invalidFields);

            throw new Exception(errorMessage);
        }

        internal static void CheckInterviewFields(Dictionary<string, string> interviewValues)
        {
            List<string> invalidFields = new List<string>();

            DateTime dateHelper;
            if (!DateTime.TryParse(interviewValues["Date"], out dateHelper))
            {
                invalidFields.Add($"Date '{interviewValues["Date"]}' is not parsable");
            }


            //check if any tests failed
            if (invalidFields.Count > 0)
            {
                throwException(invalidFields);
            }
        }
    }
}
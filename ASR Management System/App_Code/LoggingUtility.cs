using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace ASR_Management_System.App_Code
{
    public class LoggingUtility
    {
        private static string logFile = "C:\\Users\\joshh\\source\\repos\\ASR Management System\\ASR Management System\\logFile.txt";
        private static List<string> logMessageArray = new List<string>();

        //Add to log msg
        public static void appendToLog (string appendMsg)
        {
            logMessageArray.Add(appendMsg);
        }

        //flush log msg to file
        public static void writeMessage ()
        {
            if (logMessageArray.Count > 0)
            {
                logArray(logMessageArray);
                logMessageArray.Clear();
            }
        }

        //write array of log msgs to file
        public static void logArray (List<string> messages)
        {
            //StreamWriter sw = new StreamWriter(logFile, true);
            //sw.WriteLine("********** {0} **********", DateTime.Now);
            //sw.WriteLine();
            //foreach (string s in messages)
            //{
            //    sw.WriteLine(s);
            //}
            //sw.WriteLine();
            //sw.Close();
        }


        // Log a Message
        public static void LogMessage(string message)
        {
            // Get the absolute path to the log file
            //string logFile = "~/App_Data/ErrorLog.txt";
            //logFile = HttpContext.Current.Server.MapPath(logFile);

            // Open the log file for append and write the log


            //StreamWriter sw = new StreamWriter(logFile, true);
            //sw.WriteLine("********** {0} **********", DateTime.Now);
            //sw.WriteLine();
            //sw.WriteLine(message);
            //sw.WriteLine();
            //sw.Close();
        }



        // Log an Exception
        public static void LogException(Exception exc, string source)
        {
            // Include logic for logging exceptions
            // Get the absolute path to the log file
            //string logFile = "~/App_Data/ErrorLog.txt";
            //logFile = HttpContext.Current.Server.MapPath(logFile);

            // Open the log file for append and write the log
            //StreamWriter sw = new StreamWriter(logFile, true);
            //sw.WriteLine("********** {0} **********", DateTime.Now);
            //if (exc.InnerException != null)
            //{
            //    sw.Write("Inner Exception Type: ");
            //    sw.WriteLine(exc.InnerException.GetType().ToString());
            //    sw.Write("Inner Exception: ");
            //    sw.WriteLine(exc.InnerException.Message);
            //    sw.Write("Inner Source: ");
            //    sw.WriteLine(exc.InnerException.Source);
            //    if (exc.InnerException.StackTrace != null)
            //    {
            //        sw.WriteLine("Inner Stack Trace: ");
            //        sw.WriteLine(exc.InnerException.StackTrace);
            //    }
            //}
            //sw.Write("Exception Type: ");
            //sw.WriteLine(exc.GetType().ToString());
            //sw.WriteLine("Exception: " + exc.Message);
            //sw.WriteLine("Source: " + source);
            //sw.WriteLine("Stack Trace: ");
            //if (exc.StackTrace != null)
            //{
            //    sw.WriteLine(exc.StackTrace);
            //    sw.WriteLine();
            //}
            //sw.Close();
        }
    }
}
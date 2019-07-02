using System;
using System.Collections.Generic;

namespace ASR_Management_System.Models
{
    public partial class ClientInterviews
    {
        public int Id { get; set; }
        public string Date { get; set; }
        public string Consultant { get; set; }
        public string NameBdm { get; set; }
        public string Vendor { get; set; }
        public string Client { get; set; }
        public string JobPosition { get; set; }
        public string Location { get; set; }
        public string JobTypeDuration { get; set; }
        public string DateOfInterview { get; set; }
        public string ModeOfInterview { get; set; }
        public string InterviewerName { get; set; }
        public string SkillsRequired { get; set; }
        public string InterviewFeedback { get; set; }
        public string RemarksIfAny { get; set; }
    }
}

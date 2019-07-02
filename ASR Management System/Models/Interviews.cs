using System;
using System.Collections.Generic;

namespace ASR_Management_System.Models
{
    public partial class Interviews
    {
        public int Id { get; set; }
        public int? SubmissionSlno { get; set; }
        public int? ConsultantId { get; set; }
        public DateTime? DateScheduled { get; set; }
        public string Type { get; set; }
        public string Method { get; set; }
        public string Interviewer { get; set; }
        public string SkillsRequired { get; set; }
        public string Status { get; set; }
        public string Feedback { get; set; }
        public string Remarks { get; set; }
        public bool? Deleted { get; set; }

        public virtual Consultants Consultant { get; set; }
    }
}

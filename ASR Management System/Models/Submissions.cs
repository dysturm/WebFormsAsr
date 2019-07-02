using System;
using System.Collections.Generic;

namespace ASR_Management_System.Models
{
    public partial class Submissions
    {
        public int Slno { get; set; }
        public int? AsrRecruiterId { get; set; }
        public DateTime? Date { get; set; }
        public int? ConsultantId { get; set; }
        public string JobTitle { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Duration { get; set; }
        public int? VendorId { get; set; }
        public int? VendorContactId { get; set; }
        public int? ClientId { get; set; }
        public decimal? RatePerHour { get; set; }
        public string Method { get; set; }
        public string ClientSubmission { get; set; }
        public string Remarks { get; set; }
        public string SubmissionStatus { get; set; }
        public bool? Active { get; set; }
        public bool? Deleted { get; set; }
        public string DeleteUser { get; set; }

        public virtual AsrRecruiters AsrRecruiter { get; set; }
        public virtual Clients Client { get; set; }
        public virtual Consultants Consultant { get; set; }
        public virtual Vendors Vendor { get; set; }
        public virtual VendorContact VendorContact { get; set; }
    }
}

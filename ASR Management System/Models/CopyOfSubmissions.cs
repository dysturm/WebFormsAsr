using System;
using System.Collections.Generic;

namespace ASR_Management_System.Models
{
    public partial class CopyOfSubmissions
    {
        public short Slno { get; set; }
        public short? AsrRecruiterId { get; set; }
        public DateTime? Date { get; set; }
        public short? ConsultantId { get; set; }
        public string JobTitle { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Duration { get; set; }
        public string VendorId { get; set; }
        public string VendorContactId { get; set; }
        public string ClientId { get; set; }
        public string Rate { get; set; }
        public string ClientSubmission { get; set; }
        public string Remarks { get; set; }
    }
}

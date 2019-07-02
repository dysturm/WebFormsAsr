using System;
using System.Collections.Generic;

namespace ASR_Management_System.Models
{
    public partial class Vendors
    {
        public Vendors()
        {
            Submissions = new HashSet<Submissions>();
        }

        public int Id { get; set; }
        public string VendorCompanyName { get; set; }

        public virtual ICollection<Submissions> Submissions { get; set; }
    }
}

using System;
using System.Collections.Generic;

namespace ASR_Management_System.Models
{
    public partial class Consultants
    {
        public Consultants()
        {
            Interviews = new HashSet<Interviews>();
            Submissions = new HashSet<Submissions>();
        }

        public int Id { get; set; }
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public string Status { get; set; }
        public string Notes { get; set; }

        public virtual ICollection<Interviews> Interviews { get; set; }
        public virtual ICollection<Submissions> Submissions { get; set; }
    }
}

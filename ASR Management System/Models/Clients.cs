using System;
using System.Collections.Generic;

namespace ASR_Management_System.Models
{
    public partial class Clients
    {
        public Clients()
        {
            Submissions = new HashSet<Submissions>();
        }

        public int Id { get; set; }
        public string ClientName { get; set; }

        public virtual ICollection<Submissions> Submissions { get; set; }
    }
}

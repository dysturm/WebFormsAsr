﻿using System;
using System.Collections.Generic;

namespace ASR_Management_System.Models
{
    public partial class AsrRecruiters
    {
        public AsrRecruiters()
        {
            Submissions = new HashSet<Submissions>();
        }

        public int Id { get; set; }
        public string RecruiterName { get; set; }

        public virtual ICollection<Submissions> Submissions { get; set; }
    }
}
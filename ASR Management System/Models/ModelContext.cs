using System;
using EntityFrameworkCore.Jet;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace ASR_Management_System.Models
{
    public partial class ModelContext : DbContext
    {
        public ModelContext()
        {
        }

        public ModelContext(DbContextOptions<ModelContext> options)
            : base(options)
        {
        }

        public virtual DbSet<AsrRecruiters> AsrRecruiters { get; set; }
        public virtual DbSet<ClientInterviews> ClientInterviews { get; set; }
        public virtual DbSet<ClientSubmissionsForJavaConsultants24092018Onwards> ClientSubmissionsForJavaConsultants24092018Onwards { get; set; }
        public virtual DbSet<Clients> Clients { get; set; }
        public virtual DbSet<Consultants> Consultants { get; set; }
        public virtual DbSet<CopyOfSubmissions> CopyOfSubmissions { get; set; }
        public virtual DbSet<InterviewMethods> InterviewMethods { get; set; }
        public virtual DbSet<InterviewStatusOptions> InterviewStatusOptions { get; set; }
        public virtual DbSet<Interviews> Interviews { get; set; }
        public virtual DbSet<Submissions> Submissions { get; set; }
        public virtual DbSet<SubmissionsBkup> SubmissionsBkup { get; set; }
        public virtual DbSet<Tmpclp498111> Tmpclp498111 { get; set; }
        public virtual DbSet<Tmpclp654981> Tmpclp654981 { get; set; }
        public virtual DbSet<UpdatedList> UpdatedList { get; set; }
        public virtual DbSet<UsStates> UsStates { get; set; }
        public virtual DbSet<Users> Users { get; set; }
        public virtual DbSet<VendorContact> VendorContact { get; set; }
        public virtual DbSet<Vendors> Vendors { get; set; }

        // Unable to generate entity type for table 'Jet.Consultant Status Options'. Please see the warning messages.
        // Unable to generate entity type for table 'Jet.Interview Types'. Please see the warning messages.
        // Unable to generate entity type for table 'Jet.Submission Status Options'. Please see the warning messages.

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseJet("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\\Users\\joshh\\OneDrive\\Documents\\Database2.accdb;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("ProductVersion", "2.2.1-servicing-10028");

            modelBuilder.Entity<AsrRecruiters>(entity =>
            {
                entity.ToTable("ASR-RECRUITERS");

                entity.HasIndex(e => e.Id)
                    .HasName("ID")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.RecruiterName)
                    .HasColumnName("Recruiter Name")
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<ClientInterviews>(entity =>
            {
                entity.ToTable("Client Interviews");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Client).HasMaxLength(255);

                entity.Property(e => e.Consultant).HasMaxLength(255);

                entity.Property(e => e.Date).HasMaxLength(255);

                entity.Property(e => e.DateOfInterview)
                    .HasColumnName("Date of Interview")
                    .HasMaxLength(255);

                entity.Property(e => e.InterviewFeedback)
                    .HasColumnName("Interview Feedback")
                    .HasMaxLength(255);

                entity.Property(e => e.InterviewerName)
                    .HasColumnName("Interviewer Name")
                    .HasMaxLength(255);

                entity.Property(e => e.JobPosition)
                    .HasColumnName("Job Position")
                    .HasMaxLength(255);

                entity.Property(e => e.JobTypeDuration)
                    .HasColumnName("Job Type/Duration")
                    .HasMaxLength(255);

                entity.Property(e => e.Location).HasMaxLength(255);

                entity.Property(e => e.ModeOfInterview)
                    .HasColumnName("Mode of Interview")
                    .HasMaxLength(255);

                entity.Property(e => e.NameBdm)
                    .HasColumnName("Name - BDM")
                    .HasMaxLength(255);

                entity.Property(e => e.RemarksIfAny)
                    .HasColumnName("Remarks if Any")
                    .HasMaxLength(255);

                entity.Property(e => e.SkillsRequired)
                    .HasColumnName("Skills Required")
                    .HasMaxLength(255);

                entity.Property(e => e.Vendor).HasMaxLength(255);
            });

            modelBuilder.Entity<ClientSubmissionsForJavaConsultants24092018Onwards>(entity =>
            {
                entity.HasKey(e => e.Slno)
                    .HasName("PrimaryKey");

                entity.ToTable("Client Submissions for Java consultants (24-09-2018 onwards)");

                entity.Property(e => e.Slno)
                    .HasColumnName("SLNO")
                    .ValueGeneratedNever();

                entity.Property(e => e.AsrRecruiter)
                    .HasColumnName("ASR-RECRUITER")
                    .HasMaxLength(255);

                entity.Property(e => e.Client)
                    .HasColumnName("CLIENT")
                    .HasMaxLength(255);

                entity.Property(e => e.ClientSubmission)
                    .HasColumnName("CLIENT SUBMISSION")
                    .HasMaxLength(255);

                entity.Property(e => e.Consultant)
                    .HasColumnName("CONSULTANT")
                    .HasMaxLength(255);

                entity.Property(e => e.Date)
                    .HasColumnName("DATE")
                    .HasMaxLength(255);

                entity.Property(e => e.Duration).HasMaxLength(255);

                entity.Property(e => e.JobTitle)
                    .HasColumnName("JOB TITLE")
                    .HasMaxLength(255);

                entity.Property(e => e.Location)
                    .HasColumnName("LOCATION")
                    .HasMaxLength(255);

                entity.Property(e => e.Rate)
                    .HasColumnName("RATE")
                    .HasMaxLength(255);

                entity.Property(e => e.Recruiter)
                    .HasColumnName("RECRUITER")
                    .HasMaxLength(255);

                entity.Property(e => e.Remarks)
                    .HasColumnName("REMARKS")
                    .HasMaxLength(255);

                entity.Property(e => e.VendorCompanyName)
                    .HasColumnName("VENDOR COMPANY NAME")
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<Clients>(entity =>
            {
                entity.HasIndex(e => e.Id)
                    .HasName("ID");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.ClientName)
                    .HasColumnName("CLIENT NAME")
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<Consultants>(entity =>
            {
                entity.HasIndex(e => e.Id)
                    .HasName("ID");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.FirstName).HasMaxLength(255);

                entity.Property(e => e.LastName).HasMaxLength(255);

                entity.Property(e => e.Notes).HasMaxLength(255);

                entity.Property(e => e.Status).HasMaxLength(255);
            });

            modelBuilder.Entity<CopyOfSubmissions>(entity =>
            {
                entity.HasKey(e => e.Slno)
                    .HasName("PrimaryKey");

                entity.ToTable("Copy Of Submissions");

                entity.Property(e => e.Slno)
                    .HasColumnName("SLNO")
                    .ValueGeneratedNever();

                entity.Property(e => e.AsrRecruiterId)
                    .HasColumnName("ASR-RECRUITER ID")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.City)
                    .HasColumnName("CITY")
                    .HasMaxLength(255);

                entity.Property(e => e.ClientId)
                    .HasColumnName("CLIENT ID")
                    .HasMaxLength(255);

                entity.Property(e => e.ClientSubmission)
                    .HasColumnName("CLIENT SUBMISSION")
                    .HasMaxLength(255);

                entity.Property(e => e.ConsultantId)
                    .HasColumnName("CONSULTANT ID")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.Date).HasColumnName("DATE");

                entity.Property(e => e.Duration).HasMaxLength(255);

                entity.Property(e => e.JobTitle)
                    .HasColumnName("JOB TITLE")
                    .HasMaxLength(255);

                entity.Property(e => e.Rate)
                    .HasColumnName("RATE")
                    .HasMaxLength(255);

                entity.Property(e => e.Remarks)
                    .HasColumnName("REMARKS")
                    .HasMaxLength(255);

                entity.Property(e => e.State)
                    .HasColumnName("STATE")
                    .HasMaxLength(255);

                entity.Property(e => e.VendorContactId)
                    .HasColumnName("VENDOR CONTACT ID")
                    .HasMaxLength(255);

                entity.Property(e => e.VendorId)
                    .HasColumnName("VENDOR ID")
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<InterviewMethods>(entity =>
            {
                entity.ToTable("Interview Methods");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Methods).HasMaxLength(255);
            });

            modelBuilder.Entity<InterviewStatusOptions>(entity =>
            {
                entity.ToTable("Interview Status Options");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Option).HasMaxLength(255);
            });

            modelBuilder.Entity<Interviews>(entity =>
            {
                entity.HasIndex(e => e.ConsultantId)
                    .HasName("ConsultantId");

                entity.HasIndex(e => e.Id)
                    .HasName("ID");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.ConsultantId)
                    .HasColumnName("ConsultantID")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.DateScheduled).HasColumnName("Date Scheduled");

                entity.Property(e => e.Deleted)
                    .IsRequired()
                    .HasColumnType("bit")
                    .HasDefaultValueSql("=False");

                entity.Property(e => e.Feedback).HasMaxLength(255);

                entity.Property(e => e.Interviewer).HasMaxLength(255);

                entity.Property(e => e.Method).HasMaxLength(255);

                entity.Property(e => e.Remarks).HasMaxLength(255);

                entity.Property(e => e.SkillsRequired)
                    .HasColumnName("Skills Required")
                    .HasMaxLength(255);

                entity.Property(e => e.Status)
                    .HasMaxLength(255)
                    .HasDefaultValueSql("\"Pending\"");

                entity.Property(e => e.SubmissionSlno)
                    .HasColumnName("Submission-SLNO")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.Type)
                    .HasMaxLength(255)
                    .HasDefaultValueSql("\"Initial\"");

                entity.HasOne(d => d.Consultant)
                    .WithMany(p => p.Interviews)
                    .HasForeignKey(d => d.ConsultantId)
                    .HasConstraintName("ConsultantsInterviews");
            });

            modelBuilder.Entity<Submissions>(entity =>
            {
                entity.HasKey(e => e.Slno)
                    .HasName("PrimaryKey");

                entity.Property(e => e.Slno)
                    .HasColumnName("SLNO")
                    .ValueGeneratedNever();

                entity.Property(e => e.Active)
                    .IsRequired()
                    .HasColumnType("bit")
                    .HasDefaultValueSql("=False");

                entity.Property(e => e.AsrRecruiterId)
                    .HasColumnName("ASR-RECRUITER ID")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.City)
                    .HasColumnName("CITY")
                    .HasMaxLength(255);

                entity.Property(e => e.ClientId)
                    .HasColumnName("CLIENT ID")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.ClientSubmission)
                    .HasColumnName("CLIENT SUBMISSION")
                    .HasMaxLength(255);

                entity.Property(e => e.ConsultantId)
                    .HasColumnName("CONSULTANT ID")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.Date).HasColumnName("DATE");

                entity.Property(e => e.DeleteUser).HasMaxLength(255);

                entity.Property(e => e.Deleted)
                    .IsRequired()
                    .HasColumnType("bit")
                    .HasDefaultValueSql("=False");

                entity.Property(e => e.Duration).HasMaxLength(255);

                entity.Property(e => e.JobTitle)
                    .HasColumnName("JOB TITLE")
                    .HasMaxLength(255);

                entity.Property(e => e.Method)
                    .HasColumnName("METHOD")
                    .HasMaxLength(255);

                entity.Property(e => e.RatePerHour)
                    .HasColumnName("RATE PER HOUR")
                    .HasColumnType("decimal(19, 0)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.Remarks)
                    .HasColumnName("REMARKS")
                    .HasMaxLength(255);

                entity.Property(e => e.State)
                    .HasColumnName("STATE")
                    .HasMaxLength(255);

                entity.Property(e => e.SubmissionStatus)
                    .IsRequired()
                    .HasColumnName("Submission Status")
                    .HasMaxLength(255)
                    .HasDefaultValueSql("\"Waiting to Schedule Interview\"");

                entity.Property(e => e.VendorContactId)
                    .HasColumnName("VENDOR CONTACT ID")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.VendorId)
                    .HasColumnName("VENDOR ID")
                    .HasDefaultValueSql("0");

                entity.HasOne(d => d.AsrRecruiter)
                    .WithMany(p => p.Submissions)
                    .HasForeignKey(d => d.AsrRecruiterId)
                    .HasConstraintName("ASR-RECRUITERSSubmissions");

                entity.HasOne(d => d.Client)
                    .WithMany(p => p.Submissions)
                    .HasForeignKey(d => d.ClientId)
                    .HasConstraintName("ClientsSubmissions");

                entity.HasOne(d => d.Consultant)
                    .WithMany(p => p.Submissions)
                    .HasForeignKey(d => d.ConsultantId)
                    .HasConstraintName("ConsultantsSubmissions");

                entity.HasOne(d => d.VendorContact)
                    .WithMany(p => p.Submissions)
                    .HasForeignKey(d => d.VendorContactId)
                    .HasConstraintName("Vendor ContactSubmissions");

                entity.HasOne(d => d.Vendor)
                    .WithMany(p => p.Submissions)
                    .HasForeignKey(d => d.VendorId)
                    .HasConstraintName("VendorsSubmissions");
            });

            modelBuilder.Entity<SubmissionsBkup>(entity =>
            {
                entity.HasKey(e => e.Slno)
                    .HasName("PrimaryKey");

                entity.ToTable("Submissions Bkup");

                entity.Property(e => e.Slno)
                    .HasColumnName("SLNO")
                    .ValueGeneratedNever();

                entity.Property(e => e.AsrRecruiterId)
                    .HasColumnName("ASR-RECRUITER ID")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.City)
                    .HasColumnName("CITY")
                    .HasMaxLength(255);

                entity.Property(e => e.ClientId)
                    .HasColumnName("CLIENT ID")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.ClientSubmission)
                    .HasColumnName("CLIENT SUBMISSION")
                    .HasMaxLength(255);

                entity.Property(e => e.ConsultantId)
                    .HasColumnName("CONSULTANT ID")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.Date).HasColumnName("DATE");

                entity.Property(e => e.Duration).HasMaxLength(255);

                entity.Property(e => e.JobTitle)
                    .HasColumnName("JOB TITLE")
                    .HasMaxLength(255);

                entity.Property(e => e.Method)
                    .HasColumnName("METHOD")
                    .HasMaxLength(255);

                entity.Property(e => e.RatePerHour)
                    .HasColumnName("RATE PER HOUR")
                    .HasColumnType("decimal(19, 0)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.Remarks)
                    .HasColumnName("REMARKS")
                    .HasMaxLength(255);

                entity.Property(e => e.State)
                    .HasColumnName("STATE")
                    .HasMaxLength(255);

                entity.Property(e => e.SubmissionStatus)
                    .IsRequired()
                    .HasColumnName("Submission Status")
                    .HasMaxLength(255)
                    .HasDefaultValueSql("\"Pending\"");

                entity.Property(e => e.VendorContactId)
                    .HasColumnName("VENDOR CONTACT ID")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.VendorId)
                    .HasColumnName("VENDOR ID")
                    .HasDefaultValueSql("0");
            });

            modelBuilder.Entity<Tmpclp498111>(entity =>
            {
                entity.ToTable("~TMPCLP498111");

                entity.HasIndex(e => e.Id)
                    .HasName("ID");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.DateScheduled).HasColumnName("Date Scheduled");

                entity.Property(e => e.SubmissionSlno)
                    .HasColumnName("Submission-SLNO")
                    .HasDefaultValueSql("0");
            });

            modelBuilder.Entity<Tmpclp654981>(entity =>
            {
                entity.ToTable("~TMPCLP654981");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Nothing)
                    .HasColumnName("nothing")
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<UpdatedList>(entity =>
            {
                entity.HasKey(e => e.Slno)
                    .HasName("SLNO");

                entity.ToTable("UPDATED LIST");

                entity.Property(e => e.Slno).HasColumnName("SLNO");

                entity.Property(e => e.AsrRecruiter)
                    .HasColumnName("ASR-RECRUITER")
                    .HasMaxLength(255);

                entity.Property(e => e.Client)
                    .HasColumnName("CLIENT")
                    .HasMaxLength(255);

                entity.Property(e => e.ClientSubmission)
                    .HasColumnName("CLIENT SUBMISSION")
                    .HasMaxLength(255);

                entity.Property(e => e.Consultant)
                    .HasColumnName("CONSULTANT")
                    .HasMaxLength(255);

                entity.Property(e => e.Date).HasColumnName("DATE");

                entity.Property(e => e.Duration).HasMaxLength(255);

                entity.Property(e => e.Feedback).HasMaxLength(255);

                entity.Property(e => e.Field17).HasMaxLength(255);

                entity.Property(e => e.Field18).HasMaxLength(255);

                entity.Property(e => e.Field19).HasMaxLength(255);

                entity.Property(e => e.Field20).HasMaxLength(255);

                entity.Property(e => e.Interviews).HasMaxLength(255);

                entity.Property(e => e.JobTitle)
                    .HasColumnName("JOB TITLE")
                    .HasMaxLength(255);

                entity.Property(e => e.LastFollowDate)
                    .HasColumnName("Last follow Date")
                    .HasMaxLength(255);

                entity.Property(e => e.Location)
                    .HasColumnName("LOCATION")
                    .HasMaxLength(255);

                entity.Property(e => e.Rate)
                    .HasColumnName("RATE")
                    .HasMaxLength(255);

                entity.Property(e => e.Recruiter)
                    .HasColumnName("RECRUITER")
                    .HasMaxLength(255);

                entity.Property(e => e.Remarks)
                    .HasColumnName("REMARKS")
                    .HasMaxLength(255);

                entity.Property(e => e.VendorCompanyName)
                    .HasColumnName("VENDOR COMPANY NAME")
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<UsStates>(entity =>
            {
                entity.ToTable("US_States");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Initials).HasMaxLength(255);

                entity.Property(e => e.Lcname)
                    .HasColumnName("LCName")
                    .HasMaxLength(255);

                entity.Property(e => e.Ucname)
                    .HasColumnName("UCName")
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<Users>(entity =>
            {
                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Password).HasMaxLength(255);

                entity.Property(e => e.Role).HasMaxLength(255);

                entity.Property(e => e.Username).HasMaxLength(255);
            });

            modelBuilder.Entity<VendorContact>(entity =>
            {
                entity.ToTable("Vendor Contact");

                entity.HasIndex(e => e.Id)
                    .HasName("ID");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.RecruiterName)
                    .HasColumnName("RECRUITER NAME")
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<Vendors>(entity =>
            {
                entity.HasIndex(e => e.Id)
                    .HasName("ID");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.VendorCompanyName)
                    .HasColumnName("VENDOR COMPANY NAME")
                    .HasMaxLength(255);
            });
        }
    }
}

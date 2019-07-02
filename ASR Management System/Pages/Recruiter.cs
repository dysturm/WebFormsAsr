using System.Collections;

namespace ASR_Management_System.Pages
{
    internal class Recruiter
    {
        public string id;
        public string name;
        static ArrayList names = new ArrayList();

        public Recruiter(string id, string name)
        {
            this.id = id;
            this.name = name;
            names.Add(name);
        }

        static bool containsName(string name)
        {
            return names.Contains(name);
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TAMUHack.Dependency
{
    public static class WebServiceCall
    {
        public static string GetColleges = "colleges.json";
        public static string GetCollegeTest = "colleges/1.json";
        public static string GetVenues(int id){
            return String.Format("colleges/{0}/venues.json",id);
        }
        public static string GetMeals(int CollegeId, int VenueId)
        {
            return String.Format("colleges/{0}/venues/{1}/meals.json", CollegeId, VenueId);
        }
    }
}

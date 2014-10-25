using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using TAMUHack.Models;

namespace TAMUHack.Dependency
{
    public interface IRestSharp
    {
        List<College> GetColleges();
        List<Venue> GetVenuesOfCollege(int id);
        List<Meal> GetMealsOfVenue(int CollegeId, int VenueId);
    }
}

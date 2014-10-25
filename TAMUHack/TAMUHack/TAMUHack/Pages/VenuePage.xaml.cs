using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using TAMUHack.Models;
using TAMUHack.Dependency;

namespace TAMUHack.Pages
{
    public partial class VenuePage
    {
        Venue venue;

        public VenuePage(Venue venue, int CollegeId)
        {
            this.venue = venue;
            Initialize(CollegeId);
            InitializeComponent();
            BindingContext = venue;
            this.ItemsSource = venue.Meals;
        }

        async void Initialize(int CollegeId)
        {
            venue.Meals = await GetMealsOfVenue(CollegeId, venue.Id);
        }

        async Task<List<Meal>> GetMealsOfVenue(int CollegId, int VenueId)
        {
            return WebService.RestService.GetMealsOfVenue(CollegId, VenueId);
        }
    }
}

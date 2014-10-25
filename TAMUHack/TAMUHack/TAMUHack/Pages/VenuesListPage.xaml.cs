using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using TAMUHack.Models;

using Xamarin.Forms;
using TAMUHack.Dependency;

namespace TAMUHack.Pages
{
    public partial class VenuesListPage
    {
        List<Venue> Venues = new List<Venue>();
        int CollegeId;

        public VenuesListPage(int id)
        {
            CollegeId = id;
            Initialize(id);
            InitializeComponent();
            VenuesListView.ItemsSource = Venues;
            VenuesListView.RowHeight = 65;
        }

        async void Initialize(int id)
        {

            try
            {
                Venues = await GetVenues(id);
            }
            catch
            {
                
            }
        }

        async void OnTextChanged(object sender, EventArgs args)
        {
            var bar = (SearchBar)sender;
            var text = bar.Text;
            await Search(text.ToLower());
        }

        void OnItemTapped(object sender, EventArgs args)
        {
            var venue = ((ListView)sender).SelectedItem as Venue;
            ((ListView)sender).SelectedItem = null;
            Navigation.PushAsync(new VenuePage(venue, CollegeId));
        }

        async Task Search(string text)
        {
            VenuesListView.ItemsSource = Venues.Where(venue => venue.Name.ToLower().Contains(text));
        }

        async Task<List<Venue>> GetVenues(int id)
        {
            return WebService.RestService.GetVenuesOfCollege(id);
        }

        
    }
}

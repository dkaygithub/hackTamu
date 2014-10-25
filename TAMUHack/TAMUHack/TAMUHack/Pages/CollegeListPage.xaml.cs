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
    public partial class CollegeListPage
    {
        List<College> Colleges = new List<College>(); 

        public CollegeListPage()
        {
            Initalize();
            InitializeComponent();
            CollegesListView.ItemsSource = Colleges;
            CollegesListView.RowHeight = 65;
        }

        async void Initalize()
        {
            try
            {
                Colleges = await PullColleges();
            }
            catch
            {

            }
        }

        async Task<List<College>> PullColleges()
        {
            return WebService.RestService.GetColleges();
        }

        void OnItemSelected(object sender, EventArgs args)
        {
            var college = ((ListView)sender).SelectedItem as College;
            var id = college.Id;
            CollegesListView.SelectedItem = null;
            Navigation.PushAsync(new VenuesListPage(id));
        }

        async void OnTextChanged(object sender, EventArgs args)
        {
            var bar = (SearchBar)sender;
            var text = bar.Text;
            await Search(text);
        }

        async Task Search(string text)
        {
            CollegesListView.ItemsSource = Colleges.Where(college => college.Name.ToLower().Contains(text.ToLower()));
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using RestSharp;
using TAMUHack.Constants;
using TAMUHack.Models;
using TAMUHack.Dependency;
using TAMUHack.Droid;


[assembly: Xamarin.Forms.Dependency(typeof(RestSharp_Droid))]
namespace TAMUHack.Droid
{
    public class RestSharp_Droid : IRestSharp
    {
        RestClient client;
        RestRequest request;

        public RestSharp_Droid()
        {
            client = new RestClient();
            request = new RestRequest();
            client.BaseUrl = Constants.Constants.ServiceURL;
        }

        public List<College> GetColleges()
        {
            request.Resource = WebServiceCall.GetColleges;
            return client.Execute<List<College>>(request).Data;
        }

        public List<Venue> GetVenuesOfCollege(int id)
        {
            request.Resource = WebServiceCall.GetVenues(id);
            return client.Execute<List<Venue>>(request).Data;
        }

        public List<Meal> GetMealsOfVenue(int CollegeId, int VenueId)
        {
            request.Resource = WebServiceCall.GetMeals(CollegeId, VenueId);
            return client.Execute<List<Meal>>(request).Data;
        }
    }
}

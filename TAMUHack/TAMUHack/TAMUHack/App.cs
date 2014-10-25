using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Xamarin.Forms;

using TAMUHack.Pages;
using TAMUHack.Models;
using TAMUHack.Dependency;

namespace TAMUHack
{
    public class App
    {
        public static Page GetMainPage()
        {
            var navPage = new NavigationPage(new CollegeListPage());
            navPage.BarBackgroundColor = Color.FromRgb(0, 48, 21);
            navPage.BarTextColor = Color.FromRgb(255, 188, 25);
            return navPage;
        }
    }
}

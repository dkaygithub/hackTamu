using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;

namespace TAMUHack.Dependency
{
    public static class WebService
    {
        public static IRestSharp RestService = DependencyService.Get<IRestSharp>();
    }
}

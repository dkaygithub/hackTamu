using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel;
using System.Runtime.CompilerServices;

using TAMUHack.Constants;

namespace TAMUHack.Models
{
    public class Venue : INotifyPropertyChanged
    {
        int _id;
        public int Id
        {
            get { return _id; }
            set { SetProperty(ref _id, value); }
        }

        string _name;
        public string Name
        {
            get { return _name; }
            set { SetProperty(ref _name, value); }
        }

        decimal _rating;
        public decimal Rating
        {
            get 
            {
                return _rating;
            }
            set { SetProperty(ref _rating, value); }
        }

        List<Meal> _meals = new List<Meal>();
        public List<Meal> Meals
        {
            get { return _meals; }
            set { SetProperty(ref _meals, value); }
        }

        public string Rating1
        {
            get { return GetRating(Rating); }
        }

        public string Rating2
        {
            get { return GetRating(Decimal.Subtract(Rating, 1.0m)); }
        }

        public string Rating3
        {
            get { return GetRating(Decimal.Subtract(Rating, 2.0m)); }
        }

        public string Rating4
        {
            get { return GetRating(Decimal.Subtract(Rating, 3.0m)); }
        }

        public string Rating5
        {
            get { return GetRating(Decimal.Subtract(Rating, 4.0m)); }
        }

        public event PropertyChangedEventHandler PropertyChanged;

        public Venue() { }

        protected virtual void OnPropertyChanged(string name)
        {
            PropertyChangedEventHandler handler = PropertyChanged;
            if (handler != null)
            {
                handler(this, new PropertyChangedEventArgs(name));
            }
        }

        bool SetProperty<T>(ref T storage, T value, [CallerMemberName] string propertyName = null)
        {
            if (Object.Equals(storage, value))
            {
                return false;
            }
            else
            {
                storage = value;
                OnPropertyChanged(propertyName);
                return true;
            }
        }

        string GetRating(decimal value)
        {
            if (value >= 1.0m)
            {
                return Constants.Constants.FullRating;
            }
            else if (value >= 0.5m)
            {
                return Constants.Constants.HalfRating;
            }
            else
            {
                return Constants.Constants.ZeroRating;
            }
        }
    }
}

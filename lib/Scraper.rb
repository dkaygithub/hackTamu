require 'nokogiri'
require 'open-uri'

SECONDS_IN_DAY = 86400
SECONDS_IN_HOUR = 3600
BASE_URL = "http://baylor.campusdish.com"

class Scraper

  #include Singleton
  @venues
  @venueScrapeTime
  @mealScrapeTime

  def confirmWorks
    return "Hello World"
  end

  def getVenues
    #if it has been > 1 day since last update, scrape for venues
    if(@venueScrapeTime.nil? || @timeSinceVenueScrape > SECONDS_IN_DAY)
      scrapeVenues
    end

    return @venues.keys
  end

  def getMeals(venue)
    #if it has been > 1 hour since last update, scrape for meals
    if(@mealScrapeTime.nil? || @timeSinceMealScrape > SECONDS_IN_HOUR)
      scrapeMeals
    end
    return @venues
  end

  def timeSinceVenueScrape
    #Time since last Venues scrape, in seconds
    timeSinceVenueScrape = (Time.now - @venueScrapeTime)/SECONDS_IN_DAY
    return timeSinceVenueScrape
  end

  def timeSinceMealScrape
    #Time since last Venues scrape, in seconds
    timeSinceMealScrape = (Time.now - @mealScrapeTime)/SECONDS_IN_HOUR
    return timeSinceMealScrape
  end

  def scrapeMeals

  end

  def scrapeVenues
    temp = Nokogiri::HTML(open(BASE_URL + "/EatWellContent/ViewMenu.aspx"))
    venueNameSelector = ".maincontent-full > div:nth-child(1) > .media >
      .mediaBody > h2"
    venueUrlSelector = ".maincontent-full > div:nth-child(1) >
      .media > .mediaBody > a"

    venueNames = temp.css(venueNameSelector).collect{|v| v = v.text.strip}
    venueURLs = temp.css(venueUrlSelector).collect{|v| v["href"]}

    @venues = Hash.new
    #venueNames.each{|v| puts v}
    venueNames.each_index do |i|
      @venues[venueNames[i]] = venueURLs[i]
    end


    @venues.each_key do |name|
      if(name.include? "Faculty")
        @venues.delete(name)
      end
    end
  end
end

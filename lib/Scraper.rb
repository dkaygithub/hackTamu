require 'nokogiri'
require 'open-uri'

SECONDS_IN_DAY = 86400
SECONDS_IN_HOUR = 3600
BASE_URL = "http://baylor.campusdish.com"
WEEKEND_HACK = "&MenuDate=2014-10-24&UIBuildDateFrom=2014-10-24"

class Scraper

  #include Singleton
  @venues
  @venueScrapeTime
  @dishScrapeTime

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

  def getDishes(venue)
    #if it has been > 1 hour since last update, scrape for dishes
    if(@dishScrapeTime.nil? || @timeSinceDishScrape > SECONDS_IN_HOUR)
      scrapeDishes
    end
    return @venues
  end

  def timeSinceVenueScrape
    #Time since last Venues scrape, in seconds
    timeSinceVenueScrape = (Time.now - @venueScrapeTime)/SECONDS_IN_DAY
    return timeSinceVenueScrape
  end

  def timeSinceDishScrape
    #Time since last Venues scrape, in seconds
    timeSinceDishScrape = (Time.now - @dishScrapeTime)/SECONDS_IN_HOUR
    return timeSinceDishScrape
  end

  def scrapeDishes
    return false if @venues.nil?

    @venues.each do |key, value|
      print "Venue: ", key, "\n"
      page = Nokogiri::HTML(open(BASE_URL + value + WEEKEND_HACK))
      page.css(".menu-period").children.each do |mealperiod|
        dishes = page.css(".menu-name").collect{|v| v.text.strip}
        if mealperiod.text == "Breakfast"
          puts "Breakfast:\n", dishes
        elsif mealperiod.text == "Lunch"
          print "Lunch:\n", dishes
        elsif mealperiod.text == "Dinner"
          print "Dinner:\n", dishes
        end
        print "\n\n"
      end
    end
  end

  def scrapeVenues
    page = Nokogiri::HTML(open(BASE_URL + "/EatWellContent/ViewMenu.aspx"))
    venueNameSelector = ".maincontent-full > div:nth-child(1) > .media >
      .mediaBody > h2"
    venueUrlSelector = ".maincontent-full > div:nth-child(1) >
      .media > .mediaBody > a"

    venueNames = page.css(venueNameSelector).collect{|v| v = v.text.strip}
    venueURLs = page.css(venueUrlSelector).collect{|v| v["href"]}

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

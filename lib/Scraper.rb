require 'nokogiri'
require 'open-uri'
require 'singleton'

SECONDS_IN_DAY = 86400
BASE_URL = "http://baylor.campusdish.com"
WEEKEND_HACK = "&MenuDate=2014-10-24&UIBuildDateFrom=2014-10-24"

class Dish
  @meal
  @venue
  @name

  def initialize(meal, venue, name)
    @meal = meal
    @venue = venue
    @name = name
  end

  def getVenue
    return @venue
  end

  def getMeal
    return @meal
  end

  def getName
    return @name
  end
end

class Scraper

  include Singleton
  @venues
  @dishes
  @venueScrapeTime
  @dishScrapeTime

  def getVenues
    #if it has been > 1 day since last update, scrape for venues
    if(@venueScrapeTime.nil? || timeSinceVenueScrape > SECONDS_IN_DAY)
      scrapeVenues
    end

    return @venues.keys
  end

  def getDishes(ven)
    #if it has been > 1 hour since last update, scrape for dishes
    if(@dishScrapeTime.nil? || timeSinceDishScrape > SECONDS_IN_DAY)
      scrapeDishes
    end

    mealNameHash = Hash.new
    @dishes.each do |v|
      if v.getVenue == ven
        mealNameHash[v.getName] = v.getMeal
      end
    end

    return mealNameHash
  end

  def timeSinceVenueScrape
    #Time since last Venues scrape, in seconds
    timeSinceVenueScrape = (Time.now - @venueScrapeTime)/SECONDS_IN_DAY
    return timeSinceVenueScrape
  end

  def timeSinceDishScrape
    #Time since last Venues scrape, in seconds
    timeSinceDishScrape = (Time.now - @dishScrapeTime)/SECONDS_IN_DAY
    return timeSinceDishScrape
  end

  def scrapeDishes
    return false if @venues.nil?
    @dishScrapeTime = Time.now
    @dishes = Array.new

    @venues.each do |key, value|
      page = Nokogiri::HTML(open(BASE_URL + value + WEEKEND_HACK))
      page.css(".menu-period").each do |mealperiod|
        mealURL = mealperiod["href"]
        dishesArray = Nokogiri::HTML(open(BASE_URL + mealURL))
        dishesArray = dishesArray.css(".menu-name").collect{|v| v.text.strip}

        dishesArray.each do |dish|
          currentDish = Dish.new(mealperiod.text, key, dish)
          @dishes.push(currentDish)
        end
      end
    end
    return @dishes
  end

  def scrapeVenues
    @venueScrapeTime = Time.now
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

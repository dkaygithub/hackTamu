require 'sendgrid-ruby'
require 'smtpapi'
load 'Scraper.rb'

  client = SendGrid::Client.new do |c|
    c.api_user = 'matttinsley'
    c.api_key = 'tamuhack14'
  end

  mail = SendGrid::Mail.new do |m|
    m.smtpapi.add_filter('templates', "enable", 1)
    m.smtpapi.add_filter('templates', "template_id", "d6d527ef-a014-4fce-b6e7-ab7fd33091c0")
    m.smtpapi.add_substitution('<%user%>', ['Friend'])
    m.smtpapi.add_to('matt.c.tinsley@gmail.com')
    m.from = "matt.c.tinsley@gmail.com"
    m.to = m.from # hack
    m.subject = 'bite digest!'
    m.text = "Breakfast, Lunch, and Dinner!"
    m.html = "<h2> Penland: </h2> <p> Pancakes </p> <p> Quesodillas </p> <h2> East Village: </h2> <p> Cheeseburgers </p> <p> Stir-Fry </p>"
  end
puts client.send(mail)

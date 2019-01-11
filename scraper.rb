require 'nokogiri'
require "open-uri"
require "byebug"

puts "what do you want to search?"
puts ">"
query = gets.chomp

url =open("https://tokyo.craigslist.org/search/jjj?query=#{query}&lang=en&cc=us")
doc = url.read
parse_doc = Nokogiri::HTML(doc)
#byebug

#puts parse_doc.css(".result-row").first.css(".result-info").css(".result-date").text

#puts parse_doc.css(".result-row").first.css(".result-info").css(".result-title").text

parse_doc.css('.result-info').each do |row|
  title     = row.css(".result-title").text
  posted_at = row.css(".result-date").text
  place     = row.css(".result-hood").text.strip
  link      = row.css(".result-title").css(".hdrlnk").first.attributes["href"].value
  puts "#{title} #{place}"
  puts "posted at: #{posted_at}"
  puts "Link: #{link}"
  puts '---------------------------------------------'
end

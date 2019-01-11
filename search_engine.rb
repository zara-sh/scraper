require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'colored'

# this is just a preview of what's to come - a proof of concept.
# it will be converted to a api-type library, gemified, and put in it's own repo
# for now, a cool way to experiment with amazon's data

query = 'ruby'
page = '2'
doc = Nokogiri::HTML(open("http://www.amazon.com/s/field-keywords=#{query}?page=#{page}"))
puts "Amazon search for '#{query}', page ##{page}\n".red.underline
doc.css('div.product').each do |el|
  # grab the title
  title = el.css('a.title').first.content
  # grab the author (can be linked or not, hence the logic)
  author = el.css('.ptBrand a').empty? ? el.css('.ptBrand').first.content.gsub!(/by /, '') : el.css('.ptBrand a').first.content
  # grab the image
  image = el.css('.productImage').attribute 'src'
  # grab the product link
  link = el.css('a.title').attribute 'href'

  puts "#{title} by #{author}".green
  puts "image url:".yellow + " #{image}"
  puts "amazon link:".yellow + " #{link}"
  puts ""
end

require "selenium-webdriver"
require 'open-uri'
require 'nokogiri'

driver = Selenium::WebDriver.for :chrome
driver.get"https://www.mizuhobank.co.jp/market/cash.html"

#url = open ("https://www.mizuhobank.co.jp/market/cash.html")
#doc = url.read

parse_doc = Nokogiri::HTML (driver.page_source)
#puts parse_doc
#
#css("td")[2].text
#puts parse_doc
#puts parse_doc.css("tr").css("td.alnRight")
puts parse_doc.css(".sp-none").css("tbody tr").css("td")[2].text

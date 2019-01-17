require "selenium-webdriver"
require 'open-uri'
require 'nokogiri'
require "byebug"

puts "Do you want to Buy or Sell?"
puts "Enter 1 if you want to buy, enter 2 if you want to sell"
query = gets.chomp

driver_mizuho = Selenium::WebDriver.for :chrome
driver_mizuho.get"https://www.mizuhobank.co.jp/market/cash.html"


mizuho_bank = Nokogiri::HTML (driver_mizuho.page_source)

mizuho_bank_j_2_f = mizuho_bank.css(".sp-none").css("tbody tr").css("td")[1]
mizuho_bank_f_2_j = mizuho_bank.css(".sp-none").css("tbody tr").css("td")[2]


 puts "From Japanese yen to foreign currency (111.47)  #{mizuho_bank_j_2_f.text}"
 puts "From foreign currency to Japanese yen (105.47)  #{mizuho_bank_f_2_j.text}"
 puts "-------------------------------"



smbc_url = open("https://www.smbc.co.jp/ex/ExchangeServlet?ScreenID=real")
smbc_bank_doc = smbc_url.read
smbc_parse = Nokogiri::HTML (smbc_bank_doc)

puts " "
puts " "
smbc_bank_j_2_f = smbc_parse.css('td')[2]
smbc_bank_f_2_j= smbc_parse.css('td')[1]
puts "From Japanese yen to foreign currency #{smbc_bank_j_2_f.text}"
puts "----------------------------------------"
puts "From foreign currency to Japanese yen #{smbc_bank_f_2_j.text}"

gpa_url = open("https://www.gpa-net.co.jp/en/passenger-service/rate/")
gpa_doc = gpa_url.read
parse_gpa = Nokogiri::HTML(gpa_doc)

puts " "
puts " "
gpa_f_2_j = parse_gpa.css("td.table-td3")[0]
gpa_j_2_f = parse_gpa.css("td.table-td4")[0]

puts "From Japanese yen to foreign currency #{gpa_j_2_f.text}"
puts "----------------------------------------"
puts "From foreign currency to Japanese yen #{gpa_f_2_j.text}"


mufg_url = open("https://www.bk.mufg.jp/gdocs/kinri/list_j/kinri/kawase.html#")
mufg_doc = mufg_url.read
parse_mufg = Nokogiri::HTML(mufg_doc)

puts " "
puts " "
mufg_f_2_j = parse_mufg.css("tr.tb-bg0")[1].css("td")[8]
mufg_j_2_f = parse_mufg.css("tr.tb-bg0")[1].css("td")[5]
puts "From Japanese yen to foreign currency #{mufg_j_2_f.inner_text}"
puts "From foreign currency to Japanese yen #{mufg_f_2_j.inner_text}"



f_2_j = {mizuho_sell: mizuho_bank_f_2_j.text.to_f , smbc_sell: smbc_bank_f_2_j.text.to_f , gpa_sell: gpa_f_2_j.text.to_f  , mufg_sell: mufg_f_2_j.text.to_f }
#sell = f_2_j.max
j_2_f = {mizujo_buy: mizuho_bank_j_2_f.text.to_f  , smbc_buy: smbc_bank_j_2_f.text.to_f , gpa_buy: gpa_j_2_f.text.to_f , mufg_buy: mufg_j_2_f.text.to_f }
#buy = j_2_f.min

sell = f_2_j.select {|k,v|  v if v == f_2_j.values.max}
buy  = j_2_f.select {|k,v|  v if v == j_2_f.values.min}



if query === 1
  puts "you can buy at #{buy.values.first} price in #{buy.keys.to_s} bank"
else
  puts "you can sell at #{sell.values.first} price in #{sell.keys.to_s} bank"
end


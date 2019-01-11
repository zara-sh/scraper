require "selenium-webdriver"
#Selenium::WebDriver::Chrome::Service.executable.path('c:/documents')
driver = Selenium::WebDriver.for :chrome
driver.navigate.to"https://www.mizuhobank.co.jp/market/cash.html"
wait = Selenium::WebDriver::Wait.new(:timeout => 2)
usd = wait.until{
  element_1 = driver.find_element(:class,"td.alnRight")
}
puts usd.text

driver.quit

# scraper

Before doing anything make sure the gem selenium-webdriver is installed.

-gem install selenium-webdriver
-bundle install

The first thing is to run a webdriver. Selenium by default supports Mozilla Firefox browser and in case you want to run the webdriver in chrome, you can simply do it in two steps:

Download the latest version of ChromeDriver server. And then copy the chromedriver into the bin directory to run the webdriver perfectly in chrome.

-require "selenium-webdriver"/b
-driver = Selenium::WebDriver.for :chrome
-driver.navigate.to "https://..."/b
-doc = Nokogiri::HTML(driver.page_source)


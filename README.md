# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version - ruby-2.3.4

* System dependencies - for test:system driven_by :selenium, using: :firefox -> download driver at https://github.com/mozilla/geckodriver/releases

* Configuration - standard

* Database creation - none

* Database initialization - none

* How to run the test suite - bin/rails test &&  bin/rails test:system

* https://github.com/kjakub/josef/blob/master/config/secrets.yml contain airbnb cookie which makes USD currency returned from their api, otherwise CZK is returned and comparison will not work in that case !!

* i was trying to do 100% system test and interact with google place automplete purely with vanilla JS via capybara (2.5h), however i could not figure out how to select place from the dropdown via JS (events, clicks, keydowns, keypress etc...), so i need to fake it a little. https://github.com/kjakub/josef/blob/master/test/system/searches_test.rb if you know how, let me know!

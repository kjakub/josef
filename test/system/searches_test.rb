require "application_system_test_case"

class SearchesTest < ApplicationSystemTestCase
  test "searching" do
    visit root_url
    assert_selector "label", text: "Location"
    fill_in "rental[location]", with: "Prague"
    fill_in "rental[price]", with: "30"

    # page.execute_script %Q{ document.getElementById("rental_lat").value = "50.10179100000001" }
    # page.execute_script %Q{ document.getElementById("rental_lng").value = "14.263181099999997" }

    # page.execute_script %Q{ document.getElementById("rental_location").dispatchEvent(new Event('focus')); }
    # page.execute_script %Q{ document.getElementsByClassName("pac-item")[0].click() }
    
    page.execute_script %Q{
        
        // fake google place object to be selected
        var place = new Object;
        place["geometry"] = new Object;
        place.geometry["location"] = new Object({lat: function(){return 20.5}, lng: function(){return 30.5}});
        autocomplete.set("place",place);

    }

    click_on "Search"
    assert_selector "p", text: "Success"
  end
end

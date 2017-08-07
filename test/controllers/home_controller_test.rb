require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get home_index_url
    assert_response :success
  end

  test "is should search with valid params" do
    get home_search_url, params: {"utf8"=>"✓", "rental"=>{"location"=>"Kladno, Czechia", "price"=>"23.4", "lat"=>"50.1416986", "lng"=>"14.106746499999986"}, "commit"=>"Search"}
    assert_response :success 	
  end

  test "is should success even without missing value and display form error" do
    get home_search_url, params: {"utf8"=>"✓", "rental"=>{"location"=>"Kladno, Czechia", "price"=>"", "lat"=>"50.1416986", "lng"=>"14.106746499999986"}, "commit"=>"Search"}
    assert_response :success 	
  end

end

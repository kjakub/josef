require 'test_helper'

class RentalTest < ActiveSupport::TestCase
  test "it should not be valid" do
  	rental = Rental.new(price: 30, location: "Prague")
    assert_not rental.valid?
  end

  test "it should perform bnb evaluation" do
  	rental = Rental.new(price: 30, location: "Prague", lat: 30, lng: 50)
    rental.bnb_evaluate
    assert_equal rental.errors.count, 0
    assert_not_empty rental.result
  end

end

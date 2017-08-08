class Rental
  include ActiveModel::Validations
  include ActiveModel::Model
  attr_accessor :location, :price, :lat, :lng, :result
  validates :location, :price, :lat, :lng, presence: true


  def bnb_evaluate
    begin
      # cookie needed to get result in USD
      cookie = Rails.application.secrets.bnb_cookie
      url = "xxhttps://www.airbnb.com/wmpw_data?page=slash_host&duration=1_month&person_capacity=1&room_type=entire_home_apt&loading=false&sw_lat=#{self.lat}&sw_lng=#{self.lng}&ne_lat=#{self.lat}&ne_lng=#{self.lng}"
      http_result =  HTTP.headers("accept" => "application/json", "accept-language" => "en-US,en;q=0.8,cs;q=0.6").cookies(:session_cookie => cookie).get(url)
      json_result = JSON.parse(http_result)
      # "earning_estimation_duration":"1_week" is wrong their api response setting &duration=1_month just works
      diff = self.price.to_f - json_result["data"]["average_income_raw"].to_f
      if(diff > 0)
        self.result = "Rental through AirBnB is not worth. #{diff.abs.round(2)} USD less per month"
      elsif(diff < 0)
        self.result = "Think about renting through AirBnB you could make #{diff.abs.round(2)} USD more per month"
      else
        self.result = "Rental through AirBnB is the equal"
      end
    rescue StandardError => e
      self.errors.add(:base, "Problem with AirBnB evaluation")
    end
  end
end
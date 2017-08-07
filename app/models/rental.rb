class Rental
  include ActiveModel::Validations
  include ActiveModel::Model
  attr_accessor :location, :price, :lat, :lng, :result
  validates :location, :price, :lat, :lng, presence: true


  def bnb_evaluate
    begin
      # cookie needed to get result in USD
      cookie = "p3_pdp_ia_reduce_redundancy=treatment; p3_pdp_ia_consolidate=treatment; p3_pdp_ia_location=control; p3_pdp_ia_nav=control; ftv=1499874049961; __ssid=067104bb-259c-4a43-9ba2-2a4c4d15381d; fbm_138566025676=base_domain=.airbnb.com; _csrf_token=V4%24.airbnb.com%24CdzVq2EDlJs%24a7f3JCJOHiXxeJ6ujCwZqGG3Sm0Ie6WvPDVc-DIzTvw%3D; abb_fa2=%7B%22user_id%22%3A%227%7C1%7CekH1%2BDkgU2KG9VsgiV1l8p4rgc%2BU9KAiQNTlG5S33lP2tGNRHgmqwQ%3D%3D%22%7D; _airbed_session_id=1d3c0c0b460e9e62b9259da701006110; hli=1; sdid=; _pt=1--WyJmMTQwMWQ5MzVjMDUzNmE5NjE0NGI3MWE1ZDk5ZjdhMjNmZGM0YmJkIl0%3D--608744b939b02208512e6698cd568b10948cabd2; has_logged_out=true; flags=268435456; cbkp=3; fblo_138566025676=y; _user_attributes=%7B%22curr%22%3A%22USD%22%2C%22guest_exchange%22%3A1.0%2C%22device_profiling_session_id%22%3A%221502103339--479308ebee2d0a3daaea4e9d%22%2C%22giftcard_profiling_session_id%22%3A%221502103339--b2afef8db50eff08f6c660b6%22%2C%22reservation_profiling_session_id%22%3A%221502103339--74e572470eee2a7c6c84bc02%22%7D; _ga=GA1.2.876726509.1499874048; _gid=GA1.2.1017587949.1502103345; __insp_wid=965988720; __insp_slim=1502103347621; __insp_nv=true; __insp_targlpu=aHR0cHM6Ly93d3cuYWlyYm5iLmNvbS9ob3N0L2hvbWVz; __insp_targlpt=UmVudCBPdXQgWW91ciBSb29tLCBIb3VzZSBvciBBcGFydG1lbnQgb24gQWlyYm5iICgyMDE3KQ%3D%3D; _uetsid=_ueta0bae69b; __insp_norec_sess=true; bev=1499874044_x2G5dzPTmh7IaHZJ"
      url = "https://www.airbnb.com/wmpw_data?page=slash_host&duration=1_month&person_capacity=1&room_type=entire_home_apt&loading=false&sw_lat=#{self.lat}&sw_lng=#{self.lng}&ne_lat=#{self.lat}&ne_lng=#{self.lng}"
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
    rescue Exception => error
      self.errors.add(:base, "Problem with BnB evaluation")
    end
  end
end
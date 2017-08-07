class HomeController < ApplicationController
  
  def index
    @rental = Rental.new
  end

  def search
    @rental = Rental.new(rental_params)
     
    if @rental.valid?
      @rental.bnb_evaluate
    end
    
    render 'index'

  end
 
  private
  
  def rental_params
    params.require(:rental).permit(:location, :price, :lat, :lng)
  end

end
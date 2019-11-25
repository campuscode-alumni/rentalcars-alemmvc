class RentalPricesController < ApplicationController
  before_action :authorize_admin, only: %i[new create]

  def index
    @subsidiaries = Subsidiary.all
  end

  def new
    @subsidiary = Subsidiary.find(params[:id])
    @categories = Category.all
    @rental_prices = {}
    @categories.each do |category|
      rental_price = RentalPrice.where(category: category, subsidiary: @subsidiary).last
      @rental_prices[category] = rental_price if rental_price
    end
  end

  def create
    @subsidiary = Subsidiary.find(params[:id])
    params['rental_prices'].each do |key, values|
      @rental_price =  RentalPrice.new(rental_price_params(values))
      @rental_price.subsidiary = @subsidiary
      if !@rental_price.save
        @categories = Category.all
        @rental_prices = {}
        @categories.each do |category|
          rental_price = RentalPrice.where(category: category, subsidiary: @subsidiary).last
          @rental_prices[category] = rental_price if rental_price
        end
        @messages = @rental_price.errors.full_messages
        return render :new
      end
    end
    redirect_to rental_prices_path
  end

  private

  def rental_price_params(price_params)
    price_params.permit(:daily_rate, :daily_car_insurance,
                        :daily_third_party_insurance,
                        :category_id)
  end
end

class PricesController < ApplicationController

  def index
    @prices = Price.all
  end

  def new
    @price = Price.new()
    @subsidiaries = Subsidiary.all
    @categories = Category.all
  end

  def create
    @price = Price.new(price_params)
    return redirect_to @price if @price.save

    @subsidiaries = Subsidiary.all
    @categories = Category.all
    render :new
  end

  def show
    @price = Price.find(params[:id])
  end

  private
  def price_params
    params.require(:price).permit(%i[daily_rate subsidiary_id category_id])
  end

end
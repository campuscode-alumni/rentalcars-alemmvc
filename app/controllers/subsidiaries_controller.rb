class SubsidiariesController < ApplicationController
before_action :authorize_admin

  def index
    @subsidiaries = Subsidiary.all
  end

  def show
    @subsidiary = Subsidiary.find(params[:id])
    @categories = Category.all
    @rental_prices = []
    @categories.each do |category|
      @rental_prices << RentalPrice.where(category: category, subsidiary: @subsidiary).last
    end
  end

  def new
    @subsidiary = Subsidiary.new
    @subsidiary.build_address
  end

  def create
    @subsidiary = Subsidiary.new(subsidiary_params)
    @categories = Category.all
    @categories.each do |category|
      RentalPrice.create!(category: category, subsidiary: @subsidiary,
                         daily_rate: category.daily_rate,
                         daily_car_insurance: category.car_insurance,
                         daily_third_party_insurance: category.third_party_insurance)
    end
    return redirect_to @subsidiary if @subsidiary.save

    render :new
  end

  def edit
    @subsidiary = Subsidiary.find(params[:id])
    @address = Address.all
  end

  def update
    @subsidiary = Subsidiary.find(params[:id])
    @address = Address.all
    if @subsidiary.update(subsidiary_params)
      redirect_to @subsidiary
    else
      render :edit
    end
  end

  private

  def subsidiary_params
    params.require(:subsidiary)
      .permit(:name, :cnpj, address_attributes: %i[id street number complement
              neighborhood city state])
  end
end

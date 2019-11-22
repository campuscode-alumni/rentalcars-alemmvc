class CategoriesController < ApplicationController
  before_action :authorize_admin

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      Subsidiary.all.each do |subsidiary|
        RentalPrice.create!(category: @category, subsidiary: subsidiary,
                            daily_rate: @category.daily_rate,
                            daily_car_insurance: @category.car_insurance,
                            daily_third_party_insurance:
                            @category.third_party_insurance)
      end
      redirect_to categories_path
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    return redirect_to categories_path if @category.update(category_params)

    render :edit
  end

  private

  def category_params
    params.require(:category).permit(:name, :daily_rate, :car_insurance,
                                     :third_party_insurance)
  end
end

class CarsController < ApplicationController
  before_action :authenticate_user!

  def new
    @car = Car.new
    @car_models = CarModel.all
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      redirect_to @car
    else
      @car_models = CarModel.all
      render :new
    end
  end

  def show
    @car = Car.find(params[:id])
  end

  private

  def car_params
    params.require(:car).permit(%i[car_model_id car_km color license_plate])
  end
end

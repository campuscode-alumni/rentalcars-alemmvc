class InsurancesController < ApplicationController
  before_action :authorize_admin, only: %i[new create]

  def index
    @categories = Category.all
  end

  def new
    @categories = Category.all
    @insurance = Insurance.new
  end

  def create
    @insurance = Insurance.new(insurante_params)
    if @insurance.save
      redirect_to insurances_path
    else
      render :new
    end
  end

  private
  def insurante_params
    params.require(:insurance).permit(:name, :category_id, :daily_rate)
  end
end


class RentalsController < ApplicationController
  def index
    @rentals = Rental.where(subsidiary: current_subsidiary)
  end

  def new
    @rental = Rental.new
    @clients = Client.all
    @categories = Category.all
  end

  def create
    @rental = Rental.new(rental_params)
    subsidiary = current_subsidiary
    category = Category.find(params['rental']['category_id'])
    @rental.subsidiary = subsidiary
    @rental.status = :scheduled
    @rental.price_projection = @rental.calculate_price_projection
    if @rental.save
      redirect_to rental_path(@rental.id)
    else
      @clients = Client.all
      @categories = Category.all
      render :new
    end
  end

  def show
    @rental = Rental.find(params[:id])
  end

  private

  def rental_params
    params.require(:rental).permit(:category_id, :client_id, :start_date,
                                   :end_date)
  end
end

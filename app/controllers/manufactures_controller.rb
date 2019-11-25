class ManufacturesController < ApplicationController
  before_action :authorize_admin

  def index
    @manufactures = Manufacture.all
  end

  def new
    @manufacture = Manufacture.new
  end

  def create
    @manufacture = Manufacture.new(manufacture_params)
    if @manufacture.save
      redirect_to @manufacture
    else
      render :new
    end
  end

  def show
    @manufacture = Manufacture.find(params[:id])
  end

  def edit
    @manufacture = Manufacture.find(params[:id])
  end

  def update
    @manufacture = Manufacture.find(params[:id])
    if @manufacture.update(manufacture_params)
       redirect_to @manufacture
    else
      render :edit
    end
  end
  
  private

  def manufacture_params
    params.require(:manufacture).permit(:name)
  end
end

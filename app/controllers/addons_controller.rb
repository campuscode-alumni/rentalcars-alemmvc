class AddonsController < ApplicationController
  before_action :set_addon, only: %i[edit update]

  def index
    @addons = Addon.all
  end

  def new
    @addon = Addon.new
  end

  def edit; end

  def create
    @addon = Addon.new(addon_params)

    return redirect_to addons_path, notice: t('.notice') if @addon.save

    render :new
  end

  def update
    if @addon.update(addon_params)
      return redirect_to addons_path, notice: t('.notice')
    end

    render :edit
  end

  private

  def set_addon
    @addon = Addon.find(params[:id])
  end

  def addon_params
    params.require(:addon).permit(:name, :description, :photo)
  end
end

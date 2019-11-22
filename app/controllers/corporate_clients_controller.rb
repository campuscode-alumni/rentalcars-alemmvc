class CorporateClientsController < ApplicationController
  before_action :authenticate_user!

  def index
    @corporate_clients = CorporateClient.all
  end

  def show
    @corporate_client = CorporateClient.find(params[:id])
  end

  def new
    @corporate_client = CorporateClient.new
    @corporate_client.build_address
  end

  def create
    @corporate_client = CorporateClient.new(corporate_client_params)
    if @corporate_client.save
      redirect_to @corporate_client
    else
      render :new
    end
  end

  def edit
    @corporate_client = CorporateClient.find(params[:id])
  end

  def update
    @corporate_client = CorporateClient.find(params[:id])
    if @corporate_client.update(corporate_client_params)
      redirect_to @corporate_client
    else
      render :edit
    end
  end

  private

  def corporate_client_params
    params.require(:corporate_client)
      .permit(:trade_name, :cnpj, :email, address_attributes: %i[id street number complement
              neighborhood city state])
  end
end

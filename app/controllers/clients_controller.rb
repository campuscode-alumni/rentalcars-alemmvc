class ClientsController < ApplicationController
  before_action :authenticate_user!

  def new
    @client = Client.new
    @client.build_address
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to @client
    else
      render :new
    end
  end
  
  def show
    @client = Client.find(params[:id])
  end

  private

  def client_params
    params.require(:client).
           permit(:name, :cnpj, :cpf, :email, :type, address_attributes: %i[id street number
                  complement neighborhood city state])
  end
end

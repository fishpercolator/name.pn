class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client, only: %i[destroy]
  
  def create
    @client = Client.new(user: current_user)
    authorize @client
    @client.assign_attributes(permitted_attributes @client)
    @client.save!
    flash[:new_key] = @client.generate_token
    redirect_to edit_user_registration_path
  end
  
  def destroy
    @client.destroy!
    redirect_to edit_user_registration_path, notice: t('.destroyed')
  end
  
  protected 
  
  def set_client
    @client = Client.find(params[:id])
    authorize @client
  end
end

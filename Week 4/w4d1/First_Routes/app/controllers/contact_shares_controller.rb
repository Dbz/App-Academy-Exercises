class ContactSharesController < ApplicationController
  def create
    @contact_share = ContactShare.new(contact_params)
    if @contact_share.save!
      render json: @contact_share
    else
      render json: @contact_share.errors.full_messages, status: :unprocessable_entity
    end
  end
  
  def destroy
    @contact_share = ContactShare.find(params[:id])
    if @contact_share.delete
      render json: @contact_share
    else
      render json: @contact_share.errors.full_messages, status: :internal_server_error
    end
  end
  
  private
  def contact_shares_params
    params.require(:contact_share).permit(:contact_id, :user_id)
  end
end
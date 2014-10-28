class ContactsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    render json: {
      contacts: @user.contacts,
      shared_contacts: @user.shared_contacts
    }
  end
  
  def create
    @contact = Contact.new(contact_params)
    if @contact.save!
      render json: @contact
    else
      render json: @contact.errors.full_messages, status: :unprocessable_entity
    end
  end
  
  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      redirect_to contact_url(@contact), status: 303
    else
      render json: @contact.errors.full_messages, status: :internal_server_error
    end
  end
  
  def show
    @contact = Contact.find(params[:id])
    render json: @contact
  end
  
  def destroy
    @contact = Contact.find(params[:id])
    if @contact.delete
      render json: "You deleted me :`["
    else
      render json: @contact.errors.full_messages, status: :internal_server_error
    end
  end
  
  private
  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end
end
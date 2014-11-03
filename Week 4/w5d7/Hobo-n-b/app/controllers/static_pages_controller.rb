class StaticPagesController < ApplicationController
  
  def home
  end
  
  def contact
  end
  
  def create_contact_message
    @contact = Contact.new(contact_params)
    unless @contact.save
      flash.now[:errors] = @contact.errors.full_messages
    else
      flash.now[:success] = ["Success. We will never respond to your message"]
    end
    render :contact
  end
  
  def about
  end
  
  def contact_params
    params.require(:contact).permit(:name, :email, :subject, :message)
  end
  
end

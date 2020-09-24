class MailingListController < ApplicationController
  before_action :authenticate_user!
  skip_after_action :verify_authorized
  
  def show
    render partial: 'mailing_list_form'
  end
  
  def unsubscribe
    current_user.unsubscribe_from_mailing_list!
    respond_to do |format|
      format.js { render 'rerender' }
    end
  end
  
  def subscribe
    current_user.subscribe_to_mailing_list!
    respond_to do |format|
      format.js { render 'rerender' }
    end
  end
  
end

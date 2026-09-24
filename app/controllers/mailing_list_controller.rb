class MailingListController < ApplicationController
  before_action :authenticate_user!
  skip_after_action :verify_authorized
  
  def show
  end
  
  def unsubscribe
    current_user.unsubscribe_from_mailing_list!
    render Views::MailingList::Show.new
  end
  
  def subscribe
    current_user.subscribe_to_mailing_list!
    render Views::MailingList::Show.new
  end
  
end

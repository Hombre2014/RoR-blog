class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!

  private

  def authenticate_user
    unless user_signed_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_user_registration_url # halts request cycle
    end
  end
end

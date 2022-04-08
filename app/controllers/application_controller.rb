class ApplicationController < ActionController::Base
  def current_user
    User.find(6)
  end

  helper_method :current_user
end

class ApplicationController < ActionController::Base
  def current_user
    User.find(5)
  end

  helper_method :current_user
end

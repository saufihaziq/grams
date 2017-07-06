class ApplicationController < ActionController::Base
  require 'time_ago_in_words'
  protect_from_forgery with: :exception
    
  helper_method :current_user
  #makes the controllers methods available to the view.
  private

  def current_user
    if session[:user]
      @current_user ||= User.find_by_id(session[:user])
    end
  end
  
end

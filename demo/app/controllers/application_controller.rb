class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :pagify_reload

  def pagify_reload
    Pagify.reload if Rails.env.development?
  end

end

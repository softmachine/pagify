module Pagify::CategorizationsHelper
  def pagify_get_stored_location(default=nil,keep=true)
    location = session[:pagify_return_to] || default || request.referrer
    session[:pagify_return_to] = nil unless keep

    location
  end

end

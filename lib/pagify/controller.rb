module Pagify
  module Controller
    def pagify_store_location(location=nil)
      location ||= request.url
      session[:pagify_return_to] = location
    end

    def pagify_rdr_to_stored(default=nil)
      redirect_to pagify_get_stored
    end

    def pagify_get_stored(default=nil)
      location = session[:pagify_return_to] || default || request.referrer
      session[:pagify_return_to] = nil
      location
    end

    def page_class
      Pagify::Config.page_model.constantize
    end

    def category_class
      Pagify::Config.category_model.constantize
    end

  end
end

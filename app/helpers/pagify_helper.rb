module PagifyHelper
  def pagify_get_stored_location(default=nil,keep=true)
    location = session[:pagify_return_to] || default || request.referrer
    session[:pagify_return_to] = nil unless keep

    location
  end

  def pages_list ()
    each_page do |page|
      content_tag (:li) do
        link_to(page.name, page_path(page.name))
      end
    end
  end

  def each_page (&block)
    Page.find_each do |page|
      concat(capture(page, &block))
    end
  end


end

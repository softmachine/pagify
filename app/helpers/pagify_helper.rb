module PagifyHelper
  def pagify_get_stored_location(default=nil,keep=true)
    location = session[:pagify_return_to] || default || request.referrer
    session[:pagify_return_to] = nil unless keep

    location
  end

  def pagify_page_class
    Pagify::Config.page_model.constantize
  end

  def pagify_category_class
    Pagify::Config.category_model.constantize
  end

  def pagify_pages_list (category=nil)
    html = pagify_each_page(category) do |page|
      content_tag (:li) do
        link_to(page.name, page_path(page.name))
      end
    end

    html.html_safe
  end

  def pagify_each_page (category, &block)
    pages = pagify_category_class.find_by_name(category).pages if category
    pages ||= pagify_page_class.all

    html = ""
    pages.each do |page|
      html += capture(page, &block)
    end

    html
  end


end

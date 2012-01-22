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
    result = pagify_each_page(category) do |page|
      content_tag (:li) do
        link_to(page.name, page_path(page.name))
      end
    end

    return result
  end

  def pagify_each_page (category=nil, &block)
    pages = pagify_page_class.all unless category
    
    if (category) 
      cat = pagify_category_class.find_by_name(category)
      pages = cat.pages if cat ;
    end
    
    if (pages)
      result = pages.collect do |page|
        block.call(page)
      end
    end  

    return '' unless result
    return result.join.html_safe
  end

  def is_category?(category_name)
    cat = pagify_category_class.find_by_name(category_name)
    return cat.pages.size > 0 if cat

    false
  end


end

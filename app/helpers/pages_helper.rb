module PagesHelper

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

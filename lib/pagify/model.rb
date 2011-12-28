
module Pagify
  module Model
    def pagify_page?
      false
    end

    def pagify_category?
      false
    end

    def pagify_category
      include Pagify::CategoryModel
    end

    def pagify_page
      include Pagify::PageModel
    end
  end
end

ActiveRecord::Base.extend Pagify::Model

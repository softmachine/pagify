class Pagify::Page < ActiveRecord::Base
  self.table_name='pages'
  pagify_page
end

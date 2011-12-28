class Pagify::Category < ActiveRecord::Base
  self.table_name='categories'
  pagify_category
end

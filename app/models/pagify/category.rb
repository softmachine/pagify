class Pagify::Category < ActiveRecord::Base
  self.table_name = 'pagify_categories'

  validates :name,  :presence => true
end

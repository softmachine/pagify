class Pagify::Page < ActiveRecord::Base
  self.table_name = 'pagify_pages'

  validates :name,  :presence => true
  validates :title, :presence => true, :length => { :minimum => 5 }
end

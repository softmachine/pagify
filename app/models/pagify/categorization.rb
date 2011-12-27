class Pagify::Categorization < ActiveRecord::Base
  self.table_name= "pagify_categorizations"

  belongs_to :page, :class_name => 'Page'
  belongs_to :category, :class_name => 'Category'

  validates_uniqueness_of :page_id, :scope => :category_id
  validates :page,  :presence => true
  validates :category,  :presence => true

end

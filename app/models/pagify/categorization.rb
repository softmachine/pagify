class Pagify::Categorization < ActiveRecord::Base
  self.table_name= "pagify_categorizations"

  belongs_to :page, :class_name => Pagify::Config.page_model
  belongs_to :category, :class_name => Pagify::Config.category_model

  validates_uniqueness_of :page_id, :scope => :category_id
  validates :page,  :presence => true
  validates :category,  :presence => true

end

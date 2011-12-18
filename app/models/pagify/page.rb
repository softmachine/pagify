class Pagify::Page < ActiveRecord::Base
  self.table_name = 'pagify_pages'

  has_many :categorizations, :class_name => 'Pagify::Categorization', :foreign_key => "page_id", :dependent => :destroy
  has_many :categories, :class_name => 'Pagify::Category', :through => :categorizations

  validates :name,  :presence => true, :uniqueness => true
  validates :title, :presence => true, :length => { :minimum => 5 }

  def self.not_associated ()
    Pagify::Page.all(:include => :categories, :conditions => ['pagify_categories.id IS ?', nil])
  end

  def self.not_associated_with (page)
    Pagify::Page.all(:include => :categories,
      :conditions => ['page_id IS ? OR page_id NOT IN (SELECT pagify_categorizations.page_id from pagify_categorizations WHERE category_id == ?)', nil, page.id])
  end
end

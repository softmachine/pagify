class Pagify::Category < ActiveRecord::Base
  self.table_name = 'pagify_categories'

  has_many :categorizations, :class_name => 'Pagify::Categorization', :foreign_key => "category_id",
           :order => "position DESC",
           :dependent => :destroy

  has_many :pages, :class_name => 'Pagify::Page', :through => :categorizations,
           :order => "position DESC"

  accepts_nested_attributes_for :categorizations,:allow_destroy => true

  validates :name,  :presence => true, :uniqueness => true

  def self.not_associated ()
    Pagify::Category.all(:include => :pages, :conditions => ['pagify_pages.id IS ?', nil])
  end

  def self.not_associated_with (page)
    Pagify::Category.all(:include => :pages,
      :conditions => ['category_id IS ? OR category_id NOT IN (SELECT pagify_categorizations.category_id from pagify_categorizations WHERE page_id == ?)', nil, page.id])
  end

end

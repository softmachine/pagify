module Pagify
  module CategoryModel
    extend ActiveSupport::Concern

    included do
      has_many :categorizations, :class_name => 'Pagify::Categorization', :foreign_key => "category_id",
                 :order => "position DESC",
                 :dependent => :destroy

      has_many :pages, :class_name => Pagify::Config.page_model, :through => :categorizations,
                 :order => "position DESC"

      accepts_nested_attributes_for :categorizations, :allow_destroy => true

      validates :name, :presence => true, :uniqueness => true
    end

    module ClassMethods
      def pagify_category?
        true
      end

      def not_associated ()
        self.all(:include => :pages, :conditions => ['pages.id IS ?', nil])
      end

      def not_associated_with (page)
        self.all(:include => :pages,
          :conditions => ['category_id IS ? OR category_id NOT IN (SELECT pagify_categorizations.category_id from pagify_categorizations WHERE page_id == ?)', nil, page.id])
      end
    end

    # instance methods go here...

    #write title only if different from name
    def title
      read_attribute(:title) || name
    end
    def title=(t)
      write_attribute(:title, t) if t != name
    end
  end
end
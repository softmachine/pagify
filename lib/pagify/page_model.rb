module Pagify
  module PageModel
    extend ActiveSupport::Concern

    included do
      if Pagify::Config.use_friendly_id
        extend FriendlyId
        friendly_id :name
      end

      has_many :categorizations, :class_name => 'Pagify::Categorization', :foreign_key => "page_id", :dependent => :destroy
      has_many :categories, :class_name => Pagify::Config.category_model, :through => :categorizations

      accepts_nested_attributes_for :categorizations, :allow_destroy => true

      validates :name,  :presence => true, :uniqueness => true
      validates :title, :presence => true, :length => { :minimum => 5 }
    end

    module ClassMethods
      def pagify_page?
        true
      end



      def not_associated ()
        Pagify::Config.page_model.constantize.all(:include => :categories, :conditions => ['categories.id IS ?', nil])
      end

      def not_associated_with (page)
          all(:include => :categories,
            :conditions => ['page_id IS ? OR page_id NOT IN (SELECT pagify_categorizations.page_id from pagify_categorizations WHERE category_id == ?)', nil, page.id])
      end
    end

    # instance methods will go here...
  end
end
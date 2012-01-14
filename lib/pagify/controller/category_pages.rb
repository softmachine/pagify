module Pagify
  module Controller
    module CategoryPages
      extend ActiveSupport::Concern

      included do
        include Pagify::Controller::Base
        self.pagify_view_type = "categories"
      end

      module ClassMethods
      end

      def add_pages
        @category = category_class.find(params[:category_id])
        raise "category not found (#{params[:category_id]})" unless @category
        @pages =  page_class.not_associated_with(@category)
        pagify_store_location request.referrer
      end

      def update_added_pages
        @category = category_class.find(params[:category_id])
        raise "category not found (#{params[:category_id]})" unless @category

        selected_pages = params[:category][:page_ids]  if params[:category]
        pg = page_class.find(selected_pages) if selected_pages
        @category.pages << pg if pg

        respond_to do |format|
          if @category.save
            format.html { redirect_to pagify_get_stored, notice: 'category page(s) added.' }
            format.json { head :ok }
          else
            format.html { render action: "add_pages" }
            format.json { render json: @category.errors, status: :unprocessable_entity }
          end
        end
      end

      def remove_pages
        @category = category_class.find(params[:category_id])
        raise "category not found (#{params[:category_id]})" unless @category
        @pages =  @category.pages
        pagify_store_location request.referrer
      end

      def update_removed_pages
        @category = category_class.find(params[:category_id])
        raise "category not found (#{params[:category_id]})" unless @category

        selected_pages = params[:category][:page_ids]  if params[:category]
        pg = page_class.find(selected_pages) if selected_pages
        @category.pages.delete(pg) if pg

        respond_to do |format|
          if @category.save
            format.html { redirect_to pagify_get_stored, notice: 'category page(s) removed.' }
            format.json { head :ok }
          else
            format.html { render action: "add_pages" }
            format.json { render json: @category.errors, status: :unprocessable_entity }
          end
        end
      end


      def edit_pages
        @category = category_class.find(params[:category_id])
        raise "category not found (#{params[:category_id]})" unless @category
      end

      def update_pages
        @category = category_class.find(params[:category_id])
        raise "category not found (#{params[:category_id]})" unless @category
      end

      def destroy
        @category = category_class.find(params[:category_id])
        raise "category not found (#{params[:category_id]})" unless @category
        @page = page_class.find(params[:id])
        raise "page not found (#{params[:id]})" unless @page

        @category.pages.delete(@page)

        respond_to do |format|
          if @category.save
            format.html { redirect_to :back, notice: 'page removed from category.' }
            format.json { head :ok }
          else
            format.html { render action: "edit_pages" }
            format.json { render json: @category.errors, status: :unprocessable_entity }
          end
        end
      end
    end # PageCategories
  end  # Controller
end #Pagify
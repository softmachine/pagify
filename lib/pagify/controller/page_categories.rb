module Pagify
  module Controller
    module PageCategories
      extend ActiveSupport::Concern

      included do
        include Pagify::Controller::Base
        self.pagify_view_type = "pages"
      end

      module ClassMethods
      end

      def add_categories
        @page = page_class.find(params[:page_id])
        raise "page not found (#{params[:page_id]})" unless @page
        @categories = category_class.not_associated_with(@page)
        pagify_store_location request.referrer
      end

      def remove_categories
        @page = page_class.find(params[:page_id])
        raise "page not found (#{params[:page_id]})" unless @page
        @categories = @page.categories
        pagify_store_location request.referrer
      end

      def update_added_categories
        @page = page_class.find(params[:page_id])
        raise "page not found (#{params[:page_id]})" unless @page

        selected_categories = params[:page][:category_ids]  if params[:page]
        cats = category_class.find(selected_categories) if selected_categories
        @page.categories << cats if cats

        respond_to do |format|
          if @page.save
            format.html { redirect_to pagify_get_stored, notice: 'Page Categories added.' }
            format.json { head :ok }
          else
            format.html { render action: "add_categories" }
            format.json { render json: @category.errors, status: :unprocessable_entity }
          end
        end
      end

        def update_removed_categories
          @page = page_class.find(params[:page_id])
          raise "page not found (#{params[:page_id]})" unless @page

          selected_categories = params[:page][:category_ids]
          selected_categories.each do |catid|
            cat = category_class.find(catid)  unless catid.blank?
            @page.categories.delete (cat) if cat
          end

          respond_to do |format|
            if @page.save
              format.html { redirect_to pagify_get_stored, notice: 'Page Categories deleted.' }
              format.json { head :ok }
            else
              format.html { render action: "add_categories" }
              format.json { render json: @category.errors, status: :unprocessable_entity }
            end
          end

        end

      def edit_categories
        @page = page_class.find(params[:page_id])
        raise "page not found (#{params[:page_id]})" unless @page
        @categories = category_class.all
        pagify_store_location request.referrer
      end

      def update_categories
        pageid = params[:page_id]
        logger.info "attempt to update page categories #{pageid}"
        @page = page_class.find(pageid)

        respond_to do |format|
          if @page.update_attributes(params[:page])
            format.html { redirect_to pagify_get_stored, notice: 'Category was successfully updated.' }
            format.json { head :ok }
          else
            format.html { render action: "edit" }
            format.json { render json: @category.errors, status: :unprocessable_entity }
          end
        end
      end
    end # PageCategories
  end  # Controller
end #Pagify
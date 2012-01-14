module Pagify
  module Controller
    module Categories
      extend ActiveSupport::Concern

      included do
        include Pagify::Controller::Base
        self.pagify_view_type = "categories"
      end

      module ClassMethods
      end

      # GET /categories
      # GET /categories.json
      def index
        @categories = category_class.all

        respond_to do |format|
          format.html
          format.json { render json: @categories }
        end
      end

      # GET /categories/1
      # GET /categories/1.json
      def show
        @category = category_class.find(params[:id])

        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @category }
        end
      end

      # GET /categories/new
      # GET /categories/new.json
      def new
        @category = category_class.new

        pagify_store_location(request.referrer)
        respond_to do |format|
          format.html
          format.json { render json: @category }
        end
      end

      # POST /categories
      # POST /categories.json
      def create
        @category = category_class.new(params[:category])

        respond_to do |format|
          if @category.save
            format.html { redirect_to pagify_get_stored, notice: 'Category was successfully created.' }
            format.json { render json: @category, status: :created, location: @category }
          else
            format.html { render action: "new" }
            format.json { render json: @category.errors, status: :unprocessable_entity }
          end
        end
      end

      # GET /categories/1/edit
      def edit
        @category = category_class.find(params[:id])
        pagify_store_location(request.referrer)
      end

      # PUT /categories/1
      # PUT /categories/1.json
      def update
        @category = category_class.find(params[:id])

        respond_to do |format|
          if @category.update_attributes(params[:category])
            format.html { redirect_to pagify_get_stored, notice: 'Category was successfully updated.' }
            format.json { head :ok }
          else
            format.html { render action: "edit" }
            format.json { render json: @category.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /categories/1
      # DELETE /categories/1.json
      def destroy
        @category = category_class.find(params[:id])
        @category.destroy

        respond_to do |format|
          format.html { redirect_to categories_url }
          format.json { head :ok }
        end
      end
    end # CategoriesController
  end  # Controller
end #Pagify
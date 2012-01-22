module Pagify
  module Controller
    module Pages
      extend ActiveSupport::Concern

      included do
        include Pagify::Controller::Base
        self.pagify_view_type = "pages"
      end

      module ClassMethods
      end

      def index
        @pages = page_class.all
        respond_to do |format|
          format.html
          format.json { render json: @pages }
        end
      end

      def modify
        @edit = true
        @page = page_class.find(params[:id])
        raise "page not found" unless @page
        raise "UnauthorizedAccess" unless authorized_modify?(@page)

        pagify_store_location (request.referrer)
        logger.info "stored return location: #{request.referrer}"
      end

      def show
        @edit = false
        @page = page_class.find(params[:id])
        redirect_to pages_path(:default) unless @page
        raise UnauthorizedAccess unless authorized_show?(@page)
      end

      def edit
        @page = page_class.find(params[:id])
        raise "page not found" unless @page
        @categories = category_class.all

        pagify_store_location(request.referrer)
      end


      def update
        pageid = params[:id]
        logger.info "attempt to update page #{pageid}"
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

      def updatemodified
        pageid = params[:id]
        logger.info "attempt to update page #{pageid}"
        @page = page_class.find(pageid)

        raise UnauthorizedAccess unless authorized_modify?(@page)

        @page.title = params[:content][:page_title][:value]
        @page.content = params[:content][:page_content][:value]
        @page.save!
        render text: ""
      end

      def new
        @page = page_class.new
        @categories = category_class.all

        if params[:category]
          category = category_class.find(params[:category]) rescue category = nil
          @page.categories << category if category
        end
        pagify_store_location(request.referrer)

        respond_to do |format|
          format.html
          format.json { render json: @page }
        end
      end

      def create
        pageid = params[:page][:name]

        @page = page_class.new
        @page.name = pageid
        @page.title = "#{pageid} page"
        @page.content = "your content here..."

        raise UnauthorizedAccess unless authorized_create?(@page)
        respond_to do |format|
          if @page.save
            format.html { redirect_to pagify_get_stored, notice: 'Page was successfully created.' }
            format.json { render json: @category, status: :created, location: @category }
          else
            format.html { render action: "new" }
            format.json { render json: @category.errors, status: :unprocessable_entity }
          end
        end
      end


      def destroy
        pageid = params[:id]
        logger.info "attempt to delete page #{pageid}"

        @page = page_class.find(pageid)
        raise UnauthorizedAccess unless authorized_modify?(@page)
        @page.destroy if @page
        logger.info "page #{pageid} deleted"

        redirect_to :back
      end


      def page_not_found   g
        raise ActionController::RoutingError.new('Page Not Found')
      end

      def authorized_show? (page)
        return  !!instance_exec(page, &Pagify::Config.show_authorizer) if Pagify::Config.show_authorizer
        true
      end

      def authorized_modify? (page)
        return  !!instance_exec(page, &Pagify::Config.modify_authorizer) if Pagify::Config.modify_authorizer
        false
      end

      def authorized_create? (page)
        return !!instance_exec(page, &Pagify::Config.create_authorizer) if Pagify::Config.create_authorizer
        false
      end

    end # PagesController
  end  # Controller
end #Pagify
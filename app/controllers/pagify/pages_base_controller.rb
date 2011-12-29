class Pagify::PagesBaseController < ApplicationController
  protect_from_forgery

  include Pagify::Controller

  def index
    @category = get_category(params)
    @pages = @category ? @category.pages : page_class.all
    respond_to do |format|
      format.html {render "category_index" if @category } # index.html.erb otherwise
      format.json { render json: @pages }
    end
  end

  def modify
    @edit = true
    @page = page_class.find_by_name(params[:id])
    raise "page not found" unless @page
    raise "UnauthorizedAccess" unless authorized_modify?(@page)

    pagify_store_location (request.referrer)
    logger.info "stored return location: #{request.referrer}"
  end

  def show
    @edit = false
    @page = page_class.find_by_name(params[:id])
    redirect_to pages_path(:default) unless @page
    raise UnauthorizedAccess unless authorized_show?(@page)
  end

  def edit
    pagify_store_location(request.referrer)
    @page = page_class.find_by_name(params[:id])
  end


  def update
    pageid = params[:id]
    logger.info "attempt to update page #{pageid}"
    @page = page_class.find_by_name(pageid)

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
    @page = page_class.find_by_name(pageid)

    raise UnauthorizedAccess unless authorized_modify?(@page)

    @page.title = params[:content][:page_title][:value]
    @page.content = params[:content][:page_content][:value]
    @page.save!
    render text: ""
  end

  def new
    @category = get_category(params)
    if @category then
      @pagify_categorization = Pagify::Categorization.new
      @pagify_categorization.category =  @category
      @pagify_categorization.position = 0
      @candidate_pages = page_class.not_associated_with @category
      pagify_store_location(request.referrer)
      render :new_category_page
      return
    end

    @page = page_class.new
    pagify_store_location(request.referrer)
    logger.info "attempt to create a new page"
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

    @page = page_class.find_by_name(pageid)
    raise UnauthorizedAccess unless authorized_modify?(@page)

    @category = get_category(params)
    if @category then
      rel = Categorization.find(@category, @page)
      rel.destroy if rel
      pagify_rdr_to_stored
      return
    end

    @page.destroy if @page
    logger.info "page #{pageid} deleted"

    redirect_to :back
  end


protected
  def page_not_found
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

  def get_category(params)
    params[:category_id] ? category_class.find(params[:category_id]) : nil
  end

end
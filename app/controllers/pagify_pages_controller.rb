class PagifyPagesController < ApplicationController

  def index
    @pages = Page.all
  end

  def edit
    @edit = true
    render_page params
  end

  def show
    @edit = false
    render_page params
  end

  def update
    pageid = params[:id]
    logger.info "attempt to update page #{pageid}"
    #raise "Unauthorized Access" unless user_signed_in?
    page = Page.find_by_name(pageid)

    logger.info "editor_path: " + mercury_editor_path

    raise "page not found" unless page

    page.title = params[:content][:page_title][:value]
    page.content = params[:content][:page_content][:value]
    page.save!
    render text: ""
  end

  def new
    logger.info "attempt to create a new page"
    @page = Page.new
  end

  def create
    pageid = params[:page][:name]

    page = Page.new
    page.name = pageid
    page.title = "#{pageid} page"
    page.content = "your content here..."
    page.save

    redirect_to edit_page_path(pageid)
  end

  def destroy
    pageid = params[:id]
    logger.info "attempt to delete page #{pageid}"

    page = Page.find_by_name(pageid)
    page.delete if page
    logger.info "page #{pageid} deleted"

    redirect_to root_path
  end

  def mercury_update
    page = Page.find(params[:id])
    page.title = params[:content][:title][:value]
    page.content = params[:content][:content][:value]
    page.save!
    render text: ""
  end



protected
  def page_not_found
    raise ActionController::RoutingError.new('Page Not Found')
  end

  def render_page(params)
    pageid = params[:id]
    action ||= :show
    logger.info "attempt to render page #{pageid}"

    @page = Page.find_by_name(pageid)
    if (!@page && pageid == 'default')
      logger.warn "no 'default' is currently defined !"
      page_not_found
    end
    logger.debug "non-existing page '#{pageid}': redirect to default page"
    redirect_to pages_path('default') unless @page
  end


end

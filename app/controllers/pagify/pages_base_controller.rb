class Pagify::PagesBaseController < ApplicationController
  protect_from_forgery

  def index
    @pages = Pagify::Page.all
  end

  def edit
    @edit = true
    @page = Pagify::Page.find_by_name(params[:id])
    raise "page not found" unless @page
    raise "UnauthorizedAccess" unless authorized_modify?(@page)
  end

  def show
    @edit = false
    @page = Pagify::Page.find_by_name(params[:id])
    redirect_to pagify_pages_path(:default) unless @page
    raise UnauthorizedAccess unless authorized_show?(@page)
  end

  def update
    pageid = params[:id]
    logger.info "attempt to update page #{pageid}"
    @page = Pagify::Page.find_by_name(pageid)

    raise UnauthorizedAccess unless authorized_modify?(@page)

    @page.title = params[:content][:page_title][:value]
    @page.content = params[:content][:page_content][:value]
    @page.save!
    render text: ""
  end

  def new
    logger.info "attempt to create a new page"
    @page = Pagify::Page.new
  end

  def create
    pageid = params[:pagify_page][:name]

    @page = Pagify::Page.new
    @page.name = pageid
    @page.title = "#{pageid} page"
    @page.content = "your content here..."

    raise UnauthorizedAccess unless authorized_create?(@page)

    @page.save
    redirect_to edit_pagify_page_path(pageid)
  end

  def destroy
    pageid = params[:id]
    logger.info "attempt to delete page #{pageid}"

    @page = Pagify::Page.find_by_name(pageid)
    raise UnauthorizedAccess unless authorized_modify?(@page)

    @page.delete if @page
    logger.info "page #{pageid} deleted"

    redirect_to pagify_pages_path
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
end
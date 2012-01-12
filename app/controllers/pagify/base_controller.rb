class Pagify::BaseController < ApplicationController
  class_attribute :pagify_view_type
  before_filter   :handle_view_path

  protect_from_forgery
  include Pagify::Controller

private
  def controller_path
    return "pagify/#{pagify_view_type}" if pagify_view_type
    super
  end

  def handle_view_path
    #append_view_path "xxxx/#{pagify_view_type}" if pagify_view_type
  end

  #def render(*args)
  #  options = args.extract_options!
  #  options[:template] = "pagify/#{pagify_view_type}/#{params[:action]}"
  #  super(*(args << options))
  #end

end
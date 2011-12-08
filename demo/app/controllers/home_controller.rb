class HomeController < ApplicationController
  def index

  end

  def test1
    render :text => "This is TEST#1"
  end

  def test2
    render :text => "This is TEST2 #{params[:id]}"
  end

end
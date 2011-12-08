Pagify.setup do |config|
  config.page_title = "pagify demo pages"

  config.authorize = lambda{ |page|
    puts "attempt to authorize page #{page.name} ..."
    authenticate_user!
  }

end

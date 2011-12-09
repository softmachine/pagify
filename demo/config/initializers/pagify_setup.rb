Pagify.setup do |config|
  config.page_title = "pagify demo pages"

  config.authorize do  |page|
    puts "attempt to authorize page #{page.name} ..."
    authenticate_user!
  end

  config.authorize_create do |page|
    raise "New Page Creation is not allowed here" unless page.name.start_with? "mike"
    true
  end

end

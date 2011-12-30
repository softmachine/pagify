namespace :pagify do
  desc "create some pagify sample pages and categories"
  task :seed => [:environment] do
     puts "creating sample category"
     main_cat = Pagify::Category.find_or_create_by_name({:name => "main", description:'the main category'})

     puts "creating sample pages"
     [
        {:name => "default", :title => "the default page", content:'This is the default page content.'},
        {:name => "home",    :title => "the home page", content:'This is the default page content.'},
        {:name => "about",   :title => "the about page", content:'This is the default page content.'},
        {:name => "contact", :title => "the contact page", content:'This is the default page content.'},
     ].each do |attributes|
           page = Pagify::Page.find_or_create_by_name(attributes)
           Pagify::Categorization.create(:page => page, :category => main_cat, )
           page.categories << main_cat if page.categories.count == 0
     end
     puts "pagify seed complete!"

  end

end

namespace :dev do  
  desc "Rebuild system"
  task :build => ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate", "db:seed" ]

  desc "Fake Data"
  task :fake => :environment do
    Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

    FactoryGirl.create_list(:user, 20)
  end
end

namespace :dev do  
  desc "Rebuild system"
  task :build => ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate", "db:seed" ]

  desc "Fake Data"
  task :fake => :environment do
    Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

    puts "Creating users"
    FactoryGirl.create_list(:user, 50)
    users = User.all

    puts "Creating more tags"
    %w(吃飯 買書 坐車 高鐵 音樂會 其他 看電影 加油 房租 貸款 水費 電費 攤提 捐款).each do |name|
      Tag.create!(name: name)
    end
    tags = Tag.all

    20.times do
      puts "Creating group"
      group = FactoryGirl.create(:group)

      puts "Adding tags"
      5.times do
        t = tags.sample
        unless group.tags.include?(t)
          group.tags << t
        end
      end
      
      puts "Adding owners"
      3.times do 
        u = users.sample
        unless (group.owners.include?(u) or group.members.include?(u))
          group.add_owner(u)
        end
      end
      puts "Adding Members"
      10.times do 
        u = users.sample
        unless (group.owners.include?(u) or group.members.include?(u))
          group.add_member(u)
        end
      end

      puts "Adding Expenses"
      100.times do
        u = group.group_users.all.sample.user
        t = group.tags.all.sample
        FactoryGirl.create(:expense, group: group, user: u, tag: t)
      end
    end
  end
end

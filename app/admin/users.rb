ActiveAdmin.register User do

  index do
    column :avatar do |user|
      image_tag "https://graph.facebook.com/#{user.uid}/picture?type=small"
    end
    column :name
    column :email
  end
end

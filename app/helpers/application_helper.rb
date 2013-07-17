module ApplicationHelper
  def avatar_for(user)
    image_tag("https://graph.facebook.com/#{user.uid}/picture",
      class: 'img-circle user-avastar')
  end
end

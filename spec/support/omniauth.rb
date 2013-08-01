OmniAuth.config.test_mode = true

FACEBOOK_INFO = {
  "id"=> sprintf("%06d", rand(1000000)),
  "email" => "example@facebook.com",
}

OmniAuth.config.mock_auth[:facebook] = {
  "uid"       => sprintf("%09d", rand(1000000000)),
  "provider"  => 'facebook',
  "info"      => {
    "name"  => "weijenlu", 
    "email" => "weijenlu@example.com"
  }
}

OmniAuth.config.mock_auth[:twitter] = {  
  provider: "twitter", 
  uid:      sprintf("%09d", rand(1000000000)),
  extra: {
    raw_info: {
      screen_name: "weijenlu"
    }
  }
}

OmniAuth.config.mock_auth[:ooxx] = {}

def create_user
  h = attributes_for(:identity)
  h[:name] = h[:uname]
  h[:email] = h[:uemail]

  @user = User.create_by_hash(h)
end

def user_login
  create_user()

  session[:user_id] = @user.id
  session[:identity_id] = @user.identities.first.id
end


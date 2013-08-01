Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Setting.facebook_app_id, Setting.facebook_secret
end

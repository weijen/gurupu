ActionMailer::Base.smtp_settings = Setting.smtp_setting.smtp.to_options

ActionMailer::Base.default_url_options = Setting.smtp_setting.default_url_options.to_options

if Rails.env.development?
  require File.join( Rails.root,"lib","development_mail_interceptor.rb")
  Mail.register_interceptor(DevelopmentMailInterceptor)
end

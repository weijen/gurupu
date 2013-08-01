require File.expand_path('../boot', __FILE__)

require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

# For bootstrap-helper
SITE_NAME = "GURUPU"

module Gurupu
  class Application < Rails::Application
    config.app_generators do |g|
      g.test_framework :rspec, :fixture => true, :fixture_replacement => :factory_girl, :dir => 'spec/factories'
      g.integration_tool :rspec
      g.performance_tool :rspec

      g.helper        false
      g.view_specs    false
      g.helper_specs  false
      
      g.javascripts   false
      g.stylesheets   false
    end

    config.time_zone = 'Taipei'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**','*.{rb,yml}').to_s]
    config.i18n.available_locales = ['zh-TW', :en]
    config.i18n.default_locale = "zh-TW"
  end
end

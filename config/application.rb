require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
# these gems are not required by Bundler.require
require "sass"
require "haml-rails"
require "jquery-rails"
require "sucker_punch"

module FluentdUi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = 'ja'
    config.autoload_paths += %W(#{config.root}/app/workers #{config.root}/lib)
    config.after_initialize do
      # http://qiita.com/tanaka51/items/c8873319689217bb81a9
      require File.join(Rails.root, "app", "models", "fluentd")
      require File.join(Rails.root, "app", "models", "fluentd", "agent", "fluentd")
    end
  end
end
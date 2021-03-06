require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Website
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('lib/*')
    config.active_record.raise_in_transactional_callbacks = true
    # Set the host for mailcatcher
    config.action_mailer.default_url_options = { host: Rails.application.secrets.domain, protocol: Rails.application.secrets.protocol }
  end
end

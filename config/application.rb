require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ColoradoProductMentorshipMatchmaker
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.generators do |g|
      g.template_engine nil
      g.test_framework  nil
      g.assets  false
      g.helper false
      g.stylesheets false
    end
  end
end

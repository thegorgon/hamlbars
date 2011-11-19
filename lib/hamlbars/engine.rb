module Hamlbars
  class Engine < Rails::Engine
    initializer "hamlbars.configure_rails_initialization", :before => 'sprockets.environment', :group => :all do |app|
      next unless app.config.assets.enabled

      require 'sprockets'
      require 'sprockets/engines'
      require 'hamlbars/template'
      #app.config.assets.register_engine '.hamljs', ::RubyHamlJs::Template
      Sprockets.register_engine '.hamlbars', ::Hamlbars::Template
    end
  end
end
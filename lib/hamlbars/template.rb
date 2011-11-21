require 'tilt/template'

module Hamlbars
  class Template < Tilt::Template
    JS_ESCAPE_MAP = {
      "\r\n"  => '\n',
      "\n"    => '\n',
      "\r"    => '\n',
      '"'     => '\\"',
      "'"     => "\\'" }

    def self.default_mime_type
      'application/javascript'
    end
    
    def self.default_namespace
      'this.JST'
    end
    
    def self.engine_initialized?
      defined? ::Haml::Engine
    end

    def initialize_engine
      require_template_library 'haml'
    end

    def prepare
      options = @options.merge(:filename => eval_file, :line => line)
      @engine = ::Haml::Engine.new(data, options)
      @namespace = self.class.default_namespace
    end
    
    attr_reader :namespace

    def evaluate(scope, locals, &block)
      scope = scope.dup
      
      scope.class.send(:include, ActionView::Helpers) if defined?(::ActionView)
      if defined?(::Rails)
        scope.class.send(:include, Rails.application.helpers)
        scope.class.send(:include, Rails.application.routes.url_helpers)
        scope.default_url_options = Rails.application.config.action_controller.default_url_options || {}
      end
      
      template = @engine.render(scope, locals, &block)
      template = template.strip.gsub(/(\r\n|[\n\r"'])/) { JS_ESCAPE_MAP[$1] }
      
      if basename =~ /^_/
        <<-REG
(function() {
  Handlebars.registerPartial("#{scope.logical_path.inspect}", "#{indent(template)}";
}).call(this);
        REG
      else
        <<-REG
(function() {
  #{namespace} || (#{namespace} = {});
  #{namespace}[#{scope.logical_path.inspect}] = Handlebars.compile("#{indent(template)}");
}).call(this);
        REG
      end
    end
    
    private
    
    def indent(string)
      string.gsub(/$(.)/m, "\\1  ").strip
    end
  end
end

module Haml
  module Helpers

    module HamlbarsExtensions
      def iterate(name, &block)
        content = capture_haml(&block)
        "{{##{name}}}#{content.strip}{{/#{name}}}"
      end
    end

    include HamlbarsExtensions
  end
end
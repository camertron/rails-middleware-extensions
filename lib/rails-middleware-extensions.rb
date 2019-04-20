require 'rails/version'
require 'rails-middleware-extensions/middleware_stack'
require 'rails-middleware-extensions/middleware_stack_proxy'

module RailsMiddlewareExtensions
  def rails5?
    Rails::VERSION::STRING >= '5.0.0'
  end

  extend self
end

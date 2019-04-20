$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'rails-middleware-extensions/version'

Gem::Specification.new do |s|
  s.name     = 'rails-middleware-extensions'
  s.version  = ::RailsMiddlewareExtensions::VERSION
  s.authors  = ['Cameron Dutro']
  s.email    = ['camertron@gmail.com']
  s.homepage = 'http://github.com/camertron/rails-middleware-extensions'

  s.description = s.summary = 'Adds several additional operations useful for customization of your Rails middleware stack'

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true

  s.add_dependency 'railties', '>= 4.0'
  s.add_dependency 'actionpack', '>= 4.0'

  s.add_development_dependency 'pry-byebug'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'

  s.require_path = 'lib'
  s.files = Dir['{lib,spec}/**/*', 'Gemfile', 'README.md', 'Rakefile', 'rails-middleware-extensions.gemspec']
end

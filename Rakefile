$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'bundler'
require 'pry-byebug'
require 'rspec/core/rake_task'
require 'rubygems/package_task'
require 'rails-middleware-extensions'

Bundler::GemHelper.install_tasks

task default: :spec

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.pattern = './spec/**/*_spec.rb'
end

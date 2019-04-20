require 'spec_helper'

describe 'middleware extensions' do
  class TestMiddleware
    # at least make it _look_ like real middleware ;)
    def initialize(*); end
    def call(*); end
  end

  let(:app) do
    Class.new(Rails::Application) do
      config.eager_load = false
    end
  end

  before do
    unless RailsMiddlewareExtensions.rails5?
      # Rails 4 unfortunately stores a number of things in class variables that survive
      # creating new application instances. We have to clean things up here by forcibly
      # resetting them all back to nil or we'll see some test pollution, i.e. middleware
      # stacks from previous examples will persist into the contexts of other examples.

      (Rails::Railtie::Configuration.class_variables - [:@@options]).each do |cv|
        Rails::Railtie::Configuration.class_variable_set(cv, nil)
      end

      # Furthermore, Rails 4.0 raises an error if you try to subclass Rails::Application.
      # It checks to see if Rails.application non-nil, so we set it to nil here as a
      # workaround.
      Rails.application = nil
    end
  end

  describe '#insert*_unless_exists' do
    it 'inserts the middleware' do
      app.initializer('example') do |app|
        app.middleware.insert_unless_exists(1, TestMiddleware)
      end

      app.initialize!

      expect(app.middleware.middlewares.index(TestMiddleware)).to eq(1)
      expect(app.middleware.middlewares.count { |m| m == TestMiddleware }).to eq(1)
    end

    it 'inserts the middleware after' do
      app.initializer('example') do |app|
        app.middleware.insert_after_unless_exists(1, TestMiddleware)
      end

      app.initialize!

      expect(app.middleware.middlewares.index(TestMiddleware)).to eq(2)
      expect(app.middleware.middlewares.count { |m| m == TestMiddleware }).to eq(1)
    end

    context 'when the middleware already exists' do
      before do
        app.initializer('before') do |app|
          app.middleware.use(TestMiddleware)
        end
      end

      it 'only includes the middleware once' do
        app.initializer('example') do |app|
          app.middleware.insert_unless_exists(1, TestMiddleware)
        end

        app.initialize!

        expect(app.middleware.middlewares.count { |m| m == TestMiddleware }).to eq(1)
      end
    end
  end

  describe '#move' do
    it 'asserts that the middleware is not in the first position when inserted' do
      app.initializer('example') do |app|
        app.middleware.insert(5, TestMiddleware)
      end

      app.initialize!

      expect(app.middleware.middlewares.index(TestMiddleware)).to_not eq(0)
    end

    it 'moves the middleware to the desired position' do
      app.initializer('example') do |app|
        app.middleware.insert(5, TestMiddleware)
        app.middleware.move(0, TestMiddleware)
      end

      app.initialize!

      expect(app.middleware.middlewares.index(TestMiddleware)).to eq(0)
    end

    it 'moves the middleware into the desired position after' do
      app.initializer('example') do |app|
        app.middleware.insert(5, TestMiddleware)
        app.middleware.move_after(0, TestMiddleware)
      end

      app.initialize!

      expect(app.middleware.middlewares.index(TestMiddleware)).to eq(1)
    end
  end
end

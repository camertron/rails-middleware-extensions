## rails-middleware-extensions [![Build Status](https://secure.travis-ci.org/camertron/rails-middleware-extensions.png?branch=master)](http://travis-ci.org/camertron/rails-middleware-extensions)

Adds several additional operations useful for customizing your Rails middleware stack.

## Installation

`gem install rails-middleware-extensions`

## Usage

Just add this gem to your gemfile like so:

```ruby
gem 'rails-middleware-extensions'
```

## Extensions

Currently two extensions are supported: `move` and `insert_unless_exists`.

### Insert Unless Exists

As the name implies, the given middleware will only be inserted if it has not already been added to the middleware stack. For example, here's how we might insert our custom `MyCustomMiddleware` middleware before `Rails::Logger`:

```ruby
config.middleware.insert_unless_exists(Rails::Logger, MyCustomMiddleware)
```

`#insert_unless_exists` supports all the arguments regular 'ol `#insert` supports, meaning you can also pass an index to insert before. Here's how to insert our custom middleware at the very beginning of the stack:

```ruby
config.middleware.insert_unless_exists(0, MyCustomMiddleware)
```

Finally, use `#insert_after_unless_exists` to insert a particular middleware _after_ another one. For example, to insert `MyCustomMiddleware` after `Rails::Logger`:

```ruby
config.middleware.insert_after_unless_exists(Rails::Logger, MyCustomMiddleware)
```

### Move

As of Rails 5.0, it's not possible to delete a middleware and then re-add it (see [this issue](https://github.com/rails/rails/issues/26303)) because delete operations are always applied last. Instead, consider using `#move`. For example, to move our custom middleware before `Rails::Logger`:

```ruby
config.middleware.move(Rails::Logger, MyCustomMiddleware)
```

Consider `#move`'s cousin, `#move_after`, to move a piece of middleware after another:

```ruby
config.middleware.move_after(Rails::Logger, MyCustomMiddleware)
```

As with `#insert_unless_exists`, `#move` and `#move_after` also support numeric indices:

```ruby
config.middleware.move(0, MyCustomMiddleware)
```

## Running Tests

`bundle exec rspec` should do the trick :) Rails-middleware extensions supports a number of Rails versions, hence all the Gemfiles. There is one Gemfile per supported Rails version. If you'd like to run tests against a particular version, use the `BUNDLE_GEMFILE` environment variable like so:

```bash
BUNDLE_GEMFILE=Gemfile-rails-4.1.x bundle exec rspec
```

By default tests will run against Rails 5.2.x.

## License

Licensed under the MIT license. See LICENSE for details.

## Authors

* Cameron C. Dutro: http://github.com/camertron

module ActionDispatch
  class MiddlewareStack
    def insert_unless_exists(target, source, *args, &block)
      unless middlewares.include?(source)
        insert_before(target, source, *args, &block)
      end
    end

    alias_method :insert_before_unless_exists, :insert_unless_exists

    def insert_after_unless_exists(target, source, *args, &block)
      unless middlewares.include?(source)
        insert_after(target, source, *args, &block)
      end
    end

    def move(target, source, *args, &block)
      index = assert_index(source, :before)
      middlewares.delete_at(index)

      insert(target, source, *args, &block)
    end

    alias_method :move_before, :move

    def move_after(target, source, *args, &block)
      index = assert_index(source, :after)
      middlewares.delete_at(index)

      insert_after(target, source, *args, &block)
    end
  end
end

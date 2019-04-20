module Rails
  module Configuration
    class MiddlewareStackProxy
      def insert_before_unless_exists(*args, &block)
        _ops_ << [__method__, args, block]
      end

      alias_method :insert_unless_exists, :insert_before_unless_exists

      def insert_after_unless_exists(*args, &block)
        _ops_ << [__method__, args, block]
      end

      def move_before(*args, &block)
        _ops_ << [__method__, args, block]
      end

      alias_method :move, :move_before

      def move_after(*args, &block)
        _ops_ << [__method__, args, block]
      end

      private

      def _ops_
        if RailsMiddlewareExtensions.rails5?
          @delete_operations
        else
          @operations
        end
      end
    end
  end
end

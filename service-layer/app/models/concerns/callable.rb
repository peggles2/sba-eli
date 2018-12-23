# The Callable Concern provides a way to quickly instantiate and call the call
# method on service, command or other types of objects. Here is an example of
# its use:
#
#   class HelloWorld
#     include Callable
#
#     def initialize(name)
#       @name = name
#     end
#
#     def call
#       "Hello #{name}!"
#     end
#   end
#
#   HelloWorld.call("Nick")
#
# This method call would return
#
#   Hello Nick!
module Callable
  extend ActiveSupport::Concern

  class_methods do
    def call(*args)
      new(*args).call
    end
  end
end

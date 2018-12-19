# PolymorphicResource is a Rails concern. It is useful to use in controllers
# where you want the controller to be able to respond to more than one URI
# For example, LearningPaths, LearningObjectives and LearningEvents all have
# CustomContent. We want to create one controller that can service the following
# routes
#
#   - /learning_paths/:learning_path_id/custom_content
#   - /learning_objectives/:learning_objective_id/custom_content
#   - /learning_events/:learning_event_id/custom_content
#
# An example use of this could be
#
#   class CustomContentsController < ApplicationController
#     include PolymorphicResource
#
#     def index
#       render json resource.custom_content
#     end
#   end
#
# If CustomContentsController was mapped to the route
#
# /learning_paths/:learning_path_id/custom_content
#
# In this short example the resource method is called within the index action,
# which is part of the PolymorphicResource concern. The resource will then return
# and instance of LearningPath, by which the method `custom_content` is called
# and returned as json.
module PolymorphicResource
  extend ActiveSupport::Concern

  # The resource method returns the instance of a resource based upon the
  # route path. For example, the route
  #
  # /learning_paths/:learning_path_id/custom_content
  #
  # would return the LearningPath instance with an id of :learning_path_id
  def resource
    klass, param = resource_class
    klass&.find(params[param.to_sym])
  end

  private

  # This method looks at the params hash. Its looking for a param that ends in
  # '_id'. Once found it removes the id and then returns the class and the id
  # to look up. For example in the route
  #
  # /learning_paths/:learning_path_id/custom_content
  #
  # the method would find `learning_path_id` and then return the class
  # LearningPath and learning_path_id
  def resource_class
    params.each do |name, _value|
      if /(.+)_id$/.match?(name)
        model = name.match(%r{([^\/.]*)_id$})
        return model[1].classify.constantize, name
      end
    end
    nil
  end
end

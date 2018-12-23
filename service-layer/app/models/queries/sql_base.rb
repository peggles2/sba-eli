# SqlBase contains methods that help manage the execution of SQL (non ActiveRecord)
# queryies. It allow you to pass a filtered hash of query parameters,
# parse/set default values for parameters, and provides access to
# ActiveRecord's sanitation method.
#
# The query class inherits this class must implmentent the following methods
#
#   - initialize: the initialize method must call `super` with the method and
#                 pass it a hash of parameters.
#   - preapare: The prepare method takes a hash or paramters. Within this method
#               you sanatize the paramters and add values to query from to the
#               @properties hash
#   - call: This method is called to execute the query. You are required to provide
#           the method by which the query is executed.
# Example:
#
#   class Result
#     include Queryable
#     attr_accessor :id, :name, :learning_path
#   end
#
#   module Queries
#     class Search < Queries::SqlBase
#       def initialize(params)
#         super(params)
#       end
#
#       def prepare(params)
#         check_like_value(:keywords, params)
#       end
#
#       def call
#         sql = <<-SQL
#           SELECT id, title
#           FROM learning_path
#           WHERE 0=0
#             #{generate_keyword_sql}
#         SQL
#
#         Result.find_by_sql(sql)
#       end
#     end
#
#     private
#
#       def generate_keyword_sql
#         "AND title ILIKE '#{sanitize(keywords)}'" if keywords.present?
#       end
#   end
#
#   Search.call(keywords: "Math")
#
module Queries
  class SqlBase
    include Callable
    attr_reader :properties

    def initialize(params)
      @properties = {}
      prepare(params)
    end

    # Redefines method missing so that you items in the @properties hasn
    # can be called like regular methods
    def method_missing(name)
      if @properties.has_key? name
        @properties[name]
      else
        super
      end
    end

    # Redefines resond_to such that items in the @properties hash are return true
    def respond_to_missing?(method_name, include_private = false)
      @properties.has_key?(method_name) || super
    end

    private

    # this method can be used to prepare a parameter that is passed as a comma
    # separated list of values and turns it in to a ruby array
    def check_array_value(field, params)
      @properties[field] = params[field].present? ? params[field].split(",") : []
    end

    # this method can be used to prepare a paramters that will be used in a
    # LIKE or ILIKE query
    def check_like_value(field, params, default_value = nil)
      @properties[field] = params[field].present? ? "%#{params[field]}%" : default_value
    end

    # This method is used to prepare a value that is expected to be a integer. It
    # will call .to_i on the paramter to convert it to an integer
    def check_numeric_value(field, params, default_value = nil)
      @properties[field] = params[field].present? ? params[field].to_i : default_value
    end

    # This method is used to prepare a parameter that is a string
    def check_single_value(field, params, default_value = nil)
      @properties[field] = params[field] || default_value
    end

    # This method provides way to sanatize values in an array
    def array_to_string(arr)
      arr.map { |e| "'#{sanitize(e)}'" }.join(",")
    end

    # This method provides simple access to AciveRecord's sanatize_sql method
    def sanitize(value)
      ActiveRecord::Base.sanitize_sql(value)
    end
  end
end

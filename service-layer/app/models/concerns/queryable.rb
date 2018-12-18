# Queryable provides a way to easily query and populate result objects, where
# the result sets may contain multiple data types. It provides functionality similar
# to ActiveRecords `find_by_sql` method. For example, lets say you have a query
# that you want to union together results from two different tables.
#
#   SELECT id, name, 'learning_path' AS content_type FROM learning_paths
#   UNION ALL
#   SELECT if, name, 'learning_objective' AS content_type FROM learning_objectives
#
# For this query, you would not want to use the ActiveRecord find_by_sql method
# because the result set would contain more than just one model type. Queryable
# addresses this by letting you create a generic Ruby class and including the
# Querable concern. For example:
#
#   class Result
#     include Queryable
#     attr_accessor :id, :name, :learning_path
#   end
#
#   sql = <<-SQL
#     SELECT id, name, 'learning_path' AS content_type FROM learning_paths
#     UNION ALL
#     SELECT if, name, 'learning_objective' AS content_type FROM learning_objectives
#   SQL
#
#   Result.find_by_sql(sql)
#
# The concern also has a method of pagination that mimics WillPaginate's
# `paginate_by_sql` method. This is an example of paginating records
#
#   Result.paginate_by_sql(sql, page: page, per_page: per_page)
module Queryable
  extend ActiveSupport::Concern

  included do
    include ActiveModel::Model
  end

  # Provides an easy way to loop over attributes in a model. This can come in handy
  # if you want to compare the result set that comes back from a raw SQL query
  # with the attributes defined on the model
  def attributes
    self.class.attributes
  end

  # rubocop:disable Metrics/BlockLength
  class_methods do
    # Wraps +attr_accessor+ and creates/appends an attributes array which tracks attributes
    # attached to this model.
    def attr_accessor(*vars)
      @attributes ||= []
      @attributes.concat vars
      super(*vars)
    end

    # Wraps +attr_reader+ reates/appends an attributes array which tracks attributes
    # attached to this model.
    def attr_reader(*vars)
      @attributes ||= []
      @attributes.concat vars
      super(*vars)
    end

    # Provides an easy way to loop over attributes in a model. This can come in handy
    # if you want to compare the result set that comes back from a raw SQL query
    # with the attributes defined on the model
    def attributes
      @attributes
    end

    def count_by_sql(sql)
      connection.select_value(sanitize_sql(sql), "#{name} Count").to_i
    end

    # Mimics ActiveRecords +find_by_sql+. Performs query and populates
    # ruby object with data. Data must match the attributes of the object
    # this module is included in. This is best used in cases where the query
    # result does not match a table/ActiveRecord model
    #
    # Example:
    #
    #   class Todo
    #     include Queryable
    #     attr_accessor :id, :desc
    #   end
    #
    #   sql = <<-SQL
    #     SELECT id, desc FROM todos
    #   SQL
    #
    #   Todo.find_by_sql(sql)
    #
    def find_by_sql(sql)
      result_set = connection.select_all(
        sanitize_sql(sql),
        "#{name} Load",
      )
      message_bus = ActiveSupport::Notifications.instrumenter
      payload = {
        record_count: result_set.length,
        class_name: name,
      }
      message_bus.instrument("instantiation.active_record", payload) do
        result_set.map { |record| new(record) }
      end
    end

    # Wraps +find_by_sql+ by simply adding LIMIT and OFFSET to your SQL string
    # based on the params otherwise used by paginating finds: +page+ and
    # +per_page+.
    #
    # Example:
    #
    # @developers = Developer.paginate_by_sql ['select * from developers where salary > ?', 80000],
    #                          :page => params[:page], :per_page => 3
    #
    # A query for counting rows will automatically be generated if you don't
    # supply <tt>:total_entries</tt>. If you experience problems with this
    # generated SQL, you might want to perform the count manually in your
    # application.
    #
    def paginate_by_sql(sql, options)
      pagenum  = options.fetch(:page) { raise ArgumentError, ":page parameter required" } || 1
      per_page = options[:per_page] || self.per_page
      total    = options[:total_entries]

      query = sanitize_sql(sql.dup)
      original_query = query.dup

      WillPaginate::Collection.create(pagenum, per_page, total) do |pager|
        query << " LIMIT #{pager.per_page} OFFSET #{pager.offset}"
        pager.replace find_by_sql(query)
        unless pager.total_entries
          count_query = original_query.sub /\bORDER\s+BY\s+[\w`,\s.]+$/mi, ""
          count_query = "SELECT COUNT(*) FROM (#{count_query})"
          count_query << " AS count_table"
          # perform the count query
          pager.total_entries = count_by_sql(count_query)
        end
      end
    end

    # Convenience method for sanitizing a SQL Statement
    def sanitize_sql(sql)
      ActiveRecord::Base.sanitize_sql(sql)
    end

    # Convenience method for obtaining a database connection
    def connection
      ActiveRecord::Base.connection
    end
  end
  # rubocop:enable Metrics/BlockLength
end

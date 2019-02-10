module Canvas
  module Base
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def session_token
        ENV["CANVAS_TOKEN"]
      end

      def canvas_host
        ENV["CANVAS_HOST"]
      end

      def base_options
        {
          headers: {
            "Authorization" => "Bearer " + session_token,
          },
        }
      end

      def custom_options(options = {})
        per_page = options.fetch(:per_page, nil)
        masquerade = options.fetch(:masquerade, false)
        query = options.fetch(:query, {})

        query.merge!(masquerade_current_user_query) if masquerade
        query.merge!(pagination_query(per_page)) if per_page
        base_options.merge(query: query)
      end

      def pagination_query(per_page = 100)
        { "per_page" => per_page }
      end

      def masquerade_current_user_query
        Current.user ? { "as_user_id" => Current.user&.id } : {}
      end
    end
  end
end

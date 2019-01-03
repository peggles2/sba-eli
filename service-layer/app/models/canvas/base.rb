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

      def masquerade_current_user(uri)
        Current.user ? "#{uri}?as_user_id=#{Current.user&.id}" : uri
      end
    end
  end
end

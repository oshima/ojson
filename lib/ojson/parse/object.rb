module Ojson
  module Parse
    module Object
      def parse_object
        skip and skip_ws
        skip and return {} if look == '}'
        hash = {}
        loop do
          error unless look == '"'
          key = parse_string
          skip_ws
          expect ':'
          skip_ws
          hash[key] = parse_value
          skip_ws
          case look
          when ','
            skip and skip_ws
            error if look == '}'
          when '}'
            skip and break
          else
            error
          end
        end
        hash
      end
      private :parse_object
    end
  end
end

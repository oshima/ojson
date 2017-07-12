module Ojson
  module Parse
    module Array
      def parse_array
        skip and skip_ws
        skip and return [] if look == ']'
        arr = []
        loop do
          arr << parse_value
          skip_ws
          case look
          when ','
            skip and skip_ws
            error if look == ']'
          when ']'
            skip and break
          else
            error
          end
        end
        arr
      end
      private :parse_array
    end
  end
end

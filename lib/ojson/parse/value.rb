module Ojson
  module Parse
    module Value
      def parse_value
        case look
        when '{'      then parse_object
        when '['      then parse_array
        when /[\-\d]/ then parse_number
        when '"'      then parse_string
        when 't'      then parse_true
        when 'f'      then parse_false
        when 'n'      then parse_null
        else error
        end
      end
      private :parse_value
    end
  end
end

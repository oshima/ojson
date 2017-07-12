module Ojson
  module Parse
    module String
      def parse_string
        skip
        skip and return '' if look == '"'
        str = ''
        loop do
          str << read
          skip and break str if look == '"'
        end
      end
      private :parse_string
    end
  end
end

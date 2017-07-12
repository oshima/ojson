module Ojson
  module Parse
    module False
      def parse_false
        skip
        expect 'a'
        expect 'l'
        expect 's'
        expect 'e'
        false
      end
      private :parse_false
    end
  end
end

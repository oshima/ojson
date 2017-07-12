module Ojson
  module Parse
    module True
      def parse_true
        skip
        expect 'r'
        expect 'u'
        expect 'e'
        true
      end
      private :parse_true
    end
  end
end

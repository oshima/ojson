module Ojson
  module Parse
    module Null
      def parse_null
        skip
        expect 'u'
        expect 'l'
        expect 'l'
        nil
      end
      private :parse_null
    end
  end
end

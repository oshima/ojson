require 'ojson/parse'

module Ojson
  class Parser
    include Parse::Value
    include Parse::Object
    include Parse::Array
    include Parse::Number
    include Parse::String
    include Parse::True
    include Parse::False
    include Parse::Null

    def parse(json)
      set json
      skip_ws
      obj = parse_value
      skip_ws
      error if look
      obj
    end

    private

    def set(json)
      fail TypeError, 'not string' unless json.is_a?(String)
      @json, @i = json, 0
    end

    def look
      @json[@i]
    end

    def skip
      @i += 1
    end

    def expect(char)
      error unless look == char
      skip
    end

    def read
      look.tap do |char|
        error unless char
        skip
      end
    end

    def skip_ws
      while look =~ /\s/
        skip
      end
    end

    def error
      char = look&.inspect || 'EOS'
      fail ParserError, "unexpected #{char}"
    end
  end

  ParserError = Class.new(StandardError)
end

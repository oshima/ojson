module Ojson
  module ParserHelper
    private

    def register(json)
      fail TypeError, 'not string' unless json.is_a?(String)
      @json, @i = json, 0
    end

    def look
      @json[@i]
    end

    def skip
      @i += 1
    end

    def read
      char = look
      error unless char
      skip
      char
    end

    def expect(char)
      error unless look == char
      skip
    end

    def error
      char = look&.inspect || 'EOS'
      fail ParserError, "unexpected #{char}"
    end
  end

  ParserError = Class.new(StandardError)
end

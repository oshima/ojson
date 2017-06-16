require 'ojson/parser_helper'

module Ojson
  class Parser
    include ParserHelper

    def parse(json)
      register json
      skip_ws
      obj = read_value
      skip_ws
      error if look
      obj
    end

    private

    def skip_ws
      while look =~ /\s/
        skip
      end
    end

    def read_value
      case look
      when '{'      then read_object
      when '['      then read_array
      when /[\-\d]/ then read_number
      when '"'      then read_string
      when 't'      then read_true
      when 'f'      then read_false
      when 'n'      then read_null
      else error
      end
    end

    def read_object
      skip and skip_ws
      skip and return {} if look == '}'
      hash = {}
      loop do
        error unless look == '"'
        key = read_string
        skip_ws
        expect ':'
        skip_ws
        hash[key] = read_value
        skip_ws
        case look
        when ','
          skip and skip_ws
          error if look == '}'
        when '}'
          skip and return hash
        else
          error
        end
      end
    end

    def read_array
      skip and skip_ws
      skip and return [] if look == ']'
      arr = []
      loop do
        arr << read_value
        skip_ws
        case look
        when ','
          skip and skip_ws
          error if look == ']'
        when ']'
          skip and return arr
        else
          error
        end
      end
    end

    # /-?(0|[1-9]\d*)(\.\d+)?([eE][\+\-]?\d+)?/
    def read_number
      sign = 1
      if look == '-'
        skip
        sign = -1
        error unless look =~ /\d/
      end

      int = 0
      if look == '0'
        skip
        error if look =~ /\d/
      else
        loop do
          int = int * 10 + read.to_i
          break unless look =~ /\d/
        end
      end

      dec = 0
      if look == '.'
        skip
        error unless look =~ /\d/
        1.step do |n|
          dec = dec + read.to_i * 10**-n
          break unless look =~ /\d/
        end
      end

      exp_sign, exp_int = 1, 0
      if look =~ /[eE]/
        skip
        if look =~ /[\+\-]/
          exp_sign = -1 if look == '-'
          skip
        end
        error unless look =~ /\d/
        loop do
          exp_int = exp_int * 10 + read.to_i
          break unless look =~ /\d/
        end
      end

      num = sign * (int + dec) * 10**(exp_sign * exp_int)
      (dec == 0 && exp_int == 0) ? num : num.to_f
    end

    def read_string
      skip
      skip and return '' if look == '"'
      str = ''
      loop do
        str << read
        skip and return str if look == '"'
      end
    end

    def read_true
      skip
      expect 'r'
      expect 'u'
      expect 'e'
      true
    end

    def read_false
      skip
      expect 'a'
      expect 'l'
      expect 's'
      expect 'e'
      false
    end

    def read_null
      skip
      expect 'u'
      expect 'l'
      expect 'l'
      nil
    end
  end
end

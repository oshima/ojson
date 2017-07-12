module Ojson
  module Parse
    module Number
      def parse_number
        sign = parse_sign
        int = parse_integer_part
        frac = parse_fraction_part
        exp = parse_exponent_part
        num = sign * (int + frac) * exp
        num.integer? ? num : num.to_f
      end
      private :parse_number

      def parse_sign
        return 1 unless look == '-'
        skip
        error unless look =~ /\d/
        -1
      end
      private :parse_sign

      def parse_integer_part
        if look == '0'
          skip
          error if look =~ /\d/
          return 0
        end
        int = 0
        loop do
          int = int * 10 + read.to_i
          break unless look =~ /\d/
        end
        int
      end
      private :parse_integer_part

      def parse_fraction_part
        return 0 unless look == '.'
        skip
        error unless look =~ /\d/
        frac = 0
        1.step do |n|
          frac = frac + read.to_i * 10**-n
          break unless look =~ /\d/
        end
        frac.to_r
      end
      private :parse_fraction_part

      def parse_exponent_part
        return 1 unless look =~ /e/i
        skip
        exp_sign = 1
        if look =~ /[\+\-]/
          exp_sign = -1 if look == '-'
          skip
        end
        error unless look =~ /\d/
        exp_int = 0
        loop do
          exp_int = exp_int * 10 + read.to_i
          break unless look =~ /\d/
        end
        10**(exp_sign * exp_int).to_r
      end
      private :parse_exponent_part
    end
  end
end

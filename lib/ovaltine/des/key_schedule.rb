require_relative './permutation.rb'

module Ovaltine
  module DES
    class KeySchedule

      include Ovaltine::DES::Permutation

      # Round left shift count
      R = [1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 1]

      attr_accessor :key_56
      attr_accessor :key_64
      attr_accessor :keys

      def initialize(key)
        @key_64 = key.hex.to_s(2).rjust(64, '0')
        @key_56 = permute(@key_64, PC1)
        @keys = generate_keys
      end

      private

      def left_shift(key, distance)
        key.chars.rotate(distance).join
      end

      def generate_keys
        c = @key_56[0...28]
        d = @key_56[28...56]

        (1..16).to_a.map { |round|

          c = left_shift(c, R[round - 1])
          d = left_shift(d, R[round - 1])

          permute([c, d].join, PC2)
        }
      end

    end
  end
end

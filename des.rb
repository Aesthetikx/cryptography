module Cryptography
  module DES

    class KeySchedule

      # Permutation Choice 1
      PC1 = [
        57, 49, 41, 33, 25, 17, 9,
         1, 58, 50, 42, 34, 26, 18,
        10,  2, 59, 51, 43, 35, 27,
        19, 11,  3, 60, 52, 44, 36,
        63, 55, 47, 39, 31, 23, 15,
         7, 62, 54, 46, 38, 30, 22,
        14,  6, 61, 53, 45, 37, 29,
        21, 13,  5, 28, 20, 12, 4
      ].map { |p| p - 1}

      # Permutation Choice 2
      PC2 = [
        14, 17, 11, 24,  1, 5,
         3, 28, 15,  6, 21, 10,
        23, 19, 12,  4, 26, 8,
        16,  7, 27, 20, 13, 2,
        41, 52, 31, 37, 47, 55,
        30, 40, 51, 45, 33, 48,
        44, 49, 39, 56, 34, 53,
        46, 42, 50, 36, 29, 32
      ].map { |p| p - 1}

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

      def permute(key, permutation)
        permutation.map { |position| key[position] }.join
      end

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

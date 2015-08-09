module Ovaltine
  class TTH

    P = [1, 2, 3, 0,
         6, 7, 4, 5,
         11, 8, 9, 10,
         15, 14, 13, 12]

    class << self
      def hash(input)
        input = input.upcase.gsub(/[^A-Z]/,'')    # sanitize input

        sum = [0, 0, 0, 0]

        padded_blocks(input).each do |block|
          sum = compute_round(block, sum)
          sum = compute_round(permuted_block(block), sum)
        end

        sum_to_hash(sum)
      end

      private

      def padded_blocks(input)
        input.chars.each_slice(16).map do |chars|
          chars + Array.new(16 - chars.size, "A")
        end
      end

      def compute_round(block, sum)
        (0...4).to_a.map do |col|
          (sum[col] + column_sum(block, col)) % 26
        end
      end

      def column_sum(block, col)
        column_indices(col).map { |i| numval(block[i]) }.reduce(:+)
      end

      def column_indices(col)
        [0 + col, 4 + col, 8 + col, 12 + col]
      end

      def permuted_block(block)
        P.map { |i| block[i] }
      end

      def numval(char)
        char.ord - 'A'.ord
      end

      def sum_to_hash(sum)
        sum.map { |s| (s + 'A'.ord).chr }.join
      end
    end
  end
end

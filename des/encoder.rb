require_relative './permutation.rb'

module Cryptography
  module DES
    class Encoder

      include Cryptography::DES::Permutation

      def initialize(key)
        @key_schedule = Cryptography::DES::KeySchedule.new(key)
      end

      def encode(message)
        ip = permute(message.hex.to_s(2).rjust(64, '0'), IP)
        l = ip[0...32]
        r = ip[32...64]
        permute(rounds(l, r), IP_INV)
      end

      private

      def f(bits, key)
        r_48 = permute(bits, E)
        sin = xor(r_48, key)
        sout = sin.chars.each_slice(6).map.with_index { |sextet, index|
          sextet = sextet.join
          s = S_BOXES[index]
          row = (sextet[0] + sextet[5]).to_i(2)
          col = (sextet[1..4]).to_i(2)
          x = s[row * 16 + col]
          res = x.to_s(2).rjust(4, '0')
          res
        }.join

        permute(sout, PF)
      end

      def xor(x, y)
        x.chars.zip(y.chars).map { |(a, b)| (a.to_i ^ b.to_i) % 2 }.join.rjust(x.length, '0')
      end

      def rounds(l, r)
        (1..16).to_a.each { |round|
          k = get_key(round)
          f = f(r, k)
          l, r = r, xor(l, f)
        }
        [r, l].join
      end

    end
  end
end
